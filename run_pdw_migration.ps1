$apiUrl = "https://weg-converter.onrender.com/admin/run-sql"
$token  = "weg-migration-2026"

$produtos = @(
  @{sap="10046263"; cod="PDW02-0,16V25";  fam="PDW"; cv=0.16;  cmin=0.80;  cmax=1.20;  tv=220}
  @{sap="10045771"; cod="PDW02-0,33V25";  fam="PDW"; cv=0.25;  cmin=1.20;  cmax=1.80;  tv=220}
  @{sap="10045773"; cod="PDW02-0,5V25";   fam="PDW"; cv=0.50;  cmin=1.80;  cmax=2.80;  tv=220}
  @{sap="10045774"; cod="PDW02-1V25";     fam="PDW"; cv=0.75;  cmin=2.80;  cmax=4.00;  tv=220}
  @{sap="10045775"; cod="PDW02-1,5V25";   fam="PDW"; cv=1.50;  cmin=4.00;  cmax=6.30;  tv=220}
  @{sap="10045776"; cod="PDW02-2V25";     fam="PDW"; cv=2.00;  cmin=5.60;  cmax=8.00;  tv=220}
  @{sap="10045777"; cod="PDW04-3V25";     fam="PDW"; cv=3.00;  cmin=7.00;  cmax=10.00; tv=220}
  @{sap="10045778"; cod="PDW04-4V25";     fam="PDW"; cv=4.00;  cmin=10.00; cmax=15.00; tv=220}
  @{sap="10045779"; cod="PDW04-5V25";     fam="PDW"; cv=5.00;  cmin=11.00; cmax=17.00; tv=220}
  @{sap="10045780"; cod="PDW04-6V25";     fam="PDW"; cv=6.00;  cmin=15.00; cmax=23.00; tv=220}
  @{sap="10045721"; cod="PDW04-7,5V25";   fam="PDW"; cv=7.50;  cmin=15.00; cmax=23.00; tv=220}
  @{sap="13339204"; cod="PDW05-3V25";     fam="PDW"; cv=3.00;  cmin=7.00;  cmax=10.00; tv=220}
  @{sap="13339231"; cod="PDW05-4V25";     fam="PDW"; cv=4.00;  cmin=10.00; cmax=15.00; tv=220}
  @{sap="13124317"; cod="PDW05-5V25";     fam="PDW"; cv=5.00;  cmin=11.00; cmax=17.00; tv=220}
  @{sap="13339269"; cod="PDW05-6V25";     fam="PDW"; cv=6.00;  cmin=15.00; cmax=23.00; tv=220}
  @{sap="13339205"; cod="PDW05-7,5V25";   fam="PDW"; cv=7.50;  cmin=15.00; cmax=23.00; tv=220}
  @{sap="13128642"; cod="PDW05-10V25";    fam="PDW"; cv=10.00; cmin=22.00; cmax=32.00; tv=220}
  @{sap="13336724"; cod="PDW05-12,5V25";  fam="PDW"; cv=12.50; cmin=32.00; cmax=40.00; tv=220}
  @{sap="13394817"; cod="PDW05-15V25";    fam="PDW"; cv=15.00; cmin=32.00; cmax=40.00; tv=220}
  @{sap="10045782"; cod="PDW06-10V25";    fam="PDW"; cv=10.00; cmin=22.00; cmax=32.00; tv=220}
  @{sap="10045783"; cod="PDW06-12,5V25";  fam="PDW"; cv=12.50; cmin=32.00; cmax=40.00; tv=220}
  @{sap="10045798"; cod="PDW06-15V25";    fam="PDW"; cv=15.00; cmin=36.00; cmax=45.00; tv=220}
  @{sap="10045734"; cod="PDW08-20V25";    fam="PDW"; cv=20.00; cmin=50.00; cmax=63.00; tv=220}
  @{sap="10045744"; cod="PDW08-25V25";    fam="PDW"; cv=25.00; cmin=57.00; cmax=70.00; tv=220}
  @{sap="10045762"; cod="PDW08-30V25";    fam="PDW"; cv=30.00; cmin=63.00; cmax=80.00; tv=220}
  @{sap="10045763"; cod="PDW10-40V25";    fam="PDW"; cv=40.00; cmin=90.00; cmax=112.00; tv=220}
  @{sap="10072580"; cod="PDW02-0,16V40";  fam="PDW"; cv=0.16;  cmin=0.40;  cmax=0.63;  tv=380}
  @{sap="10186081"; cod="PDW02-0,25V40";  fam="PDW"; cv=0.25;  cmin=0.56;  cmax=0.80;  tv=380}
  @{sap="10186082"; cod="PDW02-0,33V40";  fam="PDW"; cv=0.33;  cmin=0.80;  cmax=1.20;  tv=380}
  @{sap="10045784"; cod="PDW02-0,75V40";  fam="PDW"; cv=0.50;  cmin=1.20;  cmax=1.80;  tv=380}
  @{sap="10118384"; cod="PDW02-1,5V40";   fam="PDW"; cv=1.00;  cmin=1.80;  cmax=2.80;  tv=380}
  @{sap="10045787"; cod="PDW02-2V40";     fam="PDW"; cv=2.00;  cmin=2.80;  cmax=4.00;  tv=380}
  @{sap="10045788"; cod="PDW02-3V40";     fam="PDW"; cv=3.00;  cmin=4.00;  cmax=6.30;  tv=380}
  @{sap="10045789"; cod="PDW02-4V40";     fam="PDW"; cv=4.00;  cmin=5.60;  cmax=8.00;  tv=380}
  @{sap="10045790"; cod="PDW04-5V40";     fam="PDW"; cv=5.00;  cmin=7.00;  cmax=10.00; tv=380}
  @{sap="10045791"; cod="PDW04-6V40";     fam="PDW"; cv=6.00;  cmin=8.00;  cmax=12.50; tv=380}
  @{sap="10045792"; cod="PDW04-7,5V40";   fam="PDW"; cv=7.50;  cmin=10.00; cmax=15.00; tv=380}
  @{sap="10045793"; cod="PDW04-10V40";    fam="PDW"; cv=10.00; cmin=11.00; cmax=17.00; tv=380}
  @{sap="10045794"; cod="PDW04-12,5V40";  fam="PDW"; cv=12.50; cmin=15.00; cmax=23.00; tv=380}
  @{sap="10046425"; cod="PDW04-15V40";    fam="PDW"; cv=15.00; cmin=22.00; cmax=32.00; tv=380}
  @{sap="13339206"; cod="PDW05-5V40";     fam="PDW"; cv=5.00;  cmin=7.00;  cmax=10.00; tv=380}
  @{sap="13339237"; cod="PDW05-6V40";     fam="PDW"; cv=6.00;  cmin=8.00;  cmax=12.50; tv=380}
  @{sap="13339207"; cod="PDW05-7,5V40";   fam="PDW"; cv=7.50;  cmin=10.00; cmax=15.00; tv=380}
  @{sap="13339228"; cod="PDW05-10V40";    fam="PDW"; cv=10.00; cmin=11.00; cmax=17.00; tv=380}
  @{sap="13339235"; cod="PDW05-12,5V40";  fam="PDW"; cv=12.50; cmin=15.00; cmax=23.00; tv=380}
  @{sap="13339232"; cod="PDW05-15V40";    fam="PDW"; cv=15.00; cmin=22.00; cmax=32.00; tv=380}
  @{sap="13336725"; cod="PDW05-20V40";    fam="PDW"; cv=20.00; cmin=22.00; cmax=32.00; tv=380}
  @{sap="13336727"; cod="PDW05-25V40";    fam="PDW"; cv=25.00; cmin=32.00; cmax=40.00; tv=380}
  @{sap="10045795"; cod="PDW06-20V40";    fam="PDW"; cv=20.00; cmin=22.00; cmax=32.00; tv=380}
  @{sap="10045797"; cod="PDW06-25V40";    fam="PDW"; cv=25.00; cmin=36.00; cmax=45.00; tv=380}
  @{sap="10045764"; cod="PDW08-30V40";    fam="PDW"; cv=30.00; cmin=40.00; cmax=57.00; tv=380}
  @{sap="10670208"; cod="PDW08-40V40";    fam="PDW"; cv=40.00; cmin=50.00; cmax=63.00; tv=380}
  @{sap="10670210"; cod="PDW08-50V40";    fam="PDW"; cv=50.00; cmin=63.00; cmax=80.00; tv=380}
  @{sap="10670212"; cod="PDW10-60V40";    fam="PDW"; cv=60.00; cmin=75.00; cmax=97.00; tv=380}
  @{sap="10070897"; cod="PDW10-75V40";    fam="PDW"; cv=75.00; cmin=90.00; cmax=112.00; tv=380}
  @{sap="10211693"; cod="PDW04-0,25V49";  fam="PDW"; cv=0.16;  cmin=0.40;  cmax=0.63;  tv=440}
  @{sap="10071024"; cod="PDW04-0,33V49";  fam="PDW"; cv=0.33;  cmin=0.56;  cmax=0.80;  tv=440}
  @{sap="10186083"; cod="PDW04-0,5V49";   fam="PDW"; cv=0.50;  cmin=0.80;  cmax=1.20;  tv=440}
  @{sap="10186084"; cod="PDW04-1V49";     fam="PDW"; cv=0.75;  cmin=1.20;  cmax=1.80;  tv=440}
  @{sap="10211144"; cod="PDW04-1,5V49";   fam="PDW"; cv=1.50;  cmin=1.80;  cmax=2.80;  tv=440}
  @{sap="10045772"; cod="PDW04-2V49";     fam="PDW"; cv=2.00;  cmin=2.80;  cmax=4.00;  tv=440}
  @{sap="10186065"; cod="PDW04-3V49";     fam="PDW"; cv=3.00;  cmin=4.00;  cmax=6.30;  tv=440}
  @{sap="10118385"; cod="PDW04-5V49";     fam="PDW"; cv=4.00;  cmin=5.60;  cmax=8.00;  tv=440}
  @{sap="10070889"; cod="PDW04-6V49";     fam="PDW"; cv=6.00;  cmin=7.00;  cmax=10.00; tv=440}
  @{sap="10045723"; cod="PDW04-7,5V49";   fam="PDW"; cv=7.50;  cmin=8.00;  cmax=12.50; tv=440}
  @{sap="10045724"; cod="PDW04-10V49";    fam="PDW"; cv=10.00; cmin=10.00; cmax=15.00; tv=440}
  @{sap="10070890"; cod="PDW04-12,5V49";  fam="PDW"; cv=12.50; cmin=15.00; cmax=23.00; tv=440}
  @{sap="10211120"; cod="PDW04-15V49";    fam="PDW"; cv=15.00; cmin=15.00; cmax=23.00; tv=440}
  @{sap="14253846"; cod="PDW05-6V49";     fam="PDW"; cv=6.00;  cmin=7.00;  cmax=10.00; tv=440}
  @{sap="13339277"; cod="PDW05-7,5V49";   fam="PDW"; cv=7.50;  cmin=8.00;  cmax=12.50; tv=440}
  @{sap="13339281"; cod="PDW05-10V49";    fam="PDW"; cv=10.00; cmin=10.00; cmax=15.00; tv=440}
  @{sap="13340069"; cod="PDW05-12,5V49";  fam="PDW"; cv=12.50; cmin=15.00; cmax=23.00; tv=440}
  @{sap="13340070"; cod="PDW05-15V49";    fam="PDW"; cv=15.00; cmin=15.00; cmax=23.00; tv=440}
  @{sap="13336726"; cod="PDW05-20V49";    fam="PDW"; cv=20.00; cmin=22.00; cmax=32.00; tv=440}
  @{sap="13336743"; cod="PDW05-25V49";    fam="PDW"; cv=25.00; cmin=32.00; cmax=40.00; tv=440}
  @{sap="13336744"; cod="PDW05-30V49";    fam="PDW"; cv=30.00; cmin=32.00; cmax=40.00; tv=440}
  @{sap="10628702"; cod="PDW06-20V49";    fam="PDW"; cv=20.00; cmin=22.00; cmax=32.00; tv=440}
  @{sap="10070868"; cod="PDW06-25V49";    fam="PDW"; cv=25.00; cmin=32.00; cmax=40.00; tv=440}
  @{sap="10211132"; cod="PDW06-30V49";    fam="PDW"; cv=30.00; cmin=36.00; cmax=45.00; tv=440}
  @{sap="10070898"; cod="PDW08-40V49";    fam="PDW"; cv=40.00; cmin=40.00; cmax=57.00; tv=440}
  @{sap="10070860"; cod="PDW08-50V49";    fam="PDW"; cv=50.00; cmin=57.00; cmax=70.00; tv=440}
  @{sap="10070899"; cod="PDW08-60V49";    fam="PDW"; cv=60.00; cmin=63.00; cmax=80.00; tv=440}
  @{sap="10670196"; cod="PDW10-75V49";    fam="PDW"; cv=75.00; cmin=75.00; cmax=97.00; tv=440}
  @{sap="13349601"; cod="PDW05-1V25-FF";    fam="PDW"; cv=0.75; cmin=2.80;  cmax=4.00;  tv=220}
  @{sap="13336745"; cod="PDW05-1,5V25-FF";  fam="PDW"; cv=1.50; cmin=4.00;  cmax=6.30;  tv=220}
  @{sap="13338038"; cod="PDW05-2V25-FF";    fam="PDW"; cv=2.00; cmin=5.60;  cmax=8.00;  tv=220}
  @{sap="13338041"; cod="PDW05-3V25-FF";    fam="PDW"; cv=3.00; cmin=7.00;  cmax=10.00; tv=220}
  @{sap="13338044"; cod="PDW05-4V25-FF";    fam="PDW"; cv=4.00; cmin=10.00; cmax=15.00; tv=220}
  @{sap="13338974"; cod="PDW05-5V25-FF";    fam="PDW"; cv=5.00; cmin=11.00; cmax=17.00; tv=220}
  @{sap="13338978"; cod="PDW05-6V25-FF";    fam="PDW"; cv=6.00; cmin=15.00; cmax=23.00; tv=220}
  @{sap="13338980"; cod="PDW05-7,5V25-FF";  fam="PDW"; cv=7.50; cmin=15.00; cmax=23.00; tv=220}
  @{sap="13336746"; cod="PDW05-10V25-FF";   fam="PDW"; cv=10.00; cmin=22.00; cmax=32.00; tv=220}
  @{sap="13338039"; cod="PDW05-2V40-FF";    fam="PDW"; cv=2.00; cmin=2.80;  cmax=4.00;  tv=380}
  @{sap="13338043"; cod="PDW05-3V40-FF";    fam="PDW"; cv=3.00; cmin=4.00;  cmax=6.30;  tv=380}
  @{sap="13338972"; cod="PDW05-4V40-FF";    fam="PDW"; cv=4.00; cmin=5.60;  cmax=8.00;  tv=380}
  @{sap="13338975"; cod="PDW05-5V40-FF";    fam="PDW"; cv=5.00; cmin=7.00;  cmax=10.00; tv=380}
  @{sap="13338979"; cod="PDW05-6V40-FF";    fam="PDW"; cv=6.00; cmin=8.00;  cmax=12.50; tv=380}
  @{sap="13338981"; cod="PDW05-7,5V40-FF";  fam="PDW"; cv=7.50; cmin=10.00; cmax=15.00; tv=380}
  @{sap="13336828"; cod="PDW05-10V40-FF";   fam="PDW"; cv=10.00; cmin=11.00; cmax=17.00; tv=380}
  @{sap="13338022"; cod="PDW05-12,5V40-FF"; fam="PDW"; cv=12.50; cmin=15.00; cmax=23.00; tv=380}
  @{sap="13338026"; cod="PDW05-15V40-FF";   fam="PDW"; cv=15.00; cmin=22.00; cmax=32.00; tv=380}
  @{sap="13338040"; cod="PDW05-2V49-FF";    fam="PDW"; cv=2.00;  cmin=2.80;  cmax=4.00;  tv=440}
  @{sap="13339287"; cod="PDW05-3V49-FF";    fam="PDW"; cv=3.00;  cmin=4.00;  cmax=6.30;  tv=440}
  @{sap="13338976"; cod="PDW05-5V49-FF";    fam="PDW"; cv=4.00;  cmin=5.60;  cmax=8.00;  tv=440}
  @{sap="13339286"; cod="PDW05-10V49-FF";   fam="PDW"; cv=10.00; cmin=10.00; cmax=15.00; tv=440}
  @{sap="13338023"; cod="PDW05-12,5V49-FF"; fam="PDW"; cv=12.50; cmin=15.00; cmax=23.00; tv=440}
  @{sap="13338027"; cod="PDW05-15V49-FF";   fam="PDW"; cv=15.00; cmin=15.00; cmax=23.00; tv=440}
  @{sap="10070809"; cod="PDWM02-0,16VC8";   fam="PDWM"; cv=0.125; cmin=2.80;  cmax=4.00;  tv=127}
  @{sap="10070810"; cod="PDWM02-0,25VC8";   fam="PDWM"; cv=0.25;  cmin=4.00;  cmax=6.30;  tv=127}
  @{sap="10070811"; cod="PDWM02-0,33VC8";   fam="PDWM"; cv=0.33;  cmin=5.60;  cmax=8.00;  tv=127}
  @{sap="10070812"; cod="PDWM04-0,5VC8";    fam="PDWM"; cv=0.50;  cmin=7.00;  cmax=10.00; tv=127}
  @{sap="10070813"; cod="PDWM04-0,75VC8";   fam="PDWM"; cv=0.75;  cmin=8.00;  cmax=12.50; tv=127}
  @{sap="10070814"; cod="PDWM04-1VC8";      fam="PDWM"; cv=1.00;  cmin=10.00; cmax=15.00; tv=127}
  @{sap="10070817"; cod="PDWM04-1,5NVC8";   fam="PDWM"; cv=1.50;  cmin=15.00; cmax=23.00; tv=127}
  @{sap="10070818"; cod="PDWM04-2NVC8";     fam="PDWM"; cv=2.00;  cmin=22.00; cmax=32.00; tv=127}
  @{sap="13340072"; cod="PDWM05-0,75VC8";   fam="PDWM"; cv=0.75;  cmin=8.00;  cmax=12.50; tv=127}
  @{sap="13339279"; cod="PDWM05-1VC8";      fam="PDWM"; cv=1.00;  cmin=10.00; cmax=15.00; tv=127}
  @{sap="13340073"; cod="PDWM05-1,5NVC8";   fam="PDWM"; cv=1.50;  cmin=15.00; cmax=23.00; tv=127}
  @{sap="13339282"; cod="PDWM05-2NVC8";     fam="PDWM"; cv=2.00;  cmin=22.00; cmax=32.00; tv=127}
)

$ok = 0; $err = 0
foreach ($p in $produtos) {
    $sql = @"
MERGE weg_produtos AS t
USING (SELECT '$($p.sap)' AS sap_code, '$($p.cod)' AS codigo, '$($p.fam)' AS familia,
              CAST($($p.cmin) AS DECIMAL(8,2)) AS corrente_min,
              CAST($($p.cmax) AS DECIMAL(8,2)) AS corrente_max,
              CAST($($p.tv)   AS INT)           AS tensao_v,
              CAST($($p.cv)   AS DECIMAL(8,3))  AS potencia_cv,
              'chave_partida' AS categoria,  1 AS ativo) AS s
ON t.sap_code = s.sap_code
WHEN MATCHED THEN UPDATE SET
    t.familia=s.familia, t.codigo=s.codigo, t.corrente_min=s.corrente_min,
    t.corrente_max=s.corrente_max, t.tensao_v=s.tensao_v, t.potencia_cv=s.potencia_cv,
    t.categoria=s.categoria, t.ativo=s.ativo, t.data_atualizacao=GETDATE()
WHEN NOT MATCHED THEN INSERT
    (familia,codigo,corrente_min,corrente_max,tensao_v,potencia_cv,sap_code,categoria,ativo,data_atualizacao)
    VALUES(s.familia,s.codigo,s.corrente_min,s.corrente_max,s.tensao_v,s.potencia_cv,s.sap_code,s.categoria,1,GETDATE());
"@
    $body = @{ token=$token; sql=$sql } | ConvertTo-Json -Depth 5 -Compress
    try {
        Invoke-RestMethod -Uri $apiUrl -Method Post -Body $body -ContentType "application/json" -TimeoutSec 30 | Out-Null
        $ok++; Write-Host "OK [$($p.sap)] $($p.cod)"
    } catch {
        $err++; Write-Host "ERRO [$($p.sap)] $($p.cod): $_"
    }
}
Write-Host "`nConcluido PDW: $ok OK | $err erros"
