$BaseUrl = "https://weg-converter.onrender.com"
$Token   = "weg-migration-2026"
$SqlDir  = "C:\projetos\weg-converter\sql\lista_precos_2026"

$files = Get-ChildItem -Path $SqlDir -Filter "*.sql" | Sort-Object Name
Write-Host "Encontrados $($files.Count) arquivos SQL" -ForegroundColor Cyan

$ok = 0; $fail = 0

foreach ($f in $files) {
    $sqlBytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $sqlB64   = [Convert]::ToBase64String($sqlBytes)
    $bodyObj  = [ordered]@{ token = $Token; sql_b64 = $sqlB64 }
    $bodyJson = $bodyObj | ConvertTo-Json -Compress
    $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($bodyJson)

    try {
        $resp = Invoke-RestMethod -Uri "$BaseUrl/admin/run-sql" `
                    -Method POST -ContentType "application/json" `
                    -Body $bodyBytes -TimeoutSec 120
        if ($resp.errors -and $resp.errors.Count -gt 0) {
            Write-Host "[WARN] $($f.Name): $($resp.executed) ok, $($resp.errors.Count) erros" -ForegroundColor Yellow
            $resp.errors | Select-Object -First 2 | ForEach-Object { Write-Host "  $_" }
        } else {
            Write-Host "[OK] $($f.Name): $($resp.executed) statements" -ForegroundColor Green
        }
        $ok++
    } catch {
        Write-Host "[ERRO] $($f.Name): $_" -ForegroundColor Red
        $fail++
    }
    Start-Sleep -Milliseconds 300
}

Write-Host ""
Write-Host "Concluido: $ok OK, $fail erros" -ForegroundColor $(if ($fail -eq 0) {"Green"} else {"Yellow"})
