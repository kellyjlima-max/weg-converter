import os
import io
import re
import json
import base64
from pathlib import Path

import anthropic
import pandas as pd
import openpyxl
from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
from openpyxl.utils import get_column_letter

from fastapi import FastAPI, File, UploadFile, HTTPException, Request
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse, JSONResponse, StreamingResponse
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

# ─── App ─────────────────────────────────────────────────────────────────────
app = FastAPI(title="Conversor de Códigos WEG – THP")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

static_dir = Path("static")
static_dir.mkdir(exist_ok=True)
app.mount("/static", StaticFiles(directory="static"), name="static")

# ─── Claude ──────────────────────────────────────────────────────────────────
client = anthropic.Anthropic(api_key=os.environ.get("ANTHROPIC_API_KEY"))

VISION_MODEL = os.environ.get("VISION_MODEL", "claude-opus-4-5")
TEXT_MODEL   = os.environ.get("TEXT_MODEL",   "claude-sonnet-4-5")

# ─── Base WEG 2026 ────────────────────────────────────────────────────────────
BASE_WEG_DATA = """
# Base de Dados WEG (WAU) 2026
Listas de Preços de referência: Drives/Controls/Segurança/Sensores/Critical Power 07/2026 e Construção Civil 07/2026

## Circular WAU 13/2026 – Painéis PMW01 sem laterais
| Código WAU | Referência            | Dimensões (A × L × P)   |
|------------|-----------------------|------------------------|
| 19082923   | PMW01 - 20.066 s/Lat  | 2.000 × 600 × 600 mm   |
| 19082951   | PMW01 - 20.068 s/Lat  | 2.000 × 600 × 800 mm   |
| 19082952   | PMW01 - 20.086 s/Lat  | 2.000 × 800 × 600 mm   |
| 19082953   | PMW01 - 20.088 s/Lat  | 2.000 × 800 × 800 mm   |
| 19082955   | PMW01 - 20.106 s/Lat  | 2.000 × 1.000 × 600 mm |
| 19082957   | PMW01 - 20.108 s/Lat  | 2.000 × 1.000 × 800 mm |
| 19082960   | PMW01 - 23.066 s/Lat  | 2.300 × 600 × 600 mm   |
| 19082961   | PMW01 - 23.068 s/Lat  | 2.300 × 600 × 800 mm   |
| 19082962   | PMW01 - 23.086 s/Lat  | 2.300 × 800 × 600 mm   |
| 19082963   | PMW01 - 23.088 s/Lat  | 2.300 × 800 × 800 mm   |
| 19082964   | PMW01 - 23.106 s/Lat  | 2.300 × 1.000 × 600 mm |
| 19082965   | PMW01 - 23.108 s/Lat  | 2.300 × 1.000 × 800 mm |
Cor: RAL 7035.

## Circular WAU 14/2026 – Switch PoE 4 Canais
| Código WAU | Referência          | Preço (R$) |
|------------|---------------------|-----------|
| 18615490   | SWITCH WEG M04-P31  | 456,68    |
Família WCAM. 4 portas PoE+, 2 Uplink, 65 W total, até 30 W/porta.

## Circular WAU 15/2026 – Câmeras IP Night Color+
| Código WAU | Referência          | Tipo   | Preço (R$) |
|------------|---------------------|--------|-----------|
| 18573342   | WCAM IP-M022-B41    | Bullet | 1.207,30  |
| 18573343   | WCAM IP-M022-D41    | Dome   | 1.207,30  |
2MP Full HD, IR até 40 m, Night Color+, Mic+Alto-falante, ONVIF, MicroSD 1 TB, IP66.

## Circular WAU 27/2026 – Protetores de Surto SPW
### SPW03 – CA Completos (emb. 12 un.)
| Código WAU | Referência          | Tensão    | Classe | Corrente | Preço (R$) | IPI%  |
|------------|---------------------|-----------|--------|----------|-----------|-------|
| 17568718   | SPW03-275-12        | 275 V CA  | II     | 12 kA    | 107,95    | 9,75  |
| 17568723   | SPW03-275-20        | 275 V CA  | II     | 20 kA    | 110,23    | 9,75  |
| 17568725   | SPW03-275-45        | 275 V CA  | II     | 45 kA    | 193,18    | 9,75  |
| 17568777   | SPW03-275-60/12,5   | 275 V CA  | I/II   | 60 kA    | 375,00    | 9,75  |
### SPW03 – CA Gôndola (1 un./emb.)
| Código WAU | Referência          | Tensão    | Classe | Corrente | Preço (R$) | IPI%  |
|------------|---------------------|-----------|--------|----------|-----------|-------|
| 17568722   | SPW03-275-12        | 275 V CA  | II     | 12 kA    | 145,74    | 9,75  |
| 17568726   | SPW03-275-20        | 275 V CA  | II     | 20 kA    | 148,81    | 9,75  |
| 17568727   | SPW03-275-45        | 275 V CA  | II     | 45 kA    | 222,16    | 9,75  |
| 17568792   | SPW03-275-60/12,5   | 275 V CA  | I/II   | 60 kA    | 393,75    | 9,75  |
### SPW03 – Com Contato de Sinalização (emb. 12 un.)
| Código WAU | Referência          | Tensão    | Classe | Corrente | Preço (R$) | IPI%  |
|------------|---------------------|-----------|--------|----------|-----------|-------|
| 17568770   | SPW03-275-12-C      | 275 V CA  | II     | 12 kA    | 329,70    | 9,75  |
| 17568771   | SPW03-275-20-C      | 275 V CA  | II     | 20 kA    | 346,19    | 9,75  |
| 17568774   | SPW03-275-45-C      | 275 V CA  | II     | 45 kA    | 410,79    | 9,75  |
| 17568795   | SPW03-275-60/12,5-C | 275 V CA  | I/II   | 60 kA    | 575,28    | 9,75  |
### SPW03 – Módulos de Reposição (emb. 24 un.)
| Código WAU | Referência          | Corrente | Preço (R$) | IPI%  |
|------------|---------------------|----------|-----------|-------|
| 17568879   | SPW03-275-12-M      | 12 kA    | 84,15     | 9,75  |
| 17568880   | SPW03-275-20-M      | 20 kA    | 88,36     | 9,75  |
| 17568882   | SPW03-275-45-M      | 45 kA    | 150,29    | 9,75  |
### SPW13 – CC/Fotovoltaica (emb. 4 un.)
| Código WAU | Referência          | Tensão     | Corrente | Preço (R$) |
|------------|---------------------|-----------|----------|-----------|
| 17568796   | SPW13-600-40        | 600 V CC  | 40 kA    | 576,51    |
| 17568797   | SPW13-1100-40       | 1.100 V CC| 40 kA    | 610,88    |
### Tabela de Equivalência SPW antigo → novo
| Código Antigo | Ref Antiga          | Código Novo | Ref Nova            |
|--------------|---------------------|------------|---------------------|
| 14827871     | SPW02-275-10        | 17568718   | SPW03-275-12        |
| 14827873     | SPW02-275-20        | 17568723   | SPW03-275-20        |
| 14827874     | SPW02-275-40        | 17568725   | SPW03-275-45        |
| 14827876     | SPW02-275-60        | 17568777   | SPW03-275-60/12,5   |
| 10609715     | SPW-275-60/12,5     | 17568777   | SPW03-275-60/12,5   |
| 11402920     | SPWC-275-12         | 17568770   | SPW03-275-12-C      |
| 11402921     | SPWC-275-20         | 17568771   | SPW03-275-20-C      |
| 11402919     | SPWC-275-45         | 17568774   | SPW03-275-45-C      |
| 11402918     | SPWC-275-60/12,5    | 17568795   | SPW03-275-60/12,5-C |
| 14827929     | SPW12-600-40        | 17568796   | SPW13-600-40        |
| 14827930     | SPW12-1100-40       | 17568797   | SPW13-1100-40       |
| 11402917     | SPWCM275-12         | 17568879   | SPW03-275-12-M      |
| 11402916     | SPWCM275-20         | 17568880   | SPW03-275-20-M      |
| 11402915     | SPWCM275-45         | 17568882   | SPW03-275-45-M      |

## Seção 4 – Capacitores e Correção do Fator de Potência (Lista 07/2026)
### Convenção de tensões nos códigos de capacitores WEG
V25=220V | V40=380V | V49=440V | V53=480V | V57=535V | V63=660V | V103=600V

### PFW03 – Controlador Automático do Fator de Potência (50/60 Hz)
| Referência  | Tipo       | Estágios | Código   | Preço (R$)  |
|-------------|------------|----------|----------|-------------|
| PFW03-M08   | Monofásico | 8        | 14387138 | 7.763,64    |
| PFW03-M12   | Monofásico | 12       | 14387141 | 8.829,11    |
| PFW03-M24   | Monofásico | 24       | 14387143 | 10.855,43   |
| PFW03-T12   | Trifásico  | 12       | 14387080 | 12.021,08   |
| PFW03-T24   | Trifásico  | 24       | 14387086 | 14.398,90   |

### PFW01 – Controlador Automático do Fator de Potência
| Referência    | Tipo       | Hz | Estágios | Código   | Preço (R$) |
|---------------|------------|----|----------|----------|------------|
| PFW01-M06     | Monofásico | 60 | 6        | 11335175 | 8.928,16   |
| PFW01-M06-50  | Monofásico | 50 | 6        | 12240101 | 8.928,16   |
| PFW01-M12     | Monofásico | 60 | 12       | 11335221 | 10.153,45  |
| PFW01-M12-50  | Monofásico | 50 | 12       | 12240107 | 10.153,45  |
| PFW01-T06     | Trifásico  | 60 | 6        | 11335223 | 13.824,23  |
| PFW01-T06-50  | Trifásico  | 50 | 6        | 12240102 | 13.824,23  |
| PFW01-T12     | Trifásico  | 60 | 12       | 11335176 | 14.546,85  |
| PFW01-T12-50  | Trifásico  | 50 | 12       | 12240168 | 14.546,85  |

### PFWD01 – Controlador Dinâmico do Fator de Potência
| Referência     | Tensão alim.     | Tensão medição | Código   | Preço (R$) |
|----------------|------------------|----------------|----------|------------|
| PFWD01-M12-D34 | 400 Vca          | 400 Vca        | 17633710 | 21.680,59  |
| PFWD01-M12-D24 | 230 Vca          | 100–690 Vca    | 18565724 | 20.428,92  |

### CTSW – Chave Tiristorizada para Manobra de Capacitores
| Referência     | Tensão | Corrente nom.(A) | kVAr ref. | Código   | Preço (R$) |
|----------------|--------|------------------|-----------|----------|------------|
| CTSW15D23-C03  | 220V   | 39               | 15 kVAr   | 18569128 | 11.772,51  |
| CTSW25D23-C03  | 220V   | 66               | 25 kVAr   | 18569129 | 12.989,34  |
| CTSW50D23-C03  | 220V   | 131              | 50 kVAr   | 18569130 | 14.359,27  |
| CTSW15D34-C03  | 380V   | 22               | 8–15 kVAr | 17139329 | 15.398,11  |
| CTSW25D34-C03  | 380V   | 36               | 14–25 kVAr| 17139330 | 22.174,58  |
| CTSW50D34-C03  | 380V   | 72               | 28–50 kVAr| 17139331 | 23.763,56  |
| CTSW15D36-C03  | 400V   | 20               | 8–15 kVAr | 18571517 | 17.069,82  |
| CTSW25D36-C03  | 400V   | 33               | 13–25 kVAr| 18571679 | 20.503,98  |
| CTSW50D36-C03  | 400V   | 66               | 25–50 kVAr| 18571680 | 24.791,41  |
| CTSW15D39-C02  | 480V   | 18               | 7–15 kVAr | 17139332 | 11.180,46  |
| CTSW25D39-C02  | 480V   | 30               | 11–25 kVAr| 17139334 | 12.336,19  |
| CTSW50D39-C02  | 480V   | 60               | 23–50 kVAr| 17139335 | 13.910,09  |
| CTSW15D48-C02  | 690V   | 13               | 5–10 kVAr | 17139337 | 14.623,81  |
| CTSW25D48-C02  | 690V   | 21               | 8–25 kVAr | 17139479 | 16.033,19  |
| CTSW50D48-C02  | 690V   | 42               | 16–50 kVAr| 17139480 | 17.723,39  |

### AHFW – Filtro Ativo para Correção de Fator de Potência (seleção)
| Referência    | Instalação | Tensão/Hz   | Corrente (A) | Código   | Preço (R$) |
|---------------|------------|-------------|--------------|----------|------------|
| AHFW 50V40 R  | Rack       | 440V / 60Hz | 50           | 17915874 | 90.000,00  |
| AHFW 100V40 R | Rack       | 440V / 60Hz | 100          | 18049907 | 100.114,17 |
| AHFW 150V40 R | Rack       | 440V / 60Hz | 150          | 18255105 | 93.731,08  |
| AHFW 50V53 R  | Rack       | 480V / 60Hz | 50           | 17916109 | 103.809,72 |
| AHFW 100V53 R | Rack       | 480V / 60Hz | 100          | 18050410 | 134.381,53 |
| AHFW 150V53 R | Rack       | 480V / 60Hz | 150          | 18255107 | 145.041,58 |
| AHFW 50V63 R  | Rack       | 690V / 60Hz | 50           | 18255494 | 147.819,61 |
| AHFW 100V63 R | Rack       | 690V / 60Hz | 100          | 18255492 | 157.898,26 |
| AHFW 50V52 R  | Rack       | 480V / 50Hz | 50           | 18748363 | 154.732,57 |
| AHFW 100V52 R | Rack       | 480V / 50Hz | 100          | 18748366 | 165.392,63 |
| AHFW 50V40 P  | Parede     | 440V / 60Hz | 50           | 17915876 | 179.283,04 |
| AHFW 100V40 P | Parede     | 440V / 60Hz | 100          | 18050408 | 176.052,76 |
| AHFW 150V40 P | Parede     | 440V / 60Hz | 150          | 18255106 | 206.740,78 |
| AHFW 50V53 P  | Parede     | 480V / 60Hz | 50           | 17916112 | 167.976,91 |
| AHFW 100V53 P | Parede     | 480V / 60Hz | 100          | 18050412 | 93.731,08  |
| AHFW 50V52 P  | Parede     | 480V / 50Hz | 50           | 18748365 | 100.114,17 |
| AHFW 100V52 P | Parede     | 480V / 50Hz | 100          | 18748538 | 93.731,08  |

### UCW – Unidade Capacitiva Monofásica (seleção 220V / 380V / 440V / 480V)
| Referência      | Tensão | kVAr  | Código   | Preço (R$) |
|-----------------|--------|-------|----------|------------|
| UCW0,83V25 J4   | 220V   | 0,83  | 11488457 | 338,38     |
| UCW1,67V25 L6   | 220V   | 1,67  | 10045802 | 365,95     |
| UCW2,5V25 L10   | 220V   | 2,50  | 10045950 | 429,83     |
| UCW3,33V25 L10  | 220V   | 3,33  | 10046652 | 547,37     |
| UCW5V25 N14     | 220V   | 5,00  | 11449885 | 1.084,93   |
| UCW6,67V25 N14  | 220V   | 6,67  | 11507565 | 1.189,92   |
| UCW0,83V40 J2   | 380V   | 0,83  | 11488508 | 293,99     |
| UCW1,67V40 J4   | 380V   | 1,67  | 11488510 | 305,06     |
| UCW2,5V40 J6    | 380V   | 2,50  | 13497628 | 321,54     |
| UCW3,33V40 J8   | 380V   | 3,33  | 11488809 | 409,50     |
| UCW5V40 L10     | 380V   | 5,00  | 10045951 | 492,28     |
| UCW6,67V40 M10  | 380V   | 6,67  | 10630797 | 708,63     |
| UCW7,5V40 N14   | 380V   | 7,50  | 11449886 | 1.084,93   |
| UCW8,33V40 N14  | 380V   | 8,33  | 11449950 | 1.123,18   |
| UCW9,17V40 N14  | 380V   | 9,17  | 11449951 | 1.137,15   |
| UCW10V40 N14    | 380V   | 10,00 | 11449887 | 1.189,92   |
| UCW0,83V49 J2   | 440V   | 0,83  | 11488824 | 293,99     |
| UCW1,67V49 J4   | 440V   | 1,67  | 11488825 | 305,06     |
| UCW2,5V49 J6    | 440V   | 2,50  | 13497629 | 321,54     |
| UCW3,33V49 J8   | 440V   | 3,33  | 11488827 | 382,40     |
| UCW5V49 L10     | 440V   | 5,00  | 10186125 | 492,28     |
| UCW6,67V49 M10  | 440V   | 6,67  | 10630798 | 708,63     |
| UCW7,5V49 N14   | 440V   | 7,50  | 11449911 | 1.084,93   |
| UCW8,33V49 N14  | 440V   | 8,33  | 11449952 | 1.123,18   |
| UCW9,17V49 N14  | 440V   | 9,17  | 11449953 | 1.137,15   |
| UCW10V49 N14    | 440V   | 10,00 | 11449915 | 1.189,92   |
| UCW0,83V53 J2   | 480V   | 0,83  | 11488839 | 305,06     |
| UCW2,5V53 J6    | 480V   | 2,50  | 13497630 | 332,97     |
| UCW5V53 L10     | 480V   | 5,00  | 10045952 | 508,93     |
| UCW6,67V53 M10  | 480V   | 6,67  | 10630800 | 732,70     |
| UCW7,5V53 N14   | 480V   | 7,50  | 11449916 | 1.084,93   |
| UCW10V53 N14    | 480V   | 10,00 | 11449928 | 1.189,92   |

### UCWT – Unidade Capacitiva Trifásica HD (seleção 220V / 380V / 440V / 480V)
| Referência         | Tensão | kVAr  | Código   | Preço (R$) |
|--------------------|--------|-------|----------|------------|
| UCWT5V25 N20 HD    | 220V   | 5,0   | 11313760 | 980,11     |
| UCWT7,5V25 N22 HD  | 220V   | 7,5   | 11313783 | 1.135,41   |
| UCWT10V25 N22 HD   | 220V   | 10,0  | 11313782 | 1.670,72   |
| UCWT15V25 S26 HD   | 220V   | 15,0  | 11914853 | 2.261,16   |
| UCWT20V25 S28 HD   | 220V   | 20,0  | 12271626 | 3.327,67   |
| UCWT25V25 U28 HD   | 220V   | 25,0  | 13365111 | 4.003,79   |
| UCWT30V25 U28 HD   | 220V   | 30,0  | 13365631 | 4.296,20   |
| UCWT0,5V40 L10 HD  | 380V   | 0,5   | 10046005 | 357,76     |
| UCWT1V40 L10 HD    | 380V   | 1,0   | 10046007 | 375,95     |
| UCWT2V40 L10 HD    | 380V   | 2,0   | 10046009 | 475,93     |
| UCWT3V40 L10 HD    | 380V   | 3,0   | 10046011 | 560,60     |
| UCWT5V40 L16 HD    | 380V   | 5,0   | 10046012 | 694,53     |
| UCWT7,5V40 N20 HD  | 380V   | 7,5   | 11313784 | 919,58     |
| UCWT10V40 N20 HD   | 380V   | 10,0  | 11313787 | 1.077,14   |
| UCWT12,5V40 N22 HD | 380V   | 12,5  | 11313820 | 1.162,09   |
| UCWT15V40 N22 HD   | 380V   | 15,0  | 11313821 | 1.495,53   |
| UCWT17,5V40 Q26 HD | 380V   | 17,5  | 11916880 | 1.976,96   |
| UCWT20V40 Q26 HD   | 380V   | 20,0  | 11916901 | 2.146,58   |
| UCWT25V40 S26 HD   | 380V   | 25,0  | 11916924 | 2.301,51   |
| UCWT30V40 S28 HD   | 380V   | 30,0  | 12272719 | 2.991,02   |
| UCWT35V40 S28 HD   | 380V   | 35,0  | 12267042 | 3.387,10   |
| UCWT40V40 U28 HD   | 380V   | 40,0  | 13365634 | 4.078,51   |
| UCWT45V40 U28 HD   | 380V   | 45,0  | 13365636 | 4.204,72   |
| UCWT50V40 U28 HD   | 380V   | 50,0  | 13365637 | 4.372,89   |
| UCWT0,5V49 L10 HD  | 440V   | 0,5   | 10046013 | 368,85     |
| UCWT1V49 L10 HD    | 440V   | 1,0   | 10046015 | 391,87     |
| UCWT2V49 L10 HD    | 440V   | 2,0   | 10046017 | 501,65     |
| UCWT3V49 L10 HD    | 440V   | 3,0   | 10046019 | 590,90     |
| UCWT5V49 L16 HD    | 440V   | 5,0   | 10046020 | 749,41     |
| UCWT7,5V49 N20 HD  | 440V   | 7,5   | 11313663 | 968,17     |
| UCWT10V49 N20 HD   | 440V   | 10,0  | 11758279 | 1.110,56   |
| UCWT12,5V49 N22 HD | 440V   | 12,5  | 11313665 | 1.211,14   |
| UCWT15V49 N22 HD   | 440V   | 15,0  | 11314666 | 1.548,36   |
| UCWT20V49 Q26 HD   | 440V   | 20,0  | 11917007 | 2.215,44   |
| UCWT25V49 S26 HD   | 440V   | 25,0  | 11917021 | 2.350,69   |
| UCWT30V49 S28 HD   | 440V   | 30,0  | 12272780 | 3.096,76   |
| UCWT35V49 S28 HD   | 440V   | 35,0  | 12272784 | 3.449,48   |
| UCWT40V49 U28 HD   | 440V   | 40,0  | 13365671 | 4.209,36   |
| UCWT45V49 U28 HD   | 440V   | 45,0  | 13365672 | 4.351,24   |
| UCWT50V49 U28 HD   | 440V   | 50,0  | 13365673 | 4.466,23   |
| UCWT5V53 L16 HD    | 480V   | 5,0   | 10045997 | 817,60     |
| UCWT7,5V53 N20 HD  | 480V   | 7,5   | 11314667 | 1.277,09   |
| UCWT10V53 N20 HD   | 480V   | 10,0  | 11314728 | 1.368,57   |
| UCWT15V53 N22 HD   | 480V   | 15,0  | 11314730 | 2.215,84   |
| UCWT20V53 Q26 HD   | 480V   | 20,0  | 11917064 | 2.736,66   |
| UCWT25V53 S26 HD   | 480V   | 25,0  | 11917066 | 4.124,53   |
| UCWT30V53 S28 HD   | 480V   | 30,0  | 12272781 | 4.376,31   |
| UCWT40V53 U28 HD   | 480V   | 40,0  | 13365674 | 5.199,72   |
| UCWT50V53 U28 HD   | 480V   | 50,0  | 13365677 | 7.836,60   |

### UCWT UHD – Unidade Capacitiva Trifásica Ultra Heavy Duty (seleção)
| Referência        | Tensão | kVAr | Código   | Preço (R$) |
|-------------------|--------|------|----------|------------|
| UCWT5V25 Q26 UHD  | 220V   | 5,0  | 16207509 | 1.896,53   |
| UCWT10V25 S26 UHD | 220V   | 10,0 | 16207513 | 3.232,87   |
| UCWT15V25 U26 UHD | 220V   | 15,0 | 16207515 | 4.375,36   |
| UCWT5V40 N20 UHD  | 380V   | 5,0  | 16202791 | 1.343,88   |
| UCWT10V40 Q26 UHD | 380V   | 10,0 | 16202792 | 2.084,27   |
| UCWT15V40 S26 UHD | 380V   | 15,0 | 16202793 | 2.893,81   |
| UCWT20V40 U26 UHD | 380V   | 20,0 | 16202794 | 4.153,61   |
| UCWT25V40 U26 UHD | 380V   | 25,0 | 16202795 | 4.453,43   |
| UCWT5V49 N20 UHD  | 440V   | 5,0  | 16216189 | 1.450,14   |
| UCWT10V49 Q26 UHD | 440V   | 10,0 | 16216190 | 2.148,94   |
| UCWT15V49 S26 UHD | 440V   | 15,0 | 16216192 | 2.996,07   |
| UCWT20V49 U26 UHD | 440V   | 20,0 | 16216194 | 4.286,89   |
| UCWT25V49 U26 UHD | 440V   | 25,0 | 16216196 | 4.548,58   |
| UCWT5V53 N20 UHD  | 480V   | 5,0  | 16218131 | 1.582,05   |
| UCWT10V53 Q26 UHD | 480V   | 10,0 | 16218132 | 2.648,19   |
| UCWT15V53 S26 UHD | 480V   | 15,0 | 16218133 | 4.287,68   |
| UCWT20V53 U26 UHD | 480V   | 20,0 | 16218135 | 5.295,46   |
| UCWT25V53 U26 UHD | 480V   | 25,0 | 16218136 | 7.980,99   |

### MCW – Módulo Capacitivo Trifásico (seleção 220V / 380V / 440V / 480V)
| Referência  | Tensão | kVAr  | Código   | Preço (R$) |
|-------------|--------|-------|----------|------------|
| MCW2,5V25   | 220V   | 2,5   | 10045851 | 1.465,55   |
| MCW5V25     | 220V   | 5,0   | 10045799 | 1.548,68   |
| MCW7,5V25   | 220V   | 7,5   | 10186130 | 1.780,56   |
| MCW10V25    | 220V   | 10,0  | 10046861 | 2.067,91   |
| MCW15V25    | 220V   | 15,0  | 11425743 | 3.827,85   |
| MCW20V25    | 220V   | 20,0  | 10731824 | 4.347,02   |
| MCW25V25    | 220V   | 25,0  | 10731826 | 6.109,54   |
| MCW30V25    | 220V   | 30,0  | 11433567 | 6.626,17   |
| MCW2,5V40   | 380V   | 2,5   | 10452269 | 1.423,68   |
| MCW5V40     | 380V   | 5,0   | 10186090 | 1.472,40   |
| MCW7,5V40   | 380V   | 7,5   | 10186099 | 1.575,53   |
| MCW10V40    | 380V   | 10,0  | 10186092 | 1.787,07   |
| MCW15V40    | 380V   | 15,0  | 10186131 | 2.108,63   |
| MCW17,5V40  | 380V   | 17,5  | 11433568 | 3.573,72   |
| MCW20V40    | 380V   | 20,0  | 10073612 | 3.785,20   |
| MCW25V40    | 380V   | 25,0  | 11363326 | 4.106,96   |
| MCW30V40    | 380V   | 30,0  | 10214419 | 4.428,63   |
| MCW35V40    | 380V   | 35,0  | 11433573 | 6.112,20   |
| MCW40V40    | 380V   | 40,0  | 11433574 | 6.426,81   |
| MCW45V40    | 380V   | 45,0  | 11433575 | 6.748,53   |
| MCW50V40    | 380V   | 50,0  | 11433576 | 8.425,08   |
| MCW60V40    | 380V   | 60,0  | 11433577 | 9.068,32   |
| MCW2,5V49   | 440V   | 2,5   | 10045854 | 1.423,68   |
| MCW5V49     | 440V   | 5,0   | 10186091 | 1.472,40   |
| MCW10V49    | 440V   | 10,0  | 10186093 | 1.787,07   |
| MCW15V49    | 440V   | 15,0  | 10045984 | 2.108,63   |
| MCW20V49    | 440V   | 20,0  | 11433578 | 3.573,72   |
| MCW25V49    | 440V   | 25,0  | 11148586 | 4.106,96   |
| MCW30V49    | 440V   | 30,0  | 10074765 | 4.428,63   |
| MCW2,5V53   | 480V   | 2,5   | 10045856 | 1.473,66   |
| MCW5V53     | 480V   | 5,0   | 10045857 | 1.523,92   |
| MCW10V53    | 480V   | 10,0  | 10186101 | 1.864,18   |
| MCW15V53    | 480V   | 15,0  | 10045984 | 2.182,51   |
| MCW20V53    | 480V   | 20,0  | 11433589 | 3.939,56   |
| MCW30V53    | 480V   | 30,0  | 11088319 | 4.576,30   |

### BCW – Banco de Capacitores Trifásico em Caixa (seleção)
| Referência   | Tensão | kVAr  | Código   | Preço (R$) |
|--------------|--------|-------|----------|------------|
| BCW10V25 T   | 220V   | 10,0  | 14891694 | 3.796,31   |
| BCW15V25 T   | 220V   | 15,0  | 14891695 | 5.138,23   |
| BCW20V25 T   | 220V   | 20,0  | 14891696 | 6.589,40   |
| BCW25V25 T   | 220V   | 25,0  | 14891697 | 7.940,81   |
| BCW30V25 T   | 220V   | 30,0  | 14891778 | 8.938,27   |
| BCW20V40 T   | 380V   | 20,0  | 14901141 | 4.144,47   |
| BCW30V40 T   | 380V   | 30,0  | 14901441 | 5.637,59   |
| BCW40V40 T   | 380V   | 40,0  | 14901774 | 7.209,97   |
| BCW50V40 T   | 380V   | 50,0  | 14902441 | 8.736,65   |
| BCW60V40 T   | 380V   | 60,0  | 14902644 | 9.256,64   |
| BCW75V40 T   | 380V   | 75,0  | 14902750 | 11.066,54  |
| BCW100V40 T  | 380V   | 100,0 | 14902788 | 12.172,65  |
| BCW30V49 T   | 440V   | 30,0  | 14896670 | 5.637,59   |
| BCW50V49 T   | 440V   | 50,0  | 14897034 | 8.736,65   |
| BCW75V49 T   | 440V   | 75,0  | 14897095 | 11.066,06  |
| BCW100V49 T  | 440V   | 100,0 | 14897172 | 12.172,65  |
| BCW30V53 T   | 480V   | 30,0  | 14904551 | 5.902,29   |
| BCW50V53 T   | 480V   | 50,0  | 14904555 | 8.793,00   |
| BCW75V53 T   | 480V   | 75,0  | 14904580 | 11.197,26  |
| BCW100V53 T  | 480V   | 100,0 | 14904580 | 12.316,99  |

### BCWA – Banco Automático de Capacitores (seleção 380V / 440V / 480V)
| Referência       | Tensão | kVAr  | Corrente (A) | Código   | Preço (R$) |
|------------------|--------|-------|--------------|----------|------------|
| BCWA20V40D-V25   | 380V   | 20,0  | 30,4         | 16312320 | 71.420,41  |
| BCWA40V40D-V25   | 380V   | 40,0  | 60,8         | 16312749 | 74.991,41  |
| BCWA50V40D-V25   | 380V   | 50,0  | 76,0         | 16312753 | 77.241,14  |
| BCWA60V40D-V25   | 380V   | 60,0  | 91,2         | 16312756 | 81.103,20  |
| BCWA70V40D-V25   | 380V   | 70,0  | 106,4        | 16312901 | 83.536,32  |
| BCWA80V40D-V25   | 380V   | 80,0  | 121,5        | 16312906 | 86.042,39  |
| BCWA90V40D-V25   | 380V   | 90,0  | 136,7        | 16313030 | 90.344,51  |
| BCWA100V40D-V25  | 380V   | 100,0 | 151,9        | 16313037 | 93.054,86  |
| BCWA120V40D-V25  | 380V   | 120,0 | 182,3        | 16313199 | 98.721,90  |
| BCWA20V49D-V25   | 440V   | 20,0  | 26,2         | 16344046 | 68.585,33  |
| BCWA40V49D-V25   | 440V   | 40,0  | 52,5         | 16344225 | 75.615,33  |
| BCWA60V49D-V25   | 440V   | 60,0  | 78,7         | 16344250 | 81.777,98  |
| BCWA100V49D-V25  | 440V   | 100,0 | 131,2        | 16344313 | 93.829,04  |
| BCWA120V49D-V25  | 440V   | 120,0 | 157,5        | 16344349 | 99.543,24  |
| BCWA20V53D-V25   | 480V   | 20,0  | 24,1         | 16348664 | 69.146,06  |
| BCWA40V53D-V25   | 480V   | 40,0  | 48,1         | 16348667 | 76.233,53  |
| BCWA60V53D-V25   | 480V   | 60,0  | 72,2         | 16348757 | 82.446,57  |
| BCWA100V53D-V25  | 480V   | 100,0 | 120,3        | 16348883 | 94.596,18  |

### DRW – Reator de Dessintonia (sempre fornecido em conjunto com UCWT)
Nota: O DRW acompanha um capacitor UCWT de kVAr nominal maior. O conjunto resulta no kVAr de potência reativa indicado.
Dessintonia 7% (frequência 226,8 Hz): série DRW7-x. Dessintonia 14% (160,4 Hz): série DRW14-x.
Códigos de referência para conjunto DRW7 + UCWT a 380V (V40):
- 12 kVAr: Reator DRW7-2,40V40 (12789187) + UCWT15V49 N22 HD (11314666)
- 20 kVAr: Reator DRW7-1,44V40 (12789288) + UCWT25V49 S26 HD (11917021)
- 28 kVAr: Reator DRW7-1,03V40 (12789290) + UCWT35V49 S28 HD (12272784)
- 40 kVAr: Reator DRW7-0,72V40 (12789291) + UCWT50V49 U28 HD (13365673)
"""

# ─── System prompt ────────────────────────────────────────────────────────────
SYSTEM_PROMPT = f"""Você é um especialista técnico sênior em produtos elétricos e industriais WEG/WAU, com profundo conhecimento em acionamentos, proteção, automação, CFTV e energia.

Fabricantes concorrentes que você conhece em detalhe: Siemens, ABB, Schneider Electric, Eaton (Moeller), Lovato, Danfoss, Rockwell (Allen-Bradley), Mitsubishi, Yaskawa, WEG antigos.

==========================================================================
## BASE DE DADOS WEG 2026
{BASE_WEG_DATA}

==========================================================================
## REGRAS GERAIS DE CONVERSÃO

1. CORRENTE NOMINAL: a corrente de operação é o critério primário. Se a corrente WEG for menor que a do concorrente para a mesma função, usar o modelo WEG com corrente IMEDIATAMENTE SUPERIOR e anotar: "⚠️ Corrente WEG utilizada: Xa (concorrente: Ya) — confirmar com cliente."
2. CUSTO-BENEFÍCIO: quando houver mais de uma opção WEG tecnicamente válida, SEMPRE indicar a de menor custo/gama que atenda os requisitos. Mencionar em "observacao" se há alternativa premium.
3. ACESSÓRIOS: identificar acessórios solicitados (contatos auxiliares, bobinas, módulos de comunicação, encoders, displays) e indicar os códigos WEG complementares no campo "acessorios_weg".
4. TENSÃO DA BOBINA / ALIMENTAÇÃO: sempre verificar e casar (24 VCC, 24 VCA, 110 V, 220 V, 380 V, 440 V, 480 V).

==========================================================================
## MATCHING TÉCNICO POR FAMÍLIA DE PRODUTO

### A. DISJUNTORES DE PROTEÇÃO DE MOTOR (DPM / Motor Starter Protectors)
Concorrentes: Siemens 3RV2, 3RV1 | Schneider GV2ME, GV3P | ABB MS116, MS132, MS165 | Eaton PKZM0, PKM0

Parâmetros críticos a extrair e casar:
- Corrente de ajuste (Ir) em Ampères
- Corrente de curto (Icu/Ics) em kA
- Número de polos (3P)
- Versão com ou sem acessórios:
  - Contato auxiliar NA+NF (Side mount ou front mount)
  - Bobina de abertura / shunt trip (bobina de disparo por tensão)
  - Relé de mínima tensão / undervoltage release
  - Bloco diferencial

WEG – linha MPW:
- MPW65-3-D... (até 65 kA) e MPW100-3-D... (até 100 kA)
- Sufixo indica faixa de corrente (ex: D040 = 25–40 A)
- Acessórios WEG: CW1 (contato NA), CW2 (contato NF), BST (bobina shunt), BVM (mínima tensão)
- Indicar sempre código base + códigos de acessórios separados

### B. CONTATORES (Contactors)
Concorrentes: Siemens 3RT2 | Schneider LC1-D, LC1-F | ABB AF-line, A-line | Eaton DILM | Lovato BF/BG

Parâmetros críticos:
- Corrente nominal AC-3 (ex: 9 A, 12 A, 18 A, 25 A, 40 A, 65 A, 80 A, 115 A, 150 A...)
- Tensão da bobina (24 VCC, 24 VCA, 48 V, 110 V, 220 V, 380 V)
- Polos (3P ou 4P)
- Contatos auxiliares integrados: quantos NA e quantos NF
- Se cliente pede contatos adicionais: indicar blocos auxiliares CW1/CW2 separados

WEG – linha CWM:
- CWM09 a CWM150 (corrente AC-3)
- Sufixo bobina: -11 (NA+NF integrado), código completo inclui tensão
- Exemplo: CWM40-11-30V04 = 40A, 1NA+1NF, bobina 220V 50/60Hz

### C. RELÉS DE SOBRECARGA (Overload Relays)
Concorrentes: Siemens 3RU2 | Schneider LRD | ABB TA25DU, TA75DU | Eaton ZB

Parâmetros críticos:
- Faixa de corrente de ajuste
- Reset: manual (M) ou automático (A)
- Classe de disparo: 10, 20 ou 30
- Número de contatos NA/NF

WEG – linha RW:
- RW27D (faixa até 27 A) e RW67D (faixa maior)
- Indicar faixa exata e modo de reset

### D. INVERSORES DE FREQUÊNCIA (Variable Frequency Drives / VFDs)
Concorrentes: Siemens SINAMICS G110/G120/G130/G150 | ABB ACS355/ACS550/ACS880 | Schneider ATV310/ATV312/ATV630/ATV930 | Danfoss FC51/FC102/FC202/FC301/FC302 | Yaskawa V1000/J1000/A1000 | Rockwell PowerFlex 4/40/400/525/755

Parâmetros críticos (TODOS devem ser casados):
- Potência nominal (kW ou HP/CV)
- Tensão de alimentação: 1F 200-240V / 3F 200-240V / 3F 380-480V / 3F 500-600V
- Corrente de saída nominal
- Grau de proteção (IP20, IP21, IP55, IP66)
- Sobrecarga suportada (150% por 60s = uso geral; 110% = bomba/ventilador; 200% = alta performance)

Acessórios/Opções — identificar no código ou descrição do cliente:
- Módulo de comunicação: Profibus DP | Profinet | DeviceNet | EtherNet/IP | CANopen | Modbus TCP (atenção: Modbus RTU já incluso na maioria dos CFW)
- Entradas/saídas digitais adicionais (I/O expansion)
- Encoder / PG card (para controle vetorial com encoder)
- Filtro EMC integrado / externo (categoria C2 ou C3)
- Resistor de frenagem externo (RFD)
- Reator de linha / filtro de saída (bobina dV/dt)
- Display remoto / IHM remota

WEG – linhas CFW:
- CFW500: compacto monofásico/trifásico, uso geral, mais econômico (até ~22 kW)
- CFW700: linha compacta e econômica para bomba/ventilador (até ~250 kW) — PREFERIR para carga quadrática
- CFW11: uso geral robusto, ampla gama de potência (até 2400 kW)
- CFW900 / CFW11: alta performance, vetor com encoder (servo e uso industrial intensivo)
- Seleção de custo-benefício: CFW500 < CFW700 < CFW11 < CFW900. Usar o menor que atender.
- Módulos de comunicação WEG: CFW-11 com slot para módulos MBP (Profibus), CAC (CANopen), ELP (EtherNet/IP), PNT (Profinet), DNet (DeviceNet)

### E. SOFT STARTERS (Chaves de Partida Suave)
Concorrentes: Schneider ATS22/ATS48 | ABB PSR/PSE/PSTB | Siemens 3RW30/3RW40/3RW50 | Eaton DS7

Parâmetros críticos:
- Corrente nominal de saída
- Bypass interno integrado (sim/não — impacta tamanho e custo)
- Tensão de controle
- Módulo de comunicação (se houver)

WEG:
- SSW-07: linha mais econômica, sem bypass
- SSW900: robusta, com bypass opcional, módulos de comunicação disponíveis

### F. RELÉS E TEMPORIZADORES DE PROTEÇÃO
Concorrentes: Schneider RM | ABB CR-P | Siemens 3RP | Phoenix Contact

- Relés temporizadores WEG: linha TW (multifunção, ON-delay, OFF-delay, pulso)
- Relés de falta de fase / desequilíbrio: linha RFW
- Relés de proteção de motor: linha RPM

### G. CHAVES DE PARTIDA DIRETA — SOLUÇÃO COMPLETA EM CAIXA (DOL Starters)
Concorrentes: **Altronic 3PDA** | Siemens 3RA2 | Schneider TeSys starter assemblies | ABB starters in enclosures

ATENÇÃO: São SOLUÇÕES COMPLETAS em caixa metálica (não componentes separados).
Incluem: contator + relé de sobrecarga + botoeira liga/desliga + chave seccionadora.
NÃO sugerir MPW + CWM separados — indicar WEG PDW ou PDWM conforme tensão/fase.

Parâmetros críticos (extrair de código ou descrição):
- Potência do motor (CV/HP)
- Tensão de alimentação (220V monofásica → PDWM | 380V trifásica → PDW)
- Corrente de ajuste do relé de sobrecarga (ex: 12–18A)
- Com ou sem botoeira (sufixo "C/ BOT." ou "B")
- Contato de contorno (CONT): contato auxiliar para sinalização

**LÓGICA DE MATCHING — SIGA ESTA ORDEM:**
1. **Potência (CV) + tensão são critérios primários.** Encontre o WEG com o mesmo CV e mesma tensão.
2. **Faixa do relé pode diferir** entre fabricantes — é normal. Selecione o WEG de mesmo CV e anote a diferença na observação: "⚠ Faixa WEG: X-Y A — confirmar ajuste com cliente."
3. **Só escale para CV maior** se o WEG de mesma potência genuinamente não cobre a corrente nominal do motor (faixa máxima menor que a corrente nominal informada). Nesse caso marque como alerta e explique.

**TABELA PDW — TRIFÁSICA 380V (V40) — CÓDIGOS SAP CONFIRMADOS:**
| Referência WEG   | Potência (CV) | Faixa (A)    | Código SAP |
|------------------|--------------|--------------|------------|
| PDW02-0,16V40    | 0,16         | 0,4 – 0,63  | 10072580   |
| PDW02-0,25V40    | 0,25         | 0,56 – 0,8  | 10186081   |
| PDW02-0,33V40    | 0,33         | 0,8 – 1,2   | 10186082   |
| PDW02-0,75V40    | 0,5 / 0,75   | 1,2 – 1,8   | 10045784   |
| PDW02-1,5V40     | 1 / 1,5      | 1,8 – 2,8   | 10118384   |
| PDW02-2V40       | 2            | 2,8 – 4     | 10045787   |
| PDW02-3V40       | 3            | 4 – 6,3     | 10045788   |
| PDW02-4V40       | 4            | 5,6 – 8     | 10045789   |
| PDW04-5V40       | 5            | 7 – 10      | 10045790   |
| PDW04-6V40       | 6            | 8 – 12,5    | 10045791   |
| PDW04-7,5V40     | 7,5          | 10 – 15     | 10045792   |
| PDW04-10V40      | 10           | 11 – 17     | 10045793   |
| PDW04-12,5V40    | 12,5         | 15 – 23     | 10045794   |
| PDW04-15V40      | 15           | 22 – 32     | 10046425   |

**TABELA PDWM — MONOFÁSICA 220V (V25) — CÓDIGOS SAP CONFIRMADOS:**
| Referência WEG         | Potência (CV)  | Faixa (A)   | Código SAP |
|------------------------|---------------|-------------|------------|
| PDWM02-0,16/0,125V25   | 0,125 / 0,16  | 1,2 – 1,8  | 10070900   |
| PDWM02-0,33V25         | 0,25 / 0,33   | 2,8 – 4    | 10046171   |
| PDWM02-0,5/0,75V25     | 0,5 / 0,75    | 4 – 6,3    | 10046170   |
| PDWM02-1V25            | 0,75 / 1      | 5,6 – 8    | 10118357   |
| PDWM04-1,5AV25         | 1,5           | 7 – 10     | 10907057   |
| PDWM04-2A/1,5NV25      | 2             | 8 – 12,5   | 10045728   |
| PDWM04-3/2V25          | 3             | 11 – 17    | 10045729   |
| PDWM04-4AV25           | 4             | 15 – 23    | 10045739   |
| PDWM04-5AV25           | 5             | 22 – 32    | 10046444   |
| PDWM05-2A/1,5NV25      | 2             | 8 – 12,5   | 13339233   |
| PDWM05-3/2V25          | 3             | 11 – 17    | 13339229   |
| PDWM05-4AV25           | 4             | 15 – 23    | 13339270   |
| PDWM05-5AV25           | 5             | 22 – 32    | 13339236   |
| PDWM05-7,5AV25         | 7,5           | 32 – 40    | 13336722   |
| PDWM06-7,5AV25         | 7,5           | 32 – 40    | 10045740   |
| PDWM08-10AV25          | 10            | 32 – 50    | 10045766   |
| PDWM08-12,5AV25        | 12,5          | 40 – 57    | 10045741   |
| PDWM08-15AV25          | 15            | 57 – 70    | 10046182   |

Notas: V25=220V CA | V40=380V CA | V49=440V CA | VC8=127V CA
Se a faixa do relé WEG for menor que a do concorrente para o mesmo CV: selecione o modelo com faixa imediatamente superior e anote "⚠ Faixa WEG: X-Y A — confirmar ajuste com cliente".
Estes códigos SAP são confirmados — status="encontrado" quando o CV e tensão baterem exatamente.

### H. PROTETORES DE SURTO (SPDs — Surge Protection Devices)
- Usar tabela de equivalência da base de dados acima como prioridade
- Para itens não listados: casar por tensão (Un), corrente máxima (Imax/kA), classe (I, II, III, I/II), tecnologia (varistor MOV, ECG)
- WEG: SPW03 (CA classe II), SPW13 (CC/fotovoltaica)

### I. EQUIPAMENTOS CFTV / REDE
- Câmeras: casar por resolução (MP), distância IR (m), tipo (bullet/dome/PTZ), IP65/66, protocolo ONVIF
- Switches: casar por número de portas PoE e não-PoE, potência total PoE, velocidade (10/100/1000)
- Usar base WAU 14/2026 e 15/2026

### J. CAPACITORES E CORREÇÃO DO FATOR DE POTÊNCIA
**ATENÇÃO: WEG FABRICA linha completa de capacitores. NUNCA retornar "não encontrado" sem primeiro tentar casar por kVAr e tensão na base acima.**

Famílias WEG e quando usar cada uma:
- **UCW** (Unidade Capacitiva Monofásica): capacitor individual monofásico. Identificar: kVAr + tensão (220/380/440/480/535V). Código: UCW{kVAr}V{tensão} + sufixo tamanho.
- **UCWT HD** (Unidade Capacitiva Trifásica): capacitor individual trifásico padrão. Usar para maioria dos itens de capacitor trifásico. Código: UCWT{kVAr}V{tensão} L/N/Q/S/U HD.
- **UCWT UHD** (Ultra Heavy Duty): versão reforçada do UCWT, para uso com chaves tiristorizadas ou harmônicos elevados.
- **MCW** (Módulo Capacitivo Trifásico): banco pré-montado com UCWs integradas. Mais compacto e prático que UCWT isolado. Usar quando cliente pede "banco modular" ou "módulo capacitivo".
- **BCW** (Banco de Capacitores Trifásico em caixa): banco fechado com caixa metálica. Usar para instalações simples.
- **BCWP-D** (Banco com Disjuntor): BCW com disjuntor integrado.
- **BCWA** (Banco Automático): banco com controlador automático integrado (PFW03). Usar quando cliente pede "banco automático de capacitores" completo.
- **PFW03/PFW01**: controladores automáticos de fator de potência separados. PFW03=50/60Hz universal, PFW01=60Hz ou 50Hz específico.
- **PFWD01**: controlador dinâmico (para cargas variáveis rápidas, thyristor output).
- **CTSW**: chave tiristorizada para manobra de capacitores sem contator. Substitui Epcos/TDK PhaseCap switch, Nokian NKKTS, FRAKO KM.
- **AHFW**: filtro ativo para correção de FP e harmônicos. Substitui ABB PQF, Schneider AccuSine, Siemens SiCap.
- **DRW**: reator de dessintonia, sempre em conjunto com UCWT. Necessário quando há harmônicos na rede (redes com drives/inversores).

Parâmetros críticos para matching de capacitores:
1. **kVAr** (potência reativa): critério primário. Casar exatamente ou imediatamente acima.
2. **Tensão nominal** (V): 220V=V25 | 380V=V40 | 440V=V49 | 480V=V53 | 535V=V57 | 660V=V63 | 600V=V103
3. **Fases**: monofásico → UCW; trifásico → UCWT ou MCW
4. **Tipo de produto**: capacitor avulso (UCWT), banco (BCW/MCW), automático (BCWA), controlador (PFW), chave (CTSW), filtro ativo (AHFW)

Concorrentes mais comuns de capacitores:
- **ABB**: CLMD (trifásico), CLMB (monofásico), PQF (filtro ativo)
- **Schneider/Capacitor Industries**: Varplus Can, Vlarpluselec, AccuSine (filtro ativo)
- **Epcos / TDK**: MKV, B32 (monofásico), PhaseCap HD (trifásico), PhaseCap Speed (com chave tiristorizada)
- **Nokian**: NKK, NKKT (trifásico), NKKTS (chave tiristorizada)
- **FRAKO**: EM, KM (chave), LM, PM
- **Ducati / Icar / Comar**: CPT, MKP, capacitores italianos
- **Controladores concorrentes**: ABB RVT, Schneider Varplus Box, Lovato DCRG, Selec, Ducati MC

Regra de matching por item de texto livre (ex: "Capacitor 16,24 kvar 380 volts"):
→ 16,24 kVAr trifásico 380V → buscar UCWT mais próximo acima: **UCWT17,5V40 Q26 HD (11916880)** com observação "⚠ Kvar WEG imediatamente superior: 17,5 kVAr — confirmar com cliente"
Regra: se kVAr exato não existe, usar UCWT imediatamente acima e registrar no campo "observacao".

==========================================================================
## IDENTIFICAÇÃO DE FABRICANTE POR CÓDIGO

- Siemens: 3RT, 3RV, 3RU, 3RP, 3SB, SINAMICS (G120, S120), 6SL, 6ES, 6GK, 3RA2 (combinações partida direta)
- ABB: AF, A (A9..A300), MS, TA, ACS, ACH, ACS355/550/880, S200, SH200
- Schneider: LC1, LC2, LRD, GV2, GV3, ATV, ATS, NSX, CVS, RH, RM, LX, XB
- Eaton (Moeller): DILM, DILK, ZB, PKZM, PKM, NZM, DS7
- Danfoss: FC51, FC102, FC202, FC301, FC302, VLT
- Rockwell / Allen-Bradley: 100-C, 140M, 509, 520, 525, 755, 22B, 25B
- Lovato: BF, BG, BX, RGK
- Altronic: 3PDA (chaves de partida direta em caixa metálica — prefixo 3PDA + números de potência/tensão + sufixo B=com botoeira)
- WEG antigo: WSW, WEG-CFW (linha antiga)
- Capacitores — Epcos/TDK: B3232, MKV, PhaseCap, B32K (capacitores de potência)
- Capacitores — Nokian: NKK, NKKT, NKKF, NKKTS (chave tiristorizada)
- Capacitores — ABB: CLMD, CLMB, RVT (controlador)
- Capacitores — FRAKO: EM, KM, LM, PM
- Capacitores — Icar / Ducati / Comar / Elco: CPT, MKP (italianos)
- Capacitores — Schneider: Varplus Can, Vlarpluselec
- Controladores de FP — ABB: RVT | Schneider: Varplus Box | Lovato: DCRG | Selec: PFCR

==========================================================================
## FORMATO DE RESPOSTA — RETORNE APENAS JSON VÁLIDO, SEM TEXTO EXTRA:

{{
  "items": [
    {{
      "seq": 1,
      "codigo_cliente": "código exatamente como recebido",
      "quantidade": 1,
      "fabricante": "fabricante identificado",
      "descricao_cliente": "descrição/nome do produto do cliente",
      "tipo_produto": "categoria: Contator / DPM / Drive / Soft Starter / SPD / Câmera / etc.",
      "especificacoes": "corrente, tensão alimentação, tensão bobina, polos, acessórios, grau proteção, comunicação, etc. — COMPLETO",
      "codigo_weg": "código WAU 8 dígitos (item principal) ou vazio",
      "referencia_weg": "referência WEG (ex: CWM40-11-30V04) ou vazio",
      "descricao_weg": "descrição completa do produto WEG equivalente",
      "acessorios_weg": "códigos/referências WEG de acessórios separados necessários (ex: CW1, BVM, módulo ELP) ou vazio",
      "preco_lista": "valor em R$ somente se constar na base acima; senão vazio",
      "observacao": "⚠️ avisos: corrente superior utilizada, acessório não disponível na WEG, confirmar tensão de bobina, alternativa premium disponível, etc.",
      "status": "encontrado"
    }}
  ],
  "resumo": {{
    "total_itens": 0,
    "encontrados": 0,
    "parciais": 0,
    "nao_encontrados": 0,
    "observacoes_gerais": "observações gerais sobre a lista"
  }}
}}

Valores possíveis para "status": "encontrado" | "parcial" | "não encontrado"
"""

# ─── Helpers ─────────────────────────────────────────────────────────────────
IMAGE_EXTS = {".jpg", ".jpeg", ".png", ".gif", ".webp", ".heic", ".heif", ".bmp", ".tiff", ".tif"}
EXCEL_EXTS = {".xlsx", ".xls"}
CSV_EXTS   = {".csv"}

MEDIA_TYPES = {
    ".png": "image/png", ".gif": "image/gif", ".webp": "image/webp",
    ".jpg": "image/jpeg", ".jpeg": "image/jpeg", ".bmp": "image/jpeg",
    ".tiff": "image/jpeg", ".tif": "image/jpeg",
    ".heic": "image/jpeg", ".heif": "image/jpeg",
}


def parse_json_response(text: str) -> dict:
    text = re.sub(r"```json\s*", "", text)
    text = re.sub(r"```\s*", "", text)
    text = text.strip()
    try:
        return json.loads(text)
    except json.JSONDecodeError:
        pass
    match = re.search(r"\{[\s\S]*\}", text)
    if match:
        try:
            return json.loads(match.group())
        except json.JSONDecodeError:
            pass
    return {
        "items": [],
        "resumo": {
            "total_itens": 0, "encontrados": 0, "parciais": 0,
            "nao_encontrados": 0,
            "observacoes_gerais": "Não foi possível interpretar a resposta. Tente novamente.",
        },
    }


def call_claude_image(image_bytes: bytes, ext: str) -> dict:
    image_b64 = base64.standard_b64encode(image_bytes).decode("utf-8")
    media_type = MEDIA_TYPES.get(ext, "image/jpeg")
    resp = client.messages.create(
        model=VISION_MODEL,
        max_tokens=8192,
        system=SYSTEM_PROMPT,
        messages=[{
            "role": "user",
            "content": [
                {
                    "type": "image",
                    "source": {"type": "base64", "media_type": media_type, "data": image_b64},
                },
                {
                    "type": "text",
                    "text": (
                        "Analise esta imagem com lista de materiais elétricos/industriais de concorrentes. "
                        "Extraia TODOS os códigos e quantidades — mesmo que a escrita seja difícil, faça o melhor. "
                        "Para cada item, identifique o fabricante, extraia TODAS as especificações técnicas visíveis "
                        "(corrente, tensão, acessórios, comunicação, etc.) e converta para equivalente WEG conforme "
                        "as regras do sistema. RETORNE APENAS o JSON, sem texto adicional."
                    ),
                },
            ],
        }],
    )
    return parse_json_response(resp.content[0].text)


def call_claude_text(codes_text: str, source_hint: str = "planilha") -> dict:
    resp = client.messages.create(
        model=TEXT_MODEL,
        max_tokens=8192,
        system=SYSTEM_PROMPT,
        messages=[{
            "role": "user",
            "content": (
                f"Lista de materiais do cliente (origem: {source_hint}):\n\n"
                f"```\n{codes_text}\n```\n\n"
                "Para cada item: identifique o fabricante pelo código, extraia TODAS as especificações técnicas "
                "(corrente, tensão, acessórios, tipo de contato, protocolo de comunicação, grau de proteção, etc.) "
                "e converta para o equivalente WEG de melhor custo-benefício conforme as regras do sistema. "
                "RETORNE APENAS o JSON, sem texto adicional."
            ),
        }],
    )
    return parse_json_response(resp.content[0].text)


def process_image(content: bytes, ext: str) -> dict:
    if ext in {".heic", ".heif", ".tiff", ".tif", ".bmp"}:
        try:
            from PIL import Image as PILImage
            buf = io.BytesIO(content)
            img = PILImage.open(buf)
            out = io.BytesIO()
            img.convert("RGB").save(out, format="JPEG", quality=90)
            out.seek(0)
            content = out.read()
            ext = ".jpg"
        except Exception:
            pass
    return call_claude_image(content, ext)


def _extrair_codigo_weg_descricao(texto: str):
    """Extrai código SAP WEG (7-10 dígitos) de parênteses na descrição."""
    if not texto:
        return None
    matches = re.findall(r'\((\d{7,10})\)', str(texto))
    return matches[-1] if matches else None


def _detectar_tabela_excel(content: bytes):
    """Detecta cabeçalho real da tabela e extrai itens com códigos WEG embutidos."""
    try:
        import openpyxl as _opxl
        wb = _opxl.load_workbook(io.BytesIO(content), data_only=True)
        ws = wb.active
        all_rows = list(ws.iter_rows(values_only=True))

        KEYWORDS = {'cod', 'código', 'codigo', 'item', 'descriç', 'descrip', 'quant', 'unid', 'ref', 'material'}
        header_row_idx = None
        for i, row in enumerate(all_rows):
            row_text = ' '.join(str(v).lower() for v in row if v is not None).strip()
            if row_text and sum(1 for kw in KEYWORDS if kw in row_text) >= 2:
                header_row_idx = i
                break

        if header_row_idx is None:
            return None

        headers = [str(v).strip() if v else f"Col{j}" for j, v in enumerate(all_rows[header_row_idx])]
        rows_data = []
        for row in all_rows[header_row_idx + 1:]:
            if any(v is not None and str(v).strip() for v in row):
                rows_data.append({headers[j]: (str(v).strip() if v is not None else '') for j, v in enumerate(row)})

        if not rows_data:
            return None

        desc_col = next((k for k in headers if 'desc' in k.lower()), None)
        lines = []
        seq = 0
        for row in rows_data:
            if not any(v.strip() for v in row.values()):
                continue
            seq += 1
            desc_text = row.get(desc_col, '') if desc_col else ''
            weg_code = _extrair_codigo_weg_descricao(desc_text)
            parts = [f"Item {seq}:"]
            for k, v in row.items():
                if v.strip():
                    parts.append(f"{k}={v}")
            if weg_code:
                parts.append(f"[CÓDIGO SAP WEG NA DESCRIÇÃO: {weg_code}]")
                parts.append("[PRODUTO JÁ É WEG — preencher codigo_weg com este valor; extrair referencia_weg do modelo na descrição; status=encontrado]")
            lines.append(' | '.join(parts))

        return '\n'.join(lines) if lines else None
    except Exception:
        return None


def process_excel(content: bytes) -> dict:
    # Detecção inteligente: lida com planilhas de pedido/cotação formatadas
    enriched = _detectar_tabela_excel(content)
    if enriched:
        return call_claude_text(enriched, "Excel (tabela auto-detectada com códigos WEG extraídos)")

    # Fallback: pandas direto
    try:
        df = pd.read_excel(io.BytesIO(content), engine="openpyxl")
    except Exception:
        df = pd.read_excel(io.BytesIO(content))
    return call_claude_text(df.to_string(index=False), "Excel")


def process_csv(content: bytes) -> dict:
    for enc in ("utf-8", "latin-1", "cp1252"):
        try:
            df = pd.read_csv(io.BytesIO(content), encoding=enc)
            break
        except Exception:
            continue
    else:
        raise ValueError("Não foi possível decodificar o CSV.")
    return call_claude_text(df.to_string(index=False), "CSV")


# ─── Excel generator ──────────────────────────────────────────────────────────
WEG_BLUE   = "00205B"
WEG_GREEN  = "00853D"
LIGHT_BLUE = "E8F0FE"


def thin_border():
    s = Side(style="thin", color="CCCCCC")
    return Border(left=s, right=s, top=s, bottom=s)


def generate_excel(items: list, resumo: dict) -> io.BytesIO:
    wb = openpyxl.Workbook()
    ws = wb.active
    ws.title = "Conversão WEG"

    # Title
    ws.merge_cells("A1:M1")
    c = ws["A1"]
    c.value = "CONVERSÃO DE CÓDIGOS WEG  –  THP Representações"
    c.font = Font(bold=True, size=13, color="FFFFFF", name="Calibri")
    c.fill = PatternFill(start_color=WEG_BLUE, end_color=WEG_BLUE, fill_type="solid")
    c.alignment = Alignment(horizontal="center", vertical="center")
    ws.row_dimensions[1].height = 34

    # Headers
    COLS = [
        ("#",                   4),
        ("Código Cliente",     18),
        ("Qtd",                 5),
        ("Fabricante",         14),
        ("Tipo",               14),
        ("Especificações",     30),
        ("Código WEG",         16),
        ("Referência WEG",     22),
        ("Descrição WEG",      34),
        ("Acessórios WEG",     22),
        ("Preço Lista (R$)",   14),
        ("Observação",         40),
        ("Status",             16),
    ]
    for col_i, (label, width) in enumerate(COLS, 1):
        cell = ws.cell(row=2, column=col_i, value=label)
        cell.font = Font(bold=True, color="FFFFFF", name="Calibri", size=10)
        cell.fill = PatternFill(start_color=WEG_BLUE, end_color=WEG_BLUE, fill_type="solid")
        cell.alignment = Alignment(horizontal="center", vertical="center", wrap_text=True)
        cell.border = thin_border()
        ws.column_dimensions[get_column_letter(col_i)].width = width
    ws.row_dimensions[2].height = 28

    fills = {
        "encontrado":     PatternFill(start_color="D4EDDA", end_color="D4EDDA", fill_type="solid"),
        "parcial":        PatternFill(start_color="FFF3CD", end_color="FFF3CD", fill_type="solid"),
        "não encontrado": PatternFill(start_color="F8D7DA", end_color="F8D7DA", fill_type="solid"),
    }
    alt_fill = PatternFill(start_color="F0F4FF", end_color="F0F4FF", fill_type="solid")
    status_meta = {
        "encontrado":     ("155724", "✅ Encontrado"),
        "parcial":        ("856404", "⚠️ Parcial"),
        "não encontrado": ("721C24", "❌ Não encontrado"),
    }

    for r_i, item in enumerate(items, 3):
        status = item.get("status", "não encontrado").lower().strip()
        st_color, st_label = status_meta.get(status, ("721C24", "❌ Não encontrado"))

        row_vals = [
            item.get("seq", r_i - 2),
            item.get("codigo_cliente", ""),
            item.get("quantidade", 1),
            item.get("fabricante", ""),
            item.get("tipo_produto", ""),
            item.get("especificacoes", ""),
            item.get("codigo_weg", ""),
            item.get("referencia_weg", ""),
            item.get("descricao_weg", ""),
            item.get("acessorios_weg", ""),
            item.get("preco_lista", ""),
            item.get("observacao", ""),
            st_label,
        ]

        for col_i, val in enumerate(row_vals, 1):
            cell = ws.cell(row=r_i, column=col_i, value=val)
            cell.font = Font(name="Calibri", size=10)
            cell.alignment = Alignment(vertical="center", wrap_text=True)
            cell.border = thin_border()

            if col_i == 13:   # Status
                cell.fill = fills.get(status, fills["não encontrado"])
                cell.font = Font(name="Calibri", size=10, bold=True, color=st_color)
            elif col_i == 7:  # Código WEG
                cell.font = Font(name="Calibri", size=10, bold=True, color=WEG_BLUE)
            elif col_i == 12 and val:  # Observação
                cell.font = Font(name="Calibri", size=10, italic=True, color="7B5E00")
            elif r_i % 2 == 0:
                cell.fill = alt_fill

        ws.row_dimensions[r_i].height = 38

    # Summary
    s_row = len(items) + 4
    ws.merge_cells(f"A{s_row}:M{s_row}")
    sc = ws[f"A{s_row}"]
    sc.value = (
        f"Total: {resumo.get('total_itens', len(items))}  |  "
        f"Encontrados: {resumo.get('encontrados', 0)}  |  "
        f"Parciais: {resumo.get('parciais', 0)}  |  "
        f"Não encontrados: {resumo.get('nao_encontrados', 0)}"
    )
    sc.font = Font(bold=True, name="Calibri", size=10, color=WEG_BLUE)
    sc.fill = PatternFill(start_color=LIGHT_BLUE, end_color=LIGHT_BLUE, fill_type="solid")
    sc.alignment = Alignment(horizontal="left", vertical="center")
    ws.row_dimensions[s_row].height = 22

    obs_geral = resumo.get("observacoes_gerais", "")
    if obs_geral:
        o_row = s_row + 1
        ws.merge_cells(f"A{o_row}:M{o_row}")
        oc = ws[f"A{o_row}"]
        oc.value = f"Obs.: {obs_geral}"
        oc.font = Font(italic=True, name="Calibri", size=10, color="856404")
        oc.fill = PatternFill(start_color="FFF3CD", end_color="FFF3CD", fill_type="solid")
        oc.alignment = Alignment(horizontal="left", vertical="center", wrap_text=True)
        ws.row_dimensions[o_row].height = 22

    ws.freeze_panes = "A3"
    ws.auto_filter.ref = f"A2:M{len(items) + 2}"

    buf = io.BytesIO()
    wb.save(buf)
    buf.seek(0)
    return buf


# ─── Routes ───────────────────────────────────────────────────────────────────
@app.get("/")
async def root():
    return FileResponse("static/index.html")

@app.get("/health")
async def health():
    return {"status": "ok"}

@app.post("/api/convert")
async def convert(file: UploadFile = File(...)):
    content = await file.read()
    name = file.filename or ""
    ext  = Path(name).suffix.lower()

    try:
        if ext in IMAGE_EXTS:
            result = process_image(content, ext)
        elif ext in EXCEL_EXTS:
            result = process_excel(content)
        elif ext in CSV_EXTS:
            result = process_csv(content)
        else:
            raise HTTPException(
                status_code=400,
                detail=f"Formato '{ext or name}' não suportado. Use imagem (JPG, PNG, HEIC) ou planilha (XLSX, CSV).",
            )
    except HTTPException:
        raise
    except Exception as exc:
        raise HTTPException(status_code=500, detail=f"Erro ao processar: {exc}") from exc

    return JSONResponse(content=result)

class TextInput(BaseModel):
    texto: str

@app.post("/api/convert-text")
async def convert_text_endpoint(body: TextInput):
    """Converte lista de produtos a partir de texto livre (mensagem WhatsApp, e-mail, etc.)."""
    if not body.texto.strip():
        raise HTTPException(status_code=400, detail="Texto vazio. Cole a mensagem e tente novamente.")
    try:
        result = call_claude_text(body.texto.strip(), "mensagem WhatsApp / texto livre")
    except Exception as exc:
        raise HTTPException(status_code=500, detail=f"Erro ao processar: {exc}") from exc
    return JSONResponse(content=result)

@app.post("/api/export")
async def export(request: Request):
    data   = await request.json()
    items  = data.get("items", [])
    resumo = data.get("resumo", {})
    buf = generate_excel(items, resumo)
    return StreamingResponse(
        buf,
        media_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        headers={"Content-Disposition": "attachment; filename=conversao_weg.xlsx"},
    )
