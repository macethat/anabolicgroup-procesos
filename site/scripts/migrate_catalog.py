import csv, json, os, re, shutil, sys, unicodedata
import pymysql
from dotenv import dotenv_values

MAP = "/home/abgroup/catalogo/migration_map.csv"
WP_CONFIG = "/home/abgroup/web/anabolicgroup.com/public_html/wp-config.php"
UPLOADS = "/home/abgroup/web/anabolicgroup.com/public_html/wp-content/uploads/"
NEW_IMG = "/home/abgroup/web/test.anabolicgroup.com/public_html/static/img/"
APP_IMG = "/home/abgroup/catalogo/static/img/"
os.makedirs(NEW_IMG, exist_ok=True)
os.makedirs(APP_IMG, exist_ok=True)

# --- credenciales WC desde wp-config ---
wpc = open(WP_CONFIG, encoding="utf-8", errors="ignore").read()
def cfgval(k):
    m = re.search(r"define\(\s*['\"]" + k + r"['\"]\s*,\s*['\"](.*?)['\"]\s*\)", wpc)
    return m.group(1) if m else None
PREFIX = "wp_buDIJ_"
m = re.search(r"\$table_prefix\s*=\s*['\"](.*?)['\"]", wpc)
if m: PREFIX = m.group(1)

wc = pymysql.connect(host=cfgval("DB_HOST") or "localhost", user=cfgval("DB_USER"),
                     password=cfgval("DB_PASSWORD"), database=cfgval("DB_NAME"),
                     charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor, autocommit=True)
env = dotenv_values("/home/abgroup/catalogo/.env")
ndb = pymysql.connect(host=env["DB_HOST"], user=env["DB_USER"], password=env["DB_PASSWORD"],
                      database=env["DB_NAME"], charset="utf8mb4",
                      cursorclass=pymysql.cursors.DictCursor, autocommit=True)

def slugify(s):
    s = unicodedata.normalize("NFKD", str(s or "")).encode("ascii", "ignore").decode().lower()
    s = re.sub(r"[^a-z0-9]+", "-", s).strip("-")
    return s or "item"

def qw(sql, args=None):
    with wc.cursor() as cur:
        cur.execute(sql, args or ())
        return cur.fetchall()

def get_product(pid):
    rows = qw(f"""SELECT p.post_title, p.post_content, p.post_excerpt, p.post_status,
      (SELECT meta_value FROM {PREFIX}postmeta WHERE post_id=p.ID AND meta_key='_stock') AS stock,
      (SELECT meta_value FROM {PREFIX}postmeta WHERE post_id=p.ID AND meta_key='_stock_status') AS stock_status,
      (SELECT meta_value FROM {PREFIX}postmeta WHERE post_id=p.ID AND meta_key='_regular_price') AS price,
      (SELECT att.meta_value FROM {PREFIX}postmeta att
         WHERE att.post_id=(SELECT meta_value FROM {PREFIX}postmeta WHERE post_id=p.ID AND meta_key='_thumbnail_id')
           AND att.meta_key='_wp_attached_file') AS image
      FROM {PREFIX}posts p WHERE p.ID=%s""", (pid,))
    return rows[0] if rows else None

def get_brand(pid):
    rows = qw(f"""SELECT t.name FROM {PREFIX}term_relationships tr
      JOIN {PREFIX}term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_brand' AND tt.parent<>0
      JOIN {PREFIX}terms t ON t.term_id=tt.term_id WHERE tr.object_id=%s LIMIT 1""", (pid,))
    return rows[0]["name"] if rows else ""

def get_leaf(pid):
    rows = qw(f"""SELECT t.name FROM {PREFIX}term_relationships tr
      JOIN {PREFIX}term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_cat'
      JOIN {PREFIX}terms t ON t.term_id=tt.term_id WHERE tr.object_id=%s""", (pid,))
    names = [r["name"] for r in rows]
    leaf = [n for n in names if n not in ("Anabolicos", "Promociónes y Combos", "Promociones y Combos")]
    return leaf[0] if leaf else None

def get_var(vid):
    rows = qw(f"""SELECT
      (SELECT meta_value FROM {PREFIX}postmeta WHERE post_id=v.ID AND meta_key='_stock') AS stock,
      (SELECT meta_value FROM {PREFIX}postmeta WHERE post_id=v.ID AND meta_key='_stock_status') AS stock_status,
      (SELECT meta_value FROM {PREFIX}postmeta WHERE post_id=v.ID AND meta_key='_price') AS price
      FROM {PREFIX}posts v WHERE v.ID=%s""", (vid,))
    return rows[0] if rows else None

def avail(stock, status):
    if stock is not None and str(stock).strip() not in ("", "NULL"):
        try:
            return float(stock) > 0
        except Exception:
            pass
    return status == "instock"

def copy_image(image_rel, base):
    if not image_rel:
        return None
    ext = os.path.splitext(image_rel)[1].lower() or ".jpg"
    fname = slugify(base) + ext
    if os.path.exists(os.path.join(NEW_IMG, fname)):
        fname = slugify(base) + "-" + str(abs(hash(image_rel)) % 100000) + ext
    src = os.path.join(UPLOADS, image_rel)
    if not os.path.exists(src):
        return None
    shutil.copy(src, os.path.join(NEW_IMG, fname))
    try:
        shutil.copy(src, os.path.join(APP_IMG, fname))
    except Exception:
        pass
    return "/static/img/" + fname

brand_ids, cat_ids = {}, {}
def brand_id(name):
    if name in brand_ids: return brand_ids[name]
    with ndb.cursor() as cur:
        cur.execute("SELECT id FROM brands WHERE name=%s", (name,))
        r = cur.fetchone()
        if r: brand_ids[name] = r["id"]; return r["id"]
        cur.execute("INSERT INTO brands (name, slug) VALUES (%s,%s)", (name, slugify(name)))
        brand_ids[name] = cur.lastrowid; return cur.lastrowid

def cat_id(name):
    if name in cat_ids: return cat_ids[name]
    with ndb.cursor() as cur:
        cur.execute("SELECT id FROM categories WHERE name=%s", (name,))
        r = cur.fetchone()
        if r: cat_ids[name] = r["id"]; return r["id"]
        cur.execute("INSERT INTO categories (name, slug) VALUES (%s,%s)", (name, slugify(name)))
        cat_ids[name] = cur.lastrowid; return cur.lastrowid

items = list(csv.DictReader(open(MAP, encoding="utf-8-sig")))
with ndb.cursor() as cur:
    for t in ("presentations", "products", "brands", "categories"):
        cur.execute(f"DELETE FROM {t}")
        cur.execute(f"ALTER TABLE {t} AUTO_INCREMENT=1")

sort_order = 0
stats = {"products": 0, "published": 0, "no_img": 0, "presentations": 0}
slug_used = set()
for it in items:
    pid = it["wc_id"]
    p = get_product(pid)
    if not p:
        print("NO WC:", pid); continue
    kind = it["kind"]
    brand = (it["brand"] or get_brand(pid)).strip()
    cat = it["category_override"] or get_leaf(pid) or "General"
    stock, st = p["stock"], p["stock_status"]
    pres = []
    if kind == "variable":
        for pr in json.loads(it["presentations_json"]):
            v = get_var(pr["var_id"])
            pr["available"] = avail(v["stock"], v["stock_status"]) if v else False
            pres.append(pr)
            stats["presentations"] += 1
        available = any(pr["available"] for pr in pres)
        price = min(float(pr["price"]) for pr in pres)
        published = (it["published_file"] == "Sí") and available
    else:
        available = avail(stock, st)
        price = float(it["price"]) if it["price"] not in ("", None) else (float(p["price"]) if p["price"] else None)
        published = ((it["published_file"] == "Sí") or (it["published_file"] == "extra")) and available

    name = (it["name"] or p["post_title"].split(":")[0]).strip()
    excerpt = (it["excerpt_file"] or p["post_excerpt"] or "").strip()[:490]
    desc = p["post_content"] or ""
    img = copy_image(p["image"], name)
    if not img:
        stats["no_img"] += 1

    base_slug = slugify(name)
    slug = base_slug
    if slug in slug_used:
        slug = base_slug + "-" + str(pid)
    slug_used.add(slug)

    bid = brand_id(brand or "SIN MARCA")
    cid = cat_id(cat)
    with ndb.cursor() as cur:
        cur.execute("""INSERT INTO products
          (brand_id, category_id, name, slug, excerpt, description, presentation, price, currency,
           stock_status, is_published, image, seo_title, seo_description, sort_order)
          VALUES (%s,%s,%s,%s,%s,%s,%s,%s,'USD',%s,%s,%s,%s,%s,%s)""",
          (bid, cid, name, slug, excerpt, desc, ("Presentaciones" if kind == "variable" else ""),
           price, ("instock" if available else "outofstock"), (1 if published else 0), img,
           p["post_title"], (p["post_excerpt"] or "")[:300], sort_order))
        prod_id = cur.lastrowid
        if kind == "variable":
            for k, pr in enumerate(pres):
                cur.execute("""INSERT INTO presentations (product_id, label, price, stock_status, sort_order)
                               VALUES (%s,%s,%s,%s,%s)""",
                            (prod_id, pr["label"], float(pr["price"]),
                             ("instock" if pr["available"] else "outofstock"), k))
    sort_order += 1
    stats["products"] += 1
    if published: stats["published"] += 1
    if stats["products"] % 10 == 0:
        print("...", stats["products"])

print("DONE", stats)
with ndb.cursor() as cur:
    cur.execute("SELECT b.name, COUNT(*) AS n FROM products p JOIN brands b ON b.id=p.brand_id GROUP BY b.name")
    for r in cur.fetchall():
        print("  ", r["name"], r["n"])
    cur.execute("SELECT c.name, COUNT(*) AS n FROM products p JOIN categories c ON c.id=p.category_id GROUP BY c.name")
    for r in cur.fetchall():
        print("  cat", r["name"], r["n"])