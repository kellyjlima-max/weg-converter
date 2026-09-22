-- WAU05/2026 - RDWH-A-Hi | WAU06/2026 - Acessorios UMDW
-- Convertido para bulk MERGE (single-statement) em 2026-09-21

MERGE INTO weg_produtos AS T
USING (VALUES
  (N'DRW', N'RDWH-A-Hi-30-25-2', 25, 25, N'250', NULL, NULL, NULL, N'17431699', NULL, 1212.43, N'interruptor diferencial residual', N'30mA 1P+N', N'WAU05/2026 - altamente imunizado Hi'),
  (N'DRW', N'RDWH-A-Hi-30-40-2', 40, 40, N'250', NULL, NULL, NULL, N'17431672', NULL, 1212.43, N'interruptor diferencial residual', N'30mA 1P+N', N'WAU05/2026 - altamente imunizado Hi'),
  (N'DRW', N'RDWH-A-Hi-30-63-2', 63, 63, N'250', NULL, NULL, NULL, N'17431486', NULL, 1212.43, N'interruptor diferencial residual', N'30mA 1P+N', N'WAU05/2026 - altamente imunizado Hi'),
  (N'DRW', N'RDWH-A-Hi-30-25-4', 25, 25, N'440', NULL, NULL, NULL, N'17431701', NULL, 1611.07, N'interruptor diferencial residual', N'30mA 3P+N', N'WAU05/2026 - altamente imunizado Hi'),
  (N'DRW', N'RDWH-A-Hi-30-40-4', 40, 40, N'440', NULL, NULL, NULL, N'17431675', NULL, 1611.07, N'interruptor diferencial residual', N'30mA 3P+N', N'WAU05/2026 - altamente imunizado Hi'),
  (N'DRW', N'RDWH-A-Hi-30-63-4', 63, 63, N'440', NULL, NULL, NULL, N'17431668', NULL, 1611.07, N'interruptor diferencial residual', N'30mA 3P+N', N'WAU05/2026 - altamente imunizado Hi'),
  (N'DRW', N'RDWH-A-Hi-300-25-2', 25, 25, N'250', NULL, NULL, NULL, N'17431700', NULL, 1468.46, N'interruptor diferencial residual', N'300mA 1P+N', N'WAU05/2026 - altamente imunizado Hi'),
  (N'DRW', N'RDWH-A-Hi-300-40-2', 40, 40, N'250', NULL, NULL, NULL, N'17431674', NULL, 1468.46, N'interruptor diferencial residual', N'300mA 1P+N', N'WAU05/2026 - altamente imunizado Hi'),
  (N'DRW', N'RDWH-A-Hi-300-63-2', 63, 63, N'250', NULL, NULL, NULL, N'17431487', NULL, 1468.46, N'interruptor diferencial residual', N'300mA 1P+N', N'WAU05/2026 - altamente imunizado Hi'),
  (N'DRW', N'RDWH-A-Hi-300-25-4', 25, 25, N'440', NULL, NULL, NULL, N'17431702', NULL, 1894.49, N'interruptor diferencial residual', N'300mA 3P+N', N'WAU05/2026 - altamente imunizado Hi'),
  (N'DRW', N'RDWH-A-Hi-300-40-4', 40, 40, N'440', NULL, NULL, NULL, N'17431676', NULL, 1894.49, N'interruptor diferencial residual', N'300mA 3P+N', N'WAU05/2026 - altamente imunizado Hi'),
  (N'DRW', N'RDWH-A-Hi-300-63-4', 63, 63, N'440', NULL, NULL, NULL, N'17431669', NULL, 1894.49, N'interruptor diferencial residual', N'300mA 3P+N', N'WAU05/2026 - altamente imunizado Hi'),
  (N'UCW', N'AMBG-UMDW075264009200', NULL, NULL, NULL, 75, NULL, NULL, N'18165586', NULL, NULL, N'nobreak modular', N'banco baterias UMDW 75kVA 264x9Ah', N'WAU06/2026'),
  (N'UCW', N'AMBG-UMDW125540009200', NULL, NULL, NULL, 125, NULL, NULL, N'18165852', NULL, NULL, N'nobreak modular', N'banco baterias UMDW 125kVA 540x9Ah', N'WAU06/2026'),
  (N'UCW', N'AMBG-UMDW200132018200', NULL, NULL, NULL, 200, NULL, NULL, N'18165857', NULL, NULL, N'nobreak modular', N'banco baterias UMDW 200kVA 132x18Ah', N'WAU06/2026'),
  (N'UCW', N'AMBG-UMDW200072040200', NULL, NULL, NULL, 200, NULL, NULL, N'18165868', NULL, NULL, N'nobreak modular', N'banco baterias UMDW 200kVA 72x40Ah', N'WAU06/2026'),
  (N'UCW', N'AMBG-UMDW200044080200', NULL, NULL, NULL, 200, NULL, NULL, N'18165869', NULL, NULL, N'nobreak modular', N'banco baterias UMDW 200kVA 44x80Ah', N'WAU06/2026'),
  (N'UCW', N'AMBG-UMDW200044100200', NULL, NULL, NULL, 200, NULL, NULL, N'18165870', NULL, NULL, N'nobreak modular', N'banco baterias UMDW 200kVA 44x100Ah', N'WAU06/2026'),
  (N'UCW', N'AMBG-UMDW200044150200', NULL, NULL, NULL, 200, NULL, NULL, N'18165871', NULL, NULL, N'nobreak modular', N'banco baterias UMDW 200kVA 44x150Ah', N'WAU06/2026'),
  (N'UCW', N'AAT-UMDW42030081', NULL, NULL, N'380', 81, NULL, NULL, N'18157450', NULL, NULL, N'nobreak modular', N'autotrafo entrada UMDW 81kVA 220/440V380V', N'WAU06/2026'),
  (N'UCW', N'ATI-UMDW03320075', NULL, NULL, N'380', 75, NULL, NULL, N'18172145', NULL, NULL, N'nobreak modular', N'trafo isolador saida UMDW 75kVA 380V220/380V', N'WAU06/2026'),
  (N'UCW', N'AATTI-UMDW42320081-0075', NULL, NULL, N'380', 81, NULL, NULL, N'18172147', NULL, NULL, N'nobreak modular', N'autotrafo+trafo isolador UMDW 81/75kVA', N'WAU06/2026'),
  (N'UCW', N'AAT-UMDW42030135', NULL, NULL, N'380', 135, NULL, NULL, N'18172242', NULL, NULL, N'nobreak modular', N'autotrafo entrada UMDW 135kVA 220/440V380V', N'WAU06/2026'),
  (N'UCW', N'ATI-UMDW03320125', NULL, NULL, N'380', 125, NULL, NULL, N'18172243', NULL, NULL, N'nobreak modular', N'trafo isolador saida UMDW 125kVA 380V220/380V', N'WAU06/2026'),
  (N'UCW', N'AAT-UMDW42030215', NULL, NULL, N'380', 215, NULL, NULL, N'18172246', NULL, NULL, N'nobreak modular', N'autotrafo entrada UMDW 215kVA 220/440V380V', N'WAU06/2026'),
  (N'UCW', N'ATI-UMDW03320200', NULL, NULL, N'380', 200, NULL, NULL, N'18172247', NULL, NULL, N'nobreak modular', N'trafo isolador saida UMDW 200kVA 380V220V', N'WAU06/2026')
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
