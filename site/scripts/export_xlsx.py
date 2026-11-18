import os
import sys

import pymysql
from dotenv import dotenv_values
from openpyxl import Workbook
from openpyxl.drawing.image import Image as XLImage
from openpyxl.styles import Alignment, Border, Font, PatternFill, Side
from openpyxl.utils import get_column_letter
from openpyxl.worksheet.properties import PageSetupProperties
from PIL import Image

sys.stdout.reconfigure(encoding="utf-8")

BASE_URL = "https://test.anabolicgroup.com/producto/"
APP = "/home/abgroup/catalogo"
OUT = os.path.join(APP, "exports", "catalogo-fichas.xlsx")
THUMBS = os.path.join(APP, "exports", "thumbs")
os.makedirs(THUMBS, exist_ok=True)

STOCK = {"instock": "En stock", "outofstock": "Agotado"}
THUMB_W, THUMB_H = 110, 138

ROJO = "E20613"
NEGRO = "141414"
GRIS = "F2F2F2"
BORDE = Side(style="thin", color="D9D9D9")

env = dotenv_values(os.path.join(APP, ".env"))
db = pymysql.connect(host=env["DB_HOST"], user=env["DB_USER"], password=env["DB_PASSWORD"],
                     database=env["DB_NAME"], charset="utf8mb4",
                     cursorclass=pymysql.cursors.DictCursor)
with db.cursor() as cur:
    cur.execute("""
        SELECT p.id, p.code, p.name, p.slug, p.price, p.stock_status, p.is_published,
               p.wc_url, p.image, b.name AS marca, c.name AS cat
        FROM products p
        JOIN brands b ON b.id = p.brand_id
        LEFT JOIN categories c ON c.id = p.category_id
        ORDER BY b.sort_order, b.name, p.sort_order, p.name
    """)
    products = cur.fetchall()
    cur.execute("""SELECT product_id, label, price, stock_status FROM presentations
                   ORDER BY product_id, sort_order""")
    pres = cur.fetchall()
db.close()

by_product = {}
for r in pres:
    by_product.setdefault(r["product_id"], []).append(r)

blocks = []
for p in products:
    if not blocks or blocks[-1][0] != p["marca"]:
        blocks.append((p["marca"], []))
    blocks[-1][1].append(p)


def thumb(rel_image, slug):
    """Devuelve la ruta del thumbnail JPEG (o None)."""
    if not rel_image:
        return None
    src = os.path.join(APP, rel_image.lstrip("/"))
    if not os.path.exists(src):
        return None
    dst = os.path.join(THUMBS, slug + ".jpg")
    if os.path.exists(dst):
        return dst
    try:
        im = Image.open(src)
        im = im.convert("RGBA")
        bg = Image.new("RGBA", im.size, (255, 255, 255, 255))
        bg.alpha_composite(im)
        im = bg.convert("RGB")
        im.thumbnail((THUMB_W, THUMB_H), Image.LANCZOS)
        im.save(dst, "JPEG", quality=82, optimize=True)
        return dst
    except Exception as exc:
        print("  imagen fallida:", slug, exc)
        return None


wb = Workbook()
ws = wb.active
ws.title = "Fichas"
headers = ["Imagen", "Nombre del producto", "Categoría", "Enlace de la ficha",
           "Enlace ficha WooCommerce (solo no disponibles)"]
widths = [17, 46, 14, 58, 58]
for i, (h, w) in enumerate(zip(headers, widths), start=1):
    c = ws.cell(row=1, column=i, value=h)
    c.font = Font(bold=True, color="FFFFFF", size=11)
    c.fill = PatternFill("solid", fgColor=NEGRO)
    c.alignment = Alignment(vertical="center", horizontal="left")
    ws.column_dimensions[get_column_letter(i)].width = w
ws.row_dimensions[1].height = 24
ws.freeze_panes = "A2"
ws.page_setup.orientation = "landscape"
ws.page_setup.fitToWidth = 1
ws.page_setup.fitToHeight = 0
ws.sheet_properties.pageSetUpPr = PageSetupProperties(fitToPage=True)
ws.print_title_rows = "1:1"

row = 2
img_count = 0
for bi, (marca, items) in enumerate(blocks):
    if bi:
        row += 1
    ws.merge_cells(start_row=row, start_column=1, end_row=row, end_column=len(headers))
    c = ws.cell(row=row, column=1, value="MARCA: " + marca)
    c.font = Font(bold=True, color="FFFFFF", size=12)
    c.fill = PatternFill("solid", fgColor=ROJO)
    c.alignment = Alignment(vertical="center", horizontal="left", indent=1)
    ws.row_dimensions[row].height = 22
    row += 1

    for p in items:
        url = BASE_URL + p["slug"] + "/" if p["is_published"] else "No publicado"
        wc = "" if p["is_published"] else (p["wc_url"] or "")
        name = p["name"]
        sub_rows = [("", name, p["cat"] or "", url, wc, p["image"], p["slug"])]
        for v in by_product.get(p["id"], []):
            sub_rows.append((v["label"], "", "", url, wc, None, None))

        for i, (label, nm, cat, link1, link2, img, slug) in enumerate(sub_rows):
            ws.row_dimensions[row].height = 112 if i == 0 else 20
            if i == 0:
                path = thumb(img, slug)
                if path:
                    pic = XLImage(path)
                    ws.add_image(pic, f"A{row}")
                    img_count += 1
            else:
                ws.cell(row=row, column=1, value=label).alignment = Alignment(
                    vertical="center", horizontal="right")
            if nm:
                ws.cell(row=row, column=2, value=nm).alignment = Alignment(
                    vertical="center", wrap_text=False)
            if cat:
                ws.cell(row=row, column=3, value=cat).alignment = Alignment(vertical="center")
            if link1:
                c = ws.cell(row=row, column=4, value=link1)
                if link1.startswith("http"):
                    c.hyperlink = link1
                    c.font = Font(color="0563C1", underline="single")
                else:
                    c.font = Font(color="C00000", italic=True)
            if link2:
                c = ws.cell(row=row, column=5, value=link2)
                c.hyperlink = link2
                c.font = Font(color="0563C1", underline="single", size=9)
            for col in range(1, len(headers) + 1):
                cell = ws.cell(row=row, column=col)
                cell.border = Border(bottom=BORDE)
                if cell.alignment is None or not cell.alignment.horizontal:
                    cell.alignment = Alignment(vertical="center", wrap_text=False)
            row += 1

# --- Hoja 2: inventario (sin imagenes) ---
ws2 = wb.create_sheet("Inventario")
h2 = ["Código", "Nombre del producto", "Categoría", "Status de stock", "Precio"]
for i, h in enumerate(h2, start=1):
    c = ws2.cell(row=1, column=i, value=h)
    c.font = Font(bold=True, color="FFFFFF", size=11)
    c.fill = PatternFill("solid", fgColor=NEGRO)
ws2.column_dimensions["A"].width = 16
ws2.column_dimensions["B"].width = 52
ws2.column_dimensions["C"].width = 14
ws2.column_dimensions["D"].width = 16
ws2.column_dimensions["E"].width = 12
ws2.freeze_panes = "A2"
ws2.page_setup.orientation = "landscape"
ws2.page_setup.fitToWidth = 1
ws2.page_setup.fitToHeight = 0
ws2.sheet_properties.pageSetUpPr = PageSetupProperties(fitToPage=True)
ws2.print_title_rows = "1:1"
r2 = 2
for bi, (marca, items) in enumerate(blocks):
    if bi:
        r2 += 1
    ws2.merge_cells(start_row=r2, start_column=1, end_row=r2, end_column=len(h2))
    c = ws2.cell(row=r2, column=1, value="MARCA: " + marca)
    c.font = Font(bold=True, color="FFFFFF", size=12)
    c.fill = PatternFill("solid", fgColor=ROJO)
    r2 += 1
    for p in items:
        rows = [(p["code"], p["name"], p["cat"] or "",
                 STOCK.get(p["stock_status"], p["stock_status"]),
                 "" if p["price"] is None else float(p["price"]))]
        for v in by_product.get(p["id"], []):
            rows.append(("", v["label"], "",
                         STOCK.get(v["stock_status"], v["stock_status"]), float(v["price"])))
        for rr in rows:
            for col, val in enumerate(rr, start=1):
                c = ws2.cell(row=r2, column=col, value=val)
                c.border = Border(bottom=BORDE)
                if col == 5:
                    c.number_format = "0.00"
            r2 += 1

wb.save(OUT)
print(f"OK {OUT} | productos {len(products)} | imagenes {img_count} | "
      f"tamano {os.path.getsize(OUT)/1024/1024:.2f} MB")
