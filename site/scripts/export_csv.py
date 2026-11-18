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
        SELECT p.id, p.code, p.name, p.slug, p.price, p.stock_status, p.presentation, p.is_published,
               c.name AS cat, b.sort_order AS bs
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

# --- CSV 1: nombre, categoria, enlace ---
f1 = os.path.join(OUT_DIR, "catalogo-fichas.csv")
n1 = 0
with open(f1, "w", encoding="utf-8-sig", newline="") as fh:
    w = csv.writer(fh, quoting=csv.QUOTE_MINIMAL, lineterminator="\r\n")
    w.writerow(["Nombre del producto", "Categoría", "Enlace de la ficha"])
    for p in products:
        url = BASE_URL + p["slug"] + "/" if p["is_published"] else ""
        w.writerow([p["name"], p["cat"] or "", url])
        n1 += 1
        for v in by_product.get(p["id"], []):
            w.writerow([v["label"], "", url])
            n1 += 1

# --- CSV 2: codigo, nombre, categoria, stock, precio ---
f2 = os.path.join(OUT_DIR, "catalogo-inventario.csv")
n2 = 0
with open(f2, "w", encoding="utf-8-sig", newline="") as fh:
    w = csv.writer(fh, quoting=csv.QUOTE_MINIMAL, lineterminator="\r\n")
    w.writerow(["Código", "Nombre del producto", "Categoría", "Status de stock", "Precio"])
    for p in products:
        w.writerow([p["code"], p["name"], p["cat"] or "",
                    STOCK.get(p["stock_status"], p["stock_status"]), money(p["price"])])
        n2 += 1
        for v in by_product.get(p["id"], []):
            w.writerow(["", v["label"], "",
                        STOCK.get(v["stock_status"], v["stock_status"]), money(v["price"])])
            n2 += 1

print(f"{f1}: {n1} filas")
print(f"{f2}: {n2} filas")
