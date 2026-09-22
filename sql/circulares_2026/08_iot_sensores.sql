-- WAU16/WDS12/WDS13 - WEGscan400, WSVS, WCD-ED210
-- Convertido para bulk MERGE (single-statement) em 2026-09-21

MERGE INTO weg_produtos AS T
USING (VALUES
  (N'SPW03', N'SENSOR IOT WEGSCAN 400-1-MFM', NULL, NULL, NULL, NULL, NULL, NULL, N'18807091', NULL, NULL, N'sensor IoT', N'sensor descargas parciais motores BT Bluetooth IP67', N'WAU16/2026 - WEGscan400'),
  (N'SPW03', N'WSVS-I1.3-12-WDP1T1-A1', NULL, NULL, NULL, NULL, NULL, NULL, N'19082676', NULL, NULL, N'sensor visao', N'sensor visao computacional 1.3MP 12mm IP65 Profinet EtherNet-IP', N'WDS12/2025 - Smart Vision Sensor'),
  (N'DRW', N'EDGE DEVICE WCD-ED210', NULL, NULL, NULL, NULL, NULL, NULL, N'17877303', NULL, NULL, N'IoT edge', N'edge device IoT WEGnology AWS Azure Google', N'WDS13/2025'),
  (N'DRW', N'MODULO COMUNICACAO ED210-BLE', NULL, NULL, NULL, NULL, NULL, NULL, N'18649411', NULL, NULL, N'IoT edge', N'modulo Bluetooth Long Range para WCD-ED210', N'WDS13/2025'),
  (N'DRW', N'MODULO COMUNICACAO ED210-MOB', NULL, NULL, NULL, NULL, NULL, NULL, N'18649198', NULL, NULL, N'IoT edge', N'modulo GPS+3G/4G para WCD-ED210', N'WDS13/2025'),
  (N'DRW', N'ANTENA EXTERNA WIFI OMNI 5dBi', NULL, NULL, NULL, NULL, NULL, NULL, N'17809982', NULL, NULL, N'IoT edge', N'antena Wi-Fi externa omni 5dBi WCD-ED210', N'WDS13/2025'),
  (N'DRW', N'ANTENA EXTERNA GNSS', NULL, NULL, NULL, NULL, NULL, NULL, N'19050760', NULL, NULL, N'IoT edge', N'antena GPS externa WCD-ED210', N'WDS13/2025')
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
