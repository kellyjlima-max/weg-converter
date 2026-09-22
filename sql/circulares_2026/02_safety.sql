-- WAU07/2026 - Safety: chaves intertravamento, emergencia e sensores magneticos
-- Convertido para bulk MERGE (single-statement) em 2026-09-21

MERGE INTO weg_produtos AS T
USING (VALUES
  (N'BCW', N'SISW-TOS-48II42-D24-69K', NULL, NULL, NULL, NULL, NULL, NULL, N'17234585', NULL, NULL, N'safety', N'chave intertravamento solenoide metalico IP69K', N'WAU07/2026 - 4NF+2NA 24Vcc'),
  (N'BCW', N'SISW-TOS-46PI31-E24', NULL, NULL, NULL, NULL, NULL, NULL, N'17217313', NULL, NULL, N'safety', N'chave intertravamento solenoide plastico trava energizacao', N'WAU07/2026 - 3NF+2NA 24Vcc'),
  (N'BCW', N'ACIS-MHL-I', NULL, NULL, NULL, NULL, NULL, NULL, N'17234509', NULL, NULL, N'safety', N'atuador flexivel inox CISS/SISW', N'WAU07/2026'),
  (N'BCW', N'ASISW-TOS1-BOLTR-D', NULL, NULL, NULL, NULL, NULL, NULL, N'18118673', NULL, NULL, N'safety', N'trinco chave solenoide direito', N'WAU07/2026'),
  (N'BCW', N'ASISW-TOS1-BOLTR-E', NULL, NULL, NULL, NULL, NULL, NULL, N'18118674', NULL, NULL, N'safety', N'trinco chave solenoide esquerdo', N'WAU07/2026'),
  (N'BCW', N'ASISW-RHBT', NULL, NULL, NULL, NULL, NULL, NULL, N'18118675', NULL, NULL, N'safety', N'macaneta trinco chave solenoide', N'WAU07/2026'),
  (N'BCW', N'ASISW-SLCBT', NULL, NULL, NULL, NULL, NULL, NULL, N'18118676', NULL, NULL, N'safety', N'trava trinco chave solenoide', N'WAU07/2026'),
  (N'BCW', N'SRPSW-1C12M11', NULL, NULL, NULL, NULL, NULL, NULL, N'17185426', NULL, NULL, N'safety', N'chave emergencia cabo 12m 2NF', N'WAU07/2026'),
  (N'BCW', N'SRPSW-1C12M20', NULL, NULL, NULL, NULL, NULL, NULL, N'17185758', NULL, NULL, N'safety', N'chave emergencia cabo 12m 1NF+1NA', N'WAU07/2026'),
  (N'BCW', N'SRPSW-1C12M21', NULL, NULL, NULL, NULL, NULL, NULL, N'17185759', NULL, NULL, N'safety', N'chave emergencia cabo 12m 2NF+1NA', N'WAU07/2026'),
  (N'BCW', N'SRPSW-1C80I31-69K', NULL, NULL, NULL, NULL, NULL, NULL, N'17234513', NULL, NULL, N'safety', N'chave emergencia cabo 80m IP69K 3NF+1NA', N'WAU07/2026'),
  (N'BCW', N'SRPSW-1C80I22-69K', NULL, NULL, NULL, NULL, NULL, NULL, N'17234511', NULL, NULL, N'safety', N'chave emergencia cabo 80m IP69K 2NF+2NA', N'WAU07/2026'),
  (N'BCW', N'SRPSW-2B-200M42-24', NULL, NULL, NULL, NULL, NULL, NULL, N'17672492', NULL, NULL, N'safety', N'chave emergencia cabo 125m bidirecional 4NF+2NA', N'WAU07/2026'),
  (N'BCW', N'SRPSW-1R-100M42-24', NULL, NULL, NULL, NULL, NULL, NULL, N'17672494', NULL, NULL, N'safety', N'chave emergencia cabo 125m direito 4NF+2NA', N'WAU07/2026'),
  (N'BCW', N'SRPSW-1L-100M42-24', NULL, NULL, NULL, NULL, NULL, NULL, N'17672493', NULL, NULL, N'safety', N'chave emergencia cabo 125m esquerdo 4NF+2NA', N'WAU07/2026'),
  (N'BCW', N'ASRPSW-K100G', NULL, NULL, NULL, NULL, NULL, NULL, N'18652452', NULL, NULL, N'safety', N'kit instalacao chave cabo 100m', N'WAU07/2026'),
  (N'BCW', N'ASRPSW-K126G', NULL, NULL, NULL, NULL, NULL, NULL, N'18652454', NULL, NULL, N'safety', N'kit instalacao chave cabo 126m', N'WAU07/2026'),
  (N'BCW', N'SMSW-M8-88RI-21S02-69K', NULL, NULL, NULL, NULL, NULL, NULL, N'17234787', NULL, NULL, N'safety', N'sensor magnetico seguranca inox IP69K cabo 2m 2NF+1NA', N'WAU07/2026'),
  (N'BCW', N'SMSW-M8-88RI-21S10-69K', NULL, NULL, NULL, NULL, NULL, NULL, N'17234910', NULL, NULL, N'safety', N'sensor magnetico seguranca inox IP69K cabo 10m 2NF+1NA', N'WAU07/2026'),
  (N'BCW', N'SMSW-M8-88RI-21SC12-69K', NULL, NULL, NULL, NULL, NULL, NULL, N'17234911', NULL, NULL, N'safety', N'sensor magnetico seguranca inox IP69K conector M12', N'WAU07/2026'),
  (N'BCW', N'SMSW-RF8-91RP-ODS05-69K', NULL, NULL, NULL, NULL, NULL, NULL, N'17204018', NULL, NULL, N'safety', N'sensor magnetico seguranca RFID IP69K cabo 5m', N'WAU07/2026'),
  (N'BCW', N'SMSW-RF8-91RP-ODS10-69K', NULL, NULL, NULL, NULL, NULL, NULL, N'17204019', NULL, NULL, N'safety', N'sensor magnetico seguranca RFID IP69K cabo 10m', N'WAU07/2026'),
  (N'BCW', N'SMSW-RF8-91RP-ODSC12', NULL, NULL, NULL, NULL, NULL, NULL, N'17204020', NULL, NULL, N'safety', N'sensor magnetico seguranca RFID conector M12', N'WAU07/2026')
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
