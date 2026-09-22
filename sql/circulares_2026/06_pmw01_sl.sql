-- WAU13/2026 - Paineis PMW01 sem laterais
-- Convertido para bulk MERGE (single-statement) em 2026-09-21

MERGE INTO weg_produtos AS T
USING (VALUES
  (N'PMW01', N'PMW01-20066-SL', NULL, NULL, NULL, NULL, NULL, NULL, N'19082923', NULL, NULL, N'painel', N'painel 2000x600x600mm s/laterais RAL7035', N'WAU13/2026'),
  (N'PMW01', N'PMW01-20068-SL', NULL, NULL, NULL, NULL, NULL, NULL, N'19082951', NULL, NULL, N'painel', N'painel 2000x600x800mm s/laterais RAL7035', N'WAU13/2026'),
  (N'PMW01', N'PMW01-20086-SL', NULL, NULL, NULL, NULL, NULL, NULL, N'19082952', NULL, NULL, N'painel', N'painel 2000x800x600mm s/laterais RAL7035', N'WAU13/2026'),
  (N'PMW01', N'PMW01-20088-SL', NULL, NULL, NULL, NULL, NULL, NULL, N'19082953', NULL, NULL, N'painel', N'painel 2000x800x800mm s/laterais RAL7035', N'WAU13/2026'),
  (N'PMW01', N'PMW01-20106-SL', NULL, NULL, NULL, NULL, NULL, NULL, N'19082955', NULL, NULL, N'painel', N'painel 2000x1000x600mm s/laterais RAL7035', N'WAU13/2026'),
  (N'PMW01', N'PMW01-20108-SL', NULL, NULL, NULL, NULL, NULL, NULL, N'19082957', NULL, NULL, N'painel', N'painel 2000x1000x800mm s/laterais RAL7035', N'WAU13/2026'),
  (N'PMW01', N'PMW01-23066-SL', NULL, NULL, NULL, NULL, NULL, NULL, N'19082960', NULL, NULL, N'painel', N'painel 2300x600x600mm s/laterais RAL7035', N'WAU13/2026'),
  (N'PMW01', N'PMW01-23068-SL', NULL, NULL, NULL, NULL, NULL, NULL, N'19082961', NULL, NULL, N'painel', N'painel 2300x600x800mm s/laterais RAL7035', N'WAU13/2026'),
  (N'PMW01', N'PMW01-23086-SL', NULL, NULL, NULL, NULL, NULL, NULL, N'19082962', NULL, NULL, N'painel', N'painel 2300x800x600mm s/laterais RAL7035', N'WAU13/2026'),
  (N'PMW01', N'PMW01-23088-SL', NULL, NULL, NULL, NULL, NULL, NULL, N'19082963', NULL, NULL, N'painel', N'painel 2300x800x800mm s/laterais RAL7035', N'WAU13/2026'),
  (N'PMW01', N'PMW01-23106-SL', NULL, NULL, NULL, NULL, NULL, NULL, N'19082964', NULL, NULL, N'painel', N'painel 2300x1000x600mm s/laterais RAL7035', N'WAU13/2026'),
  (N'PMW01', N'PMW01-23108-SL', NULL, NULL, NULL, NULL, NULL, NULL, N'19082965', NULL, NULL, N'painel', N'painel 2300x1000x800mm s/laterais RAL7035', N'WAU13/2026')
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
