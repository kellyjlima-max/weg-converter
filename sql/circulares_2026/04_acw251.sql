-- WAU11/2026 - ACW251 Disjuntor Caixa Moldada 690-1000V
-- Convertido para bulk MERGE (single-statement) em 2026-09-21

MERGE INTO weg_produtos AS T
USING (VALUES
  (N'ACW', N'ACW251X-FMU60-3', 60, 60, N'1000', NULL, NULL, NULL, N'18373480', NULL, NULL, N'disjuntor caixa moldada', N'ACW251X 60A 690-1000V 65kA@690V tripolar', N'WAU11/2026'),
  (N'ACW', N'ACW251X-FMU80-3', 80, 80, N'1000', NULL, NULL, NULL, N'18373481', NULL, NULL, N'disjuntor caixa moldada', N'ACW251X 80A 690-1000V 65kA@690V tripolar', N'WAU11/2026'),
  (N'ACW', N'ACW251X-ATU100-3', 100, 100, N'1000', NULL, NULL, NULL, N'18373482', NULL, NULL, N'disjuntor caixa moldada', N'ACW251X 100A 690-1000V 65kA@690V tripolar', N'WAU11/2026'),
  (N'ACW', N'ACW251X-ATU150-3', 150, 150, N'1000', NULL, NULL, NULL, N'18373484', NULL, NULL, N'disjuntor caixa moldada', N'ACW251X 150A 690-1000V 65kA@690V tripolar', N'WAU11/2026'),
  (N'ACW', N'ACW251X-ATU200-3', 200, 200, N'1000', NULL, NULL, NULL, N'18373485', NULL, NULL, N'disjuntor caixa moldada', N'ACW251X 200A 690-1000V 65kA@690V tripolar', N'WAU11/2026'),
  (N'ACW', N'ACW251X-ATU250-3', 250, 250, N'1000', NULL, NULL, NULL, N'18373487', NULL, NULL, N'disjuntor caixa moldada', N'ACW251X 250A 690-1000V 65kA@690V tripolar', N'WAU11/2026'),
  (N'ACW', N'ACW251W-FMU60-3', 60, 60, N'1000', NULL, NULL, NULL, N'18373659', NULL, NULL, N'disjuntor caixa moldada', N'ACW251W 60A 690-1000V 85kA@690V tripolar', N'WAU11/2026'),
  (N'ACW', N'ACW251W-FMU80-3', 80, 80, N'1000', NULL, NULL, NULL, N'18373661', NULL, NULL, N'disjuntor caixa moldada', N'ACW251W 80A 690-1000V 85kA@690V tripolar', N'WAU11/2026'),
  (N'ACW', N'ACW251W-ATU100-3', 100, 100, N'1000', NULL, NULL, NULL, N'18373662', NULL, NULL, N'disjuntor caixa moldada', N'ACW251W 100A 690-1000V 85kA@690V tripolar', N'WAU11/2026'),
  (N'ACW', N'ACW251W-ATU150-3', 150, 150, N'1000', NULL, NULL, NULL, N'18373664', NULL, NULL, N'disjuntor caixa moldada', N'ACW251W 150A 690-1000V 85kA@690V tripolar', N'WAU11/2026'),
  (N'ACW', N'ACW251W-ATU200-3', 200, 200, N'1000', NULL, NULL, NULL, N'18373665', NULL, NULL, N'disjuntor caixa moldada', N'ACW251W 200A 690-1000V 85kA@690V tripolar', N'WAU11/2026'),
  (N'ACW', N'ACW251W-ATU250-3', 250, 250, N'1000', NULL, NULL, NULL, N'18373667', NULL, NULL, N'disjuntor caixa moldada', N'ACW251W 250A 690-1000V 85kA@690V tripolar', N'WAU11/2026')
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
