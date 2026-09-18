$apiUrl = "https://weg-converter.onrender.com/admin/run-sql"
$token  = "weg-migration-2026"

$produtos = @(
  @{sap="12463886"; cod="ACBF-11";          fam="ACBF"; sub="frontal"; obs="Frontal 1NA+1NF Parafuso MPW18/40/80"}
  @{sap="12463909"; cod="ACBS-11";          fam="ACBS"; sub="lateral"; obs="Lateral 1NA+1NF Parafuso MPW18/40/80"}
  @{sap="12463912"; cod="ACBS-20";          fam="ACBS"; sub="lateral"; obs="Lateral 2NA Parafuso MPW18/40/80"}
  @{sap="12463914"; cod="ACBS-02";          fam="ACBS"; sub="lateral"; obs="Lateral 2NF Parafuso MPW18/40/80"}
  @{sap="12463916"; cod="TSB";              fam="TSB";  sub="alarme";  obs="Alarme Parafuso MPW18/40/80"}
  @{sap="12463910"; cod="ACBF-11S";         fam="ACBF"; sub="frontal"; obs="Frontal 1NA+1NF Mola MPW12"}
  @{sap="12463908"; cod="ACBS-11S";         fam="ACBS"; sub="lateral"; obs="Lateral 1NA+1NF Mola MPW12"}
  @{sap="12463913"; cod="ACBS-20S";         fam="ACBS"; sub="lateral"; obs="Lateral 2NA Mola MPW12"}
  @{sap="12463915"; cod="ACBS-02S";         fam="ACBS"; sub="lateral"; obs="Lateral 2NF Mola MPW12"}
  @{sap="10047296"; cod="ACBF-11 MPW100";   fam="ACBF"; sub="frontal"; obs="Frontal 1NA+1NF Parafuso MPW100"}
  @{sap="10047297"; cod="ACBS-11 MPW100";   fam="ACBS"; sub="lateral"; obs="Lateral 1NA+1NF Parafuso MPW100"}
  @{sap="10076555"; cod="ACBS-20 MPW100";   fam="ACBS"; sub="lateral"; obs="Lateral 2NA Parafuso MPW100"}
  @{sap="10076556"; cod="ACBS-02 MPW100";   fam="ACBS"; sub="lateral"; obs="Lateral 2NF Parafuso MPW100"}
  @{sap="10047298"; cod="TSB AT-11 MPW100"; fam="TSB";  sub="alarme";  obs="Alarme AT-11 Parafuso MPW100"}
  @{sap="10076559"; cod="TSB SC-11 MPW100"; fam="TSB";  sub="alarme";  obs="Alarme SC-11 Parafuso MPW100"}
)

$ok = 0; $err = 0
foreach ($p in $produtos) {
    $obsEsc = $p.obs -replace "'","''"
    $sql = @"
MERGE weg_produtos AS t
USING (SELECT '$($p.sap)' AS sap_code, '$($p.cod)' AS codigo, '$($p.fam)' AS familia,
              '$obsEsc' AS observacoes, '$($p.sub)' AS subtipo,
              'acessorio_mpw' AS categoria, 1 AS ativo) AS s
ON t.sap_code = s.sap_code
WHEN MATCHED THEN UPDATE SET
    t.familia=s.familia, t.codigo=s.codigo, t.observacoes=s.observacoes,
    t.subtipo=s.subtipo, t.categoria=s.categoria, t.ativo=s.ativo,
    t.data_atualizacao=GETDATE()
WHEN NOT MATCHED THEN INSERT
    (familia,codigo,sap_code,observacoes,subtipo,categoria,ativo,data_atualizacao)
    VALUES(s.familia,s.codigo,s.sap_code,s.observacoes,s.subtipo,s.categoria,1,GETDATE());
"@
    $body = @{ token=$token; sql=$sql } | ConvertTo-Json -Depth 5 -Compress
    try {
        Invoke-RestMethod -Uri $apiUrl -Method Post -Body $body -ContentType "application/json" -TimeoutSec 30 | Out-Null
        $ok++; Write-Host "OK [$($p.sap)] $($p.cod)"
    } catch {
        $err++; Write-Host "ERRO [$($p.sap)] $($p.cod): $_"
    }
}
Write-Host "`nConcluido ACBF/ACBS/TSB: $ok OK | $err erros"
