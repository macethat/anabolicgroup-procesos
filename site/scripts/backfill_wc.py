import csv
import sys

import pymysql
from dotenv import dotenv_values

sys.stdout.reconfigure(encoding="utf-8")

env = dotenv_values("/home/abgroup/catalogo/.env")
db = pymysql.connect(host=env["DB_HOST"], user=env["DB_USER"], password=env["DB_PASSWORD"],
                     database=env["DB_NAME"], charset="utf8mb4",
                     cursorclass=pymysql.cursors.DictCursor, autocommit=True)

COLS = {"wc_id": "INT NULL", "wc_url": "VARCHAR(255) NULL"}
with db.cursor() as cur:
    cur.execute("""SELECT COLUMN_NAME FROM information_schema.COLUMNS
                   WHERE TABLE_SCHEMA=%s AND TABLE_NAME='products'""", (env["DB_NAME"],))
    have = {r["COLUMN_NAME"] for r in cur.fetchall()}
    for name, ddl in COLS.items():
        if name not in have:
            cur.execute(f"ALTER TABLE products ADD COLUMN {name} {ddl}")
            print("columna agregada:", name)

rows = list(csv.DictReader(open("/home/abgroup/catalogo/wc_links.csv", encoding="utf-8")))
ok = 0
missing = []
with db.cursor() as cur:
    for r in rows:
        cur.execute("UPDATE products SET wc_id=%s, wc_url=%s WHERE slug=%s",
                    (r["wc_id"], r["wc_url"], r["slug"]))
        if cur.rowcount:
            ok += 1
        else:
            missing.append(r["slug"])

print(f"actualizados {ok} de {len(rows)}")
for m in missing:
    print("  sin match:", m)
