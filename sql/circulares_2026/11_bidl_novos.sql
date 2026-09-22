-- WAU20/2026 - Novos blocos sinalizacao LED D61 (CA) e C13 (CC)
-- Convertido para bulk MERGE (single-statement) em 2026-09-21

MERGE INTO weg_produtos AS T
USING (VALUES
  (N'CSW', N'CSW-BIDLF-0D61', NULL, NULL, N'127', NULL, NULL, NULL, N'12640048', NULL, NULL, N'sinalizacao LED', N'bloco LED flange branco 110-130V CA', N'WAU20/2026 - substitui E10 (13899138)'),
  (N'CSW', N'CSW-BIDLF-1D61', NULL, NULL, N'127', NULL, NULL, NULL, N'12640049', NULL, NULL, N'sinalizacao LED', N'bloco LED flange vermelho 110-130V CA', N'WAU20/2026 - substitui E10 (13899139)'),
  (N'CSW', N'CSW-BIDLF-2D61', NULL, NULL, N'127', NULL, NULL, NULL, N'12640050', NULL, NULL, N'sinalizacao LED', N'bloco LED flange verde 110-130V CA', N'WAU20/2026 - substitui E10 (13899140)'),
  (N'CSW', N'CSW-BIDLF-3D61', NULL, NULL, N'127', NULL, NULL, NULL, N'12640051', NULL, NULL, N'sinalizacao LED', N'bloco LED flange amarelo 110-130V CA', N'WAU20/2026 - substitui E10 (13899141)'),
  (N'CSW', N'CSW-BIDLF-4D61', NULL, NULL, N'127', NULL, NULL, NULL, N'12640052', NULL, NULL, N'sinalizacao LED', N'bloco LED flange azul 110-130V CA', N'WAU20/2026 - substitui E10 (13899142)'),
  (N'CSW', N'CSW-BIDLF-0C13', NULL, NULL, N'125', NULL, NULL, NULL, N'12640058', NULL, NULL, N'sinalizacao LED', N'bloco LED flange branco 125V CC', N'WAU20/2026 - substitui E10 (13899138)'),
  (N'CSW', N'CSW-BIDLF-1C13', NULL, NULL, N'125', NULL, NULL, NULL, N'12640059', NULL, NULL, N'sinalizacao LED', N'bloco LED flange vermelho 125V CC', N'WAU20/2026 - substitui E10 (13899139)'),
  (N'CSW', N'CSW-BIDLF-2C13', NULL, NULL, N'125', NULL, NULL, NULL, N'12640060', NULL, NULL, N'sinalizacao LED', N'bloco LED flange verde 125V CC', N'WAU20/2026 - substitui E10 (13899140)'),
  (N'CSW', N'CSW-BIDLF-3C13', NULL, NULL, N'125', NULL, NULL, NULL, N'12640061', NULL, NULL, N'sinalizacao LED', N'bloco LED flange amarelo 125V CC', N'WAU20/2026 - substitui E10 (13899141)'),
  (N'CSW', N'CSW-BIDLF-4C13', NULL, NULL, N'125', NULL, NULL, NULL, N'12640062', NULL, NULL, N'sinalizacao LED', N'bloco LED flange azul 125V CC', N'WAU20/2026 - substitui E10 (13899142)'),
  (N'CSW', N'CSW-BIDLB-0D61', NULL, NULL, N'127', NULL, NULL, NULL, N'12195949', NULL, NULL, N'sinalizacao LED', N'bloco LED base branco 110-130V CA', N'WAU20/2026 - substitui E10 (13899143)'),
  (N'CSW', N'CSW-BIDLB-1D61', NULL, NULL, N'127', NULL, NULL, NULL, N'12195950', NULL, NULL, N'sinalizacao LED', N'bloco LED base vermelho 110-130V CA', N'WAU20/2026 - substitui E10 (13899144)'),
  (N'CSW', N'CSW-BIDLB-2D61', NULL, NULL, N'127', NULL, NULL, NULL, N'12195951', NULL, NULL, N'sinalizacao LED', N'bloco LED base verde 110-130V CA', N'WAU20/2026 - substitui E10 (13899146)'),
  (N'CSW', N'CSW-BIDLB-3D61', NULL, NULL, N'127', NULL, NULL, NULL, N'12195956', NULL, NULL, N'sinalizacao LED', N'bloco LED base amarelo 110-130V CA', N'WAU20/2026 - substitui E10 (13899147)'),
  (N'CSW', N'CSW-BIDLB-4D61', NULL, NULL, N'127', NULL, NULL, NULL, N'12195957', NULL, NULL, N'sinalizacao LED', N'bloco LED base azul 110-130V CA', N'WAU20/2026 - substitui E10 (13899190)'),
  (N'CSW', N'CSW-BIDLB-0C13', NULL, NULL, N'125', NULL, NULL, NULL, N'12196013', NULL, NULL, N'sinalizacao LED', N'bloco LED base branco 125V CC', N'WAU20/2026 - substitui E10 (13899143)'),
  (N'CSW', N'CSW-BIDLB-1C13', NULL, NULL, N'125', NULL, NULL, NULL, N'12196014', NULL, NULL, N'sinalizacao LED', N'bloco LED base vermelho 125V CC', N'WAU20/2026 - substitui E10 (13899144)'),
  (N'CSW', N'CSW-BIDLB-2C13', NULL, NULL, N'125', NULL, NULL, NULL, N'12196015', NULL, NULL, N'sinalizacao LED', N'bloco LED base verde 125V CC', N'WAU20/2026 - substitui E10 (13899146)'),
  (N'CSW', N'CSW-BIDLB-3C13', NULL, NULL, N'125', NULL, NULL, NULL, N'12196016', NULL, NULL, N'sinalizacao LED', N'bloco LED base amarelo 125V CC', N'WAU20/2026 - substitui E10 (13899147)'),
  (N'CSW', N'CSW-BIDLB-4C13', NULL, NULL, N'125', NULL, NULL, NULL, N'12196017', NULL, NULL, N'sinalizacao LED', N'bloco LED base azul 125V CC', N'WAU20/2026 - substitui E10 (13899190)')
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
