import os
import shutil
import sys

import openpyxl

sys.stdout.reconfigure(encoding="utf-8")

SRC = r"C:\anabolicgroup\upgrade-data\cat-prod-actualizado.xlsx"
BK = r"C:\anabolicgroup\upgrade-data\backups\cat-prod-actualizado-20261118-antes-stanoprime.xlsx"
os.makedirs(os.path.dirname(BK), exist_ok=True)
if not os.path.exists(BK):
    shutil.copy(SRC, BK)
    print("backup:", BK)

wb = openpyxl.load_workbook(SRC)
ws = wb["Catálogo"]

encontrado = False
for r in range(2, 120):
    v = ws.cell(row=r, column=2).value
    if v and "stanozolol 50mg" in str(v).lower():
        print("fila", r, "antes:", [ws.cell(row=r, column=c).value for c in range(1, 8)])
        ws.cell(row=r, column=2).value = "Stanoprime 50 mg"
        ws.cell(row=r, column=3).value = "Definición Dura + Vascular"
        ws.cell(row=r, column=4).value = "Individual"
        ws.cell(row=r, column=5).value = "No"
        ws.cell(row=r, column=6).value = 54.99
        encontrado = True
        print("fila", r, "despues:", [ws.cell(row=r, column=c).value for c in range(1, 8)])
        break

if not encontrado:
    print("NO ENCONTRADO")
else:
    wb.save(SRC)
    print("guardado")
