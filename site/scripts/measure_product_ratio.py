from PIL import Image, ImageChops
import os

base = "/home/abgroup/catalogo/static/img"
files = ["anstroprime-1-mg-53421.webp", "hcg-10-000-ui.webp", "stanoplex-10-ml.webp",
         "chorionic-gonadotrophin.webp", "trenboplex-acetato.png", "oxanprime-10-mg.webp",
         "boldeprime-200-mg-5.webp"]

for f in files:
    p = os.path.join(base, f)
    if not os.path.exists(p):
        continue
    im = Image.open(p).convert("RGBA")
    w, h = im.size
    bg = Image.new("RGBA", im.size, (255, 255, 255, 255))
    diff = ImageChops.difference(im, bg)
    bbox = diff.getbbox()
    if not bbox:
        print(f, "sin bbox")
        continue
    bwd = bbox[2] - bbox[0]
    bht = bbox[3] - bbox[1]
    print(f"{f:<34} lienzo {w}x{h}  empaque {bwd}x{bht}  ancho {bwd/w:.0%}  alto {bht/h:.0%}")
