-- WAU27/2026 - Protetores de surto SPW03 e SPW13
-- Convertido para bulk MERGE (single-statement) em 2026-09-21

MERGE INTO weg_produtos AS T
USING (VALUES
  (N'SPW03', N'SPW03-275-12', NULL, NULL, NULL, NULL, NULL, NULL, N'17568718', NULL, 107.95, N'protetor surto', N'SPW03 275V CA 12kA classe II emb.12', N'WAU27/2026'),
  (N'SPW03', N'SPW03-275-20', NULL, NULL, NULL, NULL, NULL, NULL, N'17568723', NULL, 110.23, N'protetor surto', N'SPW03 275V CA 20kA classe II emb.12', N'WAU27/2026'),
  (N'SPW03', N'SPW03-275-45', NULL, NULL, NULL, NULL, NULL, NULL, N'17568725', NULL, 193.18, N'protetor surto', N'SPW03 275V CA 45kA classe II emb.12', N'WAU27/2026'),
  (N'SPW03', N'SPW03-275-60-12-5', NULL, NULL, NULL, NULL, NULL, NULL, N'17568777', NULL, 375.0, N'protetor surto', N'SPW03 275V CA 60kA classe I/II emb.12', N'WAU27/2026'),
  (N'SPW03', N'SPW03-275-12-G', NULL, NULL, NULL, NULL, NULL, NULL, N'17568722', NULL, 145.74, N'protetor surto', N'SPW03 275V CA 12kA classe II gondola', N'WAU27/2026'),
  (N'SPW03', N'SPW03-275-20-G', NULL, NULL, NULL, NULL, NULL, NULL, N'17568726', NULL, 148.81, N'protetor surto', N'SPW03 275V CA 20kA classe II gondola', N'WAU27/2026'),
  (N'SPW03', N'SPW03-275-45-G', NULL, NULL, NULL, NULL, NULL, NULL, N'17568727', NULL, 222.16, N'protetor surto', N'SPW03 275V CA 45kA classe II gondola', N'WAU27/2026'),
  (N'SPW03', N'SPW03-275-60-12-5-G', NULL, NULL, NULL, NULL, NULL, NULL, N'17568792', NULL, 393.75, N'protetor surto', N'SPW03 275V CA 60kA classe I/II gondola', N'WAU27/2026'),
  (N'SPW03', N'SPW03-275-12-C', NULL, NULL, NULL, NULL, NULL, NULL, N'17568770', NULL, 329.7, N'protetor surto', N'SPW03 275V CA 12kA classe II c/contato sinalizacao', N'WAU27/2026'),
  (N'SPW03', N'SPW03-275-20-C', NULL, NULL, NULL, NULL, NULL, NULL, N'17568771', NULL, 346.19, N'protetor surto', N'SPW03 275V CA 20kA classe II c/contato sinalizacao', N'WAU27/2026'),
  (N'SPW03', N'SPW03-275-45-C', NULL, NULL, NULL, NULL, NULL, NULL, N'17568774', NULL, 410.79, N'protetor surto', N'SPW03 275V CA 45kA classe II c/contato sinalizacao', N'WAU27/2026'),
  (N'SPW03', N'SPW03-275-60-12-5-C', NULL, NULL, NULL, NULL, NULL, NULL, N'17568795', NULL, 575.28, N'protetor surto', N'SPW03 275V CA 60kA classe I/II c/contato sinalizacao', N'WAU27/2026'),
  (N'SPW03', N'SPW03-275-12-M', NULL, NULL, NULL, NULL, NULL, NULL, N'17568879', NULL, 84.15, N'protetor surto', N'SPW03 modulo reposicao 275V 12kA', N'WAU27/2026'),
  (N'SPW03', N'SPW03-275-20-M', NULL, NULL, NULL, NULL, NULL, NULL, N'17568880', NULL, 88.36, N'protetor surto', N'SPW03 modulo reposicao 275V 20kA', N'WAU27/2026'),
  (N'SPW03', N'SPW03-275-45-M', NULL, NULL, NULL, NULL, NULL, NULL, N'17568882', NULL, 150.29, N'protetor surto', N'SPW03 modulo reposicao 275V 45kA', N'WAU27/2026'),
  (N'SPW13', N'SPW13-600-40', NULL, NULL, NULL, NULL, NULL, NULL, N'17568796', NULL, 576.51, N'protetor surto', N'SPW13 600V CC 40kA fotovoltaico classe II', N'WAU27/2026'),
  (N'SPW13', N'SPW13-1100-40', NULL, NULL, NULL, NULL, NULL, NULL, N'17568797', NULL, 610.88, N'protetor surto', N'SPW13 1100V CC 40kA fotovoltaico classe II', N'WAU27/2026')
) AS S (familia, codigo, corrente_min, corrente_max, tensao_v,
        potencia_kw, potencia_cv, potencia_kvar,
        sap_code, sap_alt, preco, categoria, subtipo, observacoes)
ON T.codigo = S.codigo
WHEN MATCHED THEN
  UPDATE SET
    familia=S.familia, corrente_min=S.corrente_min, corrente_max=S.corrente_max,
    tensao_v=CAST(S.tensao_v AS NVARCHAR(50)),
    potencia_kw=S.potencia_kw, potencia_cv=S.potencia_cv, potencia_kvar=S.potencia_kvar,
    sap_code=S.sap_code, sap_alt=S.sap_alt, preco=S.preco,
    categoria=S.categoria, subtipo=S.subtipo, observacoes=S.observacoes,
    ativo=1, data_atualizacao=GETDATE()
WHEN NOT MATCHED THEN
  INSERT (familia, codigo, corrente_min, corrente_max, tensao_v,
          potencia_kw, potencia_cv, potencia_kvar,
          sap_code, sap_alt, preco, categoria, subtipo, observacoes, ativo, data_atualizacao)
  VALUES (S.familia, S.codigo, S.corrente_min, S.corrente_max, CAST(S.tensao_v AS NVARCHAR(50)),
          S.potencia_kw, S.potencia_cv, S.potencia_kvar,
          S.sap_code, S.sap_alt, S.preco, S.categoria, S.subtipo, S.observacoes, 1, GETDATE());
