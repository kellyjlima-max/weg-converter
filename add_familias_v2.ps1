# Migração v2: PIWD / CIWD / TSWD / TEWD / CMRW-D34 / NHOME / PF
$apiUrl = "https://weg-converter.onrender.com/admin/run-sql"
$token  = "weg-migration-2026"
$sqlFile = Join-Path $PSScriptRoot "sql\add_familias_v2.sql"

$sql  = Get-Content $sqlFile -Raw -Encoding UTF8
$body = @{ token = $token; sql = $sql } | ConvertTo-Json -Depth 3 -Compress

Write-Host "Enviando migração v2 para $apiUrl ..."
$resp = Invoke-RestMethod -Uri $apiUrl -Method Post -ContentType "application/json" -Body $body
$resp | ConvertTo-Json -Depth 5
