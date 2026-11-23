import os
import sys

from rapidocr_onnxruntime import RapidOCR

sys.stdout.reconfigure(encoding="utf-8")

RES = r"C:\anabolicgroup\fotos-productos\editadas"
engine = RapidOCR()

files = sorted(f for f in os.listdir(RES)
               if f.lower().endswith((".jpg", ".jpeg", ".png", ".webp")) and not f.lower().startswith("modelo"))

for name in files:
    path = os.path.join(RES, name)
    result, _ = engine(path)
    texts = []
    if result:
        for item in result:
            # item = [box, text, score]
            try:
                conf = float(item[2])
            except (TypeError, ValueError):
                conf = 0.0
            if conf > 0.5:
                texts.append(str(item[1]).strip())
    print("==", name)
    print("   ", " | ".join(texts[:12]))
    print()
