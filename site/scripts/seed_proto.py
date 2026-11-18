import csv, os, re, sys, shutil, unicodedata
import pymysql
from dotenv import dotenv_values

UPLOADS = "/home/abgroup/web/anabolicgroup.com/public_html/wp-content/uploads/"
TSV = "/home/abgroup/web/anabolicgroup.com/proto_products.tsv"
IMGDIR = "/home/abgroup/web/test.anabolicgroup.com/public_html/static/img"
WEBPATH = "/static/img"
os.makedirs(IMGDIR, exist_ok=True)

cfg = dotenv_values("/home/abgroup/catalogo/.env")
conn = pymysql.connect(host=cfg["DB_HOST"], user=cfg["DB_USER"], password=cfg["DB_PASSWORD"],
                       database=cfg["DB_NAME"], charset="utf8mb4", autocommit=True)
cur = conn.cursor()

def slugify(s):
    s = unicodedata.normalize("NFKD", s).encode("ascii", "ignore").decode()
    s = s.lower()
    s = re.sub(r"[^a-z0-9]+", "-", s).strip("-")
    return s or "item"

def brand_id(name):
    name = name or "SIN MARCA"
    cur.execute("SELECT id FROM brands WHERE name=%s", (name,))
    r = cur.fetchone()
    if r: return r[0]
    cur.execute("INSERT INTO brands (name, slug, sort_order) VALUES (%s,%s,%s)", (name, slugify(name), 0))
    return cur.lastrowid

def cat_id(name):
    cur.execute("SELECT id FROM categories WHERE name=%s", (name,))
    r = cur.fetchone()
    if r: return r[0]
    cur.execute("INSERT INTO categories (name, slug) VALUES (%s,%s)", (name, slugify(name)))
    return cur.lastrowid

# limpiar prototipo
cur.execute("DELETE FROM presentations")
cur.execute("DELETE FROM products")
cur.execute("DELETE FROM brands")
cur.execute("DELETE FROM categories")
cur.execute("ALTER TABLE brands AUTO_INCREMENT=1")
cur.execute("ALTER TABLE categories AUTO_INCREMENT=1")
cur.execute("ALTER TABLE products AUTO_INCREMENT=1")

rows = list(csv.DictReader(open(TSV, encoding="utf-8-sig"), delimiter="\t"))
print(f"filas: {len(rows)}")

ok = 0
for r in rows:
    full = (r.get("name") or "").strip()
    if not full: continue
    if ":" in full:
        name, tagline = full.split(":", 1)
    else:
        name, tagline = full, ""
    name = name.strip(); tagline = tagline.strip()
    price = None
    p = (r.get("price") or "").strip()
    if p and p.upper() != "NULL":
        try: price = float(p)
        except: price = None
    brand = (r.get("brand") or "SIN MARCA").strip()
    cats = (r.get("cats") or "")
    if "Péptidos" in cats or "Peptidos" in cats: cat = "Péptidos"
    elif "Inyectables" in cats: cat = "Inyectables"
    elif "Orales" in cats: cat = "Orales"
    else: cat = "General"

    image_rel = (r.get("image") or "").strip()
    fname = None
    if image_rel:
        ext = os.path.splitext(image_rel)[1].lower() or ".jpg"
        base = slugify(name)
        fname = base + ext
        if os.path.exists(os.path.join(IMGDIR, fname)):
            fname = base + "-" + str(r.get("ID")) + ext
        src = os.path.join(UPLOADS, image_rel)
        try:
            if os.path.exists(src):
                shutil.copy(src, os.path.join(IMGDIR, fname))
            else:
                print("img missing", image_rel)
                fname = None
        except Exception as e:
            print("img fail", image_rel, e)
            fname = None

    bid = brand_id(brand)
    cid = cat_id(cat)
    slug = slugify(name)
    cur.execute("SELECT id FROM products WHERE slug=%s", (slug,))
    if cur.fetchone():
        slug = slug + "-" + str(r.get("ID"))

    cur.execute(
        """INSERT INTO products (brand_id, category_id, name, slug, excerpt, price, currency,
             stock_status, is_published, image, sort_order)
           VALUES (%s,%s,%s,%s,%s,%s,'USD','instock',1,%s,%s)""",
        (bid, cid, name, slug, tagline, price, (WEBPATH + "/" + fname) if fname else None, ok)
    )
    ok += 1

print(f"insertados: {ok}")
cur.execute("SELECT b.name, COUNT(*) FROM products p JOIN brands b ON b.id=p.brand_id GROUP BY b.name")
for row in cur.fetchall():
    print("  ", row[0], row[1])
cur.execute("SELECT COUNT(*) FROM products")
print("total products:", cur.fetchone()[0])
