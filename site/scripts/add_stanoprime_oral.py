import re
import shutil
import sys

import pymysql
from dotenv import dotenv_values

sys.stdout.reconfigure(encoding="utf-8")

APP = "/home/abgroup/catalogo"
WP_CONFIG = "/home/abgroup/web/anabolicgroup.com/public_html/wp-config.php"
UPLOADS = "/home/abgroup/web/anabolicgroup.com/public_html/wp-content/uploads/"
PUB_IMG = "/home/abgroup/web/test.anabolicgroup.com/public_html/static/img/"

WC_ID = 14523
IMG_SRC = "2025/11/STANOPRIME-10-MG.webp"
IMG_NAME = "stanoprime-10-mg.webp"

wpc = open(WP_CONFIG, encoding="utf-8", errors="ignore").read()


def cfgval(k):
    m = re.search(r"define\(\s*['\"]" + k + r"['\"]\s*,\s*['\"](.*?)['\"]\s*\)", wpc)
    return m.group(1) if m else None


PREFIX = "wp_buDIJ_"
m = re.search(r"\$table_prefix\s*=\s*['\"](.*?)['\"]", wpc)
if m:
    PREFIX = m.group(1)

wc = pymysql.connect(host=cfgval("DB_HOST") or "localhost", user=cfgval("DB_USER"),
                     password=cfgval("DB_PASSWORD"), database=cfgval("DB_NAME"),
                     charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor)
with wc.cursor() as cur:
    cur.execute(f"SELECT post_title, post_content FROM {PREFIX}posts WHERE ID=%s", (WC_ID,))
    p = cur.fetchone()
wc.close()

env = dotenv_values(f"{APP}/.env")
db = pymysql.connect(host=env["DB_HOST"], user=env["DB_USER"], password=env["DB_PASSWORD"],
                     database=env["DB_NAME"], charset="utf8mb4",
                     cursorclass=pymysql.cursors.DictCursor, autocommit=True)

with db.cursor() as cur:
    cur.execute("SELECT id FROM brands WHERE name='EMINENCE'")
    brand_id = cur.fetchone()["id"]
    cur.execute("SELECT id FROM categories WHERE name='Orales'")
    cat_id = cur.fetchone()["id"]
    cur.execute("SELECT id FROM products WHERE slug='stanoprime-10-mg'")
    if cur.fetchone():
        print("ya existe, no se inserta")
        sys.exit(0)
    cur.execute("SELECT COALESCE(MAX(sort_order),0)+1 AS nxt FROM products WHERE brand_id=%s", (brand_id,))
    sort_order = cur.fetchone()["nxt"]
    cur.execute("""INSERT INTO products
        (brand_id, category_id, name, slug, excerpt, description, presentation, price, currency,
         stock_status, is_published, image, seo_title, seo_description, sort_order, wc_id, wc_url)
        VALUES (%s,%s,%s,%s,%s,%s,'',%s,'USD','outofstock',0,%s,%s,%s,%s,%s,%s)""",
        (brand_id, cat_id, "Stanoprime 10 mg", "stanoprime-10-mg",
         "Definición + Dureza", p["post_content"] or "", 36.99,
         "/static/img/" + IMG_NAME, p["post_title"],
         "Stanoprime 10 mg de Eminence Labs: estanozolol oral, caja de 50 tabletas.",
         sort_order, WC_ID, f"https://anabolicgroup.com/wp-admin/post.php?post={WC_ID}&action=edit"))
    print("producto insertado, id", cur.lastrowid)

for dst in (f"{APP}/static/img/{IMG_NAME}", f"{PUB_IMG}{IMG_NAME}"):
    try:
        shutil.copy(UPLOADS + IMG_SRC, dst)
        print("imagen:", dst)
    except Exception as exc:
        print("imagen fallida", dst, exc)
