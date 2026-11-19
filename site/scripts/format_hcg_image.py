import os
import sys

from PIL import Image

sys.stdout.reconfigure(encoding="utf-8")

SRC = r"C:\anabolicgroup\imagenes\hcg-5000-ui-landerlan.webp"
OUT = r"C:\anabolicgroup\imagenes\hcg-5000-ui-landerlan-final.webp"

CANVAS = (1060, 1080)      # mismo formato que el resto del catalogo
FIT = (740, 740)           # empaque al ~70% del lienzo, con margen amplio
BG = (255, 255, 255, 255)

im = Image.open(SRC).convert("RGBA")
print("origen", im.size)

# recorta el blanco sobrante para centrar el empaque con margen uniforme
bg = Image.new("RGBA", im.size, BG)
diff = Image.new("RGBA", im.size, BG)
diff.paste(im, (0, 0))
# bbox de los pixeles que difieren del blanco
import PIL.ImageChops as chops
bbox = chops.difference(diff, bg).getbbox()
if bbox:
    im = im.crop(bbox)
    print("recorte", bbox, "->", im.size)

im.thumbnail(FIT, Image.LANCZOS)

canvas = Image.new("RGBA", CANVAS, BG)
x = (CANVAS[0] - im.width) // 2
y = (CANVAS[1] - im.height) // 2
canvas.alpha_composite(im, (x, y))

canvas.convert("RGB").save(OUT, "WEBP", quality=88, method=6)
print("guardado", OUT, canvas.size, os.path.getsize(OUT))
canvas.convert("RGB").save(r"C:\Users\Usuario\AppData\Local\Temp\opencode\hcg_final_view.png")
