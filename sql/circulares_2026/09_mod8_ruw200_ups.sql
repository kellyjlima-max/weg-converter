-- WAU17/WAU21/WAU22 - MOD8, RUW200-ECAT e UPS Corporate 10/15kVA
-- Convertido para bulk MERGE (single-statement) em 2026-09-21

MERGE INTO weg_produtos AS T
USING (VALUES
  (N'MCW', N'MOD8', NULL, NULL, N'24', NULL, NULL, NULL, N'16072007', NULL, NULL, N'automacao', N'modulo gerenciador 4 partidas Smart Connection SCW100', N'WAU17/2026 - IP20 24Vcc'),
  (N'UCW', N'COR0100T22010200', NULL, NULL, N'220', 10, NULL, NULL, N'16138837', NULL, NULL, N'nobreak corporate', N'UPS Corporate 10kVA 220V/220V 18x9Ah dupla conversao', N'WAU21/2026'),
  (N'UCW', N'COR0150T22010200', NULL, NULL, N'220', 15, NULL, NULL, N'16689878', NULL, NULL, N'nobreak corporate', N'UPS Corporate 15kVA 220V/220V 24x9Ah dupla conversao', N'WAU21/2026'),
  (N'MCW', N'RUW200-ECAT', NULL, NULL, N'24', NULL, NULL, NULL, N'17985373', NULL, NULL, N'automacao', N'unidade remota EtherCAT 8ED+4SD rapidas expansivel 8 modulos IP20', N'WAU22/2026')
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
