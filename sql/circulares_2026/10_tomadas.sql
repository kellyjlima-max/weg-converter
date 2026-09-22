-- WAU18/WAU25 - Tomadas Multiplas em Barra e Interruptores Touch+Tomada
-- Convertido para bulk MERGE (single-statement) em 2026-09-21

MERGE INTO weg_produtos AS T
USING (VALUES
  (N'CEW', N'TOMADA MULTIPLA 2S 2P+T 20A BR', 20, 20, N'250', NULL, NULL, NULL, N'17810168', NULL, 76.87, N'tomada', N'2 saidas 20A branco', N'WAU18/2026'),
  (N'CEW', N'TOMADA MULTIPLA 2S 2P+T 20A CZ', 20, 20, N'250', NULL, NULL, NULL, N'17810169', NULL, 76.87, N'tomada', N'2 saidas 20A cinza', N'WAU18/2026'),
  (N'CEW', N'TOMADA MULTIPLA 2S 2P+T 20A PT', 20, 20, N'250', NULL, NULL, NULL, N'17810170', NULL, 76.87, N'tomada', N'2 saidas 20A preto', N'WAU18/2026'),
  (N'CEW', N'TOMADA MULTIPLA 3S 2P+T 20A BR', 20, 20, N'250', NULL, NULL, NULL, N'17810177', NULL, 98.37, N'tomada', N'3 saidas 20A branco', N'WAU18/2026'),
  (N'CEW', N'TOMADA MULTIPLA 3S 2P+T 20A CZ', 20, 20, N'250', NULL, NULL, NULL, N'17810270', NULL, 98.37, N'tomada', N'3 saidas 20A cinza', N'WAU18/2026'),
  (N'CEW', N'TOMADA MULTIPLA 3S 2P+T 20A PT', 20, 20, N'250', NULL, NULL, NULL, N'17810273', NULL, 98.37, N'tomada', N'3 saidas 20A preto', N'WAU18/2026'),
  (N'CEW', N'TOMADA MULTIPLA 4S 2P+T 20A BR', 20, 20, N'250', NULL, NULL, NULL, N'17810699', NULL, 120.13, N'tomada', N'4 saidas 20A branco', N'WAU18/2026'),
  (N'CEW', N'TOMADA MULTIPLA 4S 2P+T 20A CZ', 20, 20, N'250', NULL, NULL, NULL, N'17810749', NULL, 120.13, N'tomada', N'4 saidas 20A cinza', N'WAU18/2026'),
  (N'CEW', N'TOMADA MULTIPLA 4S 2P+T 20A PT', 20, 20, N'250', NULL, NULL, NULL, N'17810751', NULL, 120.13, N'tomada', N'4 saidas 20A preto', N'WAU18/2026'),
  (N'CEW', N'INT TOUCH 1B+TOM WI-FI PL4X2 WHOME BR', NULL, NULL, NULL, NULL, NULL, NULL, N'18290559', NULL, 403.07, N'smart home', N'interruptor touch 1 botao + tomada 10A Wi-Fi branco', N'WAU25/2026'),
  (N'CEW', N'INT TOUCH 1B+TOM WI-FI PL4X2 WHOME PT', NULL, NULL, NULL, NULL, NULL, NULL, N'18290561', NULL, 403.07, N'smart home', N'interruptor touch 1 botao + tomada 10A Wi-Fi preto', N'WAU25/2026'),
  (N'CEW', N'INT TOUCH 2B+TOM WI-FI PL4X2 WHOME BR', NULL, NULL, NULL, NULL, NULL, NULL, N'18290563', NULL, 423.64, N'smart home', N'interruptor touch 2 botoes + tomada 10A Wi-Fi branco', N'WAU25/2026'),
  (N'CEW', N'INT TOUCH 2B+TOM WI-FI PL4X2 WHOME PT', NULL, NULL, NULL, NULL, NULL, NULL, N'18290565', NULL, 423.64, N'smart home', N'interruptor touch 2 botoes + tomada 10A Wi-Fi preto', N'WAU25/2026'),
  (N'CEW', N'INT TOUCH 1B+TOM ZIGBEE PL4X2 WHOME BR', NULL, NULL, NULL, NULL, NULL, NULL, N'18290566', NULL, 443.38, N'smart home', N'interruptor touch 1 botao + tomada 10A Zigbee branco', N'WAU25/2026'),
  (N'CEW', N'INT TOUCH 1B+TOM ZIGBEE PL4X2 WHOME PT', NULL, NULL, NULL, NULL, NULL, NULL, N'18290567', NULL, 443.38, N'smart home', N'interruptor touch 1 botao + tomada 10A Zigbee preto', N'WAU25/2026'),
  (N'CEW', N'INT TOUCH 2B+TOM ZIGBEE PL4X2 WHOME BR', NULL, NULL, NULL, NULL, NULL, NULL, N'18290598', NULL, 466.0, N'smart home', N'interruptor touch 2 botoes + tomada 10A Zigbee branco', N'WAU25/2026'),
  (N'CEW', N'INT TOUCH 2B+TOM ZIGBEE PL4X2 WHOME PT', NULL, NULL, NULL, NULL, NULL, NULL, N'18290599', NULL, 466.0, N'smart home', N'interruptor touch 2 botoes + tomada 10A Zigbee preto', N'WAU25/2026')
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
