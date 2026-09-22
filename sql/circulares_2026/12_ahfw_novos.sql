-- WAU28/2026 - Filtros ativos AHFW universais 50/60Hz (D34, D39, D48)
-- Convertido para bulk MERGE (single-statement) em 2026-09-21

MERGE INTO weg_produtos AS T
USING (VALUES
  (N'AHFW', N'AHFW 50D34 R', 50, 50, N'400', NULL, NULL, NULL, N'19498500', NULL, NULL, N'filtro ativo', N'filtro ativo 50A 400V rack 50/60Hz', N'WAU28/2026 - substitui AHFW 50V40 R (17915874)'),
  (N'AHFW', N'AHFW 100D34 R', 100, 100, N'400', NULL, NULL, NULL, N'19498504', NULL, NULL, N'filtro ativo', N'filtro ativo 100A 400V rack 50/60Hz', N'WAU28/2026 - substitui AHFW 100V40 R (18049907)'),
  (N'AHFW', N'AHFW 150D34 R', 150, 150, N'400', NULL, NULL, NULL, N'19498505', NULL, NULL, N'filtro ativo', N'filtro ativo 150A 400V rack 50/60Hz', N'WAU28/2026 - substitui AHFW 150V40 R (18255105)'),
  (N'AHFW', N'AHFW 50D39 R', 50, 50, N'480', NULL, NULL, NULL, N'19498506', NULL, NULL, N'filtro ativo', N'filtro ativo 50A 480V rack 50/60Hz', N'WAU28/2026 - substitui AHFW 50V53/52 R'),
  (N'AHFW', N'AHFW 100D39 R', 100, 100, N'480', NULL, NULL, NULL, N'19498507', NULL, NULL, N'filtro ativo', N'filtro ativo 100A 480V rack 50/60Hz', N'WAU28/2026 - substitui AHFW 100V53/52 R'),
  (N'AHFW', N'AHFW 150D39 R', 150, 150, N'480', NULL, NULL, NULL, N'19498580', NULL, NULL, N'filtro ativo', N'filtro ativo 150A 480V rack 50/60Hz', N'WAU28/2026 - substitui AHFW 150V53/52 R'),
  (N'AHFW', N'AHFW 50D48 R', 50, 50, N'690', NULL, NULL, NULL, N'19498581', NULL, NULL, N'filtro ativo', N'filtro ativo 50A 690V rack 50/60Hz', N'WAU28/2026 - substitui AHFW 50V63 R (18255494)'),
  (N'AHFW', N'AHFW 100D48 R', 100, 100, N'690', NULL, NULL, NULL, N'19498585', NULL, NULL, N'filtro ativo', N'filtro ativo 100A 690V rack 50/60Hz', N'WAU28/2026 - substitui AHFW 100V63 R (18255492)'),
  (N'AHFW', N'AHFW 50D34 P', 50, 50, N'400', NULL, NULL, NULL, N'19498312', NULL, NULL, N'filtro ativo', N'filtro ativo 50A 400V parede 50/60Hz', N'WAU28/2026 - substitui AHFW 50V40 P (17915876)'),
  (N'AHFW', N'AHFW 100D34 P', 100, 100, N'400', NULL, NULL, NULL, N'19498315', NULL, NULL, N'filtro ativo', N'filtro ativo 100A 400V parede 50/60Hz', N'WAU28/2026 - substitui AHFW 100V40 P (18050408)'),
  (N'AHFW', N'AHFW 150D34 P', 150, 150, N'400', NULL, NULL, NULL, N'19498316', NULL, NULL, N'filtro ativo', N'filtro ativo 150A 400V parede 50/60Hz', N'WAU28/2026 - substitui AHFW 150V40 P (18255106)'),
  (N'AHFW', N'AHFW 50D39 P', 50, 50, N'480', NULL, NULL, NULL, N'19498317', NULL, NULL, N'filtro ativo', N'filtro ativo 50A 480V parede 50/60Hz', N'WAU28/2026 - substitui AHFW 50V53/52 P'),
  (N'AHFW', N'AHFW 100D39 P', 100, 100, N'480', NULL, NULL, NULL, N'19498379', NULL, NULL, N'filtro ativo', N'filtro ativo 100A 480V parede 50/60Hz', N'WAU28/2026 - substitui AHFW 100V53/52 P'),
  (N'AHFW', N'AHFW 150D39 P', 150, 150, N'480', NULL, NULL, NULL, N'19498380', NULL, NULL, N'filtro ativo', N'filtro ativo 150A 480V parede 50/60Hz', N'WAU28/2026 - substitui AHFW 150V53/52 P'),
  (N'AHFW', N'AHFW 50D48 P', 50, 50, N'690', NULL, NULL, NULL, N'19498382', NULL, NULL, N'filtro ativo', N'filtro ativo 50A 690V parede 50/60Hz', N'WAU28/2026 - substitui AHFW 50V63 P (18255332)'),
  (N'AHFW', N'AHFW 100D48 P', 100, 100, N'690', NULL, NULL, NULL, N'19498385', NULL, NULL, N'filtro ativo', N'filtro ativo 100A 690V parede 50/60Hz', N'WAU28/2026 - substitui AHFW 100V63 P (18255336)')
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
