import re
import sys

import pymysql
from dotenv import dotenv_values

sys.stdout.reconfigure(encoding="utf-8")

APPLY = "--apply" in sys.argv

# Siglas y nombres que deben conservarse tal cual (clave en minusculas).
ACRONYMS = {
    "hcg": "HCG", "npp": "NPP", "hcl": "HCL", "ui": "UI", "iu": "IU",
    "igf-1": "IGF-1", "igf": "IGF", "lr3": "LR3", "tb500": "TB500", "ghk-cu": "GHK-Cu",
    "nad+": "NAD+", "mots-c": "MOTS-C", "cjc1295": "CJC1295", "aod9604": "AOD9604",
    "bpc-157": "BPC-157", "tvr": "TVR", "txt": "TXT", "xxx": "XXX", "dac": "DAC",
    "gh": "GH", "glow": "GLOW",
}
# Unidades: siempre en minuscula.
UNITS = {"mg", "mcg", "ml", "comp", "tab", "g", "caps"}


def cap_word(w):
    return w[0].upper() + w[1:].lower() if w else w


def norm_token(tok):
    m = re.match(r"^([\(\[\¿\¡]*)(.*?)([\)\]\,\;\.\:]*)$", tok)
    pre, core, post = m.groups()
    if not core:
        return tok

    # Numero pegado a unidad: 10mg -> 10 mg, 0.60MCG -> 0.60 mcg
    m2 = re.match(r"^(\d+(?:[.,]\d+)?)([A-Za-z]+)$", core)
    if m2 and m2.group(2).lower() in UNITS:
        return pre + f"{m2.group(1)} {m2.group(2).lower()}" + post

    low = core.lower()
    if low in ACRONYMS:
        return pre + ACRONYMS[low] + post
    if low in UNITS:
        return pre + low + post

    out = []
    for part in re.split(r"([/-])", core):
        if part in ("/", "-"):
            out.append(part)
            continue
        pl = part.lower()
        if pl in ACRONYMS:
            out.append(ACRONYMS[pl])
        elif pl in UNITS:
            out.append(pl)
        else:
            out.append(cap_word(part))
    return pre + "".join(out) + post


def normalize(text):
    text = re.sub(r"\s+", " ", (text or "").strip())
    return " ".join(norm_token(t) for t in text.split(" ")) if text else text


def connect():
    env = dotenv_values("/home/abgroup/catalogo/.env")
    return pymysql.connect(host=env["DB_HOST"], user=env["DB_USER"], password=env["DB_PASSWORD"],
                           database=env["DB_NAME"], charset="utf8mb4",
                           cursorclass=pymysql.cursors.DictCursor, autocommit=True)


db = connect()
with db.cursor() as cur:
    cur.execute("SELECT id, name FROM products ORDER BY id")
    products = cur.fetchall()
    cur.execute("SELECT id, label FROM presentations ORDER BY id")
    presentations = cur.fetchall()

changes = []
for p in products:
    new = normalize(p["name"])
    if new != p["name"]:
        changes.append((p["id"], p["name"], new))

pres_changes = []
for v in presentations:
    new = normalize(v["label"])
    if new != v["label"]:
        pres_changes.append((v["id"], v["label"], new))

print(f"Productos a corregir: {len(changes)} de {len(products)}")
for _, old, new in changes:
    print(f"  - {old}\n    {new}")
print(f"\nPresentaciones a corregir: {len(pres_changes)}")
for _, old, new in pres_changes:
    print(f"  - {old} -> {new}")

if APPLY:
    with db.cursor() as cur:
        for pid, old, new in changes:
            cur.execute("UPDATE products SET name=%s WHERE id=%s AND name=%s", (new, pid, old))
        for vid, old, new in pres_changes:
            cur.execute("UPDATE presentations SET label=%s WHERE id=%s AND label=%s", (new, vid, old))
    print("\nAPLICADO")
else:
    print("\n(dry-run: usa --apply para guardar)")
db.close()
