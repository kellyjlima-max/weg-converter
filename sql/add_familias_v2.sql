-- =====================================================================
-- Migração v2: PIWD / CIWD / TSWD / TEWD / CMRW-D34 / NHOME / PF
-- Fonte: Lista Preços Construção Civil 07/2026 + Drives & Controls 07/2026
-- CORREÇÃO v2: tensao_v corretos (E10=127, E57=220, E53=380)
-- NOVO em v2: família TEWD (Tomada de Embutir Industrial Standard)
-- =====================================================================

-- ─── PIWD (Plugue Industrial Standard) ─────────────────────────────
MERGE INTO weg_produtos AS target
USING (VALUES
  (N'PIWD',N'PIWD-16P3H4E10',16,16,127,N'14684403',NULL,59.49 ,N'plugue_industrial',N'16A 3P+T 4h 127V',N'Lista CC 07/2026'),
  (N'PIWD',N'PIWD-32P3H4E10',32,32,127,N'14684404',NULL,95.54 ,N'plugue_industrial',N'32A 3P+T 4h 127V',N'Lista CC 07/2026'),
  (N'PIWD',N'PIWD-16P3H6E57',16,16,220,N'14684405',NULL,59.49 ,N'plugue_industrial',N'16A 3P+T 6h 220V',N'Lista CC 07/2026'),
  (N'PIWD',N'PIWD-16P4H9E57',16,16,220,N'14684406',NULL,66.96 ,N'plugue_industrial',N'16A 4P+T 9h 220V',N'Lista CC 07/2026'),
  (N'PIWD',N'PIWD-16P5H9E57',16,16,220,N'14684407',NULL,78.21 ,N'plugue_industrial',N'16A 5P+T 9h 220V',N'Lista CC 07/2026'),
  (N'PIWD',N'PIWD-32P3H6E57',32,32,220,N'14684568',NULL,95.54 ,N'plugue_industrial',N'32A 3P+T 6h 220V',N'Lista CC 07/2026'),
  (N'PIWD',N'PIWD-32P4H9E57',32,32,220,N'14684569',NULL,110.62,N'plugue_industrial',N'32A 4P+T 9h 220V',N'Lista CC 07/2026'),
  (N'PIWD',N'PIWD-32P5H9E57',32,32,220,N'14684570',NULL,124.60,N'plugue_industrial',N'32A 5P+T 9h 220V',N'Lista CC 07/2026'),
  (N'PIWD',N'PIWD-16P3H9E53',16,16,380,N'14684571',NULL,59.49 ,N'plugue_industrial',N'16A 3P+T 9h 380V',N'Lista CC 07/2026'),
  (N'PIWD',N'PIWD-16P4H6E53',16,16,380,N'14684572',NULL,66.96 ,N'plugue_industrial',N'16A 4P+T 6h 380V',N'Lista CC 07/2026'),
  (N'PIWD',N'PIWD-16P5H6E53',16,16,380,N'14684573',NULL,78.21 ,N'plugue_industrial',N'16A 5P+T 6h 380V',N'Lista CC 07/2026'),
  (N'PIWD',N'PIWD-32P3H9E53',32,32,380,N'14684574',NULL,95.54 ,N'plugue_industrial',N'32A 3P+T 9h 380V',N'Lista CC 07/2026'),
  (N'PIWD',N'PIWD-32P4H6E53',32,32,380,N'14684575',NULL,110.62,N'plugue_industrial',N'32A 4P+T 6h 380V',N'Lista CC 07/2026'),
  (N'PIWD',N'PIWD-32P5H6E53',32,32,380,N'14684576',NULL,124.60,N'plugue_industrial',N'32A 5P+T 6h 380V',N'Lista CC 07/2026')
) AS source(familia,codigo,corrente_min,corrente_max,tensao_v,sap_code,sap_alt,preco,categoria,subtipo,observacoes)
ON target.sap_code = source.sap_code
WHEN MATCHED THEN UPDATE SET
  target.familia=source.familia, target.codigo=source.codigo,
  target.corrente_min=source.corrente_min, target.corrente_max=source.corrente_max,
  target.tensao_v=source.tensao_v, target.sap_alt=source.sap_alt, target.preco=source.preco,
  target.categoria=source.categoria, target.subtipo=source.subtipo,
  target.observacoes=source.observacoes, target.ativo=1, target.data_atualizacao=GETDATE()
WHEN NOT MATCHED THEN INSERT
  (familia,codigo,corrente_min,corrente_max,tensao_v,sap_code,sap_alt,preco,categoria,subtipo,observacoes,ativo,data_atualizacao)
VALUES (source.familia,source.codigo,source.corrente_min,source.corrente_max,source.tensao_v,
        source.sap_code,source.sap_alt,source.preco,source.categoria,source.subtipo,source.observacoes,1,GETDATE());

-- ─── CIWD (Conector Industrial Standard) ───────────────────────────
MERGE INTO weg_produtos AS target
USING (VALUES
  (N'CIWD',N'CIWD-16P3H4E10',16,16,127,N'14684802',NULL,80.67 ,N'conector_industrial',N'16A 3P+T 4h 127V',N'Lista CC 07/2026'),
  (N'CIWD',N'CIWD-32P3H4E10',32,32,127,N'14684809',NULL,130.84,N'conector_industrial',N'32A 3P+T 4h 127V',N'Lista CC 07/2026'),
  (N'CIWD',N'CIWD-16P3H6E57',16,16,220,N'14684819',NULL,80.67 ,N'conector_industrial',N'16A 3P+T 6h 220V',N'Lista CC 07/2026'),
  (N'CIWD',N'CIWD-16P4H9E57',16,16,220,N'14684828',NULL,92.48 ,N'conector_industrial',N'16A 4P+T 9h 220V',N'Lista CC 07/2026'),
  (N'CIWD',N'CIWD-16P5H9E57',16,16,220,N'14684850',NULL,105.84,N'conector_industrial',N'16A 5P+T 9h 220V',N'Lista CC 07/2026'),
  (N'CIWD',N'CIWD-32P3H6E57',32,32,220,N'14684869',NULL,130.84,N'conector_industrial',N'32A 3P+T 6h 220V',N'Lista CC 07/2026'),
  (N'CIWD',N'CIWD-32P4H9E57',32,32,220,N'14684874',NULL,144.74,N'conector_industrial',N'32A 4P+T 9h 220V',N'Lista CC 07/2026'),
  (N'CIWD',N'CIWD-32P5H9E57',32,32,220,N'14684879',NULL,163.48,N'conector_industrial',N'32A 5P+T 9h 220V',N'Lista CC 07/2026'),
  (N'CIWD',N'CIWD-16P3H9E53',16,16,380,N'14684887',NULL,80.67 ,N'conector_industrial',N'16A 3P+T 9h 380V',N'Lista CC 07/2026'),
  (N'CIWD',N'CIWD-16P4H6E53',16,16,380,N'14684892',NULL,92.48 ,N'conector_industrial',N'16A 4P+T 6h 380V',N'Lista CC 07/2026'),
  (N'CIWD',N'CIWD-16P5H6E53',16,16,380,N'14684901',NULL,105.84,N'conector_industrial',N'16A 5P+T 6h 380V',N'Lista CC 07/2026'),
  (N'CIWD',N'CIWD-32P3H9E53',32,32,380,N'14684909',NULL,130.84,N'conector_industrial',N'32A 3P+T 9h 380V',N'Lista CC 07/2026'),
  (N'CIWD',N'CIWD-32P4H6E53',32,32,380,N'14684918',NULL,144.74,N'conector_industrial',N'32A 4P+T 6h 380V',N'Lista CC 07/2026'),
  (N'CIWD',N'CIWD-32P5H6E53',32,32,380,N'14684928',NULL,163.48,N'conector_industrial',N'32A 5P+T 6h 380V',N'Lista CC 07/2026')
) AS source(familia,codigo,corrente_min,corrente_max,tensao_v,sap_code,sap_alt,preco,categoria,subtipo,observacoes)
ON target.sap_code = source.sap_code
WHEN MATCHED THEN UPDATE SET
  target.familia=source.familia, target.codigo=source.codigo,
  target.corrente_min=source.corrente_min, target.corrente_max=source.corrente_max,
  target.tensao_v=source.tensao_v, target.sap_alt=source.sap_alt, target.preco=source.preco,
  target.categoria=source.categoria, target.subtipo=source.subtipo,
  target.observacoes=source.observacoes, target.ativo=1, target.data_atualizacao=GETDATE()
WHEN NOT MATCHED THEN INSERT
  (familia,codigo,corrente_min,corrente_max,tensao_v,sap_code,sap_alt,preco,categoria,subtipo,observacoes,ativo,data_atualizacao)
VALUES (source.familia,source.codigo,source.corrente_min,source.corrente_max,source.tensao_v,
        source.sap_code,source.sap_alt,source.preco,source.categoria,source.subtipo,source.observacoes,1,GETDATE());

-- ─── TSWD (Tomada de Sobrepor Industrial Standard) ──────────────────
MERGE INTO weg_produtos AS target
USING (VALUES
  (N'TSWD',N'TSWD-16P3H4E10',16,16,127,N'14684577',NULL    ,104.00,N'tomada_industrial',N'16A 3P+T 4h 127V',N'Lista CC 07/2026'),
  (N'TSWD',N'TSWD-32P3H4E10',32,32,127,N'14684679',NULL    ,181.68,N'tomada_industrial',N'32A 3P+T 4h 127V',N'Lista CC 07/2026'),
  (N'TSWD',N'TSWD-16P3H6E57',16,16,220,N'14684678',NULL    ,99.01 ,N'tomada_industrial',N'16A 3P+T 6h 220V',N'Lista CC 07/2026'),
  (N'TSWD',N'TSWD-16P4H9E57',16,16,220,N'14684680',NULL    ,128.51,N'tomada_industrial',N'16A 4P+T 9h 220V',N'Lista CC 07/2026'),
  (N'TSWD',N'TSWD-16P5H9E57',16,16,220,N'14684682',NULL    ,144.60,N'tomada_industrial',N'16A 5P+T 9h 220V',N'Lista CC 07/2026'),
  (N'TSWD',N'TSWD-32P3H6E57',32,32,220,N'14684683',NULL    ,173.02,N'tomada_industrial',N'32A 3P+T 6h 220V',N'Lista CC 07/2026'),
  (N'TSWD',N'TSWD-32P4H9E57',32,32,220,N'14684685',NULL    ,178.51,N'tomada_industrial',N'32A 4P+T 9h 220V',N'Lista CC 07/2026'),
  (N'TSWD',N'TSWD-32P5H9E57',32,32,220,N'14684686',NULL    ,214.15,N'tomada_industrial',N'32A 5P+T 9h 220V',N'Lista CC 07/2026'),
  (N'TSWD',N'TSWD-16P3H9E53',16,16,380,N'14684718',NULL    ,103.80,N'tomada_industrial',N'16A 3P+T 9h 380V',N'Lista CC 07/2026'),
  (N'TSWD',N'TSWD-16P4H6E53',16,16,380,N'14684723',NULL    ,122.28,N'tomada_industrial',N'16A 4P+T 6h 380V',N'Lista CC 07/2026'),
  (N'TSWD',N'TSWD-16P5H6E53',16,16,380,N'14684729',NULL    ,137.76,N'tomada_industrial',N'16A 5P+T 6h 380V',N'Lista CC 07/2026'),
  (N'TSWD',N'TSWD-32P3H9E53',32,32,380,N'14684731',NULL    ,169.93,N'tomada_industrial',N'32A 3P+T 9h 380V',N'Lista CC 07/2026'),
  (N'TSWD',N'TSWD-32P4H6E53',32,32,380,N'14684771',NULL    ,181.59,N'tomada_industrial',N'32A 4P+T 6h 380V',N'Lista CC 07/2026'),
  (N'TSWD',N'TSWD-32P5H6E53',32,32,380,N'14684791',NULL    ,203.84,N'tomada_industrial',N'32A 5P+T 6h 380V',N'Lista CC 07/2026'),
  (N'TSWD',N'TSWD-32P3H6E57',32,32,220,N'14684663',N'14684683',173.02,N'tomada_industrial',N'32A 3P+T 6h 220V',N'SAP alt para 14684683 (TSWD-32P3H6E57)')
) AS source(familia,codigo,corrente_min,corrente_max,tensao_v,sap_code,sap_alt,preco,categoria,subtipo,observacoes)
ON target.sap_code = source.sap_code
WHEN MATCHED THEN UPDATE SET
  target.familia=source.familia, target.codigo=source.codigo,
  target.corrente_min=source.corrente_min, target.corrente_max=source.corrente_max,
  target.tensao_v=source.tensao_v, target.sap_alt=source.sap_alt, target.preco=source.preco,
  target.categoria=source.categoria, target.subtipo=source.subtipo,
  target.observacoes=source.observacoes, target.ativo=1, target.data_atualizacao=GETDATE()
WHEN NOT MATCHED THEN INSERT
  (familia,codigo,corrente_min,corrente_max,tensao_v,sap_code,sap_alt,preco,categoria,subtipo,observacoes,ativo,data_atualizacao)
VALUES (source.familia,source.codigo,source.corrente_min,source.corrente_max,source.tensao_v,
        source.sap_code,source.sap_alt,source.preco,source.categoria,source.subtipo,source.observacoes,1,GETDATE());

-- ─── TEWD (Tomada de Embutir Industrial Standard) ─── NOVO EM V2 ───
MERGE INTO weg_produtos AS target
USING (VALUES
  (N'TEWD',N'TEWD-16P3H4E10',16,16,127,N'14684934',NULL,74.95 ,N'tomada_industrial',N'16A 3P+T 4h 127V',N'Lista CC 07/2026'),
  (N'TEWD',N'TEWD-32P3H4E10',32,32,127,N'14684936',NULL,106.35,N'tomada_industrial',N'32A 3P+T 4h 127V',N'Lista CC 07/2026'),
  (N'TEWD',N'TEWD-16P3H6E57',16,16,220,N'14684937',NULL,71.22 ,N'tomada_industrial',N'16A 3P+T 6h 220V',N'Lista CC 07/2026'),
  (N'TEWD',N'TEWD-16P4H9E57',16,16,220,N'14684949',NULL,83.87 ,N'tomada_industrial',N'16A 4P+T 9h 220V',N'Lista CC 07/2026'),
  (N'TEWD',N'TEWD-16P5H9E57',16,16,220,N'14684950',NULL,97.91 ,N'tomada_industrial',N'16A 5P+T 9h 220V',N'Lista CC 07/2026'),
  (N'TEWD',N'TEWD-32P3H6E57',32,32,220,N'14684951',NULL,101.18,N'tomada_industrial',N'32A 3P+T 6h 220V',N'Lista CC 07/2026'),
  (N'TEWD',N'TEWD-32P4H9E57',32,32,220,N'14684952',NULL,120.03,N'tomada_industrial',N'32A 4P+T 9h 220V',N'Lista CC 07/2026'),
  (N'TEWD',N'TEWD-32P5H9E57',32,32,220,N'14684953',NULL,135.85,N'tomada_industrial',N'32A 5P+T 9h 220V',N'Lista CC 07/2026'),
  (N'TEWD',N'TEWD-16P3H9E53',16,16,380,N'14684955',NULL,74.95 ,N'tomada_industrial',N'16A 3P+T 9h 380V',N'Lista CC 07/2026'),
  (N'TEWD',N'TEWD-16P4H6E53',16,16,380,N'14684956',NULL,79.65 ,N'tomada_industrial',N'16A 4P+T 6h 380V',N'Lista CC 07/2026'),
  (N'TEWD',N'TEWD-16P5H6E53',16,16,380,N'14684957',NULL,93.20 ,N'tomada_industrial',N'16A 5P+T 6h 380V',N'Lista CC 07/2026'),
  (N'TEWD',N'TEWD-32P3H9E53',32,32,380,N'14685008',NULL,106.35,N'tomada_industrial',N'32A 3P+T 9h 380V',N'Lista CC 07/2026'),
  (N'TEWD',N'TEWD-32P4H6E53',32,32,380,N'14685009',NULL,114.27,N'tomada_industrial',N'32A 4P+T 6h 380V',N'Lista CC 07/2026'),
  (N'TEWD',N'TEWD-32P5H6E53',32,32,380,N'14685010',NULL,129.30,N'tomada_industrial',N'32A 5P+T 6h 380V',N'Lista CC 07/2026')
) AS source(familia,codigo,corrente_min,corrente_max,tensao_v,sap_code,sap_alt,preco,categoria,subtipo,observacoes)
ON target.sap_code = source.sap_code
WHEN MATCHED THEN UPDATE SET
  target.familia=source.familia, target.codigo=source.codigo,
  target.corrente_min=source.corrente_min, target.corrente_max=source.corrente_max,
  target.tensao_v=source.tensao_v, target.sap_alt=source.sap_alt, target.preco=source.preco,
  target.categoria=source.categoria, target.subtipo=source.subtipo,
  target.observacoes=source.observacoes, target.ativo=1, target.data_atualizacao=GETDATE()
WHEN NOT MATCHED THEN INSERT
  (familia,codigo,corrente_min,corrente_max,tensao_v,sap_code,sap_alt,preco,categoria,subtipo,observacoes,ativo,data_atualizacao)
VALUES (source.familia,source.codigo,source.corrente_min,source.corrente_max,source.tensao_v,
        source.sap_code,source.sap_alt,source.preco,source.categoria,source.subtipo,source.observacoes,1,GETDATE());

-- ─── CMRW D34 (400V) ── atualiza se existir, insere se faltar ──────
MERGE INTO weg_produtos AS target
USING (VALUES
  (N'CMRW',N'CMRW2D34P0TF200' ,0,0,400,N'10071052',NULL,28.78 ,N'capacitor_motor_run',N'2uF 400V Fio TF200'       ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW2D34P0TS'    ,0,0,400,N'10071055',NULL,33.96 ,N'capacitor_motor_run',N'2uF 400V Fast-On Simples'  ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW2D34P0TD'    ,0,0,400,N'10071056',NULL,33.96 ,N'capacitor_motor_run',N'2uF 400V Fast-On Duplo'    ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW3D34P0TF200' ,0,0,400,N'10071057',NULL,28.78 ,N'capacitor_motor_run',N'3uF 400V Fio TF200'       ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW3D34P0TS'    ,0,0,400,N'10071058',NULL,33.96 ,N'capacitor_motor_run',N'3uF 400V Fast-On Simples'  ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW3D34P0TD'    ,0,0,400,N'10071059',NULL,33.96 ,N'capacitor_motor_run',N'3uF 400V Fast-On Duplo'    ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW4D34P0TF200' ,0,0,400,N'10045835',NULL,28.78 ,N'capacitor_motor_run',N'4uF 400V Fio TF200'       ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW4D34P0TS'    ,0,0,400,N'10045877',NULL,33.96 ,N'capacitor_motor_run',N'4uF 400V Fast-On Simples'  ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW4D34P0TD'    ,0,0,400,N'10045834',NULL,33.96 ,N'capacitor_motor_run',N'4uF 400V Fast-On Duplo'    ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW5D34P0TF200' ,0,0,400,N'10045836',NULL,31.36 ,N'capacitor_motor_run',N'5uF 400V Fio TF200'       ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW5D34P0TS'    ,0,0,400,N'10045878',NULL,36.54 ,N'capacitor_motor_run',N'5uF 400V Fast-On Simples'  ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW5D34P0TD'    ,0,0,400,N'10045837',NULL,36.54 ,N'capacitor_motor_run',N'5uF 400V Fast-On Duplo'    ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW6D34P0TF200' ,0,0,400,N'10045838',NULL,37.25 ,N'capacitor_motor_run',N'6uF 400V Fio TF200'       ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW6D34P0TS'    ,0,0,400,N'10045879',NULL,42.43 ,N'capacitor_motor_run',N'6uF 400V Fast-On Simples'  ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW6D34P0TD'    ,0,0,400,N'10045839',NULL,42.43 ,N'capacitor_motor_run',N'6uF 400V Fast-On Duplo'    ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW7D34P0TF200' ,0,0,400,N'10071060',NULL,45.31 ,N'capacitor_motor_run',N'7uF 400V Fio TF200'       ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW7D34P0TS'    ,0,0,400,N'10071061',NULL,50.49 ,N'capacitor_motor_run',N'7uF 400V Fast-On Simples'  ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW7D34P0TD'    ,0,0,400,N'10071062',NULL,50.49 ,N'capacitor_motor_run',N'7uF 400V Fast-On Duplo'    ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW8D34P0TF200' ,0,0,400,N'10045841',NULL,45.31 ,N'capacitor_motor_run',N'8uF 400V Fio TF200'       ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW8D34P0TS'    ,0,0,400,N'10045880',NULL,50.49 ,N'capacitor_motor_run',N'8uF 400V Fast-On Simples'  ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW8D34P0TD'    ,0,0,400,N'10045842',NULL,50.49 ,N'capacitor_motor_run',N'8uF 400V Fast-On Duplo'    ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW10D34P0TF200',0,0,400,N'10045843',NULL,47.15 ,N'capacitor_motor_run',N'10uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW10D34P0TS'   ,0,0,400,N'10045881',NULL,53.00 ,N'capacitor_motor_run',N'10uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW10D34P0TD'   ,0,0,400,N'10045882',NULL,53.00 ,N'capacitor_motor_run',N'10uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW12D34P0TF200',0,0,400,N'10045844',NULL,56.14 ,N'capacitor_motor_run',N'12uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW12D34P0TS'   ,0,0,400,N'10071063',NULL,62.38 ,N'capacitor_motor_run',N'12uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW12D34P0TD'   ,0,0,400,N'10071064',NULL,62.38 ,N'capacitor_motor_run',N'12uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW14D34P0TF200',0,0,400,N'10071065',NULL,56.14 ,N'capacitor_motor_run',N'14uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW14D34P0TS'   ,0,0,400,N'10071072',NULL,62.68 ,N'capacitor_motor_run',N'14uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW14D34P0TD'   ,0,0,400,N'12594278',NULL,62.68 ,N'capacitor_motor_run',N'14uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW15D34P0TF200',0,0,400,N'10410130',NULL,60.57 ,N'capacitor_motor_run',N'15uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW15D34P0TS'   ,0,0,400,N'10410137',NULL,65.98 ,N'capacitor_motor_run',N'15uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW15D34P0TD'   ,0,0,400,N'10410116',NULL,65.98 ,N'capacitor_motor_run',N'15uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW16D34P0TF200',0,0,400,N'10045845',NULL,62.84 ,N'capacitor_motor_run',N'16uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW16D34P0TS'   ,0,0,400,N'10045888',NULL,68.37 ,N'capacitor_motor_run',N'16uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW16D34P0TD'   ,0,0,400,N'10045840',NULL,68.37 ,N'capacitor_motor_run',N'16uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW17D34P0TF200',0,0,400,N'10410131',NULL,65.95 ,N'capacitor_motor_run',N'17uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW17D34P0TS'   ,0,0,400,N'10071073',NULL,71.37 ,N'capacitor_motor_run',N'17uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW17D34P0TD'   ,0,0,400,N'10648589',NULL,71.37 ,N'capacitor_motor_run',N'17uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW18D34P0TF200',0,0,400,N'14165145',NULL,66.60 ,N'capacitor_motor_run',N'18uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW18D34P0TS'   ,0,0,400,N'14233192',NULL,72.37 ,N'capacitor_motor_run',N'18uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW18D34P0TD'   ,0,0,400,N'14233196',NULL,72.37 ,N'capacitor_motor_run',N'18uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW19D34P0TF200',0,0,400,N'14233466',NULL,71.84 ,N'capacitor_motor_run',N'19uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW19D34P0TS'   ,0,0,400,N'14235502',NULL,77.25 ,N'capacitor_motor_run',N'19uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW19D34P0TD'   ,0,0,400,N'14235030',NULL,77.25 ,N'capacitor_motor_run',N'19uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW20D34P0TF200',0,0,400,N'14235374',NULL,73.33 ,N'capacitor_motor_run',N'20uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW20D34P0TS'   ,0,0,400,N'14235500',NULL,78.95 ,N'capacitor_motor_run',N'20uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW20D34P0TD'   ,0,0,400,N'14142236',NULL,78.95 ,N'capacitor_motor_run',N'20uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW25D34P0TF200',0,0,400,N'10045846',NULL,84.86 ,N'capacitor_motor_run',N'25uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW25D34P0TS'   ,0,0,400,N'10045891',NULL,90.58 ,N'capacitor_motor_run',N'25uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW25D34P0TD'   ,0,0,400,N'10045843',NULL,90.58 ,N'capacitor_motor_run',N'25uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW30D34P0TF200',0,0,400,N'10410134',NULL,106.16,N'capacitor_motor_run',N'30uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW30D34P0TS'   ,0,0,400,N'10410153',NULL,112.39,N'capacitor_motor_run',N'30uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW30D34P0TD'   ,0,0,400,N'10410117',NULL,112.39,N'capacitor_motor_run',N'30uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW35D34P0TF200',0,0,400,N'10045847',NULL,120.63,N'capacitor_motor_run',N'35uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW35D34P0TS'   ,0,0,400,N'10045892',NULL,124.12,N'capacitor_motor_run',N'35uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW35D34P0TD'   ,0,0,400,N'10410118',NULL,124.12,N'capacitor_motor_run',N'35uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW40D34P0TF200',0,0,400,N'10410135',NULL,130.80,N'capacitor_motor_run',N'40uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW40D34P0TS'   ,0,0,400,N'10410154',NULL,136.58,N'capacitor_motor_run',N'40uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW40D34P0TD'   ,0,0,400,N'10410119',NULL,136.58,N'capacitor_motor_run',N'40uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW45D34P0TF200',0,0,400,N'10410136',NULL,139.59,N'capacitor_motor_run',N'45uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW45D34P0TS'   ,0,0,400,N'10045893',NULL,145.71,N'capacitor_motor_run',N'45uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW45D34P0TD'   ,0,0,400,N'10045844',NULL,145.71,N'capacitor_motor_run',N'45uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW50D34P0TF200',0,0,400,N'10045953',NULL,155.44,N'capacitor_motor_run',N'50uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW50D34P0TS'   ,0,0,400,N'10186232',NULL,160.60,N'capacitor_motor_run',N'50uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW50D34P0TD'   ,0,0,400,N'10410186',NULL,160.60,N'capacitor_motor_run',N'50uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW60D34P0TF200',0,0,400,N'10047419',NULL,186.53,N'capacitor_motor_run',N'60uF 400V Fio TF200'      ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW60D34P0TS'   ,0,0,400,N'13463875',NULL,192.69,N'capacitor_motor_run',N'60uF 400V Fast-On Simples' ,N'Lista D&C 07/2026'),
  (N'CMRW',N'CMRW60D34P0TD'   ,0,0,400,N'10928304',NULL,192.69,N'capacitor_motor_run',N'60uF 400V Fast-On Duplo'   ,N'Lista D&C 07/2026')
) AS source(familia,codigo,corrente_min,corrente_max,tensao_v,sap_code,sap_alt,preco,categoria,subtipo,observacoes)
ON target.sap_code = source.sap_code
WHEN MATCHED THEN UPDATE SET
  target.familia=source.familia, target.codigo=source.codigo,
  target.tensao_v=source.tensao_v, target.preco=source.preco,
  target.categoria=source.categoria, target.subtipo=source.subtipo,
  target.observacoes=source.observacoes, target.ativo=1, target.data_atualizacao=GETDATE()
WHEN NOT MATCHED THEN INSERT
  (familia,codigo,corrente_min,corrente_max,tensao_v,sap_code,sap_alt,preco,categoria,subtipo,observacoes,ativo,data_atualizacao)
VALUES (source.familia,source.codigo,source.corrente_min,source.corrente_max,source.tensao_v,
        source.sap_code,source.sap_alt,source.preco,source.categoria,source.subtipo,source.observacoes,1,GETDATE());

-- ─── NHOME (No-Break WEG) ──────────────────────────────────────────
MERGE INTO weg_produtos AS target
USING (VALUES
  (N'NHOME',N'HOME012051090200',0,0,220,N'15586583',NULL,2577.55,N'nobreak',N'UPS 1,2kVA senoidal 220V',N'Pedido WEG-SETEMBRO.pdf / Lista CC 07/2026')
) AS source(familia,codigo,corrente_min,corrente_max,tensao_v,sap_code,sap_alt,preco,categoria,subtipo,observacoes)
ON target.sap_code = source.sap_code
WHEN MATCHED THEN UPDATE SET
  target.familia=source.familia, target.codigo=source.codigo,
  target.tensao_v=source.tensao_v, target.preco=source.preco,
  target.categoria=source.categoria, target.subtipo=source.subtipo,
  target.observacoes=source.observacoes, target.ativo=1, target.data_atualizacao=GETDATE()
WHEN NOT MATCHED THEN INSERT
  (familia,codigo,corrente_min,corrente_max,tensao_v,sap_code,sap_alt,preco,categoria,subtipo,observacoes,ativo,data_atualizacao)
VALUES (source.familia,source.codigo,source.corrente_min,source.corrente_max,source.tensao_v,
        source.sap_code,source.sap_alt,source.preco,source.categoria,source.subtipo,source.observacoes,1,GETDATE());

-- ─── PF (Plugue Fêmea 2P+T 20A) ────────────────────────────────────
MERGE INTO weg_produtos AS target
USING (VALUES
  (N'PF',N'PLUGUE FEMEA 2P+T 20A BC',20,20,250,N'176851',NULL,0,N'plugue',N'Plugue femea 2P+T 20A branco/creme',N'SAP 6 digitos - pedido SETEMBRO 2026; confirmar preco via tabela')
) AS source(familia,codigo,corrente_min,corrente_max,tensao_v,sap_code,sap_alt,preco,categoria,subtipo,observacoes)
ON target.sap_code = source.sap_code
WHEN MATCHED THEN UPDATE SET
  target.familia=source.familia, target.codigo=source.codigo,
  target.tensao_v=source.tensao_v, target.preco=source.preco,
  target.categoria=source.categoria, target.subtipo=source.subtipo,
  target.observacoes=source.observacoes, target.ativo=1, target.data_atualizacao=GETDATE()
WHEN NOT MATCHED THEN INSERT
  (familia,codigo,corrente_min,corrente_max,tensao_v,sap_code,sap_alt,preco,categoria,subtipo,observacoes,ativo,data_atualizacao)
VALUES (source.familia,source.codigo,source.corrente_min,source.corrente_max,source.tensao_v,
        source.sap_code,source.sap_alt,source.preco,source.categoria,source.subtipo,source.observacoes,1,GETDATE());

-- Verificacao final
SELECT familia, COUNT(*) AS n FROM weg_produtos WHERE familia IN ('PIWD','CIWD','TSWD','TEWD','CMRW','NHOME','PF') GROUP BY familia ORDER BY familia;
