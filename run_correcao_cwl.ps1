# Aplica sql/circulares_2026/15_correcao_cwl_brl_rdws.sql no banco (CWL com bobinas, BRL, RDWS-AC 2P)
$token = 'weg-migration-2026'
$api   = 'https://weg-converter.onrender.com/admin/run-sql'
$file  = "$PSScriptRoot\sql\circulares_2026\15_correcao_cwl_brl_rdws.sql"
$sql   = Get-Content $file -Raw -Encoding UTF8
$b64   = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($sql))
$body  = @{ token = $token; sql_b64 = $b64 } | ConvertTo-Json
Write-Host "Rodando: 15_correcao_cwl_brl_rdws.sql" -ForegroundColor Cyan
$r = Invoke-RestMethod -Uri $api -Method Post -ContentType 'application/json' -Body $body
$r | ConvertTo-Json -Depth 3

# Conferencia: deve listar CWL18-10-30D23 = 14011652, CWL40-00-30D23 = 14246822, BRL-32 D33 = 14247158
$chk = "SELECT codigo, sap_code, preco FROM weg_produtos WHERE ativo=1 AND codigo IN ('CWL18-10-30D23','CWL25-10-30D23','CWL32-11-30D23','CWL40-00-30D23','BRL-32 D33','RDWS-AC-30-25-2')"
$b64c = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($chk))
$bodyc = @{ token = $token; sql_b64 = $b64c } | ConvertTo-Json
(Invoke-RestMethod -Uri 'https://weg-converter.onrender.com/admin/query-sql' -Method Post -ContentType 'application/json' -Body $bodyc).rows | Format-Table
