import os
import shutil
import sys

import openpyxl

sys.stdout.reconfigure(encoding="utf-8")

SRC = r"C:\anabolicgroup\upgrade-data\cat-prod-actualizado.xlsx"
BK = r"C:\anabolicgroup\upgrade-data\backups\cat-prod-actualizado-20261118-antes-stanoprime-oral.xlsx"
os.makedirs(os.path.dirname(BK), exist_ok=True)
if not os.path.exists(BK):
    shutil.copy(SRC, BK)
    print("backup:", BK)

wb = openpyxl.load_workbook(SRC)
ws = wb["Catálogo"]

fila_ref = None
for r in range(2, 120):
    v = ws.cell(row=r, column=2).value
    if v and str(v).strip() == "Stanoprime 50 mg":
        fila_ref = r
        break

if not fila_ref:
    print("no encontre la fila de Stanoprime 50 mg")
    sys.exit(1)

nueva = fila_ref + 1
ws.insert_rows(nueva)
valores = ["EMINENCE", "Stanoprime 10 mg", "Definición + Dureza", "Individual", "No", 36.99, None]
for i, v in enumerate(valores, start=1):
    ws.cell(row=nueva, column=i).value = v
    ws.cell(row=nueva, column=i)._style = ws.cell(row=fila_ref, column=i)._style

wb.save(SRC)
print(f"insertada fila {nueva}:", valores)
