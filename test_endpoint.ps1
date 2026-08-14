$sql = Get-Content "sql\lista_precos_2026\01_lp_ABW-ABWC.sql" -Raw -Encoding UTF8
$sqlB64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($sql))
$body = [ordered]@{token="weg-migration-2026"; sql_b64=$sqlB64} | ConvertTo-Json -Compress
$r = Invoke-RestMethod -Uri "https://weg-converter.onrender.com/admin/run-sql" `
     -Method POST -ContentType "application/json" `
     -Body ([System.Text.Encoding]::UTF8.GetBytes($body)) -TimeoutSec 60
$r | ConvertTo-Json -Depth 5
