import os
import shutil
import sys

import openpyxl

sys.stdout.reconfigure(encoding="utf-8")

SRC = r"C:\anabolicgroup\upgrade-data\cat-prod-actualizado.xlsx"
BK_DIR = r"C:\anabolicgroup\upgrade-data\backups"
os.makedirs(BK_DIR, exist_ok=True)
BK = os.path.join(BK_DIR, "cat-prod-actualizado-20261118-antes-nombres.xlsx")
if not os.path.exists(BK):
    shutil.copy(SRC, BK)
    print("backup:", BK)

CAMBIOS = [
    ("Anstroprime 1 mg", "Anastroprime 1 mg"),
    ("KLENPRIME 0.40 MG", "Klenprime 40 mcg"),
    ("Klembuterol 0.60mcg 50comp", "Klenprime 60 mcg"),
    ("Masterolona 25mg (Proviron) 50 comp", "Proviprime 25 mg"),
    ("Methandrostenolona 10mg (Dianabol) 50 comp", "Metaprime 10 mg"),
    ("Arimidex 1 mg Anastrozol", "Arimidext 1 mg"),
    ("Oxiplex 50 mg", "Oxyplex 50 mg"),
    ("Tremboplex Acetato", "Trenboplex Acetato 100 mg"),
    ("Tremboplex Enantato", "Trenboplex Enantato 200 mg"),
    ("IGF-1 LR3 1 ml", "IGF-1 LR3 1 mg"),
    ("Clenbutrex HCL 0.40 mg", "Clembutrex 40 mcg"),
    ("Clenbutrex Ultra 0.60 mg", "Clembutrex Ultra 60 mcg"),
]

wb = openpyxl.load_workbook(SRC)
ws = wb["Catálogo"]

index = {}
for r in range(2, 120):
    marca = ws.cell(row=r, column=1).value
    prod = ws.cell(row=r, column=2).value
    if marca and prod:
        index.setdefault(str(prod).strip().lower(), []).append(r)

hechos = 0
for old, new in CAMBIOS:
    filas = index.get(old.lower(), [])
    if not filas:
        print("NO ENCONTRADO:", old)
        continue
    for r in filas:
        ws.cell(row=r, column=2).value = new
        hechos += 1
    print(f"fila(s) {filas}: {old} -> {new}")

wb.save(SRC)
print("filas actualizadas:", hechos)
