import csv
import os
import sys

import pymysql
from dotenv import dotenv_values

sys.stdout.reconfigure(encoding="utf-8")

BASE_URL = "https://test.anabolicgroup.com/producto/"
OUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/home/abgroup/catalogo/exports"
os.makedirs(OUT_DIR, exist_ok=True)

STOCK = {"instock": "En stock", "outofstock": "Agotado"}


def connect():
    env = dotenv_values("/home/abgroup/catalogo/.env")
    return pymysql.connect(host=env["DB_HOST"], user=env["DB_USER"], password=env["DB_PASSWORD"],
                           database=env["DB_NAME"], charset="utf8mb4",
                           cursorclass=pymysql.cursors.DictCursor)


def money(v):
    return "" if v is None else f"{float(v):.2f}"


db = connect()
with db.cursor() as cur:
    cur.execute("""
        SELECT p.id, p.code, p.name, p.slug, p.price, p.stock_status, p.is_published, p.wc_url,
               b.name AS marca, c.name AS cat
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

# Agrupa por marca conservando el orden de la consulta
blocks = []
for p in products:
    if not blocks or blocks[-1][0] != p["marca"]:
        blocks.append((p["marca"], []))
    blocks[-1][1].append(p)


def write_csv(path, header, row_for):
    n = 0
    with open(path, "w", encoding="utf-8-sig", newline="") as fh:
        w = csv.writer(fh, quoting=csv.QUOTE_MINIMAL, lineterminator="\r\n")
        w.writerow(header)
        for i, (marca, items) in enumerate(blocks):
            if i:
                w.writerow([""] * len(header))       # separación entre bloques
            w.writerow([f"MARCA: {marca}"] + [""] * (len(header) - 1))
            for p in items:
                for row in row_for(p):
                    w.writerow(row)
                    n += 1
    return n, len(blocks)


# --- CSV 1: nombre, categoria, enlace, enlace WooCommerce (solo no disponibles) ---
def rows_fichas(p):
    url = BASE_URL + p["slug"] + "/" if p["is_published"] else "No publicado"
    wc = "" if p["is_published"] else (p["wc_url"] or "")
    yield [p["name"], p["cat"] or "", url, wc]
    for v in by_product.get(p["id"], []):
        yield [v["label"], "", url, wc]


# --- CSV 2: codigo, nombre, categoria, stock, precio ---
def rows_inventario(p):
    yield [p["code"], p["name"], p["cat"] or "",
           STOCK.get(p["stock_status"], p["stock_status"]), money(p["price"])]
    for v in by_product.get(p["id"], []):
        yield ["", v["label"], "",
               STOCK.get(v["stock_status"], v["stock_status"]), money(v["price"])]


f1 = os.path.join(OUT_DIR, "catalogo-fichas.csv")
n1, b1 = write_csv(f1, ["Nombre del producto", "Categoría", "Enlace de la ficha",
                        "Enlace ficha WooCommerce (solo no disponibles)"], rows_fichas)
f2 = os.path.join(OUT_DIR, "catalogo-inventario.csv")
n2, b2 = write_csv(f2, ["Código", "Nombre del producto", "Categoría", "Status de stock", "Precio"],
                   rows_inventario)

print(f"{f1}: {n1} filas de producto en {b1} bloques")
print(f"{f2}: {n2} filas de producto en {b2} bloques")
