-- =============================================================================
-- Migration: Variantes de bobina CWM / CWB  (todos os SAP codes por tensão)
-- Fonte: Lista de Preços Drives, Controls, Segurança & Sensores 07/2026
-- Problema resolvido: MERGE anterior usava codigo como chave única, sobrescrevia
--                     todos os SAP de bobinas diferentes pelo mesmo código base.
-- Solução: cada variante recebe codigo único (ex: CWM18-10-30-V26)
-- =============================================================================

SET NOCOUNT ON;

MERGE INTO weg_produtos AS target
USING (VALUES

-- ===========================================================================
-- CWM  CONTATORES 50/60Hz  (série D — bobina CA 50/60Hz)
-- ===========================================================================

-- CWM9-10-30 D-series (9A, 4kW/6HP)
('CWM9-10-30-D02','CWM',9,9,220,4,6,NULL,'10045468',NULL,NULL,'contator','CWM','Bobina 24V CA 50/60Hz',1),
('CWM9-10-30-D13','CWM',9,9,220,4,6,NULL,'10045459',NULL,NULL,'contator','CWM','Bobina 110V CA 50/60Hz',1),
('CWM9-10-30-D23','CWM',9,9,220,4,6,NULL,'10045457',NULL,NULL,'contator','CWM','Bobina 220V CA 50/60Hz',1),
('CWM9-10-30-D33','CWM',9,9,220,4,6,NULL,'10045458',NULL,NULL,'contator','CWM','Bobina 380V CA 50/60Hz',1),

-- CWM12-10-30 D-series (12A, 5.5kW/7.5HP)
('CWM12-10-30-D02','CWM',12,12,220,5.5,7.5,NULL,'10409944',NULL,NULL,'contator','CWM','Bobina 24V CA 50/60Hz',1),
('CWM12-10-30-D13','CWM',12,12,220,5.5,7.5,NULL,'10045467',NULL,NULL,'contator','CWM','Bobina 110V CA 50/60Hz',1),
('CWM12-10-30-D23','CWM',12,12,220,5.5,7.5,NULL,'10045466',NULL,NULL,'contator','CWM','Bobina 220V CA 50/60Hz',1),
('CWM12-10-30-D33','CWM',12,12,220,5.5,7.5,NULL,'10045465',NULL,NULL,'contator','CWM','Bobina 380V CA 50/60Hz',1),

-- CWM18-10-30 D-series (18A, 7.5kW/10HP)
('CWM18-10-30-D02','CWM',18,18,220,7.5,10,NULL,'10409943',NULL,NULL,'contator','CWM','Bobina 24V CA 50/60Hz',1),
('CWM18-10-30-D13','CWM',18,18,220,7.5,10,NULL,'10045478',NULL,NULL,'contator','CWM','Bobina 110V CA 50/60Hz',1),
('CWM18-10-30-D23','CWM',18,18,220,7.5,10,NULL,'10185988',NULL,NULL,'contator','CWM','Bobina 220V CA 50/60Hz',1),
('CWM18-10-30-D33','CWM',18,18,220,7.5,10,NULL,'10045475',NULL,NULL,'contator','CWM','Bobina 380V CA 50/60Hz',1),

-- CWM25-00-30 D-series (25A, 11kW/15HP)
('CWM25-00-30-D02','CWM',25,25,220,11,15,NULL,'10045488',NULL,NULL,'contator','CWM','Bobina 24V CA 50/60Hz',1),
('CWM25-00-30-D13','CWM',25,25,220,11,15,NULL,'10045491',NULL,NULL,'contator','CWM','Bobina 110V CA 50/60Hz',1),
('CWM25-00-30-D23','CWM',25,25,220,11,15,NULL,'10045484',NULL,NULL,'contator','CWM','Bobina 220V CA 50/60Hz',1),
('CWM25-00-30-D33','CWM',25,25,220,11,15,NULL,'10045485',NULL,NULL,'contator','CWM','Bobina 380V CA 50/60Hz',1),

-- CWM32-00-30 D-series (32A, 15kW/20HP)
('CWM32-00-30-D02','CWM',32,32,220,15,20,NULL,'10045502',NULL,NULL,'contator','CWM','Bobina 24V CA 50/60Hz',1),
('CWM32-00-30-D13','CWM',32,32,220,15,20,NULL,'10045503',NULL,NULL,'contator','CWM','Bobina 110V CA 50/60Hz',1),
('CWM32-00-30-D23','CWM',32,32,220,15,20,NULL,'10045495',NULL,NULL,'contator','CWM','Bobina 220V CA 50/60Hz',1),
('CWM32-00-30-D33','CWM',32,32,220,15,20,NULL,'10045500',NULL,NULL,'contator','CWM','Bobina 380V CA 50/60Hz',1),

-- CWM40-00-30 D-series (40A, 18.5kW/25HP)
('CWM40-00-30-D02','CWM',40,40,220,18.5,25,NULL,'10045549',NULL,NULL,'contator','CWM','Bobina 24V CA 50/60Hz',1),
('CWM40-00-30-D13','CWM',40,40,220,18.5,25,NULL,'10045546',NULL,NULL,'contator','CWM','Bobina 110V CA 50/60Hz',1),
('CWM40-00-30-D23','CWM',40,40,220,18.5,25,NULL,'10045504',NULL,NULL,'contator','CWM','Bobina 220V CA 50/60Hz',1),
('CWM40-00-30-D33','CWM',40,40,220,18.5,25,NULL,'10072066',NULL,NULL,'contator','CWM','Bobina 380V CA 50/60Hz',1),

-- CWM50-00-30 D-series (50A, 22kW/30HP)
('CWM50-00-30-D02','CWM',50,50,220,22,30,NULL,'10045554',NULL,NULL,'contator','CWM','Bobina 24V CA 50/60Hz',1),
('CWM50-00-30-D13','CWM',50,50,220,22,30,NULL,'10045552',NULL,NULL,'contator','CWM','Bobina 110V CA 50/60Hz',1),
('CWM50-00-30-D23','CWM',50,50,220,22,30,NULL,'10045516',NULL,NULL,'contator','CWM','Bobina 220V CA 50/60Hz',1),
('CWM50-00-30-D33','CWM',50,50,220,22,30,NULL,'10045553',NULL,NULL,'contator','CWM','Bobina 380V CA 50/60Hz',1),

-- CWM65-00-30 D-series (65A, 30kW/40HP)
('CWM65-00-30-D02','CWM',65,65,220,30,40,NULL,'10045560',NULL,NULL,'contator','CWM','Bobina 24V CA 50/60Hz',1),
('CWM65-00-30-D13','CWM',65,65,220,30,40,NULL,'10045561',NULL,NULL,'contator','CWM','Bobina 110V CA 50/60Hz',1),
('CWM65-00-30-D23','CWM',65,65,220,30,40,NULL,'10045525',NULL,NULL,'contator','CWM','Bobina 220V CA 50/60Hz',1),
('CWM65-00-30-D33','CWM',65,65,220,30,40,NULL,'10071435',NULL,NULL,'contator','CWM','Bobina 380V CA 50/60Hz',1),

-- CWM80-00-30 D-series (80A, 37kW/50HP)
('CWM80-00-30-D02','CWM',80,80,220,37,50,NULL,'10045568',NULL,NULL,'contator','CWM','Bobina 24V CA 50/60Hz',1),
('CWM80-00-30-D13','CWM',80,80,220,37,50,NULL,'10186231',NULL,NULL,'contator','CWM','Bobina 110V CA 50/60Hz',1),
('CWM80-00-30-D23','CWM',80,80,220,37,50,NULL,'10409953',NULL,NULL,'contator','CWM','Bobina 220V CA 50/60Hz',1),
('CWM80-00-30-D33','CWM',80,80,220,37,50,NULL,'10076197',NULL,NULL,'contator','CWM','Bobina 380V CA 50/60Hz',1),

-- CWM95-00-30 D-series (95A, 45kW/60HP)
('CWM95-00-30-D02','CWM',95,95,220,45,60,NULL,'10071290',NULL,NULL,'contator','CWM','Bobina 24V CA 50/60Hz',1),
('CWM95-00-30-D13','CWM',95,95,220,45,60,NULL,'10186014',NULL,NULL,'contator','CWM','Bobina 110V CA 50/60Hz',1),
('CWM95-00-30-D23','CWM',95,95,220,45,60,NULL,'10186007',NULL,NULL,'contator','CWM','Bobina 220V CA 50/60Hz',1),
('CWM95-00-30-D33','CWM',95,95,220,45,60,NULL,'10076198',NULL,NULL,'contator','CWM','Bobina 380V CA 50/60Hz',1),

-- CWM105-00-30 D-series (105A, 55kW/75HP)
('CWM105-00-30-D02','CWM',105,105,220,55,75,NULL,'10071287',NULL,NULL,'contator','CWM','Bobina 24V CA 50/60Hz',1),
('CWM105-00-30-D13','CWM',105,105,220,55,75,NULL,'10071594',NULL,NULL,'contator','CWM','Bobina 110V CA 50/60Hz',1),
('CWM105-00-30-D23','CWM',105,105,220,55,75,NULL,'10045548',NULL,NULL,'contator','CWM','Bobina 220V CA 50/60Hz',1),
('CWM105-00-30-D33','CWM',105,105,220,55,75,NULL,'10076199',NULL,NULL,'contator','CWM','Bobina 380V CA 50/60Hz',1),

-- CWM112-22-30 D-series (112A, 55kW/75HP)
('CWM112-22-30-D02','CWM',112,112,220,55,75,NULL,'10789753',NULL,NULL,'contator','CWM','Bobina 24V CA 50/60Hz',1),
('CWM112-22-30-D13','CWM',112,112,220,55,75,NULL,'10046220',NULL,NULL,'contator','CWM','Bobina 110V CA 50/60Hz',1),
('CWM112-22-30-D23','CWM',112,112,220,55,75,NULL,'10046222',NULL,NULL,'contator','CWM','Bobina 220V CA 50/60Hz',1),
('CWM112-22-30-D33','CWM',112,112,220,55,75,NULL,'10648787',NULL,NULL,'contator','CWM','Bobina 380V CA 50/60Hz',1),

-- ===========================================================================
-- CWM  CONTATORES 60Hz  (série V — bobina CA 60Hz somente)
-- ===========================================================================

-- CWM9-10-30 V-series
('CWM9-10-30-V04','CWM',9,9,220,4,6,NULL,'10409927',NULL,NULL,'contator','CWM','Bobina 24V CA 60Hz',1),
('CWM9-10-30-V15','CWM',9,9,220,4,6,NULL,'10185964',NULL,NULL,'contator','CWM','Bobina 110V CA 60Hz',1),
('CWM9-10-30-V26','CWM',9,9,220,4,6,NULL,'10045399',NULL,NULL,'contator','CWM','Bobina 220V CA 60Hz',1),
('CWM9-10-30-V41','CWM',9,9,220,4,6,NULL,'10045400',NULL,NULL,'contator','CWM','Bobina 380V CA 60Hz',1),

-- CWM12-10-30 V-series
('CWM12-10-30-V04','CWM',12,12,220,5.5,7.5,NULL,'10409929',NULL,NULL,'contator','CWM','Bobina 24V CA 60Hz',1),
('CWM12-10-30-V15','CWM',12,12,220,5.5,7.5,NULL,'10045404',NULL,NULL,'contator','CWM','Bobina 110V CA 60Hz',1),
('CWM12-10-30-V26','CWM',12,12,220,5.5,7.5,NULL,'10045405',NULL,NULL,'contator','CWM','Bobina 220V CA 60Hz',1),
('CWM12-10-30-V41','CWM',12,12,220,5.5,7.5,NULL,'10045406',NULL,NULL,'contator','CWM','Bobina 380V CA 60Hz',1),

-- CWM18-10-30 V-series  ← 10045410 = V26 (código do cliente)
('CWM18-10-30-V04','CWM',18,18,220,7.5,10,NULL,'10409931',NULL,NULL,'contator','CWM','Bobina 24V CA 60Hz',1),
('CWM18-10-30-V15','CWM',18,18,220,7.5,10,NULL,'10045409',NULL,NULL,'contator','CWM','Bobina 110V CA 60Hz',1),
('CWM18-10-30-V26','CWM',18,18,220,7.5,10,NULL,'10045410',NULL,NULL,'contator','CWM','Bobina 220V CA 60Hz',1),
('CWM18-10-30-V41','CWM',18,18,220,7.5,10,NULL,'10045411',NULL,NULL,'contator','CWM','Bobina 380V CA 60Hz',1),

-- CWM25-00-30 V-series  ← 10185968 = V26
('CWM25-00-30-V04','CWM',25,25,220,11,15,NULL,'10409933',NULL,NULL,'contator','CWM','Bobina 24V CA 60Hz',1),
('CWM25-00-30-V15','CWM',25,25,220,11,15,NULL,'10045415',NULL,NULL,'contator','CWM','Bobina 110V CA 60Hz',1),
('CWM25-00-30-V26','CWM',25,25,220,11,15,NULL,'10185968',NULL,NULL,'contator','CWM','Bobina 220V CA 60Hz',1),
('CWM25-00-30-V41','CWM',25,25,220,11,15,NULL,'10045416',NULL,NULL,'contator','CWM','Bobina 380V CA 60Hz',1),

-- CWM32-00-30 V-series  ← 10045454 = V26
('CWM32-00-30-V04','CWM',32,32,220,15,20,NULL,'10409941',NULL,NULL,'contator','CWM','Bobina 24V CA 60Hz',1),
('CWM32-00-30-V15','CWM',32,32,220,15,20,NULL,'10045453',NULL,NULL,'contator','CWM','Bobina 110V CA 60Hz',1),
('CWM32-00-30-V26','CWM',32,32,220,15,20,NULL,'10045454',NULL,NULL,'contator','CWM','Bobina 220V CA 60Hz',1),
('CWM32-00-30-V41','CWM',32,32,220,15,20,NULL,'10185982',NULL,NULL,'contator','CWM','Bobina 380V CA 60Hz',1),

-- CWM40-00-30 V-series
('CWM40-00-30-V04','CWM',40,40,220,18.5,25,NULL,'10451936',NULL,NULL,'contator','CWM','Bobina 24V CA 60Hz',1),
('CWM40-00-30-V15','CWM',40,40,220,18.5,25,NULL,'10045542',NULL,NULL,'contator','CWM','Bobina 110V CA 60Hz',1),
('CWM40-00-30-V26','CWM',40,40,220,18.5,25,NULL,'10045506',NULL,NULL,'contator','CWM','Bobina 220V CA 60Hz',1),
('CWM40-00-30-V41','CWM',40,40,220,18.5,25,NULL,'10045543',NULL,NULL,'contator','CWM','Bobina 380V CA 60Hz',1),

-- CWM50-00-30 V-series
('CWM50-00-30-V04','CWM',50,50,220,22,30,NULL,'10451945',NULL,NULL,'contator','CWM','Bobina 24V CA 60Hz',1),
('CWM50-00-30-V15','CWM',50,50,220,22,30,NULL,'10045519',NULL,NULL,'contator','CWM','Bobina 110V CA 60Hz',1),
('CWM50-00-30-V26','CWM',50,50,220,22,30,NULL,'10186001',NULL,NULL,'contator','CWM','Bobina 220V CA 60Hz',1),
('CWM50-00-30-V41','CWM',50,50,220,22,30,NULL,'10045518',NULL,NULL,'contator','CWM','Bobina 380V CA 60Hz',1),

-- CWM65-00-30 V-series
('CWM65-00-30-V04','CWM',65,65,220,30,40,NULL,'10451940',NULL,NULL,'contator','CWM','Bobina 24V CA 60Hz',1),
('CWM65-00-30-V15','CWM',65,65,220,30,40,NULL,'10045602',NULL,NULL,'contator','CWM','Bobina 110V CA 60Hz',1),
('CWM65-00-30-V26','CWM',65,65,220,30,40,NULL,'10045524',NULL,NULL,'contator','CWM','Bobina 220V CA 60Hz',1),
('CWM65-00-30-V41','CWM',65,65,220,30,40,NULL,'10045558',NULL,NULL,'contator','CWM','Bobina 380V CA 60Hz',1),

-- CWM80-00-30 V-series
('CWM80-00-30-V04','CWM',80,80,220,37,50,NULL,'10451943',NULL,NULL,'contator','CWM','Bobina 24V CA 60Hz',1),
('CWM80-00-30-V15','CWM',80,80,220,37,50,NULL,'10045601',NULL,NULL,'contator','CWM','Bobina 110V CA 60Hz',1),
('CWM80-00-30-V26','CWM',80,80,220,37,50,NULL,'10045530',NULL,NULL,'contator','CWM','Bobina 220V CA 60Hz',1),
('CWM80-00-30-V41','CWM',80,80,220,37,50,NULL,'10045566',NULL,NULL,'contator','CWM','Bobina 380V CA 60Hz',1),

-- CWM95-00-30 V-series
('CWM95-00-30-V04','CWM',95,95,220,45,60,NULL,'10452081',NULL,NULL,'contator','CWM','Bobina 24V CA 60Hz',1),
('CWM95-00-30-V15','CWM',95,95,220,45,60,NULL,'10046143',NULL,NULL,'contator','CWM','Bobina 110V CA 60Hz',1),
('CWM95-00-30-V26','CWM',95,95,220,45,60,NULL,'10045536',NULL,NULL,'contator','CWM','Bobina 220V CA 60Hz',1),
('CWM95-00-30-V41','CWM',95,95,220,45,60,NULL,'10071438',NULL,NULL,'contator','CWM','Bobina 380V CA 60Hz',1),

-- CWM105-00-30 V-series
('CWM105-00-30-V04','CWM',105,105,220,55,75,NULL,'10451872',NULL,NULL,'contator','CWM','Bobina 24V CA 60Hz',1),
('CWM105-00-30-V15','CWM',105,105,220,55,75,NULL,'10045603',NULL,NULL,'contator','CWM','Bobina 110V CA 60Hz',1),
('CWM105-00-30-V26','CWM',105,105,220,55,75,NULL,'10186012',NULL,NULL,'contator','CWM','Bobina 220V CA 60Hz',1),
('CWM105-00-30-V41','CWM',105,105,220,55,75,NULL,'10071463',NULL,NULL,'contator','CWM','Bobina 380V CA 60Hz',1),

-- CWM112-22-30 V-series
('CWM112-22-30-V04','CWM',112,112,220,55,75,NULL,'10648801',NULL,NULL,'contator','CWM','Bobina 24V CA 60Hz',1),
('CWM112-22-30-V15','CWM',112,112,220,55,75,NULL,'10409917',NULL,NULL,'contator','CWM','Bobina 110V CA 60Hz',1),
('CWM112-22-30-V26','CWM',112,112,220,55,75,NULL,'10409918',NULL,NULL,'contator','CWM','Bobina 220V CA 60Hz',1),
('CWM112-22-30-V41','CWM',112,112,220,55,75,NULL,'10071355',NULL,NULL,'contator','CWM','Bobina 380V CA 60Hz',1),

-- ===========================================================================
-- CWB  CONTATORES CA  50/60Hz  (série D — bobina CA 50/60Hz)
-- ===========================================================================

-- CWB9-11-30 D-series (9A)
('CWB9-11-30-D02','CWB',9,9,220,4,6,NULL,'12660800',NULL,NULL,'contator','CWB','Bobina 24V CA 50/60Hz',1),
('CWB9-11-30-D13','CWB',9,9,220,4,6,NULL,'12660801',NULL,NULL,'contator','CWB','Bobina 110V CA 50/60Hz',1),
('CWB9-11-30-D23','CWB',9,9,220,4,6,NULL,'12220434',NULL,NULL,'contator','CWB','Bobina 220V CA 50/60Hz',1),
('CWB9-11-30-D33','CWB',9,9,220,4,6,NULL,'12660802',NULL,NULL,'contator','CWB','Bobina 380V CA 50/60Hz',1),

-- CWB12-11-30 D-series (12A)
('CWB12-11-30-D02','CWB',12,12,220,5.5,7.5,NULL,'12660803',NULL,NULL,'contator','CWB','Bobina 24V CA 50/60Hz',1),
('CWB12-11-30-D13','CWB',12,12,220,5.5,7.5,NULL,'12660804',NULL,NULL,'contator','CWB','Bobina 110V CA 50/60Hz',1),
('CWB12-11-30-D23','CWB',12,12,220,5.5,7.5,NULL,'12220435',NULL,NULL,'contator','CWB','Bobina 220V CA 50/60Hz',1),
('CWB12-11-30-D33','CWB',12,12,220,5.5,7.5,NULL,'12660805',NULL,NULL,'contator','CWB','Bobina 380V CA 50/60Hz',1),

-- CWB18-11-30 D-series (18A)
('CWB18-11-30-D02','CWB',18,18,220,7.5,10,NULL,'12660806',NULL,NULL,'contator','CWB','Bobina 24V CA 50/60Hz',1),
('CWB18-11-30-D13','CWB',18,18,220,7.5,10,NULL,'12660807',NULL,NULL,'contator','CWB','Bobina 110V CA 50/60Hz',1),
('CWB18-11-30-D23','CWB',18,18,220,7.5,10,NULL,'12220436',NULL,NULL,'contator','CWB','Bobina 220V CA 50/60Hz',1),
('CWB18-11-30-D33','CWB',18,18,220,7.5,10,NULL,'12660848',NULL,NULL,'contator','CWB','Bobina 380V CA 50/60Hz',1),

-- CWB25-11-30 D-series (25A)  ← 12075682 = D23 (código do cliente)
('CWB25-11-30-D02','CWB',25,25,220,11,15,NULL,'12232932',NULL,NULL,'contator','CWB','Bobina 24V CA 50/60Hz',1),
('CWB25-11-30-D13','CWB',25,25,220,11,15,NULL,'12232934',NULL,NULL,'contator','CWB','Bobina 110V CA 50/60Hz',1),
('CWB25-11-30-D23','CWB',25,25,220,11,15,NULL,'12075682',NULL,NULL,'contator','CWB','Bobina 220V CA 50/60Hz',1),
('CWB25-11-30-D33','CWB',25,25,220,11,15,NULL,'12232935',NULL,NULL,'contator','CWB','Bobina 380V CA 50/60Hz',1),

-- CWB32-11-30 D-series (32A)  ← 12240799 = D23 (código do cliente)
('CWB32-11-30-D02','CWB',32,32,220,15,20,NULL,'12240777',NULL,NULL,'contator','CWB','Bobina 24V CA 50/60Hz',1),
('CWB32-11-30-D13','CWB',32,32,220,15,20,NULL,'12240798',NULL,NULL,'contator','CWB','Bobina 110V CA 50/60Hz',1),
('CWB32-11-30-D23','CWB',32,32,220,15,20,NULL,'12240799',NULL,NULL,'contator','CWB','Bobina 220V CA 50/60Hz',1),
('CWB32-11-30-D33','CWB',32,32,220,15,20,NULL,'12240800',NULL,NULL,'contator','CWB','Bobina 380V CA 50/60Hz',1),

-- CWB38-11-30 D-series (38A)
('CWB38-11-30-D02','CWB',38,38,220,18.5,25,NULL,'12232937',NULL,NULL,'contator','CWB','Bobina 24V CA 50/60Hz',1),
('CWB38-11-30-D13','CWB',38,38,220,18.5,25,NULL,'12233028',NULL,NULL,'contator','CWB','Bobina 110V CA 50/60Hz',1),
('CWB38-11-30-D23','CWB',38,38,220,18.5,25,NULL,'12075684',NULL,NULL,'contator','CWB','Bobina 220V CA 50/60Hz',1),
('CWB38-11-30-D33','CWB',38,38,220,18.5,25,NULL,'12233029',NULL,NULL,'contator','CWB','Bobina 380V CA 50/60Hz',1),

-- CWB40-11-30 D-series (40A)
('CWB40-11-30-D02','CWB',40,40,220,18.5,25,NULL,'13543410',NULL,NULL,'contator','CWB','Bobina 24V CA 50/60Hz',1),
('CWB40-11-30-D13','CWB',40,40,220,18.5,25,NULL,'13851360',NULL,NULL,'contator','CWB','Bobina 110V CA 50/60Hz',1),
('CWB40-11-30-D23','CWB',40,40,220,18.5,25,NULL,'13539284',NULL,NULL,'contator','CWB','Bobina 220V CA 50/60Hz',1),
('CWB40-11-30-D33','CWB',40,40,220,18.5,25,NULL,'13851361',NULL,NULL,'contator','CWB','Bobina 380V CA 50/60Hz',1),

-- CWB50-11-30 D-series (50A)
('CWB50-11-30-D02','CWB',50,50,220,22,30,NULL,'13851363',NULL,NULL,'contator','CWB','Bobina 24V CA 50/60Hz',1),
('CWB50-11-30-D13','CWB',50,50,220,22,30,NULL,'13851365',NULL,NULL,'contator','CWB','Bobina 110V CA 50/60Hz',1),
('CWB50-11-30-D23','CWB',50,50,220,22,30,NULL,'13539285',NULL,NULL,'contator','CWB','Bobina 220V CA 50/60Hz',1),
('CWB50-11-30-D33','CWB',50,50,220,22,30,NULL,'13860342',NULL,NULL,'contator','CWB','Bobina 380V CA 50/60Hz',1),

-- CWB65-11-30 D-series (65A)
('CWB65-11-30-D02','CWB',65,65,220,30,40,NULL,'13851366',NULL,NULL,'contator','CWB','Bobina 24V CA 50/60Hz',1),
('CWB65-11-30-D13','CWB',65,65,220,30,40,NULL,'13851367',NULL,NULL,'contator','CWB','Bobina 110V CA 50/60Hz',1),
('CWB65-11-30-D23','CWB',65,65,220,30,40,NULL,'13539298',NULL,NULL,'contator','CWB','Bobina 220V CA 50/60Hz',1),
('CWB65-11-30-D33','CWB',65,65,220,30,40,NULL,'13860343',NULL,NULL,'contator','CWB','Bobina 380V CA 50/60Hz',1),

-- CWB80-11-30 D-series (80A)
('CWB80-11-30-D02','CWB',80,80,220,37,50,NULL,'13860240',NULL,NULL,'contator','CWB','Bobina 24V CA 50/60Hz',1),
('CWB80-11-30-D13','CWB',80,80,220,37,50,NULL,'13851448',NULL,NULL,'contator','CWB','Bobina 110V CA 50/60Hz',1),
('CWB80-11-30-D23','CWB',80,80,220,37,50,NULL,'12370329',NULL,NULL,'contator','CWB','Bobina 220V CA 50/60Hz',1),
('CWB80-11-30-D33','CWB',80,80,220,37,50,NULL,'13860344',NULL,NULL,'contator','CWB','Bobina 380V CA 50/60Hz',1),

-- CWB95-11-30 D-series (95A)
('CWB95-11-30-D02','CWB',95,95,220,45,60,NULL,'15257932',NULL,NULL,'contator','CWB','Bobina 24V CA 50/60Hz',1),
('CWB95-11-30-D13','CWB',95,95,220,45,60,NULL,'15177767',NULL,NULL,'contator','CWB','Bobina 110V CA 50/60Hz',1),
('CWB95-11-30-D23','CWB',95,95,220,45,60,NULL,'14079987',NULL,NULL,'contator','CWB','Bobina 220V CA 50/60Hz',1),
('CWB95-11-30-D33','CWB',95,95,220,45,60,NULL,'15258083',NULL,NULL,'contator','CWB','Bobina 380V CA 50/60Hz',1)

) AS source (codigo, familia, corrente_min, corrente_max, tensao_v, potencia_kw, potencia_cv, potencia_kvar,
             sap_code, sap_alt, preco, categoria, subtipo, observacoes, ativo)
ON target.sap_code = source.sap_code

WHEN MATCHED THEN
    UPDATE SET
        target.codigo       = source.codigo,
        target.familia      = source.familia,
        target.corrente_min = source.corrente_min,
        target.corrente_max = source.corrente_max,
        target.tensao_v     = source.tensao_v,
        target.potencia_kw  = source.potencia_kw,
        target.potencia_cv  = source.potencia_cv,
        target.categoria    = source.categoria,
        target.subtipo      = source.subtipo,
        target.observacoes  = source.observacoes,
        target.ativo        = source.ativo,
        target.data_atualizacao = GETDATE()

WHEN NOT MATCHED BY TARGET THEN
    INSERT (codigo, familia, corrente_min, corrente_max, tensao_v, potencia_kw, potencia_cv, potencia_kvar,
            sap_code, sap_alt, preco, categoria, subtipo, observacoes, ativo, data_atualizacao)
    VALUES (source.codigo, source.familia, source.corrente_min, source.corrente_max, source.tensao_v,
            source.potencia_kw, source.potencia_cv, source.potencia_kvar,
            source.sap_code, source.sap_alt, source.preco, source.categoria, source.subtipo,
            source.observacoes, source.ativo, GETDATE());

-- Verificação pós-migration
SELECT 'CWM18 V26 (10045410)' AS teste, COUNT(*) AS encontrado FROM weg_produtos WHERE sap_code = '10045410'
UNION ALL
SELECT 'CWB25 D23 (12075682)', COUNT(*) FROM weg_produtos WHERE sap_code = '12075682'
UNION ALL
SELECT 'CWB32 D23 (12240799)', COUNT(*) FROM weg_produtos WHERE sap_code = '12240799'
UNION ALL
SELECT 'CWM25 V26 (10185968)', COUNT(*) FROM weg_produtos WHERE sap_code = '10185968'
UNION ALL
SELECT 'CWM32 V26 (10045454)', COUNT(*) FROM weg_produtos WHERE sap_code = '10045454';
