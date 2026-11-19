from PIL import Image
import os

base = "/home/abgroup/catalogo/static/img"
for f in ["anstroprime-1-mg-53421.webp", "boldeprime-200-mg.webp", "hcg-10-000-ui.webp",
          "chorionic-gonadotrophin.webp", "stanoplex-10-ml.webp"]:
    p = os.path.join(base, f)
    try:
        im = Image.open(p)
        print(f, im.size, im.mode)
    except Exception as exc:
        print(f, "err", exc)
