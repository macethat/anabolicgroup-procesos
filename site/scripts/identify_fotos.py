import csv
import os
import re
import sys
import unicodedata
from difflib import SequenceMatcher

import numpy as np
from PIL import Image

sys.stdout.reconfigure(encoding="utf-8")

BASE = r"C:\anabolicgroup\fotos-productos"
RES = os.path.join(BASE, "editadas")
IDX = os.path.join(BASE, "indice.csv")

# Productos cuyo texto en la caja no incluye el nombre comercial
ALIASES = {
    "EMI-REC-012": ["chorionic", "gonadotrophin", "hormoprime", "5000"],
    "LAN-REC-018": ["gonadotropina", "corionica", "landerlan", "5000"],
    "XTL-REC-008": ["hcg", "10000"],
}

STOP = {"de", "con", "and", "the", "for", "injection", "tablets", "tablet", "mg", "ml", "ui", "iu"}


def norm(text):
    text = unicodedata.normalize("NFKD", str(text)).encode("ascii", "ignore").decode()
    return re.sub(r"[^a-z0-9]+", "", text.lower())


def family(name):
    """Palabra comercial: primera palabra significativa del nombre."""
    for w in re.split(r"\s+", name.strip()):
        n = norm(w)
        if n and n not in STOP:
            return n
    return norm(name)


def numbers(name):
    return [n for n in re.findall(r"\d+", name) if len(n) >= 2]


def features(path):
    im = Image.open(path).convert("RGB")
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


def img_score(f1, f2):
    a1, d1, h1 = f1
    a2, d2, h2 = f2
    sa = 1 - np.count_nonzero(a1 != a2) / a1.size
    sd = 1 - np.count_nonzero(d1 != d2) / d1.size
    sh = float(np.dot(h1, h2) / (np.linalg.norm(h1) * np.linalg.norm(h2) + 1e-9))
    return 0.40 * sa + 0.40 * sd + 0.20 * sh


def kw_score(lines, keywords):
    """Cuanto aparece la palabra comercial (o alias) en el texto OCR."""
    best = 0.0
    joined = norm(" ".join(lines))
    for kw in keywords:
        if not kw:
            continue
        if kw in joined:
            return 1.0
        for line in lines:
            ln = norm(line)
            if not ln:
                continue
            r = SequenceMatcher(None, ln, kw).ratio()
            if len(kw) > 4 and (kw in ln or ln in kw):
                r = max(r, 0.92)
            best = max(best, r)
    return best


def full_score(lines, name):
    full = norm(name)
    best = 0.0
    for line in lines:
        ln = norm(line)
        if ln:
            best = max(best, SequenceMatcher(None, ln, full).ratio())
    if full and full in norm(" ".join(lines)):
        best = 1.0
    return best


def dose_score(lines, name):
    nums = numbers(name)
    if not nums:
        return 1.0
    ocr = norm(" ".join(lines))
    return sum(1 for n in nums if n in ocr) / len(nums)


def ocr_lines(path, engine):
    result, _ = engine(path)
    out = []
    if result:
        for item in result:
            try:
                conf = float(item[2])
            except (TypeError, ValueError):
                conf = 0.0
            if conf > 0.5:
                out.append(str(item[1]).strip())
    return out


def main():
    from rapidocr_onnxruntime import RapidOCR
    engine = RapidOCR()

    rows = list(csv.DictReader(open(IDX, encoding="utf-8-sig")))
    orig = []
    for r in rows:
        p = os.path.join(BASE, r["archivo"])
        if os.path.exists(p):
            orig.append((r, features(p)))

    files = sorted(f for f in os.listdir(RES)
                   if f.lower().endswith((".jpg", ".jpeg", ".png", ".webp")))

    mapping = []
    for name in files:
        path = os.path.join(RES, name)
        f = features(path)
        lines = ocr_lines(path, engine)
        scored = []
        for r, of in orig:
            kws = [family(r["producto"])] + ALIASES.get(r["codigo"], [])
            kws = [norm(k) for k in kws]
            kw = kw_score(lines, kws)
            fu = full_score(lines, r["producto"])
            do = dose_score(lines, r["producto"])
            im = img_score(f, of)
            total = 0.45 * kw + 0.20 * fu + 0.15 * do + 0.20 * im
            scored.append((total, kw, fu, do, im, r))
        scored.sort(key=lambda x: -x[0])
        top, second = scored[0], scored[1]
        margen = top[0] - second[0]
        conf = "Alta" if margen >= 0.05 else ("Media" if margen >= 0.02 else "Revisar")

        mapping.append({
            "archivo": name,
            "codigo": top[5]["codigo"],
            "marca": top[5]["marca"],
            "producto": top[5]["producto"],
            "score": round(top[0], 3),
            "clave": round(top[1], 2),
            "nombre": round(top[2], 2),
            "dosis": round(top[3], 2),
            "imagen": round(top[4], 2),
            "margen": round(margen, 3),
            "confianza": conf,
            "segunda": f"{second[5]['producto']} ({second[0]:.3f})",
            "ocr": " | ".join(lines)[:160],
        })

    out = os.path.join(RES, "mapeo.csv")
    with open(out, "w", encoding="utf-8-sig", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=list(mapping[0].keys()))
        w.writeheader()
        w.writerows(mapping)

    for i, m in enumerate(mapping, 1):
        print(f"{i:>2}. {m['confianza']:<8} {m['score']:.3f} (clave {m['clave']:.2f} dosis {m['dosis']:.2f} "
              f"margen {m['margen']:.2f})  {m['archivo'][-14:]:<14} -> {m['codigo']:<12} {m['producto']}")
        if m["confianza"] != "Alta":
            print(f"      2da: {m['segunda']}")
            print(f"      OCR: {m['ocr'][:120]}")
    print("\nmapeo:", out)


if __name__ == "__main__":
    main()
