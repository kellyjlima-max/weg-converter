-- WAU12/2026 - Servoconversores SCA700 e acessorios
-- Convertido para bulk MERGE (single-statement) em 2026-09-21

MERGE INTO weg_produtos AS T
USING (VALUES
  (N'SCA700', N'SCA700B02P0B2DB20F2C3M1', 2, 2, N'240', NULL, NULL, NULL, N'17552997', NULL, NULL, N'servoconversor', N'SCA700 2A 220-240V mono/tri tamanho B resolver', N'WAU12/2026'),
  (N'SCA700', N'SCA700B03P4B2DB20F2C3M1', 3.4, 3.4, N'240', NULL, NULL, NULL, N'17553040', NULL, NULL, N'servoconversor', N'SCA700 3.4A 220-240V mono/tri tamanho B resolver', N'WAU12/2026'),
  (N'SCA700', N'SCA700B06P0T2DB20F2C3M1', 6, 6, N'240', NULL, NULL, NULL, N'17553078', NULL, NULL, N'servoconversor', N'SCA700 6A 220-240V tri tamanho B resolver', N'WAU12/2026'),
  (N'SCA700', N'SCA700C12P4T2DB20F2C3M1', 12.4, 12.4, N'240', NULL, NULL, NULL, N'17553111', NULL, NULL, N'servoconversor', N'SCA700 12.4A 220-240V tri tamanho C resolver', N'WAU12/2026'),
  (N'SCA700', N'SCA700C16P0T2DB20F2C3M1', 16, 16, N'240', NULL, NULL, NULL, N'17553135', NULL, NULL, N'servoconversor', N'SCA700 16A 220-240V tri tamanho C resolver', N'WAU12/2026'),
  (N'SCA700', N'SCA700D24P0T2DB20F2C3M1', 24, 24, N'240', NULL, NULL, NULL, N'18138014', NULL, NULL, N'servoconversor', N'SCA700 24A 220-240V tri tamanho D resolver', N'WAU12/2026'),
  (N'SCA700', N'SCA700E40P0T2DB20F2C3M1', 40, 40, N'240', NULL, NULL, NULL, N'18307931', NULL, NULL, N'servoconversor', N'SCA700 40A 220-240V tri tamanho E resolver', N'WAU12/2026'),
  (N'SCA700', N'SCA700B01P9T4DB20F2C3M1', 1.9, 1.9, N'480', NULL, NULL, NULL, N'17553169', NULL, NULL, N'servoconversor', N'SCA700 1.9A 380-480V tri tamanho B resolver', N'WAU12/2026'),
  (N'SCA700', N'SCA700B04P0T4DB20F2C3M1', 4, 4, N'480', NULL, NULL, NULL, N'17553203', NULL, NULL, N'servoconversor', N'SCA700 4A 380-480V tri tamanho B resolver', N'WAU12/2026'),
  (N'SCA700', N'SCA700C08P0T4DB20F2C3M1', 8, 8, N'480', NULL, NULL, NULL, N'17553226', NULL, NULL, N'servoconversor', N'SCA700 8A 380-480V tri tamanho C resolver', N'WAU12/2026'),
  (N'SCA700', N'SCA700C11P2T4DB20F2C3M1', 11.2, 11.2, N'480', NULL, NULL, NULL, N'17553248', NULL, NULL, N'servoconversor', N'SCA700 11.2A 380-480V tri tamanho C resolver', N'WAU12/2026'),
  (N'SCA700', N'SCA700D15P0T4DB20F2C3M1', 15, 15, N'480', NULL, NULL, NULL, N'18138036', NULL, NULL, N'servoconversor', N'SCA700 15A 380-480V tri tamanho D resolver', N'WAU12/2026'),
  (N'SCA700', N'SCA700D24P0T4DB20F2C3M1', 24, 24, N'480', NULL, NULL, NULL, N'18138119', NULL, NULL, N'servoconversor', N'SCA700 24A 380-480V tri tamanho D resolver', N'WAU12/2026'),
  (N'SCA700', N'SCA700E33P5T4DB20F2C3M1', 33.5, 33.5, N'480', NULL, NULL, NULL, N'18307975', NULL, NULL, N'servoconversor', N'SCA700 33.5A 380-480V tri tamanho E resolver', N'WAU12/2026'),
  (N'SCA700', N'SCA700-IOD', NULL, NULL, NULL, NULL, NULL, NULL, N'17882553', NULL, NULL, N'servoconversor', N'modulo expansao digital 8ED+8SD', N'WAU12/2026 - acessorio SCA700'),
  (N'SCA700', N'SCA700-IOA', NULL, NULL, NULL, NULL, NULL, NULL, N'17882649', NULL, NULL, N'servoconversor', N'modulo expansao analogica 2EA+4SA', N'WAU12/2026 - acessorio SCA700'),
  (N'SCA700', N'SCA700-SIMU', NULL, NULL, NULL, NULL, NULL, NULL, N'17882554', NULL, NULL, N'servoconversor', N'simulador encoder + entrada analogica', N'WAU12/2026 - acessorio SCA700'),
  (N'SCA700', N'SCA700-ENC1', NULL, NULL, NULL, NULL, NULL, NULL, N'17882556', NULL, NULL, N'servoconversor', N'modulo encoder externo 1 entrada 500kHz', N'WAU12/2026 - acessorio SCA700'),
  (N'SCA700', N'SCA700-ENC2', NULL, NULL, NULL, NULL, NULL, NULL, N'18419669', NULL, NULL, N'servoconversor', N'modulo encoder externo 2 entradas + repetidor', N'WAU12/2026 - acessorio SCA700'),
  (N'SCA700', N'SCA700-CETH', NULL, NULL, NULL, NULL, NULL, NULL, N'17882650', NULL, NULL, N'servoconversor', N'modulo Modbus TCP / EtherNet/IP', N'WAU12/2026 - acessorio SCA700'),
  (N'SCA700', N'SCA700-ECAT', NULL, NULL, NULL, NULL, NULL, NULL, N'17882648', NULL, NULL, N'servoconversor', N'modulo EtherCAT escravo', N'WAU12/2026 - acessorio SCA700')
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
