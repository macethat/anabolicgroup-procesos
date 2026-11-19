import os
import sys

from PIL import Image, ImageChops
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8")

SRC = sys.argv[1]
OUT = sys.argv[2]
CANVAS = (1060, 1080)
FIT = (740, 740)
TOL = 10

im = Image.open(SRC).convert("RGB")
w, h = im.size
print("origen", im.size)

# color de fondo: el mas comun en el borde de la foto
border = []
step = max(1, min(w, h) // 100)
for x in range(0, w, step):
    border.append(im.getpixel((x, 0)))
    border.append(im.getpixel((x, h - 1)))
for y in range(0, h, step):
    border.append(im.getpixel((0, y)))
    border.append(im.getpixel((w - 1, y)))
bg_color = Counter(border).most_common(1)[0][0]
print("fondo", bg_color)

bg = Image.new("RGB", im.size, bg_color)
diff = ImageChops.difference(im, bg).convert("L")
mask = diff.point(lambda p: 255 if p > TOL else 0)
bbox = mask.getbbox()
print("bbox", bbox)
if bbox:
    pad = 10
    box = (max(bbox[0] - pad, 0), max(bbox[1] - pad, 0),
           min(bbox[2] + pad, w), min(bbox[3] + pad, h))
    im = im.crop(box)
    print("recorte", box, "->", im.size)

im.thumbnail(FIT, Image.LANCZOS)
print("escalado", im.size)

canvas = Image.new("RGB", CANVAS, bg_color)
canvas.paste(im, ((CANVAS[0] - im.width) // 2, (CANVAS[1] - im.height) // 2))
canvas.save(OUT, "WEBP", quality=88, method=6)
print("guardado", OUT, canvas.size, os.path.getsize(OUT))
canvas.save(r"C:\Users\Usuario\AppData\Local\Temp\opencode\proc_view.png")
