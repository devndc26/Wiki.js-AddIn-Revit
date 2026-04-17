param(
    [string]$BaseUrl = "http://localhost:3000",
    [string]$ApiToken = $env:WIKIJS_API_TOKEN,
    [string]$Locale = "fr",
    [string]$ConfigFile = "wiki-import-map.json",
    [int]$TimeoutSec = 30,
    [switch]$Publish,
    [switch]$UpdateExisting,
    [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-Info { param([string]$M); Write-Host "[INFO] $M" -ForegroundColor Cyan }
function Write-Ok   { param([string]$M); Write-Host "[OK]   $M" -ForegroundColor Green }
function Write-Warn { param([string]$M); Write-Host "[WARN] $M" -ForegroundColor Yellow }
function Write-Err  { param([string]$M); Write-Host "[ERR]  $M" -ForegroundColor Red }

function Invoke-WikiGraphQL {
    param(
        [string]$Endpoint,
        [string]$Token,
        [string]$Query,
        [hashtable]$Variables
    )
    $body = @{ query = $Query; variables = $Variables } | ConvertTo-Json -Depth 20 -Compress
    $headers = @{ "Content-Type" = "application/json" }
    if (-not [string]::IsNullOrWhiteSpace($Token)) {
        $headers["Authorization"] = "Bearer $Token"
    }
    $resp = Invoke-RestMethod -Uri $Endpoint -Method Post -Headers $headers -Body $body -TimeoutSec $TimeoutSec
    $ep = $resp.PSObject.Properties["errors"]
    if ($null -ne $ep -and $null -ne $ep.Value -and $ep.Value.Count -gt 0) {
        $msgs = $ep.Value | ForEach-Object { $_.message }
        throw "GraphQL error: $($msgs -join '; ')"
    }
    return $resp.data
}

function Resolve-WorkspacePath {
    param([string]$PathValue)
    if ([System.IO.Path]::IsPathRooted($PathValue)) { return $PathValue }
    return Join-Path (Get-Location) $PathValue
}

$endpoint = ($BaseUrl.TrimEnd('/')) + "/graphql"
$configPath = Resolve-WorkspacePath -PathValue $ConfigFile

if (-not (Test-Path $configPath)) {
    throw "Fichier de mapping introuvable: $configPath"
}

$items = Get-Content -Path $configPath -Raw | ConvertFrom-Json
if ($null -eq $items -or $items.Count -eq 0) {
    throw "Le fichier de mapping est vide: $configPath"
}

Write-Info "Wiki endpoint: $endpoint"
Write-Info "Locale: $Locale"
Write-Info "Pages a traiter: $($items.Count)"

if (-not $DryRun -and [string]::IsNullOrWhiteSpace($ApiToken)) {
    throw "Aucun token API fourni. Definissez WIKIJS_API_TOKEN ou passez -ApiToken."
}


$queryGetPage = @"
query(
  `$path: String!
  `$locale: String!
) {
  pages {
    singleByPath(path: `$path, locale: `$locale) {
      id
      path
      title
    }
  }
}
"@

$mutationCreate = @"
mutation(
  `$content: String!
  `$description: String!
  `$editor: String!
  `$isPublished: Boolean!
  `$isPrivate: Boolean!
  `$locale: String!
  `$path: String!
  `$tags: [String]!
  `$title: String!
) {
  pages {
    create(
      content: `$content
      description: `$description
      editor: `$editor
      isPublished: `$isPublished
      isPrivate: `$isPrivate
      locale: `$locale
      path: `$path
      tags: `$tags
      title: `$title
    ) {
      responseResult {
        succeeded
        message
      }
      page {
        id
        path
        title
      }
    }
  }
}
"@

$mutationUpdate = @"
mutation(
  `$id: Int!
  `$content: String!
  `$description: String!
  `$editor: String!
  `$isPublished: Boolean!
  `$isPrivate: Boolean!
  `$locale: String!
  `$path: String!
  `$tags: [String]!
  `$title: String!
) {
  pages {
    update(
      id: `$id
      content: `$content
      description: `$description
      editor: `$editor
      isPublished: `$isPublished
      isPrivate: `$isPrivate
      locale: `$locale
      path: `$path
      tags: `$tags
      title: `$title
    ) {
      responseResult {
        succeeded
        message
      }
      page {
        id
        path
        title
      }
    }
  }
}
"@

$created = 0
$updated = 0
$skipped = 0
$failed = 0

foreach ($item in $items) {
    try {
        $wikiPath = [string]$item.path
        $title = [string]$item.title
        $relativeFile = [string]$item.file
        $description = if ($null -ne $item.description) { [string]$item.description } else { "" }

        if ([string]::IsNullOrWhiteSpace($wikiPath) -or [string]::IsNullOrWhiteSpace($title) -or [string]::IsNullOrWhiteSpace($relativeFile)) {
            throw "Entree mapping invalide: path/title/file sont obligatoires."
        }

        $filePath = Resolve-WorkspacePath -PathValue $relativeFile
        if (-not (Test-Path $filePath)) {
            throw "Fichier Markdown introuvable: $filePath"
        }

        $content = Get-Content -Path $filePath -Raw
        $tags = @()
        if ($null -ne $item.tags) {
            $tags = @($item.tags)
        }

        if ($DryRun) {
            Write-Info "DRY-RUN -> path='$wikiPath' title='$title' file='$relativeFile'"
            continue
        }

        Write-Info "Traitement page: $wikiPath"

        $existing = $null
        try {
          $existingData = Invoke-WikiGraphQL -Endpoint $endpoint -Token $ApiToken -Query $queryGetPage -Variables @{ path = $wikiPath; locale = $Locale }
          $existing = $existingData.pages.singleByPath
        }
        catch {
          if ($_.Exception.Message -notlike "*does not exist*") {
            throw
          }
        }

        if ($null -eq $existing) {
            $createVars = @{
                content = $content
                description = $description
                editor = "markdown"
                isPublished = [bool]$Publish
                isPrivate = $false
                locale = $Locale
                path = $wikiPath
                tags = $tags
                title = $title
            }
            $createData = Invoke-WikiGraphQL -Endpoint $endpoint -Token $ApiToken -Query $mutationCreate -Variables $createVars
            $res = $createData.pages.create.responseResult
            if ($null -ne $res -and $res.succeeded -eq $true) {
                $created++
                Write-Ok "Cree: $wikiPath"
            }
            else {
                $failed++
                $msg = if ($null -ne $res.message) { $res.message } else { "Creation non confirmee par l'API." }
                Write-Err "Echec creation '$wikiPath': $msg"
            }
        }
        else {
            if (-not $UpdateExisting) {
                $skipped++
                Write-Warn "Existe deja (ignore): $wikiPath"
                continue
            }

            $updateVars = @{
                id = [int]$existing.id
                content = $content
                description = $description
                editor = "markdown"
                isPublished = [bool]$Publish
                isPrivate = $false
                locale = $Locale
                path = $wikiPath
                tags = $tags
                title = $title
            }
            $updateData = Invoke-WikiGraphQL -Endpoint $endpoint -Token $ApiToken -Query $mutationUpdate -Variables $updateVars
            $res = $updateData.pages.update.responseResult
            if ($null -ne $res -and $res.succeeded -eq $true) {
                $updated++
                Write-Ok "Mis a jour: $wikiPath"
            }
            else {
                $failed++
                $msg = if ($null -ne $res.message) { $res.message } else { "Mise a jour non confirmee par l'API." }
                Write-Err "Echec mise a jour '$wikiPath': $msg"
            }
        }
    }
    catch {
        $failed++
        Write-Err "Erreur sur '$($item.path)': $($_.Exception.Message)"
    }
}

Write-Host ""
Write-Host "===== Resume import Wiki.js =====" -ForegroundColor White
Write-Host "Crees      : $created"
Write-Host "Mis a jour : $updated"
Write-Host "Ignores    : $skipped"
Write-Host "Erreurs    : $failed"

if ($DryRun) {
    Write-Info "Mode dry-run termine sans appel API."
}