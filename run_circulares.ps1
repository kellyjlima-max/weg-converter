$token = 'weg-migration-2026'
$api = 'https://weg-converter.onrender.com/admin/run-sql'
$excluir = '14_inativacoes.sql'

Get-ChildItem "$PSScriptRoot\sql\circulares_2026\*.sql" | Sort-Object Name | Where-Object { $_.Name -ne $excluir } | ForEach-Object {
    $sql = Get-Content $_.FullName -Raw -Encoding UTF8
    $b64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($sql))
    $body = @{token=$token; sql_b64=$b64} | ConvertTo-Json
    Write-Host ("Rodando: " + $_.Name) -ForegroundColor Cyan
    try {
        $r = Invoke-RestMethod -Uri $api -Method Post -ContentType 'application/json' -Body $body
        $r | ConvertTo-Json -Depth 2
    } catch {
        Write-Host ("ERRO: " + $_.Exception.Message) -ForegroundColor Red
    }
    Start-Sleep -Seconds 3
}
Write-Host "Concluido!" -ForegroundColor Green
