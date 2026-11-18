import sys
import pymysql
from dotenv import dotenv_values

sys.stdout.reconfigure(encoding="utf-8")

PREFIX = {"EMINENCE": "EMI", "LANDERLAN": "LAN", "XTLABS": "XTL", "VMS": "VMS"}
FUNCS = {
    "ANT": "Anti-estrogeno / control de E2",
    "QUI": "Quema / perdida de grasa",
    "FER": "Fertilidad",
    "ART": "Articulaciones",
    "DEF": "Definicion / dureza",
    "VOL": "Volumen / masa magra",
    "REC": "Recuperacion / PCT",
    "FUE": "Fuerza",
    "MET": "Metabolico",
    "REP": "Reparacion / tejidos",
    "GH": "Hormona de crecimiento",
    "DER": "Piel / regeneracion",
    "GEN": "General (sin clasificar)",
}


def connect():
    env = dotenv_values("/home/abgroup/catalogo/.env")
    return pymysql.connect(host=env["DB_HOST"], user=env["DB_USER"], password=env["DB_PASSWORD"],
                           database=env["DB_NAME"], charset="utf8mb4",
                           cursorclass=pymysql.cursors.DictCursor, autocommit=True)


def next_code(db, brand, fn):
    """Siguiente codigo libre para una marca (secuencia por marca, no por funcion)."""
    prefix = PREFIX[brand]
    with db.cursor() as cur:
        cur.execute("""SELECT MAX(CAST(SUBSTRING_INDEX(p.code,'-',-1) AS UNSIGNED)) AS mx
                       FROM products p JOIN brands b ON b.id = p.brand_id
                       WHERE b.name = %s""", (brand,))
        row = cur.fetchone()
        n = int(row["mx"] or 0) + 1
        while True:
            code = f"{prefix}-{fn}-{n:03d}"
            cur.execute("SELECT 1 FROM products WHERE code = %s", (code,))
            if not cur.fetchone():
                return code
            n += 1


def main():
    if len(sys.argv) != 3:
        print("Uso: next_code.py <MARCA> <FUNCION>")
        print("Marcas:", ", ".join(PREFIX))
        print("Funciones:", ", ".join(f"{k} ({v})" for k, v in FUNCS.items()), sep="\n  ")
        return 1
    brand = sys.argv[1].strip().upper()
    fn = sys.argv[2].strip().upper()
    if brand not in PREFIX:
        print(f"Marca no valida: {brand}. Use: {', '.join(PREFIX)}")
        return 1
    if fn not in FUNCS:
        print(f"Funcion no valida: {fn}. Use: {', '.join(FUNCS)}")
        return 1
    db = connect()
    try:
        print(next_code(db, brand, fn))
    finally:
        db.close()
    return 0


if __name__ == "__main__":
    sys.exit(main())
