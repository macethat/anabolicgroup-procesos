import os
import shutil
import sys

import openpyxl

sys.stdout.reconfigure(encoding="utf-8")

SRC = r"C:\anabolicgroup\upgrade-data\cat-prod-actualizado.xlsx"
BK = r"C:\anabolicgroup\upgrade-data\backups\cat-prod-actualizado-20261118-antes-marca-gh.xlsx"
os.makedirs(os.path.dirname(BK), exist_ok=True)
if not os.path.exists(BK):
    shutil.copy(SRC, BK)
    print("backup:", BK)

CAMBIOS = {"Gentropin 210 UI": "GENLI PHARMA", "Hutrope 100 IU": "HUBIO PHARM"}

wb = openpyxl.load_workbook(SRC)
ws = wb["Catálogo"]
for r in range(2, 120):
    prod = ws.cell(row=r, column=2).value
    if prod and str(prod).strip() in CAMBIOS:
        prev = ws.cell(row=r, column=1).value
        ws.cell(row=r, column=1).value = CAMBIOS[str(prod).strip()]
        print(f"fila {r}: {prod} | {prev} -> {CAMBIOS[str(prod).strip()]}")
wb.save(SRC)
print("ok")
