import csv

RAW = r"C:\Users\Usuario\AppData\Local\Temp\opencode\export_raw.tsv"
VAR = r"C:\Users\Usuario\AppData\Local\Temp\opencode\export_var.tsv"
OUT = r"C:\anabolicgroup\productos_todos_por_marca.csv"

var = {}
with open(VAR, "r", encoding="utf-8-sig") as f:
    r = csv.DictReader(f, delimiter="\t")
    for row in r:
        try:
            pid = int(row["padre"])
        except ValueError:
            continue
        var[pid] = row

productos = {}
with open(RAW, "r", encoding="utf-8-sig") as f:
    r = csv.DictReader(f, delimiter="\t")
    for row in r:
        try:
            pid = int(row["ID"])
        except ValueError:
            continue
        estado = (row["estado"] or "").strip().lower()
        tipo = (row["tipo"] or "").strip().lower()
        marca = (row["marca"] or "").strip()
        if not marca or marca.upper() == "NULL":
            marca = "SIN MARCA"
        nombre = row["nombre"].strip()
        precio = (row["precio"] or "").strip()
        stock = (row["stock"] or "").strip()

        if tipo == "variable":
            v = var.get(pid)
            if v:
                try:
                    stock_sum = int(float(v["stock_total"] or 0))
                except ValueError:
                    stock_sum = 0
                pmin = (v["precio_min"] or "").strip()
                pmax = (v["precio_max"] or "").strip()
                if pmin and pmax and pmin != pmax:
                    precio = f"{pmin}-{pmax}"
                elif pmin:
                    precio = pmin
                stock = str(stock_sum)
        elif tipo == "simple":
            pass

        activo = "ACTIVO" if estado == "publish" else "INACTIVO"
        productos[pid] = {
            "marca": marca,
            "estado": activo,
            "nombre": nombre,
            "stock": stock,
            "precio": precio,
        }

# Ordenar: por marca alfabetico, luego ACTIVO primero, luego nombre
items = sorted(productos.values(), key=lambda x: (x["marca"].upper(), x["estado"] != "ACTIVO", x["nombre"].lower()))

with open(OUT, "w", encoding="utf-8-sig", newline="") as f:
    w = csv.writer(f)
    w.writerow(["MARCA", "STATUS", "NOMBRE DEL PRODUCTO", "EXISTENCIA", "PRECIO (USD)"])
    marca_actual = None
    for it in items:
        if it["marca"].upper() != marca_actual:
            marca_actual = it["marca"].upper()
            w.writerow([])
            w.writerow([f"=== {it['marca'].upper()} ==="])
        w.writerow([it["marca"], it["estado"], it["nombre"], it["stock"], it["precio"]])

print(f"OK: {len(items)} productos -> {OUT}")

from collections import Counter
c = Counter((x["marca"], x["estado"]) for x in items)
for k in sorted(c):
    print(f"  {k[0]:<25} {k[1]:<8} {c[k]}")