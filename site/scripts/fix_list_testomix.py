import os
import shutil
import sys

import openpyxl

sys.stdout.reconfigure(encoding="utf-8")

SRC = r"C:\anabolicgroup\upgrade-data\cat-prod-actualizado.xlsx"
BK = r"C:\anabolicgroup\upgrade-data\backups\cat-prod-actualizado-20261118-antes-testomix.xlsx"
os.makedirs(os.path.dirname(BK), exist_ok=True)
if not os.path.exists(BK):
    shutil.copy(SRC, BK)
    print("backup:", BK)

wb = openpyxl.load_workbook(SRC)
ws = wb["Catálogo"]
hecho = False
for r in range(2, 130):
    v = ws.cell(row=r, column=2).value
    if v and str(v).strip().lower() == "testomix 250 mg":
        ws.cell(row=r, column=2).value = "Testo-Mix 250 mg"
        print(f"fila {r}: Testomix 250 mg -> Testo-Mix 250 mg")
        hecho = True
if hecho:
    wb.save(SRC)
else:
    print("no encontrado")
