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


def norm(text):
    text = unicodedata.normalize("NFKD", str(text)).encode("ascii", "ignore").decode()
    return re.sub(r"[^a-z0-9]+", "", text.lower())


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


def text_score(ocr_norm, product_name, brand):
    full = norm(product_name)
    words = [w for w in re.split(r"\s+", product_name) if len(w) >= 4]
    token = norm(words[0]) if words else full
    ratio = SequenceMatcher(None, ocr_norm, full).ratio()
    if token and token in ocr_norm:
        return max(0.95, ratio), f"token:{token}"
    if norm(brand) and norm(brand) in ocr_norm and ratio > 0.4:
        return ratio + 0.1, f"marca+{ratio:.2f}"
    return ratio, f"fuzzy:{ratio:.2f}"


def ocr_text(path, engine):
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
                   if f.lower().endswith((".jpg", ".jpeg", ".png", ".webp"))
                   and not f.lower().startswith("modelo"))

    mapping = []
    for name in files:
        path = os.path.join(RES, name)
        f = features(path)
        texts = ocr_text(path, engine)
        ocr_norm = norm(" ".join(texts))
        scored = []
        for r, of in orig:
            ts, why = text_score(ocr_norm, r["producto"], r["marca"])
            isc = img_score(f, of)
            total = 0.75 * ts + 0.25 * isc
            scored.append((total, ts, isc, r, why))
        scored.sort(key=lambda x: -x[0])
        top, second = scored[0], scored[1]
        margen = top[0] - second[0]
        conf = "Alta" if margen >= 0.06 and top[1] >= 0.8 else ("Media" if margen >= 0.03 else "Revisar")
        mapping.append({
            "archivo": name,
            "codigo": top[3]["codigo"],
            "marca": top[3]["marca"],
            "producto": top[3]["producto"],
            "score": round(top[0], 3),
            "texto": round(top[1], 3),
            "imagen": round(top[2], 3),
            "margen": round(margen, 3),
            "confianza": conf,
            "segunda": f"{second[3]['producto']} ({second[0]:.3f})",
            "ocr": " | ".join(texts)[:140],
        })

    out = os.path.join(RES, "mapeo.csv")
    with open(out, "w", encoding="utf-8-sig", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=list(mapping[0].keys()))
        w.writeheader()
        w.writerows(mapping)

    for m in mapping:
        print(f"{m['confianza']:<8} {m['score']:.3f} (txt {m['texto']:.2f} / img {m['imagen']:.2f}, "
              f"margen {m['margen']:.2f})  {m['archivo'][:34]:<34} -> {m['marca']} | {m['producto']}")
        print(f"         OCR: {m['ocr'][:110]}")
    print("\nmapeo:", out)


if __name__ == "__main__":
    main()
