-- WAU14/WAU15/WAU34 - Cameras, switch PoE e video porteiro WCAM
-- Convertido para bulk MERGE (single-statement) em 2026-09-21

MERGE INTO weg_produtos AS T
USING (VALUES
  (N'WCAM', N'SWITCH WEG M04-P31', NULL, NULL, NULL, NULL, NULL, NULL, N'18615490', NULL, 456.68, N'CFTV', N'switch PoE+ 4 portas + 2 uplink 65W', N'WAU14/2026'),
  (N'WCAM', N'WCAM IP-M022-B41', NULL, NULL, NULL, NULL, NULL, NULL, N'18573342', NULL, 1207.3, N'CFTV', N'camera IP bullet 2MP Night Color+ IR40m IP66', N'WAU15/2026'),
  (N'WCAM', N'WCAM IP-M022-D41', NULL, NULL, NULL, NULL, NULL, NULL, N'18573343', NULL, 1207.3, N'CFTV', N'camera IP dome 2MP Night Color+ IR40m IP66', N'WAU15/2026'),
  (N'WCAM', N'VIDEO PORTEIRO WI-FI WHOME', NULL, NULL, NULL, NULL, NULL, NULL, N'17928769', NULL, 1110.75, N'smart home', N'video porteiro VP2K Smart Wi-Fi 2K IP65', N'WAU34/2025')
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
