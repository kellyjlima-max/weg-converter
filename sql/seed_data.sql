-- ============================================================
-- WEG Products – Seed Data
-- Source: Lista de Preços WAU 07/2026 + Circulares WAU 13-27/2026
-- ============================================================

SET NOCOUNT ON;
BEGIN TRANSACTION;

-- ── PMW01 – Painéis (WAU 13/2026) ──────────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,sap_code,categoria,subtipo,observacoes)
VALUES
('PMW','PMW01-20.066','19082923','Painel','2000x600x600 mm sem laterais','RAL 7035; Circular WAU 13/2026'),
('PMW','PMW01-20.068','19082951','Painel','2000x600x800 mm sem laterais','RAL 7035'),
('PMW','PMW01-20.086','19082952','Painel','2000x800x600 mm sem laterais','RAL 7035'),
('PMW','PMW01-20.088','19082953','Painel','2000x800x800 mm sem laterais','RAL 7035'),
('PMW','PMW01-20.106','19082955','Painel','2000x1000x600 mm sem laterais','RAL 7035'),
('PMW','PMW01-20.108','19082957','Painel','2000x1000x800 mm sem laterais','RAL 7035'),
('PMW','PMW01-23.066','19082960','Painel','2300x600x600 mm sem laterais','RAL 7035'),
('PMW','PMW01-23.068','19082961','Painel','2300x600x800 mm sem laterais','RAL 7035'),
('PMW','PMW01-23.086','19082962','Painel','2300x800x600 mm sem laterais','RAL 7035'),
('PMW','PMW01-23.088','19082963','Painel','2300x800x800 mm sem laterais','RAL 7035'),
('PMW','PMW01-23.106','19082964','Painel','2300x1000x600 mm sem laterais','RAL 7035'),
('PMW','PMW01-23.108','19082965','Painel','2300x1000x800 mm sem laterais','RAL 7035');

-- ── Switch PoE (WAU 14/2026) ───────────────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('SWITCH','SWITCH WEG M04-P31','18615490',456.68,'Switch PoE','4 portas PoE+, 2 Uplink','65 W total, até 30 W/porta; família WCAM; WAU 14/2026');

-- ── Câmeras IP (WAU 15/2026) ───────────────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('WCAM','WCAM IP-M022-B41','18573342',1207.30,'Câmera IP','Bullet 2MP Full HD IR 40m','Night Color+, Mic+Alto-falante, ONVIF, MicroSD 1TB, IP66; WAU 15/2026'),
('WCAM','WCAM IP-M022-D41','18573343',1207.30,'Câmera IP','Dome 2MP Full HD IR 40m','Night Color+, Mic+Alto-falante, ONVIF, MicroSD 1TB, IP66; WAU 15/2026');

-- ── SPW03 – Protetores de Surto CA (WAU 27/2026) ──────────────────────────
INSERT INTO weg_produtos (familia,codigo,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('SPW03','SPW03-275-12','17568718',107.95,'Protetor de Surto','CA 275V Classe II 12kA','Emb. 12 un. IPI 9,75%'),
('SPW03','SPW03-275-20','17568723',110.23,'Protetor de Surto','CA 275V Classe II 20kA','Emb. 12 un. IPI 9,75%'),
('SPW03','SPW03-275-45','17568725',193.18,'Protetor de Surto','CA 275V Classe II 45kA','Emb. 12 un. IPI 9,75%'),
('SPW03','SPW03-275-60/12,5','17568777',375.00,'Protetor de Surto','CA 275V Classe I/II 60kA','Emb. 12 un. IPI 9,75%'),
-- Gôndola (unit.)
('SPW03','SPW03-275-12','17568722',145.74,'Protetor de Surto','CA 275V Classe II 12kA','Gôndola 1 un. IPI 9,75%'),
('SPW03','SPW03-275-20','17568726',148.81,'Protetor de Surto','CA 275V Classe II 20kA','Gôndola 1 un. IPI 9,75%'),
('SPW03','SPW03-275-45','17568727',222.16,'Protetor de Surto','CA 275V Classe II 45kA','Gôndola 1 un. IPI 9,75%'),
('SPW03','SPW03-275-60/12,5','17568792',393.75,'Protetor de Surto','CA 275V Classe I/II 60kA','Gôndola 1 un. IPI 9,75%'),
-- Com contato de sinalização
('SPW03','SPW03-275-12-C','17568770',329.70,'Protetor de Surto','CA 275V Classe II 12kA c/contato','Emb. 12 un. IPI 9,75%'),
('SPW03','SPW03-275-20-C','17568771',346.19,'Protetor de Surto','CA 275V Classe II 20kA c/contato','Emb. 12 un. IPI 9,75%'),
('SPW03','SPW03-275-45-C','17568774',410.79,'Protetor de Surto','CA 275V Classe II 45kA c/contato','Emb. 12 un. IPI 9,75%'),
('SPW03','SPW03-275-60/12,5-C','17568795',575.28,'Protetor de Surto','CA 275V Classe I/II 60kA c/contato','Emb. 12 un. IPI 9,75%'),
-- Módulos de reposição
('SPW03','SPW03-275-12-M','17568879',84.15,'Protetor de Surto','Módulo reposição 12kA','Emb. 24 un.'),
('SPW03','SPW03-275-20-M','17568880',88.36,'Protetor de Surto','Módulo reposição 20kA','Emb. 24 un.'),
('SPW03','SPW03-275-45-M','17568882',150.29,'Protetor de Surto','Módulo reposição 45kA','Emb. 24 un.');

INSERT INTO weg_produtos (familia,codigo,tensao_v,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('SPW13','SPW13-600-40','600',17568796,576.51,'Protetor de Surto','CC/FV 600V 40kA','Emb. 4 un.'),
('SPW13','SPW13-1100-40','1100',17568797,610.88,'Protetor de Surto','CC/FV 1100V 40kA','Emb. 4 un.');

-- ── CWM – Contatores Série D (220V, bobina D23) ────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,tensao_v,potencia_kw,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('CWM','CWM9-10-30',9,9,'220',3,'10045457',441.99,'Contator','Série D 220V 1NA','3kW@220V 5kW@380V; aux D13=110V SAP varia'),
('CWM','CWM9-01-30',9,9,'220',3,'10045460',441.99,'Contator','Série D 220V 1NF',''),
('CWM','CWM12-10-30',12,12,'220',4,'10045464',471.88,'Contator','Série D 220V 1NA','4kW@220V 7,5kW@380V'),
('CWM','CWM18-10-30',18,18,'220',6,'10185988',500.64,'Contator','Série D 220V 1NA','6kW@220V 10kW@380V'),
('CWM','CWM18-01-30',18,18,'220',6,'10045476',500.64,'Contator','Série D 220V 1NF',''),
('CWM','CWM25-00-30',25,25,'220',7.5,'10045484',586.09,'Contator','Série D 220V sem aux','7,5kW@220V 15kW@380V'),
('CWM','CWM32-00-30',32,32,'220',12.5,'10045495',962.39,'Contator','Série D 220V sem aux','12,5kW@220V 20kW@380V'),
('CWM','CWM40-00-30',40,40,'220',15,'10045504',1259.74,'Contator','Série D 220V sem aux','15kW@220V 25kW@380V'),
('CWM','CWM50-00-30',50,50,'220',20,'10045516',1722.95,'Contator','Série D 220V sem aux','20kW@220V 30kW@380V'),
('CWM','CWM65-00-30',65,65,'220',25,'10045525',2426.20,'Contator','Série D 220V sem aux','25kW@220V 40kW@380V'),
('CWM','CWM80-00-30',80,80,'220',30,'10409953',3281.89,'Contator','Série D 220V sem aux','30kW@220V 50kW@380V'),
('CWM','CWM95-00-30',95,95,'220',30,'10186007',3892.58,'Contator','Série D 220V sem aux','30kW@220V 60kW@380V'),
('CWM','CWM105-00-30',105,105,'220',40,'10045548',4560.63,'Contator','Série D 220V sem aux','40kW@220V 75kW@380V'),
('CWM','CWM112-22-30',112,112,'220',40,'10046222',5466.27,'Contator','Série D 220V 2NA+2NF','40kW@220V 75kW@380V'),
('CWM','CWM180-22-30',180,180,'220',75,'10045398',7876.72,'Contator','Série D 220V 2NA+2NF','75kW@220V 125kW@380V'),
('CWM','CWM250-22-30',250,250,'220',100,'10071222',15803.92,'Contator','Série D 220V 2NA+2NF','100kW@220V 175kW@380V');

-- ── CWM – Contatores Série D (380V, bobina D33) ────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,tensao_v,potencia_kw,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('CWM','CWM9-10-30',9,9,'380',5,'10045458',441.99,'Contator','Série D 380V 1NA',''),
('CWM','CWM9-01-30',9,9,'380',5,'10045462',441.99,'Contator','Série D 380V 1NF',''),
('CWM','CWM12-10-30',12,12,'380',7.5,'10045465',471.88,'Contator','Série D 380V 1NA',''),
('CWM','CWM18-10-30',18,18,'380',10,'10045475',500.64,'Contator','Série D 380V 1NA',''),
('CWM','CWM18-01-30',18,18,'380',10,'10045480',500.64,'Contator','Série D 380V 1NF',''),
('CWM','CWM25-00-30',25,25,'380',15,'10045485',586.09,'Contator','Série D 380V sem aux',''),
('CWM','CWM32-00-30',32,32,'380',20,'10045500',962.39,'Contator','Série D 380V sem aux',''),
('CWM','CWM40-00-30',40,40,'380',25,'10072066',1259.74,'Contator','Série D 380V sem aux',''),
('CWM','CWM50-00-30',50,50,'380',30,'10045553',1722.95,'Contator','Série D 380V sem aux',''),
('CWM','CWM65-00-30',65,65,'380',40,'10071435',2426.20,'Contator','Série D 380V sem aux',''),
('CWM','CWM80-00-30',80,80,'380',50,'10076197',3281.89,'Contator','Série D 380V sem aux',''),
('CWM','CWM95-00-30',95,95,'380',60,'10076198',3892.58,'Contator','Série D 380V sem aux',''),
('CWM','CWM105-00-30',105,105,'380',75,'10076199',4560.63,'Contator','Série D 380V sem aux',''),
('CWM','CWM112-22-30',112,112,'380',75,'10648787',5466.27,'Contator','Série D 380V 2NA+2NF',''),
('CWM','CWM180-22-30',180,180,'380',125,'10071794',7876.72,'Contator','Série D 380V 2NA+2NF',''),
('CWM','CWM250-22-30',250,250,'380',175,'10647242',15803.92,'Contator','Série D 380V 2NA+2NF','');

-- ── CWM – Módulo Eletrônico CA/CC (112-1260A) ─────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,tensao_v,potencia_kw,sap_code,sap_alt,preco,categoria,subtipo,observacoes)
VALUES
('CWM','CWM112-22-30',112,112,'24',75,'10535725','E65:16119964',6045.04,'Contator','Módulo Eletrônico 24V','SAP E02=10535725 (24V); SAP E65=16119964 (110-255V)'),
('CWM','CWM150-22-30',150,150,'24',100,'10535726','E65:16119967',6704.02,'Contator','Módulo Eletrônico 24V','SAP E02=10535726; E65=16119967'),
('CWM','CWM180-22-30',180,180,'24',125,'10535727','E65:16120038',8455.49,'Contator','Módulo Eletrônico 24V','SAP E02=10535727; E65=16120038'),
('CWM','CWM215-22-30',215,215,'24',150,'15288627','E65:16142112',10896.05,'Contator','Módulo Eletrônico 24V','SAP E02=15288627; E65=16142112'),
('CWM','CWM250-22-30',250,250,'24',175,'10535728','E65:16120040',17716.86,'Contator','Módulo Eletrônico 24V','SAP E02=10535728; E65=16120040'),
('CWM','CWM300-22-30',300,300,'24',200,'10535729','E65:16120042',21518.97,'Contator','Módulo Eletrônico 24V','SAP E02=10535729; E65=16120042'),
('CWM','CWM400-22-30',400,400,'24',300,'11747363',NULL,25133.38,'Contator','Módulo Eletrônico E36','SAP E36=11747363'),
('CWM','CWM450-22-30',450,450,'110',350,NULL,'E65:14266987',28400.68,'Contator','Módulo Eletrônico E65','SAP E65=14266987'),
('CWM','CWM500-22-30',500,500,'24',350,'11747433',NULL,38211.15,'Contator','Módulo Eletrônico E39','SAP E39=11747433'),
('CWM','CWM560-22-30',560,560,'110',400,NULL,'E65:10837670',31230.23,'Contator','Módulo Eletrônico E65','SAP E65=10837670'),
('CWM','CWM630-22-30',630,630,'24',450,'11747434',NULL,48482.58,'Contator','Módulo Eletrônico E39','SAP E39=11747434'),
('CWM','CWM800-22-30',800,800,'24',600,'11747436',NULL,63324.77,'Contator','Módulo Eletrônico E39','SAP E39=11747436'),
('CWM','CWM1260-22-30',1260,1260,'24',NULL,'16015887',NULL,73773.35,'Contator','Módulo Eletrônico E36','SAP E36=16015887');

-- ── CWMC – Contatores para Capacitores (60Hz) ─────────────────────────────
INSERT INTO weg_produtos (familia,codigo,potencia_kvar,tensao_v,sap_code,sap_alt,preco,categoria,subtipo,observacoes)
VALUES
('CWMC','CWMC9-10-30',10,'380','12713066','X26:12713060',762.24,'Contator Capacitor','380V X41 / 220V X26','kVAr@380V=10; kVAr@220V=6'),
('CWMC','CWMC18-10-30',15,'380','12615600','X26:12387956',824.45,'Contator Capacitor','380V X41 / 220V X26','kVAr@380V=15; kVAr@220V=8'),
('CWMC','CWMC25-10-30',20,'380','11486210','X26:11471428',962.49,'Contator Capacitor','380V X41 / 220V X26','kVAr@380V=20; kVAr@220V=11'),
('CWMC','CWMC32-10-30',26,'380','11486226','X26:11471896',1286.47,'Contator Capacitor','380V X41 / 220V X26','kVAr@380V=26; kVAr@220V=15'),
('CWMC','CWMC50-10-30',40,'380','11486244','X26:11486237',2257.85,'Contator Capacitor','380V X41 / 220V X26','kVAr@380V=40; kVAr@220V=25'),
('CWMC','CWMC65-10-30',50,'380','11486268','X26:11486254',3134.92,'Contator Capacitor','380V X41 / 220V X26','kVAr@380V=50; kVAr@220V=30'),
('CWMC','CWMC80-10-30',61,'380','12256300','X26:12256299',4432.79,'Contator Capacitor','380V X41 / 220V X26','kVAr@380V=61; kVAr@220V=35');

-- ── RW27-1D3 – Relé Sobrecarga Térmico (para CWM9-40) ────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('RW','RW27-1D3-D004',0.28,0.4,'10045630',407.59,'Relé Sobrecarga','RW27 para CWM9-40','Classe 10'),
('RW','RW27-1D3-C063',0.4,0.63,'10186032',407.59,'Relé Sobrecarga','RW27 para CWM9-40','Classe 10'),
('RW','RW27-1D3-D008',0.56,0.8,'10186033',407.59,'Relé Sobrecarga','RW27 para CWM9-40','Classe 10'),
('RW','RW27-1D3-D012',0.8,1.2,'10045631',407.59,'Relé Sobrecarga','RW27 para CWM9-40','Classe 10'),
('RW','RW27-1D3-D018',1.2,1.8,'10045632',407.59,'Relé Sobrecarga','RW27 para CWM9-40','Classe 10'),
('RW','RW27-1D3-D028',1.8,2.8,'10452548',407.59,'Relé Sobrecarga','RW27 para CWM9-40','Classe 10'),
('RW','RW27-1D3-U004',2.8,4,'10452213',407.59,'Relé Sobrecarga','RW27 para CWM9-40','Classe 10'),
('RW','RW27-1D3-D063',4,6.3,'10045633',407.59,'Relé Sobrecarga','RW27 para CWM9-40','Classe 10'),
('RW','RW27-1D3-U008',5.6,8,'10452197',407.59,'Relé Sobrecarga','RW27 para CWM9-40','Classe 10'),
('RW','RW27-1D3-U010',7,10,'10045634',407.59,'Relé Sobrecarga','RW27 para CWM9-40','Classe 10'),
('RW','RW27-1D3-D125',8,12.5,'10452967',407.59,'Relé Sobrecarga','RW27 para CWM9-40','Classe 10'),
('RW','RW27-1D3-U015',10,15,'10452384',407.59,'Relé Sobrecarga','RW27 para CWM9-40','Classe 10'),
('RW','RW27-1D3-U017',11,17,'10452204',449.66,'Relé Sobrecarga','RW27 para CWM9-40','Classe 10'),
('RW','RW27-1D3-U023',15,23,'10452205',449.66,'Relé Sobrecarga','RW27 para CWM9-40','Classe 10'),
('RW','RW27-1D3-U032',22,32,'10452382',449.66,'Relé Sobrecarga','RW27 para CWM9-40','Classe 10');

-- ── RW67-1D3 – Relé Sobrecarga (para CWM32/40) ────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('RW','RW67-1D3-U040',25,40,'10452216',841.94,'Relé Sobrecarga','RW67 para CWM32-40','Classe 10'),
('RW','RW67-1D3-U050',32,50,'10452217',841.94,'Relé Sobrecarga','RW67 para CWM32-40','Classe 10');

-- ── RW67-2D3 – Relé Sobrecarga (para CWM50-80) ────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('RW','RW67-2D3-U040',25,40,'10844133',961.99,'Relé Sobrecarga','RW67 para CWM50-80','Classe 10'),
('RW','RW67-2D3-U050',32,50,'10186035',961.99,'Relé Sobrecarga','RW67 para CWM50-80','Classe 10'),
('RW','RW67-2D3-U057',40,57,'10452201',961.99,'Relé Sobrecarga','RW67 para CWM50-80','Classe 10'),
('RW','RW67-2D3-U063',50,63,'10452218',961.99,'Relé Sobrecarga','RW67 para CWM50-80','Classe 10'),
('RW','RW67-2D3-U070',57,70,'10045635',1133.64,'Relé Sobrecarga','RW67 para CWM50-80','Classe 10'),
('RW','RW67-2D3-U080',63,80,'10045636',1417.07,'Relé Sobrecarga','RW67 para CWM50-80','Classe 10');

-- ── RW117-1D3 – Relé Sobrecarga (para CWM95-105) ──────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('RW','RW117-1D3-U080',63,80,'10186370',1441.76,'Relé Sobrecarga','RW117 para CWM95-105','Classe 10'),
('RW','RW117-1D3-U097',75,97,'10410002',1465.47,'Relé Sobrecarga','RW117 para CWM95-105','Classe 10'),
('RW','RW117-1D3-U112',90,112,'10410003',1465.47,'Relé Sobrecarga','RW117 para CWM95-105','Classe 10');

-- ── RW117-2D3 – Relé Sobrecarga (para CWM112) ─────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('RW','RW117-2D3-U080',63,80,'11033689',1699.54,'Relé Sobrecarga','RW117 para CWM112','Classe 10'),
('RW','RW117-2D3-U097',75,97,'10045646',1723.25,'Relé Sobrecarga','RW117 para CWM112','Classe 10'),
('RW','RW117-2D3-U112',90,112,'10410004',1723.25,'Relé Sobrecarga','RW117 para CWM112','Classe 10');

-- ── RW317-1D3 – Relé Sobrecarga (para CWM112-450) ─────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('RW','RW317-1D3-U150',100,150,'10045647',2230.65,'Relé Sobrecarga','RW317 para CWM112-450','Classe 10'),
('RW','RW317-1D3-U215',140,215,'10410005',2230.65,'Relé Sobrecarga','RW317 para CWM112-450','Classe 10'),
('RW','RW317-1D3-U310',200,310,'10410006',3294.27,'Relé Sobrecarga','RW317 para CWM112-450','Classe 10'),
('RW','RW317-1D3-U420',275,420,'10410007',3294.27,'Relé Sobrecarga','RW317 para CWM112-450','Classe 10');

-- ── RW407-1D3 – Relé Sobrecarga (para CWM500-800) ─────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('RW','RW407-1D3-U600',400,600,'10452250',4752.62,'Relé Sobrecarga','RW407 para CWM500-800','Classe 10'),
('RW','RW407-1D3-U840',560,840,'10045637',6349.46,'Relé Sobrecarga','RW407 para CWM500-800','Classe 10');

-- ── RW – Série CWB ─────────────────────────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('RW','RW27-2D3-D004',0.28,0.4,'12140441',407.59,'Relé Sobrecarga','RW27 para CWB9-38','Classe 10'),
('RW','RW27-2D3-U017',11,17,'12140453',449.66,'Relé Sobrecarga','RW27 para CWB9-38','Classe 10'),
('RW','RW27-2D3-U032',22,32,'12140455',449.66,'Relé Sobrecarga','RW27 para CWB9-38','Classe 10'),
('RW','RW27-2D3-U040',32,40,'12140456',517.04,'Relé Sobrecarga','RW27 para CWB9-38','Classe 10'),
('RW','RW67-5D3-U040',25,40,'13368960',961.99,'Relé Sobrecarga','RW67 para CWB40-80','Classe 10'),
('RW','RW67-5D3-U080',63,80,'13368965',1417.29,'Relé Sobrecarga','RW67 para CWB40-80','Classe 10'),
('RW','RW117-3D3-U112',90,112,'14204761',1465.47,'Relé Sobrecarga','RW117 para CWB95-125','Classe 10'),
('RW','RW117-3D3-U140',110,140,'14204762',1538.72,'Relé Sobrecarga','RW117 para CWB95-125','Classe 10'),
('RW','RW317-5D3-U165',110,165,'17225764',2230.65,'Relé Sobrecarga','RW317 para CWB150-225','Classe 10'),
('RW','RW317-5D3-U310',200,310,'17312968',3294.27,'Relé Sobrecarga','RW317 para CWB265-500','Classe 10'),
('RW','RW317-5D3-U520',350,520,'18226971',4000.15,'Relé Sobrecarga','RW317 para CWB265-500','Classe 10');

-- ── RWM – Relés Eletrônicos Classe 10/20/30 ───────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('RWM','RWM40E-3-R4U002',0.4,2,'14773683',2869.00,'Relé Sobrecarga Eletrônico','RWM para CWM9-40','Classe 10/20/30 selecionável'),
('RWM','RWM40E-3-R4U008',1.6,8,'14773682',2869.00,'Relé Sobrecarga Eletrônico','RWM para CWM9-40','Classe 10/20/30 selecionável'),
('RWM','RWM40E-3-R4U025',5,25,'14773680',2869.00,'Relé Sobrecarga Eletrônico','RWM para CWM9-40','Classe 10/20/30 selecionável'),
('RWM','RWM40E-3-R4U040',8,40,'14773678',4160.05,'Relé Sobrecarga Eletrônico','RWM para CWM9-40','Classe 10/20/30 selecionável'),
('RWM','RWM112E-3-R4U056',14,56,'14773686',4373.66,'Relé Sobrecarga Eletrônico','RWM para CWM50-105','Classe 10/20/30 selecionável'),
('RWM','RWM112E-3-R4U112',28,112,'14773718',4373.66,'Relé Sobrecarga Eletrônico','RWM para CWM50-105','Classe 10/20/30 selecionável'),
('RWM','RWM420E-3-R4U250',50,250,'14773721',6484.30,'Relé Sobrecarga Eletrônico','RWM para CWM112-250','Classe 10/20/30 selecionável'),
('RWM','RWM420E-3-R4U420',85,420,'14773720',7690.41,'Relé Sobrecarga Eletrônico','RWM para CWM112-450','Classe 10/20/30 selecionável'),
('RWM','RWM840E-3-R4U840',170,840,'14773723',9665.37,'Relé Sobrecarga Eletrônico','RWM para CWM180-800','Classe 10/20/30 selecionável');

-- ── MPW18-3 – Disjuntor-Motor (100kA) ─────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('MPW','MPW18-3-C016',0.10,0.16,'12429311',658.71,'Disjuntor-Motor','MPW18 100kA 3P','Icu 100/100/100kA @220/380/440V'),
('MPW','MPW18-3-C025',0.16,0.25,'12429312',658.71,'Disjuntor-Motor','MPW18 100kA 3P',''),
('MPW','MPW18-3-D004',0.25,0.40,'12429313',658.71,'Disjuntor-Motor','MPW18 100kA 3P',''),
('MPW','MPW18-3-C063',0.40,0.63,'12429315',673.41,'Disjuntor-Motor','MPW18 100kA 3P',''),
('MPW','MPW18-3-U001',0.63,1.0,'12429317',673.41,'Disjuntor-Motor','MPW18 100kA 3P',''),
('MPW','MPW18-3-D016',1.0,1.6,'12429368',744.11,'Disjuntor-Motor','MPW18 100kA 3P',''),
('MPW','MPW18-3-D025',1.6,2.5,'12429369',744.11,'Disjuntor-Motor','MPW18 100kA 3P',''),
('MPW','MPW18-3-U004',2.5,4.0,'12429370',744.11,'Disjuntor-Motor','MPW18 100kA 3P',''),
('MPW','MPW18-3-D063',4.0,6.3,'12429371',744.11,'Disjuntor-Motor','MPW18 100kA 3P',''),
('MPW','MPW18-3-U010',6.3,10,'12429372',868.50,'Disjuntor-Motor','MPW18 100kA 3P',''),
('MPW','MPW18-3-U016',10,16,'12429373',868.50,'Disjuntor-Motor','MPW18 100kA 3P',''),
('MPW','MPW18-3-U018',12,18,'12429374',923.70,'Disjuntor-Motor','MPW18 100kA 3P','');

-- ── MPW40-3 – Disjuntor-Motor ──────────────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('MPW','MPW40-3-C016',0.10,0.16,'12428084',762.30,'Disjuntor-Motor','MPW40 3P','Icu 100kA<6,3A; 50kA<25A; 30kA<40A @220V'),
('MPW','MPW40-3-C025',0.16,0.25,'12428085',762.30,'Disjuntor-Motor','MPW40 3P',''),
('MPW','MPW40-3-D004',0.25,0.40,'12428086',762.30,'Disjuntor-Motor','MPW40 3P',''),
('MPW','MPW40-3-C063',0.40,0.63,'12428087',816.00,'Disjuntor-Motor','MPW40 3P',''),
('MPW','MPW40-3-U001',0.63,1.0,'12429239',816.00,'Disjuntor-Motor','MPW40 3P',''),
('MPW','MPW40-3-D016',1.0,1.6,'12428108',901.69,'Disjuntor-Motor','MPW40 3P',''),
('MPW','MPW40-3-D025',1.6,2.5,'12428110',901.69,'Disjuntor-Motor','MPW40 3P',''),
('MPW','MPW40-3-U004',2.5,4.0,'12428111',901.69,'Disjuntor-Motor','MPW40 3P',''),
('MPW','MPW40-3-D063',4.0,6.3,'12428115',901.69,'Disjuntor-Motor','MPW40 3P',''),
('MPW','MPW40-3-U010',6.3,10,'12428117',1052.34,'Disjuntor-Motor','MPW40 3P',''),
('MPW','MPW40-3-U016',10,16,'12428128',1052.34,'Disjuntor-Motor','MPW40 3P',''),
('MPW','MPW40-3-U020',16,20,'12428129',1106.53,'Disjuntor-Motor','MPW40 3P',''),
('MPW','MPW40-3-U025',20,25,'12428133',1106.53,'Disjuntor-Motor','MPW40 3P',''),
('MPW','MPW40-3-U032',25,32,'12428131',1493.69,'Disjuntor-Motor','MPW40 3P',''),
('MPW','MPW40-3-U040',32,40,'12382551',1717.71,'Disjuntor-Motor','MPW40 3P','');

-- ── MPW80-3 – Disjuntor-Motor ──────────────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('MPW','MPW80-3-U040',32,40,'12425347',3311.63,'Disjuntor-Motor','MPW80 3P','Icu 100/65/65kA'),
('MPW','MPW80-3-U050',40,50,'12425428',3311.63,'Disjuntor-Motor','MPW80 3P',''),
('MPW','MPW80-3-U065',50,65,'12425429',3311.63,'Disjuntor-Motor','MPW80 3P',''),
('MPW','MPW80-3-U080',65,80,'12501063',3852.73,'Disjuntor-Motor','MPW80 3P','');

-- ── MPW100-3 – Disjuntor-Motor ─────────────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('MPW','MPW100-3-U075',55,75,'10076551',3966.63,'Disjuntor-Motor','MPW100 3P','Icu 100/75/50kA'),
('MPW','MPW100-3-U090',70,90,'10076552',4280.77,'Disjuntor-Motor','MPW100 3P',''),
('MPW','MPW100-3-U100',80,100,'10047295',4736.26,'Disjuntor-Motor','MPW100 3P','');

-- ── MPW12-3S – Disjuntor-Motor Terminal Mola ──────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('MPW','MPW12-3-C016S',0.10,0.16,'12500989',724.53,'Disjuntor-Motor','MPW12S terminal mola','Icu 100kA DIN compacto'),
('MPW','MPW12-3-D016S',1.0,1.6,'12500993',818.55,'Disjuntor-Motor','MPW12S terminal mola',''),
('MPW','MPW12-3-D025S',1.6,2.5,'12500994',818.55,'Disjuntor-Motor','MPW12S terminal mola',''),
('MPW','MPW12-3-U004S',2.5,4.0,'12500997',818.55,'Disjuntor-Motor','MPW12S terminal mola',''),
('MPW','MPW12-3-D063S',4.0,6.3,'12500995',818.55,'Disjuntor-Motor','MPW12S terminal mola',''),
('MPW','MPW12-3-U010S',6.3,10,'12501028',955.38,'Disjuntor-Motor','MPW12S terminal mola',''),
('MPW','MPW12-3-U012S',8,12,'12501029',955.38,'Disjuntor-Motor','MPW12S terminal mola','');

-- ── MWL18-3 – Disjuntor-Motor Econômico ───────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('MWL','MWL18-3-C016',0.10,0.16,'14158005',490.08,'Disjuntor-Motor','MWL18 econômico 3P','Icu 80/65kA @240/415V; 60Hz'),
('MWL','MWL18-3-U001',0.63,1.0,'14159085',556.90,'Disjuntor-Motor','MWL18 econômico 3P',''),
('MWL','MWL18-3-D016',1.0,1.6,'14159086',556.90,'Disjuntor-Motor','MWL18 econômico 3P',''),
('MWL','MWL18-3-D025',1.6,2.5,'14159087',556.90,'Disjuntor-Motor','MWL18 econômico 3P',''),
('MWL','MWL18-3-U004',2.5,4.0,'14159180',556.90,'Disjuntor-Motor','MWL18 econômico 3P',''),
('MWL','MWL18-3-D063',4.0,6.3,'14159182',556.90,'Disjuntor-Motor','MWL18 econômico 3P',''),
('MWL','MWL18-3-U010',6.3,10,'14159188',556.90,'Disjuntor-Motor','MWL18 econômico 3P',''),
('MWL','MWL18-3-U016',10,16,'14159193',556.90,'Disjuntor-Motor','MWL18 econômico 3P',''),
('MWL','MWL18-3-U018',12,18,'14159194',556.90,'Disjuntor-Motor','MWL18 econômico 3P','');

-- ── PDW – Partida Direta Trifásica 380V ────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,tensao_v,potencia_cv,sap_code,categoria,subtipo,observacoes)
VALUES
('PDW','PDW02-0,16V40',0.4,0.63,'380',0.16,'10072580','Partida Direta','Trifásica 380V','SAP confirmado; faixa relé 0,4-0,63A'),
('PDW','PDW02-0,25V40',0.56,0.8,'380',0.25,'10186081','Partida Direta','Trifásica 380V','SAP confirmado'),
('PDW','PDW02-0,33V40',0.8,1.2,'380',0.33,'10186082','Partida Direta','Trifásica 380V','SAP confirmado'),
('PDW','PDW02-0,75V40',1.2,1.8,'380',0.75,'10045784','Partida Direta','Trifásica 380V','0,5/0,75CV; SAP confirmado'),
('PDW','PDW02-1,5V40',1.8,2.8,'380',1.5,'10118384','Partida Direta','Trifásica 380V','1/1,5CV; SAP confirmado'),
('PDW','PDW02-2V40',2.8,4,'380',2,'10045787','Partida Direta','Trifásica 380V','SAP confirmado'),
('PDW','PDW02-3V40',4,6.3,'380',3,'10045788','Partida Direta','Trifásica 380V','SAP confirmado'),
('PDW','PDW02-4V40',5.6,8,'380',4,'10045789','Partida Direta','Trifásica 380V','SAP confirmado'),
('PDW','PDW04-5V40',7,10,'380',5,'10045790','Partida Direta','Trifásica 380V','SAP confirmado'),
('PDW','PDW04-6V40',8,12.5,'380',6,'10045791','Partida Direta','Trifásica 380V','SAP confirmado'),
('PDW','PDW04-7,5V40',10,15,'380',7.5,'10045792','Partida Direta','Trifásica 380V','SAP confirmado'),
('PDW','PDW04-10V40',11,17,'380',10,'10045793','Partida Direta','Trifásica 380V','SAP confirmado'),
('PDW','PDW04-12,5V40',15,23,'380',12.5,'10045794','Partida Direta','Trifásica 380V','SAP confirmado'),
('PDW','PDW04-15V40',22,32,'380',15,'10046425','Partida Direta','Trifásica 380V','SAP confirmado');

-- ── PDWM – Partida Direta Monofásica 220V ─────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,tensao_v,potencia_cv,sap_code,categoria,subtipo,observacoes)
VALUES
('PDWM','PDWM02-0,16/0,125V25',1.2,1.8,'220',0.16,'10070900','Partida Direta','Monofásica 220V','0,125/0,16CV; SAP confirmado'),
('PDWM','PDWM02-0,33V25',2.8,4,'220',0.33,'10046171','Partida Direta','Monofásica 220V','0,25/0,33CV; SAP confirmado'),
('PDWM','PDWM02-0,5/0,75V25',4,6.3,'220',0.75,'10046170','Partida Direta','Monofásica 220V','0,5/0,75CV; SAP confirmado'),
('PDWM','PDWM02-1V25',5.6,8,'220',1,'10118357','Partida Direta','Monofásica 220V','0,75/1CV; SAP confirmado'),
('PDWM','PDWM04-1,5AV25',7,10,'220',1.5,'10907057','Partida Direta','Monofásica 220V','SAP confirmado'),
('PDWM','PDWM04-2A/1,5NV25',8,12.5,'220',2,'10045728','Partida Direta','Monofásica 220V','SAP confirmado'),
('PDWM','PDWM04-3/2V25',11,17,'220',3,'10045729','Partida Direta','Monofásica 220V','SAP confirmado'),
('PDWM','PDWM04-4AV25',15,23,'220',4,'10045739','Partida Direta','Monofásica 220V','SAP confirmado'),
('PDWM','PDWM04-5AV25',22,32,'220',5,'10046444','Partida Direta','Monofásica 220V','SAP confirmado'),
('PDWM','PDWM05-2A/1,5NV25',8,12.5,'220',2,'13339233','Partida Direta','Monofásica 220V','SAP confirmado'),
('PDWM','PDWM05-3/2V25',11,17,'220',3,'13339229','Partida Direta','Monofásica 220V','SAP confirmado'),
('PDWM','PDWM05-4AV25',15,23,'220',4,'13339270','Partida Direta','Monofásica 220V','SAP confirmado'),
('PDWM','PDWM05-5AV25',22,32,'220',5,'13339236','Partida Direta','Monofásica 220V','SAP confirmado'),
('PDWM','PDWM05-7,5AV25',32,40,'220',7.5,'13336722','Partida Direta','Monofásica 220V','SAP confirmado'),
('PDWM','PDWM06-7,5AV25',32,40,'220',7.5,'10045740','Partida Direta','Monofásica 220V','SAP confirmado'),
('PDWM','PDWM08-10AV25',32,50,'220',10,'10045766','Partida Direta','Monofásica 220V','SAP confirmado'),
('PDWM','PDWM08-12,5AV25',40,57,'220',12.5,'10045741','Partida Direta','Monofásica 220V','SAP confirmado'),
('PDWM','PDWM08-15AV25',57,70,'220',15,'10046182','Partida Direta','Monofásica 220V','SAP confirmado');

-- ── PFW03 – Controlador Automático FP (50/60 Hz) ──────────────────────────
INSERT INTO weg_produtos (familia,codigo,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('PFW03','PFW03-M08','14387138',7763.64,'Controlador FP','Monofásico 8 estágios 50/60Hz',''),
('PFW03','PFW03-M12','14387141',8829.11,'Controlador FP','Monofásico 12 estágios 50/60Hz',''),
('PFW03','PFW03-M24','14387143',10855.43,'Controlador FP','Monofásico 24 estágios 50/60Hz',''),
('PFW03','PFW03-T12','14387080',12021.08,'Controlador FP','Trifásico 12 estágios 50/60Hz',''),
('PFW03','PFW03-T24','14387086',14398.90,'Controlador FP','Trifásico 24 estágios 50/60Hz','');

-- ── PFW01 – Controlador Automático FP ─────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('PFW01','PFW01-M06','11335175',8928.16,'Controlador FP','Monofásico 6 estágios 60Hz',''),
('PFW01','PFW01-M06-50','12240101',8928.16,'Controlador FP','Monofásico 6 estágios 50Hz',''),
('PFW01','PFW01-M12','11335221',10153.45,'Controlador FP','Monofásico 12 estágios 60Hz',''),
('PFW01','PFW01-M12-50','12240107',10153.45,'Controlador FP','Monofásico 12 estágios 50Hz',''),
('PFW01','PFW01-T06','11335223',13824.23,'Controlador FP','Trifásico 6 estágios 60Hz',''),
('PFW01','PFW01-T06-50','12240102',13824.23,'Controlador FP','Trifásico 6 estágios 50Hz',''),
('PFW01','PFW01-T12','11335176',14546.85,'Controlador FP','Trifásico 12 estágios 60Hz',''),
('PFW01','PFW01-T12-50','12240168',14546.85,'Controlador FP','Trifásico 12 estágios 50Hz','');

-- ── PFWD01 – Controlador Dinâmico FP ─────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,tensao_v,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('PFWD01','PFWD01-M12-D34','400','17633710',21680.59,'Controlador FP Dinâmico','400Vca alim. e medição','Para cargas variáveis rápidas; saída tiristor'),
('PFWD01','PFWD01-M12-D24','230','18565724',20428.92,'Controlador FP Dinâmico','230Vca alim. 100-690V medição','');

-- ── CTSW – Chave Tiristorizada para Capacitores ───────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,tensao_v,potencia_kvar,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('CTSW','CTSW15D23-C03',39,39,'220',15,'18569128',11772.51,'Chave Tiristorizada','220V 15kVAr',''),
('CTSW','CTSW25D23-C03',66,66,'220',25,'18569129',12989.34,'Chave Tiristorizada','220V 25kVAr',''),
('CTSW','CTSW50D23-C03',131,131,'220',50,'18569130',14359.27,'Chave Tiristorizada','220V 50kVAr',''),
('CTSW','CTSW15D34-C03',22,22,'380',15,'17139329',15398.11,'Chave Tiristorizada','380V 8-15kVAr',''),
('CTSW','CTSW25D34-C03',36,36,'380',25,'17139330',22174.58,'Chave Tiristorizada','380V 14-25kVAr',''),
('CTSW','CTSW50D34-C03',72,72,'380',50,'17139331',23763.56,'Chave Tiristorizada','380V 28-50kVAr',''),
('CTSW','CTSW15D36-C03',20,20,'400',15,'18571517',17069.82,'Chave Tiristorizada','400V 8-15kVAr',''),
('CTSW','CTSW25D36-C03',33,33,'400',25,'18571679',20503.98,'Chave Tiristorizada','400V 13-25kVAr',''),
('CTSW','CTSW50D36-C03',66,66,'400',50,'18571680',24791.41,'Chave Tiristorizada','400V 25-50kVAr',''),
('CTSW','CTSW15D39-C02',18,18,'480',15,'17139332',11180.46,'Chave Tiristorizada','480V 7-15kVAr',''),
('CTSW','CTSW25D39-C02',30,30,'480',25,'17139334',12336.19,'Chave Tiristorizada','480V 11-25kVAr',''),
('CTSW','CTSW50D39-C02',60,60,'480',50,'17139335',13910.09,'Chave Tiristorizada','480V 23-50kVAr',''),
('CTSW','CTSW15D48-C02',13,13,'690',10,'17139337',14623.81,'Chave Tiristorizada','690V 5-10kVAr',''),
('CTSW','CTSW25D48-C02',21,21,'690',25,'17139479',16033.19,'Chave Tiristorizada','690V 8-25kVAr',''),
('CTSW','CTSW50D48-C02',42,42,'690',50,'17139480',17723.39,'Chave Tiristorizada','690V 16-50kVAr','');

-- ── AHFW – Filtro Ativo FP ─────────────────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,corrente_min,corrente_max,tensao_v,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('AHFW','AHFW 50V40 R',50,50,'440','17915874',90000.00,'Filtro Ativo','Rack 440V 60Hz 50A',''),
('AHFW','AHFW 100V40 R',100,100,'440','18049907',100114.17,'Filtro Ativo','Rack 440V 60Hz 100A',''),
('AHFW','AHFW 150V40 R',150,150,'440','18255105',93731.08,'Filtro Ativo','Rack 440V 60Hz 150A',''),
('AHFW','AHFW 50V53 R',50,50,'480','17916109',103809.72,'Filtro Ativo','Rack 480V 60Hz 50A',''),
('AHFW','AHFW 100V53 R',100,100,'480','18050410',134381.53,'Filtro Ativo','Rack 480V 60Hz 100A',''),
('AHFW','AHFW 150V53 R',150,150,'480','18255107',145041.58,'Filtro Ativo','Rack 480V 60Hz 150A',''),
('AHFW','AHFW 50V63 R',50,50,'690','18255494',147819.61,'Filtro Ativo','Rack 690V 60Hz 50A',''),
('AHFW','AHFW 100V63 R',100,100,'690','18255492',157898.26,'Filtro Ativo','Rack 690V 60Hz 100A',''),
('AHFW','AHFW 50V52 R',50,50,'480','18748363',154732.57,'Filtro Ativo','Rack 480V 50Hz 50A','50Hz'),
('AHFW','AHFW 100V52 R',100,100,'480','18748366',165392.63,'Filtro Ativo','Rack 480V 50Hz 100A','50Hz'),
('AHFW','AHFW 50V40 P',50,50,'440','17915876',179283.04,'Filtro Ativo','Parede 440V 60Hz 50A',''),
('AHFW','AHFW 100V40 P',100,100,'440','18050408',176052.76,'Filtro Ativo','Parede 440V 60Hz 100A',''),
('AHFW','AHFW 150V40 P',150,150,'440','18255106',206740.78,'Filtro Ativo','Parede 440V 60Hz 150A',''),
('AHFW','AHFW 50V53 P',50,50,'480','17916112',167976.91,'Filtro Ativo','Parede 480V 60Hz 50A',''),
('AHFW','AHFW 100V53 P',100,100,'480','18050412',93731.08,'Filtro Ativo','Parede 480V 60Hz 100A',''),
('AHFW','AHFW 50V52 P',50,50,'480','18748365',100114.17,'Filtro Ativo','Parede 480V 50Hz 50A','50Hz'),
('AHFW','AHFW 100V52 P',100,100,'480','18748538',93731.08,'Filtro Ativo','Parede 480V 50Hz 100A','50Hz');

-- ── UCW – Capacitor Monofásico 220V ───────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,tensao_v,potencia_kvar,sap_code,preco,categoria,subtipo)
VALUES
('UCW','UCW0,83V25 J4','220',0.83,'11488457',338.38,'Capacitor Monofásico','220V'),
('UCW','UCW1,67V25 L6','220',1.67,'10045802',365.95,'Capacitor Monofásico','220V'),
('UCW','UCW2,5V25 L10','220',2.50,'10045950',429.83,'Capacitor Monofásico','220V'),
('UCW','UCW3,33V25 L10','220',3.33,'10046652',547.37,'Capacitor Monofásico','220V'),
('UCW','UCW5V25 N14','220',5.00,'11449885',1084.93,'Capacitor Monofásico','220V'),
('UCW','UCW6,67V25 N14','220',6.67,'11507565',1189.92,'Capacitor Monofásico','220V');

-- UCW 380V
INSERT INTO weg_produtos (familia,codigo,tensao_v,potencia_kvar,sap_code,preco,categoria,subtipo)
VALUES
('UCW','UCW0,83V40 J2','380',0.83,'11488508',293.99,'Capacitor Monofásico','380V'),
('UCW','UCW1,67V40 J4','380',1.67,'11488510',305.06,'Capacitor Monofásico','380V'),
('UCW','UCW2,5V40 J6','380',2.50,'13497628',321.54,'Capacitor Monofásico','380V'),
('UCW','UCW3,33V40 J8','380',3.33,'11488809',409.50,'Capacitor Monofásico','380V'),
('UCW','UCW5V40 L10','380',5.00,'10045951',492.28,'Capacitor Monofásico','380V'),
('UCW','UCW6,67V40 M10','380',6.67,'10630797',708.63,'Capacitor Monofásico','380V'),
('UCW','UCW7,5V40 N14','380',7.50,'11449886',1084.93,'Capacitor Monofásico','380V'),
('UCW','UCW8,33V40 N14','380',8.33,'11449950',1123.18,'Capacitor Monofásico','380V'),
('UCW','UCW9,17V40 N14','380',9.17,'11449951',1137.15,'Capacitor Monofásico','380V'),
('UCW','UCW10V40 N14','380',10.00,'11449887',1189.92,'Capacitor Monofásico','380V');

-- UCW 440V
INSERT INTO weg_produtos (familia,codigo,tensao_v,potencia_kvar,sap_code,preco,categoria,subtipo)
VALUES
('UCW','UCW0,83V49 J2','440',0.83,'11488824',293.99,'Capacitor Monofásico','440V'),
('UCW','UCW1,67V49 J4','440',1.67,'11488825',305.06,'Capacitor Monofásico','440V'),
('UCW','UCW2,5V49 J6','440',2.50,'13497629',321.54,'Capacitor Monofásico','440V'),
('UCW','UCW3,33V49 J8','440',3.33,'11488827',382.40,'Capacitor Monofásico','440V'),
('UCW','UCW5V49 L10','440',5.00,'10186125',492.28,'Capacitor Monofásico','440V'),
('UCW','UCW6,67V49 M10','440',6.67,'10630798',708.63,'Capacitor Monofásico','440V'),
('UCW','UCW7,5V49 N14','440',7.50,'11449911',1084.93,'Capacitor Monofásico','440V'),
('UCW','UCW8,33V49 N14','440',8.33,'11449952',1123.18,'Capacitor Monofásico','440V'),
('UCW','UCW9,17V49 N14','440',9.17,'11449953',1137.15,'Capacitor Monofásico','440V'),
('UCW','UCW10V49 N14','440',10.00,'11449915',1189.92,'Capacitor Monofásico','440V');

-- UCW 480V
INSERT INTO weg_produtos (familia,codigo,tensao_v,potencia_kvar,sap_code,preco,categoria,subtipo)
VALUES
('UCW','UCW0,83V53 J2','480',0.83,'11488839',305.06,'Capacitor Monofásico','480V'),
('UCW','UCW2,5V53 J6','480',2.50,'13497630',332.97,'Capacitor Monofásico','480V'),
('UCW','UCW5V53 L10','480',5.00,'10045952',508.93,'Capacitor Monofásico','480V'),
('UCW','UCW6,67V53 M10','480',6.67,'10630800',732.70,'Capacitor Monofásico','480V'),
('UCW','UCW7,5V53 N14','480',7.50,'11449916',1084.93,'Capacitor Monofásico','480V'),
('UCW','UCW10V53 N14','480',10.00,'11449928',1189.92,'Capacitor Monofásico','480V');

-- ── UCWT HD – Capacitor Trifásico 220V ────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,tensao_v,potencia_kvar,sap_code,preco,categoria,subtipo)
VALUES
('UCWT','UCWT5V25 N20 HD','220',5.0,'11313760',980.11,'Capacitor Trifásico HD','220V'),
('UCWT','UCWT7,5V25 N22 HD','220',7.5,'11313783',1135.41,'Capacitor Trifásico HD','220V'),
('UCWT','UCWT10V25 N22 HD','220',10.0,'11313782',1670.72,'Capacitor Trifásico HD','220V'),
('UCWT','UCWT15V25 S26 HD','220',15.0,'11914853',2261.16,'Capacitor Trifásico HD','220V'),
('UCWT','UCWT20V25 S28 HD','220',20.0,'12271626',3327.67,'Capacitor Trifásico HD','220V'),
('UCWT','UCWT25V25 U28 HD','220',25.0,'13365111',4003.79,'Capacitor Trifásico HD','220V'),
('UCWT','UCWT30V25 U28 HD','220',30.0,'13365631',4296.20,'Capacitor Trifásico HD','220V');

-- UCWT HD 380V
INSERT INTO weg_produtos (familia,codigo,tensao_v,potencia_kvar,sap_code,preco,categoria,subtipo)
VALUES
('UCWT','UCWT0,5V40 L10 HD','380',0.5,'10046005',357.76,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT1V40 L10 HD','380',1.0,'10046007',375.95,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT2V40 L10 HD','380',2.0,'10046009',475.93,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT3V40 L10 HD','380',3.0,'10046011',560.60,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT5V40 L16 HD','380',5.0,'10046012',694.53,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT7,5V40 N20 HD','380',7.5,'11313784',919.58,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT10V40 N20 HD','380',10.0,'11313787',1077.14,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT12,5V40 N22 HD','380',12.5,'11313820',1162.09,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT15V40 N22 HD','380',15.0,'11313821',1495.53,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT17,5V40 Q26 HD','380',17.5,'11916880',1976.96,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT20V40 Q26 HD','380',20.0,'11916901',2146.58,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT25V40 S26 HD','380',25.0,'11916924',2301.51,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT30V40 S28 HD','380',30.0,'12272719',2991.02,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT35V40 S28 HD','380',35.0,'12267042',3387.10,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT40V40 U28 HD','380',40.0,'13365634',4078.51,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT45V40 U28 HD','380',45.0,'13365636',4204.72,'Capacitor Trifásico HD','380V'),
('UCWT','UCWT50V40 U28 HD','380',50.0,'13365637',4372.89,'Capacitor Trifásico HD','380V');

-- UCWT HD 440V
INSERT INTO weg_produtos (familia,codigo,tensao_v,potencia_kvar,sap_code,preco,categoria,subtipo)
VALUES
('UCWT','UCWT0,5V49 L10 HD','440',0.5,'10046013',368.85,'Capacitor Trifásico HD','440V'),
('UCWT','UCWT1V49 L10 HD','440',1.0,'10046015',391.87,'Capacitor Trifásico HD','440V'),
('UCWT','UCWT2V49 L10 HD','440',2.0,'10046017',501.65,'Capacitor Trifásico HD','440V'),
('UCWT','UCWT3V49 L10 HD','440',3.0,'10046019',590.90,'Capacitor Trifásico HD','440V'),
('UCWT','UCWT5V49 L16 HD','440',5.0,'10046020',749.41,'Capacitor Trifásico HD','440V'),
('UCWT','UCWT7,5V49 N20 HD','440',7.5,'11313663',968.17,'Capacitor Trifásico HD','440V'),
('UCWT','UCWT10V49 N20 HD','440',10.0,'11758279',1110.56,'Capacitor Trifásico HD','440V'),
('UCWT','UCWT12,5V49 N22 HD','440',12.5,'11313665',1211.14,'Capacitor Trifásico HD','440V'),
('UCWT','UCWT15V49 N22 HD','440',15.0,'11314666',1548.36,'Capacitor Trifásico HD','440V'),
('UCWT','UCWT20V49 Q26 HD','440',20.0,'11917007',2215.44,'Capacitor Trifásico HD','440V'),
('UCWT','UCWT25V49 S26 HD','440',25.0,'11917021',2350.69,'Capacitor Trifásico HD','440V'),
('UCWT','UCWT30V49 S28 HD','440',30.0,'12272780',3096.76,'Capacitor Trifásico HD','440V'),
('UCWT','UCWT35V49 S28 HD','440',35.0,'12272784',3449.48,'Capacitor Trifásico HD','440V'),
('UCWT','UCWT40V49 U28 HD','440',40.0,'13365671',4209.36,'Capacitor Trifásico HD','440V'),
('UCWT','UCWT45V49 U28 HD','440',45.0,'13365672',4351.24,'Capacitor Trifásico HD','440V'),
('UCWT','UCWT50V49 U28 HD','440',50.0,'13365673',4466.23,'Capacitor Trifásico HD','440V');

-- UCWT HD 480V
INSERT INTO weg_produtos (familia,codigo,tensao_v,potencia_kvar,sap_code,preco,categoria,subtipo)
VALUES
('UCWT','UCWT5V53 L16 HD','480',5.0,'10045997',817.60,'Capacitor Trifásico HD','480V'),
('UCWT','UCWT7,5V53 N20 HD','480',7.5,'11314667',1277.09,'Capacitor Trifásico HD','480V'),
('UCWT','UCWT10V53 N20 HD','480',10.0,'11314728',1368.57,'Capacitor Trifásico HD','480V'),
('UCWT','UCWT15V53 N22 HD','480',15.0,'11314730',2215.84,'Capacitor Trifásico HD','480V'),
('UCWT','UCWT20V53 Q26 HD','480',20.0,'11917064',2736.66,'Capacitor Trifásico HD','480V'),
('UCWT','UCWT25V53 S26 HD','480',25.0,'11917066',4124.53,'Capacitor Trifásico HD','480V'),
('UCWT','UCWT30V53 S28 HD','480',30.0,'12272781',4376.31,'Capacitor Trifásico HD','480V'),
('UCWT','UCWT40V53 U28 HD','480',40.0,'13365674',5199.72,'Capacitor Trifásico HD','480V'),
('UCWT','UCWT50V53 U28 HD','480',50.0,'13365677',7836.60,'Capacitor Trifásico HD','480V');

-- ── UCWT UHD – Ultra Heavy Duty ───────────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,tensao_v,potencia_kvar,sap_code,preco,categoria,subtipo,observacoes)
VALUES
('UCWT_UHD','UCWT5V25 Q26 UHD','220',5.0,'16207509',1896.53,'Capacitor Trifásico UHD','220V','Para chaves tiristorizadas e harmônicos elevados'),
('UCWT_UHD','UCWT10V25 S26 UHD','220',10.0,'16207513',3232.87,'Capacitor Trifásico UHD','220V',''),
('UCWT_UHD','UCWT15V25 U26 UHD','220',15.0,'16207515',4375.36,'Capacitor Trifásico UHD','220V',''),
('UCWT_UHD','UCWT5V40 N20 UHD','380',5.0,'16202791',1343.88,'Capacitor Trifásico UHD','380V',''),
('UCWT_UHD','UCWT10V40 Q26 UHD','380',10.0,'16202792',2084.27,'Capacitor Trifásico UHD','380V',''),
('UCWT_UHD','UCWT15V40 S26 UHD','380',15.0,'16202793',2893.81,'Capacitor Trifásico UHD','380V',''),
('UCWT_UHD','UCWT20V40 U26 UHD','380',20.0,'16202794',4153.61,'Capacitor Trifásico UHD','380V',''),
('UCWT_UHD','UCWT25V40 U26 UHD','380',25.0,'16202795',4453.43,'Capacitor Trifásico UHD','380V',''),
('UCWT_UHD','UCWT5V49 N20 UHD','440',5.0,'16216189',1450.14,'Capacitor Trifásico UHD','440V',''),
('UCWT_UHD','UCWT10V49 Q26 UHD','440',10.0,'16216190',2148.94,'Capacitor Trifásico UHD','440V',''),
('UCWT_UHD','UCWT15V49 S26 UHD','440',15.0,'16216192',2996.07,'Capacitor Trifásico UHD','440V',''),
('UCWT_UHD','UCWT20V49 U26 UHD','440',20.0,'16216194',4286.89,'Capacitor Trifásico UHD','440V',''),
('UCWT_UHD','UCWT25V49 U26 UHD','440',25.0,'16216196',4548.58,'Capacitor Trifásico UHD','440V',''),
('UCWT_UHD','UCWT5V53 N20 UHD','480',5.0,'16218131',1582.05,'Capacitor Trifásico UHD','480V',''),
('UCWT_UHD','UCWT10V53 Q26 UHD','480',10.0,'16218132',2648.19,'Capacitor Trifásico UHD','480V',''),
('UCWT_UHD','UCWT15V53 S26 UHD','480',15.0,'16218133',4287.68,'Capacitor Trifásico UHD','480V',''),
('UCWT_UHD','UCWT20V53 U26 UHD','480',20.0,'16218135',5295.46,'Capacitor Trifásico UHD','480V',''),
('UCWT_UHD','UCWT25V53 U26 UHD','480',25.0,'16218136',7980.99,'Capacitor Trifásico UHD','480V','');

-- ── MCW – Módulo Capacitivo Trifásico ─────────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,tensao_v,potencia_kvar,sap_code,preco,categoria,subtipo)
VALUES
('MCW','MCW2,5V25','220',2.5,'10045851',1465.55,'Módulo Capacitivo','220V'),
('MCW','MCW5V25','220',5.0,'10045799',1548.68,'Módulo Capacitivo','220V'),
('MCW','MCW7,5V25','220',7.5,'10186130',1780.56,'Módulo Capacitivo','220V'),
('MCW','MCW10V25','220',10.0,'10046861',2067.91,'Módulo Capacitivo','220V'),
('MCW','MCW15V25','220',15.0,'11425743',3827.85,'Módulo Capacitivo','220V'),
('MCW','MCW20V25','220',20.0,'10731824',4347.02,'Módulo Capacitivo','220V'),
('MCW','MCW25V25','220',25.0,'10731826',6109.54,'Módulo Capacitivo','220V'),
('MCW','MCW30V25','220',30.0,'11433567',6626.17,'Módulo Capacitivo','220V'),
('MCW','MCW2,5V40','380',2.5,'10452269',1423.68,'Módulo Capacitivo','380V'),
('MCW','MCW5V40','380',5.0,'10186090',1472.40,'Módulo Capacitivo','380V'),
('MCW','MCW7,5V40','380',7.5,'10186099',1575.53,'Módulo Capacitivo','380V'),
('MCW','MCW10V40','380',10.0,'10186092',1787.07,'Módulo Capacitivo','380V'),
('MCW','MCW15V40','380',15.0,'10186131',2108.63,'Módulo Capacitivo','380V'),
('MCW','MCW17,5V40','380',17.5,'11433568',3573.72,'Módulo Capacitivo','380V'),
('MCW','MCW20V40','380',20.0,'10073612',3785.20,'Módulo Capacitivo','380V'),
('MCW','MCW25V40','380',25.0,'11363326',4106.96,'Módulo Capacitivo','380V'),
('MCW','MCW30V40','380',30.0,'10214419',4428.63,'Módulo Capacitivo','380V'),
('MCW','MCW35V40','380',35.0,'11433573',6112.20,'Módulo Capacitivo','380V'),
('MCW','MCW40V40','380',40.0,'11433574',6426.81,'Módulo Capacitivo','380V'),
('MCW','MCW45V40','380',45.0,'11433575',6748.53,'Módulo Capacitivo','380V'),
('MCW','MCW50V40','380',50.0,'11433576',8425.08,'Módulo Capacitivo','380V'),
('MCW','MCW60V40','380',60.0,'11433577',9068.32,'Módulo Capacitivo','380V'),
('MCW','MCW2,5V49','440',2.5,'10045854',1423.68,'Módulo Capacitivo','440V'),
('MCW','MCW5V49','440',5.0,'10186091',1472.40,'Módulo Capacitivo','440V'),
('MCW','MCW10V49','440',10.0,'10186093',1787.07,'Módulo Capacitivo','440V'),
('MCW','MCW15V49','440',15.0,'10045984',2108.63,'Módulo Capacitivo','440V'),
('MCW','MCW20V49','440',20.0,'11433578',3573.72,'Módulo Capacitivo','440V'),
('MCW','MCW25V49','440',25.0,'11148586',4106.96,'Módulo Capacitivo','440V'),
('MCW','MCW30V49','440',30.0,'10074765',4428.63,'Módulo Capacitivo','440V'),
('MCW','MCW2,5V53','480',2.5,'10045856',1473.66,'Módulo Capacitivo','480V'),
('MCW','MCW5V53','480',5.0,'10045857',1523.92,'Módulo Capacitivo','480V'),
('MCW','MCW10V53','480',10.0,'10186101',1864.18,'Módulo Capacitivo','480V'),
('MCW','MCW15V53','480',15.0,'10045984',2182.51,'Módulo Capacitivo','480V'),
('MCW','MCW20V53','480',20.0,'11433589',3939.56,'Módulo Capacitivo','480V'),
('MCW','MCW30V53','480',30.0,'11088319',4576.30,'Módulo Capacitivo','480V');

-- ── BCW – Banco de Capacitores em Caixa ───────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,tensao_v,potencia_kvar,sap_code,preco,categoria,subtipo)
VALUES
('BCW','BCW10V25 T','220',10.0,'14891694',3796.31,'Banco Capacitores','220V em caixa'),
('BCW','BCW15V25 T','220',15.0,'14891695',5138.23,'Banco Capacitores','220V em caixa'),
('BCW','BCW20V25 T','220',20.0,'14891696',6589.40,'Banco Capacitores','220V em caixa'),
('BCW','BCW25V25 T','220',25.0,'14891697',7940.81,'Banco Capacitores','220V em caixa'),
('BCW','BCW30V25 T','220',30.0,'14891778',8938.27,'Banco Capacitores','220V em caixa'),
('BCW','BCW20V40 T','380',20.0,'14901141',4144.47,'Banco Capacitores','380V em caixa'),
('BCW','BCW30V40 T','380',30.0,'14901441',5637.59,'Banco Capacitores','380V em caixa'),
('BCW','BCW40V40 T','380',40.0,'14901774',7209.97,'Banco Capacitores','380V em caixa'),
('BCW','BCW50V40 T','380',50.0,'14902441',8736.65,'Banco Capacitores','380V em caixa'),
('BCW','BCW60V40 T','380',60.0,'14902644',9256.64,'Banco Capacitores','380V em caixa'),
('BCW','BCW75V40 T','380',75.0,'14902750',11066.54,'Banco Capacitores','380V em caixa'),
('BCW','BCW100V40 T','380',100.0,'14902788',12172.65,'Banco Capacitores','380V em caixa'),
('BCW','BCW30V49 T','440',30.0,'14896670',5637.59,'Banco Capacitores','440V em caixa'),
('BCW','BCW50V49 T','440',50.0,'14897034',8736.65,'Banco Capacitores','440V em caixa'),
('BCW','BCW75V49 T','440',75.0,'14897095',11066.06,'Banco Capacitores','440V em caixa'),
('BCW','BCW100V49 T','440',100.0,'14897172',12172.65,'Banco Capacitores','440V em caixa'),
('BCW','BCW30V53 T','480',30.0,'14904551',5902.29,'Banco Capacitores','480V em caixa'),
('BCW','BCW50V53 T','480',50.0,'14904555',8793.00,'Banco Capacitores','480V em caixa'),
('BCW','BCW75V53 T','480',75.0,'14904580',11197.26,'Banco Capacitores','480V em caixa'),
('BCW','BCW100V53 T','480',100.0,'14904580',12316.99,'Banco Capacitores','480V em caixa');

-- ── BCWA – Banco Automático de Capacitores ────────────────────────────────
INSERT INTO weg_produtos (familia,codigo,tensao_v,potencia_kvar,corrente_min,corrente_max,sap_code,preco,categoria,subtipo)
VALUES
('BCWA','BCWA20V40D-V25','380',20.0,30.4,30.4,'16312320',71420.41,'Banco Automático','380V 20kVAr'),
('BCWA','BCWA40V40D-V25','380',40.0,60.8,60.8,'16312749',74991.41,'Banco Automático','380V 40kVAr'),
('BCWA','BCWA50V40D-V25','380',50.0,76.0,76.0,'16312753',77241.14,'Banco Automático','380V 50kVAr'),
('BCWA','BCWA60V40D-V25','380',60.0,91.2,91.2,'16312756',81103.20,'Banco Automático','380V 60kVAr'),
('BCWA','BCWA70V40D-V25','380',70.0,106.4,106.4,'16312901',83536.32,'Banco Automático','380V 70kVAr'),
('BCWA','BCWA80V40D-V25','380',80.0,121.5,121.5,'16312906',86042.39,'Banco Automático','380V 80kVAr'),
('BCWA','BCWA90V40D-V25','380',90.0,136.7,136.7,'16313030',90344.51,'Banco Automático','380V 90kVAr'),
('BCWA','BCWA100V40D-V25','380',100.0,151.9,151.9,'16313037',93054.86,'Banco Automático','380V 100kVAr'),
('BCWA','BCWA120V40D-V25','380',120.0,182.3,182.3,'16313199',98721.90,'Banco Automático','380V 120kVAr'),
('BCWA','BCWA20V49D-V25','440',20.0,26.2,26.2,'16344046',68585.33,'Banco Automático','440V 20kVAr'),
('BCWA','BCWA40V49D-V25','440',40.0,52.5,52.5,'16344225',75615.33,'Banco Automático','440V 40kVAr'),
('BCWA','BCWA60V49D-V25','440',60.0,78.7,78.7,'16344250',81777.98,'Banco Automático','440V 60kVAr'),
('BCWA','BCWA100V49D-V25','440',100.0,131.2,131.2,'16344313',93829.04,'Banco Automático','440V 100kVAr'),
('BCWA','BCWA120V49D-V25','440',120.0,157.5,157.5,'16344349',99543.24,'Banco Automático','440V 120kVAr'),
('BCWA','BCWA20V53D-V25','480',20.0,24.1,24.1,'16348664',69146.06,'Banco Automático','480V 20kVAr'),
('BCWA','BCWA40V53D-V25','480',40.0,48.1,48.1,'16348667',76233.53,'Banco Automático','480V 40kVAr'),
('BCWA','BCWA60V53D-V25','480',60.0,72.2,72.2,'16348757',82446.57,'Banco Automático','480V 60kVAr'),
('BCWA','BCWA100V53D-V25','480',100.0,120.3,120.3,'16348883',94596.18,'Banco Automático','480V 100kVAr');

-- ── DRW – Reator de Dessintonia (sempre com UCWT) ─────────────────────────
INSERT INTO weg_produtos (familia,codigo,tensao_v,potencia_kvar,sap_code,categoria,subtipo,observacoes)
VALUES
('DRW','DRW7-2,40V40','380',12,'12789187','Reator Dessintonia','7% 380V 12kVAr','Par com UCWT15V49 N22 HD (SAP 11314666)'),
('DRW','DRW7-1,44V40','380',20,'12789288','Reator Dessintonia','7% 380V 20kVAr','Par com UCWT25V49 S26 HD (SAP 11917021)'),
('DRW','DRW7-1,03V40','380',28,'12789290','Reator Dessintonia','7% 380V 28kVAr','Par com UCWT35V49 S28 HD (SAP 12272784)'),
('DRW','DRW7-0,72V40','380',40,'12789291','Reator Dessintonia','7% 380V 40kVAr','Par com UCWT50V49 U28 HD (SAP 13365673)');

COMMIT TRANSACTION;

PRINT 'Seed concluído. Verifique: SELECT familia, COUNT(*) n FROM weg_produtos GROUP BY familia ORDER BY familia;';
