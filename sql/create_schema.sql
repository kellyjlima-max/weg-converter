-- ============================================================
-- WEG Products – Azure SQL Database Schema
-- Run once against the Azure SQL Database
-- ============================================================

-- Drop if exists (dev/reset only)
-- DROP TABLE IF EXISTS weg_produtos;

CREATE TABLE weg_produtos (
    id               INT IDENTITY(1,1)  PRIMARY KEY,
    familia          NVARCHAR(30)  NOT NULL,       -- CWM, RW, MPW, CFW500, SSW900, UCWT, etc.
    codigo           NVARCHAR(150) NOT NULL,        -- Referência WEG completa
    corrente_min     DECIMAL(10,2) NULL,            -- A (faixa inferior ou corrente AC-3)
    corrente_max     DECIMAL(10,2) NULL,            -- A (faixa superior ou corrente AC-3)
    tensao_v         NVARCHAR(50)  NULL,            -- V (bobina para contatores; alimentação para drives; nominal para caps)
    potencia_kw      DECIMAL(10,3) NULL,            -- kW (drives, soft-starters)
    potencia_cv      DECIMAL(10,3) NULL,            -- CV/HP (PDW, PDWM, drives)
    potencia_kvar    DECIMAL(10,2) NULL,            -- kVAr (capacitores, bancos, filtros)
    sap_code         NVARCHAR(50)  NULL,            -- Código WAU/SAP principal
    sap_alt          NVARCHAR(500) NULL,            -- Códigos SAP alternativos (JSON ou texto)
    preco            DECIMAL(12,2) NULL,            -- Preço lista R$
    categoria        NVARCHAR(80)  NULL,            -- Contator, Relé Sobrecarga, Disjuntor-Motor, etc.
    subtipo          NVARCHAR(200) NULL,            -- Detalhes: série, faixa de uso, contator compat.
    observacoes      NVARCHAR(1000) NULL,           -- Alertas e notas técnicas
    ativo            BIT           NOT NULL DEFAULT 1,
    data_atualizacao DATE          NOT NULL DEFAULT GETDATE()
);

-- Índices de busca primários
CREATE INDEX IX_wp_familia
    ON weg_produtos (familia)
    WHERE ativo = 1;

CREATE INDEX IX_wp_familia_corrente
    ON weg_produtos (familia, corrente_min, corrente_max)
    WHERE ativo = 1;

CREATE INDEX IX_wp_familia_kvar
    ON weg_produtos (familia, potencia_kvar)
    WHERE ativo = 1;

CREATE INDEX IX_wp_familia_kw
    ON weg_produtos (familia, potencia_kw)
    WHERE ativo = 1;

CREATE INDEX IX_wp_familia_cv
    ON weg_produtos (familia, potencia_cv)
    WHERE ativo = 1;

CREATE INDEX IX_wp_sap
    ON weg_produtos (sap_code)
    WHERE ativo = 1;
