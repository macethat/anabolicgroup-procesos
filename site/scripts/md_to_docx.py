import re
import sys

from docx import Document
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.shared import Cm, Pt, RGBColor

sys.stdout.reconfigure(encoding="utf-8")

SRC = r"C:\anabolicgroup\INFORME-CAMBIOS-20261118.md"
OUT = r"C:\anabolicgroup\INFORME-CAMBIOS-20261118.docx"

ROJO = RGBColor(0xE2, 0x06, 0x13)
NEGRO = RGBColor(0x14, 0x14, 0x14)
GRIS = RGBColor(0x59, 0x59, 0x59)

doc = Document()

# --- estilos base ---
normal = doc.styles["Normal"]
normal.font.name = "Calibri"
normal.font.size = Pt(10.5)
normal.font.color.rgb = NEGRO
normal.paragraph_format.space_after = Pt(6)
normal.paragraph_format.line_spacing = 1.15

for name, size, color, before in (("Heading 1", 22, ROJO, 0), ("Heading 2", 14, NEGRO, 16),
                                  ("Heading 3", 11.5, ROJO, 12)):
    st = doc.styles[name]
    st.font.name = "Calibri"
    st.font.size = Pt(size)
    st.font.bold = True
    st.font.color.rgb = color
    st.paragraph_format.space_before = Pt(before)
    st.paragraph_format.space_after = Pt(6)

for section in doc.sections:
    section.top_margin = Cm(2)
    section.bottom_margin = Cm(2)
    section.left_margin = Cm(2.2)
    section.right_margin = Cm(2.2)


def shade(cell, hexcolor):
    tcPr = cell._tc.get_or_add_tcPr()
    shd = OxmlElement("w:shd")
    shd.set(qn("w:val"), "clear")
    shd.set(qn("w:color"), "auto")
    shd.set(qn("w:fill"), hexcolor)
    tcPr.append(shd)


def add_inline(par, text, bold_all=False, color=None, italic=False):
    """Convierte **negrita** y `codigo` en runs."""
    tokens = re.split(r"(\*\*.+?\*\*|`.+?`)", text)
    for tok in tokens:
        if not tok:
            continue
        if tok.startswith("**") and tok.endswith("**"):
            run = par.add_run(tok[2:-2])
            run.bold = True
        elif tok.startswith("`") and tok.endswith("`"):
            run = par.add_run(tok[1:-1])
            run.font.name = "Consolas"
            run.font.size = Pt(9.5)
            run.bold = bold_all
        else:
            run = par.add_run(tok)
            run.bold = bold_all
        if color:
            run.font.color.rgb = color
        if italic:
            run.italic = True
    return par


def add_table(rows):
    header, body = rows[0], rows[1:]
    table = doc.add_table(rows=1, cols=len(header))
    table.style = "Table Grid"
    table.alignment = WD_TABLE_ALIGNMENT.CENTER
    table.autofit = True

    for i, txt in enumerate(header):
        cell = table.rows[0].cells[i]
        cell.text = ""
        par = cell.paragraphs[0]
        par.paragraph_format.space_after = Pt(2)
        add_inline(par, txt, bold_all=True)
        shade(cell, "F2F2F2")

    for r in body:
        cells = table.add_row().cells
        for i, txt in enumerate(r[: len(header)]):
            cells[i].text = ""
            par = cells[i].paragraphs[0]
            par.paragraph_format.space_after = Pt(2)
            add_inline(par, txt)

    doc.add_paragraph().paragraph_format.space_after = Pt(2)


lines = open(SRC, encoding="utf-8").read().splitlines()
i = 0
while i < len(lines):
    line = lines[i].rstrip()
    if not line:
        i += 1
        continue

    if line.startswith("| "):
        block = []
        while i < len(lines) and lines[i].strip().startswith("|"):
            row = [c.strip() for c in lines[i].strip().strip("|").split("|")]
            if not all(re.fullmatch(r"-{2,}|:?-{2,}:?", c or "-") for c in row):
                block.append(row)
            i += 1
        if block:
            add_table(block)
        continue

    if line.startswith("# "):
        doc.add_heading(line[2:].strip(), level=1)
    elif line.startswith("## "):
        doc.add_heading(line[3:].strip(), level=2)
    elif line.startswith("### "):
        doc.add_heading(line[4:].strip(), level=3)
    elif line.strip() == "---":
        p = doc.add_paragraph()
        pPr = p._p.get_or_add_pPr()
        pbdr = OxmlElement("w:pBdr")
        bottom = OxmlElement("w:bottom")
        bottom.set(qn("w:val"), "single")
        bottom.set(qn("w:sz"), "6")
        bottom.set(qn("w:color"), "D9D9D9")
        pbdr.append(bottom)
        pPr.append(pbdr)
    elif line.startswith("> "):
        p = doc.add_paragraph()
        p.paragraph_format.left_indent = Cm(0.6)
        add_inline(p, line[2:].strip(), color=GRIS, italic=True)
    elif line.startswith("- "):
        p = doc.add_paragraph(style="List Bullet")
        p.paragraph_format.space_after = Pt(3)
        add_inline(p, line[2:].strip())
    elif re.match(r"^\d+\.\s", line):
        p = doc.add_paragraph(style="List Number")
        add_inline(p, re.sub(r"^\d+\.\s", "", line))
    else:
        p = doc.add_paragraph()
        add_inline(p, line)
    i += 1

doc.save(OUT)
print("guardado:", OUT)
