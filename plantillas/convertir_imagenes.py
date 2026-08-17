# ============================================================
# PLANTILLA: convertir imagenes PNG de presentaciones a JPG
# Uso local (Python + Pillow). Ejecutar desde:
# python convertir_imagenes.py
# Reemplazar ORIGEN (carpeta con PNG) y NOMBRES_SALIDA.
# ============================================================
from PIL import Image
import os

# ============ CONFIGURACION ============
ORIGEN = r"C:\suplementos\anabolicos\fotos"      # carpeta con los PNG
OUTDIR = r"C:\Users\Usuario\AppData\Local\Temp\opencode\imgs"
# nombre_png -> slug de salida (sin extension)
COMBINACIONES = {
    "Retratrutide 10mg.png": "producto-10mg",   # ojo typos en nombres del cliente
    "Retatrutide 60mg.png": "producto-60mg",
}
SIZE = 1000                # px
QUALITY = 88
# ========================================

os.makedirs(OUTDIR, exist_ok=True)
for src, out in COMBINACIONES.items():
    p = os.path.join(ORIGEN, src)
    if not os.path.exists(p):
        print("NO EXISTE:", p); continue
    im = Image.open(p).convert("RGB")
    im = im.resize((SIZE, SIZE), Image.LANCZOS)
    dest = os.path.join(OUTDIR, out + ".jpg")
    im.save(dest, "JPEG", quality=QUALITY)
    print(f"OK: {src} -> {dest} ({os.path.getsize(dest)} bytes)")

print("DONE")