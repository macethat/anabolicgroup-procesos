import os
import shutil
import sys

import openpyxl

sys.stdout.reconfigure(encoding="utf-8")

SRC = r"C:\anabolicgroup\upgrade-data\cat-prod-actualizado.xlsx"
BK = r"C:\anabolicgroup\upgrade-data\backups\cat-prod-actualizado-20261118-antes-publicar-hcg.xlsx"
os.makedirs(os.path.dirname(BK), exist_ok=True)
if not os.path.exists(BK):
    shutil.copy(SRC, BK)
    print("backup:", BK)

wb = openpyxl.load_workbook(SRC)
ws = wb["Catálogo"]
hecho = False
for r in range(2, 130):
    marca = ws.cell(row=r, column=1).value
    prod = ws.cell(row=r, column=2).value
    if marca and prod and str(prod).strip().lower() == "hcg 5000 ui" and str(marca).strip().upper() == "LANDERLAN":
        ws.cell(row=r, column=5).value = "Sí"
        print(f"fila {r}: {marca} | {prod} -> Publicado = Sí")
        hecho = True
if hecho:
    wb.save(SRC)
else:
    print("no encontrado")
