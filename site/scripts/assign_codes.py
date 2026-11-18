import os, re, sys, unicodedata
from collections import defaultdict, Counter
import pymysql
from dotenv import dotenv_values

sys.stdout.reconfigure(encoding="utf-8")
env = dotenv_values("/home/abgroup/catalogo/.env")
db = pymysql.connect(host=env["DB_HOST"], user=env["DB_USER"], password=env["DB_PASSWORD"],
                     database=env["DB_NAME"], charset="utf8mb4",
                     cursorclass=pymysql.cursors.DictCursor, autocommit=True)

def norm(s):
    s = unicodedata.normalize("NFKD", str(s or "")).encode("ascii", "ignore").decode().lower()
    return re.sub(r"\s+", " ", s)

PREFIX = {"EMINENCE": "EMI", "LANDERLAN": "LAN", "XTLABS": "XTL", "VMS": "VMS"}

# Excepciones por nombre exacto de la ficha. Mandan sobre cualquier regla.
EXACT = {
    "Oxanprime 10 mg": "DEF",
    "Methandrostenolona 10 mg (Dianabol) 50 comp": "VOL",
    "Metenolona Acetato 25 mg": "VOL",
    "Metenolona Enantato 100 mg": "VOL",
}

# Manual por compuesto (nombre). Se aplica primero. Orden: especifico -> generico.
MANUAL_NAME = [
    ("anstroprime", "ANT"), ("anastro", "ANT"), ("arimidex", "ANT"),
    ("cloprime", "REC"), ("clomifeno", "REC"), ("clomix", "REC"), ("tamoprime", "REC"), ("tamoxifeno", "REC"),
    ("hcg", "REC"), ("chorionic", "REC"), ("hormoprime", "REC"),
    ("klenprime", "QUI"), ("klembuterol", "QUI"), ("clembuterol", "QUI"), ("clembutrex", "QUI"), ("clembuterol", "QUI"),
    ("lioprime", "MET"), ("liotironina", "MET"),
    ("methandrostenolona", "VOL"), ("metandrostenolona", "VOL"), ("dianabol", "VOL"),
    ("oxanprime", "DEF"), ("metenolona", "VOL"), ("primoboland", "VOL"), ("primoplex", "VOL"),
    ("masterolona", "DEF"), ("proviron", "DEF"), ("provix", "DEF"), ("masteplex", "DEF"), ("mastaplex", "DEF"),
    ("oxand", "DEF"), ("stan", "DEF"), ("drost", "DEF"),
    ("testoland", "VOL"), ("testenat", "VOL"), ("testosterona", "VOL"), ("testomix", "VOL"),
    ("sustaplex", "VOL"), ("cypoprime", "VOL"), ("enaprime", "VOL"), ("proprime", "VOL"),
    ("androlic", "VOL"), ("oxymeprime", "VOL"), ("oxymetalona", "VOL"), ("methandroplex", "VOL"),
    ("boldenona", "VOL"), ("boldeprime", "VOL"), ("boldeplex", "VOL"), ("boldaplex", "VOL"),
    ("decaprime", "VOL"), ("decaland", "VOL"), ("decaplex", "VOL"), ("nandrolona", "VOL"),
    ("nandroplex", "VOL"), ("npp", "VOL"),
    ("trembolona acetato", "DEF"), ("tremboplex acetato", "DEF"),
    ("trembolona enantato", "VOL"), ("trembolona enantado", "VOL"), ("tremboplex enantato", "VOL"),
    ("trenthate", "VOL"), ("trenoprime", "DEF"),
    ("turina", "VOL"), ("titan", "VOL"), ("testoplex", "VOL"), ("oxiplex", "VOL"), ("triple", "VOL"),
    ("cardarine", "QUI"), ("clenbut", "QUI"),
    ("gentropin", "GH"), ("hutrope", "GH"), ("genotropin", "GH"), ("igf", "GH"),
    ("ibutamoren", "GH"), ("ipamorelin", "GH"), ("cjc", "GH"), ("tesamorelin", "GH"),
    ("bpc", "REP"), ("tb500", "REP"), ("ghk", "DER"), ("glow", "DER"),
    ("mots", "MET"), ("nad", "MET"), ("aod", "MET"), ("reta", "MET"), ("tirze", "MET"), ("sema", "MET"),
]

def func_for(p):
    name = norm(p["name"])
    if p["name"] in EXACT:
        return EXACT[p["name"]]
    for kw, fn in MANUAL_NAME:
        if kw in name:
            return fn
    text = norm((p["excerpt"] or "") + " " + (p["seo_title"] or ""))
    if re.search(r"control e2|control estrogen|anastrozol|arimidex", text): return "ANT"
    if re.search(r"quema|grasa|termogen", text): return "QUI"
    if re.search(r"fertilidad", text): return "FER"
    if re.search(r"definici|corte|dureza|vascular|seco|seca", text): return "DEF"
    if re.search(r"volumen|masa|magro|ganancia de musculo", text): return "VOL"
    if re.search(r"recuperaci", text): return "REC"
    if re.search(r"fuerza", text): return "FUE"
    if re.search(r"articulaci", text): return "ART"
    return "GEN"

with db.cursor() as cur:
    cur.execute("""SELECT COUNT(*) AS n FROM information_schema.COLUMNS
                   WHERE TABLE_SCHEMA=%s AND TABLE_NAME='products' AND COLUMN_NAME='code'""", (env["DB_NAME"],))
    if cur.fetchone()["n"] == 0:
        cur.execute("ALTER TABLE products ADD COLUMN code VARCHAR(20) NULL UNIQUE")
        print("columna code agregada")
    cur.execute("""SELECT p.id, p.name, p.excerpt, p.seo_title, b.name AS brand
                   FROM products p JOIN brands b ON b.id=p.brand_id ORDER BY b.name, p.id""")
    products = cur.fetchall()

counters = defaultdict(int)
rows = []
for p in products:
    prefix = PREFIX.get(p["brand"], "GEN")
    fn = func_for(p)
    counters[p["brand"]] += 1
    code = f"{prefix}-{fn}-{counters[p['brand']]:03d}"
    with db.cursor() as cur:
        cur.execute("UPDATE products SET code=%s WHERE id=%s", (code, p["id"]))
    rows.append((p["brand"], code, p["name"], fn))

print(f"Codificados: {len(rows)}")
cur_brand = None
for brand, code, name, fn in rows:
    if brand != cur_brand:
        cur_brand = brand
        print(f"\n=== {brand} ===")
    print(f"  {code:<14} {name[:55]:<55} {fn}")
print("\nFunciones:", dict(Counter(r[3] for r in rows)))