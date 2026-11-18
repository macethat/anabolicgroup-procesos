import sys
import pymysql
from dotenv import dotenv_values
sys.stdout.reconfigure(encoding="utf-8")
env = dotenv_values("/home/abgroup/catalogo/.env")
db = pymysql.connect(host=env["DB_HOST"], user=env["DB_USER"], password=env["DB_PASSWORD"],
                     database=env["DB_NAME"], charset="utf8mb4",
                     cursorclass=pymysql.cursors.DictCursor)
FN = {"ANT": "Anti-estrógeno", "QUI": "Quema / pérdida de grasa", "FER": "Fertilidad",
      "ART": "Articulaciones", "DEF": "Definición / dureza", "VOL": "Volumen / masa magra",
      "REC": "Recuperación / PCT", "FUE": "Fuerza", "MET": "Metabólico", "REP": "Reparación",
      "GH": "Hormona de crecimiento", "DER": "Piel / regeneración", "GEN": "General"}
with db.cursor() as cur:
    cur.execute("""SELECT b.name AS marca, p.code, p.name, c.name AS cat, p.is_published
                   FROM products p JOIN brands b ON b.id=p.brand_id
                   LEFT JOIN categories c ON c.id=p.category_id
                   ORDER BY b.sort_order, b.name, p.code""")
    rows = cur.fetchall()
marca = None
for r in rows:
    if r["marca"] != marca:
        marca = r["marca"]
        print(f"\n### {marca}\n")
        print("| Código | Producto | Función | Categoría | Web |")
        print("|---|---|---|---|---|")
    fn = r["code"].split("-")[1]
    print(f"| `{r['code']}` | {r['name']} | {fn} · {FN.get(fn,'')} | {r['cat'] or '—'} | "
          f"{'Público' if r['is_published'] else 'Oculto'} |")
