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

### G. PROTETORES DE SURTO (SPDs)
- Usar tabela de equivalência da base de dados acima como prioridade
- Para itens não listados: casar por tensão (Un), corrente máxima (Imax/kA), classe (I, II, III, I/II), tecnologia (varistor MOV, ECG)
- WEG: SPW03 (CA classe II), SPW13 (CC/fotovoltaica)

### H. EQUIPAMENTOS CFTV / REDE
- Câmeras: casar por resolução (MP), distância IR (m), tipo (bullet/dome/PTZ), IP65/66, protocolo ONVIF
- Switches: casar por número de portas PoE e não-PoE, potência total PoE, velocidade (10/100/1000)
- Usar base WAU 14/2026 e 15/2026

==========================================================================
## IDENTIFICAÇÃO DE FABRICANTE POR CÓDIGO

- Siemens: 3RT, 3RV, 3RU, 3RP, 3SB, SINAMICS (G120, S120), 6SL, 6ES, 6GK
- ABB: AF, A (A9..A300), MS, TA, ACS, ACH, ACS355/550/880, S200, SH200
- Schneider: LC1, LC2, LRD, GV2, GV3, ATV, ATS, NSX, CVS, RH, RM, LX, XB
- Eaton (Moeller): DILM, DILK, ZB, PKZM, PKM, NZM, DS7
- Danfoss: FC51, FC102, FC202, FC301, FC302, VLT
- Rockwell / Allen-Bradley: 100-C, 140M, 509, 520, 525, 755, 22B, 25B
- Lovato: BF, BG, BX, RGK
- WEG antigo: WSW, WEG-CFW (linha antiga)

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


def process_excel(content: bytes) -> dict:
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
