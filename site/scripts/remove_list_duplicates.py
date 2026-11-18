import os
import shutil
import sys

import openpyxl

sys.stdout.reconfigure(encoding="utf-8")

SRC = r"C:\anabolicgroup\upgrade-data\cat-prod-actualizado.xlsx"
BK_DIR = r"C:\anabolicgroup\upgrade-data\backups"
BK = os.path.join(BK_DIR, "cat-prod-actualizado-20261118-antes-duplicados.xlsx")
os.makedirs(BK_DIR, exist_ok=True)
if not os.path.exists(BK):
    shutil.copy(SRC, BK)
    print("backup:", BK)

# Filas a eliminar (nombre exacto en la columna B de la hoja Catalogo)
ELIMINAR = [
    "BOLDENONA UNDECILENATO",
    "PRIMOBOLAND ENANTATO GOLD 10ml",
    "TESTOLAND DEPOT 200 MG",
    "TREMBOLONA ENANTADO GOLD",
    "Trembolona Enantato 100mg",
    "BOLDAPLEX 200 MG",
    "CLEMBUTEROL ULTRA 0.60MCG",
    "CLEMBUTREX 0.40 MG",
    "MASTEPLEX - P",
]
# Nota del bloque "SIN STOCK XTLABS" que reintroduce el duplicado
NOTA_URL = "trembolona-acetato-100mg"

wb = openpyxl.load_workbook(SRC)
ws = wb["Catálogo"]

filas = set()
for r in range(2, ws.max_row + 1):
    val = ws.cell(row=r, column=2).value
    if not val:
        continue
    texto = str(val).strip()
    if texto.lower() in {x.lower() for x in ELIMINAR}:
        filas.add(r)
    elif NOTA_URL in texto.lower() and "http" in texto.lower():
        filas.add(r)

print("filas a borrar:", sorted(filas))
for r in sorted(filas, reverse=True):
    print("  -", r, ws.cell(row=r, column=2).value)
    ws.delete_rows(r, 1)

wb.save(SRC)
print("eliminadas:", len(filas))
