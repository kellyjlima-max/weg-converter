-- WAU10/2026 - PFWD01 e CTSW (qualidade de energia)
-- Convertido para bulk MERGE (single-statement) em 2026-09-21

MERGE INTO weg_produtos AS T
USING (VALUES
  (N'PFWD01', N'PFWD01-M12-D34', NULL, NULL, N'400', NULL, NULL, NULL, N'17633710', NULL, NULL, N'qualidade energia', N'controlador FP dinamico 400Vca', N'WAU10/2026'),
  (N'PFWD01', N'PFWD01-M12-D24', NULL, NULL, N'230', NULL, NULL, NULL, N'18565724', NULL, NULL, N'qualidade energia', N'controlador FP dinamico 230Vca medicao 100-690V', N'WAU10/2026'),
  (N'CTSW', N'CTSW15D23-C03', 15, 15, N'220', NULL, NULL, 15, N'18569128', NULL, NULL, N'qualidade energia', N'chave tiristorizada capacitor 15kVAr 220V', N'WAU10/2026'),
  (N'CTSW', N'CTSW25D23-C03', 25, 25, N'220', NULL, NULL, 25, N'18569129', NULL, NULL, N'qualidade energia', N'chave tiristorizada capacitor 25kVAr 220V', N'WAU10/2026'),
  (N'CTSW', N'CTSW50D23-C03', 50, 50, N'220', NULL, NULL, 50, N'18569130', NULL, NULL, N'qualidade energia', N'chave tiristorizada capacitor 50kVAr 220V', N'WAU10/2026'),
  (N'CTSW', N'CTSW15D34-C03', 15, 15, N'400', NULL, NULL, 15, N'17139329', NULL, NULL, N'qualidade energia', N'chave tiristorizada capacitor 15kVAr 380-400V', N'WAU10/2026'),
  (N'CTSW', N'CTSW25D34-C03', 25, 25, N'400', NULL, NULL, 25, N'17139330', NULL, NULL, N'qualidade energia', N'chave tiristorizada capacitor 25kVAr 380-400V', N'WAU10/2026'),
  (N'CTSW', N'CTSW50D34-C03', 50, 50, N'400', NULL, NULL, 50, N'17139331', NULL, NULL, N'qualidade energia', N'chave tiristorizada capacitor 50kVAr 380-400V', N'WAU10/2026'),
  (N'CTSW', N'CTSW15D36-C03', 15, 15, N'440', NULL, NULL, 15, N'18571517', NULL, NULL, N'qualidade energia', N'chave tiristorizada capacitor 15kVAr 380-440V', N'WAU10/2026'),
  (N'CTSW', N'CTSW25D36-C03', 25, 25, N'440', NULL, NULL, 25, N'18571679', NULL, NULL, N'qualidade energia', N'chave tiristorizada capacitor 25kVAr 380-440V', N'WAU10/2026'),
  (N'CTSW', N'CTSW50D36-C03', 50, 50, N'440', NULL, NULL, 50, N'18571680', NULL, NULL, N'qualidade energia', N'chave tiristorizada capacitor 50kVAr 380-440V', N'WAU10/2026'),
  (N'CTSW', N'CTSW15D39-C02', 15, 15, N'480', NULL, NULL, 15, N'17139332', NULL, NULL, N'qualidade energia', N'chave tiristorizada capacitor 15kVAr 380-480V', N'WAU10/2026'),
  (N'CTSW', N'CTSW25D39-C02', 25, 25, N'480', NULL, NULL, 25, N'17139334', NULL, NULL, N'qualidade energia', N'chave tiristorizada capacitor 25kVAr 380-480V', N'WAU10/2026'),
  (N'CTSW', N'CTSW50D39-C02', 50, 50, N'480', NULL, NULL, 50, N'17139335', NULL, NULL, N'qualidade energia', N'chave tiristorizada capacitor 50kVAr 380-480V', N'WAU10/2026'),
  (N'CTSW', N'CTSW15D48-C02', 15, 15, N'690', NULL, NULL, 15, N'17139337', NULL, NULL, N'qualidade energia', N'chave tiristorizada capacitor 15kVAr 380-690V', N'WAU10/2026'),
  (N'CTSW', N'CTSW25D48-C02', 25, 25, N'690', NULL, NULL, 25, N'17139479', NULL, NULL, N'qualidade energia', N'chave tiristorizada capacitor 25kVAr 380-690V', N'WAU10/2026'),
  (N'CTSW', N'CTSW50D48-C02', 50, 50, N'690', NULL, NULL, 50, N'17139480', NULL, NULL, N'qualidade energia', N'chave tiristorizada capacitor 50kVAr 380-690V', N'WAU10/2026')
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
