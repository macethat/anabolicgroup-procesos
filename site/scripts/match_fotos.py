import csv
import os
import sys

import numpy as np
from PIL import Image

sys.stdout.reconfigure(encoding="utf-8")

BASE = r"C:\anabolicgroup\fotos-productos"
RES = os.path.join(BASE, "editadas")
IDX = os.path.join(BASE, "indice.csv")


def features(path):
    im = Image.open(path).convert("RGB")
    # recorte central 80% para quedarnos con el producto
    w, h = im.size
    im = im.crop((int(w * .1), int(h * .1), int(w * .9), int(h * .9)))

    g = im.convert("L")
    a = np.asarray(g.resize((16, 16), Image.LANCZOS), dtype=np.float32)
    a_hash = (a > a.mean()).flatten()

    d = np.asarray(g.resize((17, 16), Image.LANCZOS), dtype=np.float32)
    d_hash = (d[:, 1:] > d[:, :-1]).flatten()

    small = np.asarray(im.resize((64, 64), Image.LANCZOS), dtype=np.float32) / 255.0
    hist = np.histogramdd(small.reshape(-1, 3), bins=(4, 4, 4), range=((0, 1), (0, 1), (0, 1)))[0]
    hist = hist.flatten()
    hist = hist / (hist.sum() + 1e-9)
    return a_hash, d_hash, hist


def score(f1, f2):
    a1, d1, h1 = f1
    a2, d2, h2 = f2
    sa = 1 - np.count_nonzero(a1 != a2) / a1.size
    sd = 1 - np.count_nonzero(d1 != d2) / d1.size
    sh = float(np.dot(h1, h2) / (np.linalg.norm(h1) * np.linalg.norm(h2) + 1e-9))
    return 0.40 * sa + 0.40 * sd + 0.20 * sh


rows = list(csv.DictReader(open(IDX, encoding="utf-8-sig")))
orig = []
for r in rows:
    p = os.path.join(BASE, r["archivo"])
    if os.path.exists(p):
        orig.append((r, features(p)))

results = [f for f in sorted(os.listdir(RES))
           if f.lower().endswith((".jpg", ".jpeg", ".png", ".webp"))
           and not f.lower().startswith("modelo")]

print(f"resultados: {len(results)} | originales: {len(orig)}\n")
for name in results:
    f = features(os.path.join(RES, name))
    ranked = sorted(((score(f, of), r) for r, of in orig), key=lambda x: -x[0])
    print(f"== {name}")
    for s, r in ranked[:3]:
        print(f"   {s:.3f}  {r['marca']:<14} {r['producto']:<38} {r['codigo']}")
    print(f"   margen: {ranked[0][0] - ranked[1][0]:.3f}\n")
