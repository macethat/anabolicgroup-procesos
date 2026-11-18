import os
import sys
import urllib.request

from PIL import Image

URL = "https://landerlan.com.br/img/produto/gonadotropina-landerlan.png"
RAW = "/tmp/hcg_landerlan.png"
OUT_DIRS = ["/home/abgroup/catalogo/static/img",
            "/home/abgroup/web/test.anabolicgroup.com/public_html/static/img"]
NAME = "hcg-5000-ui-landerlan.png"

req = urllib.request.Request(URL, headers={"User-Agent": "Mozilla/5.0"})
data = urllib.request.urlopen(req, timeout=90).read()
print("bytes:", len(data))
open(RAW, "wb").write(data)

im = Image.open(RAW)
print("formato:", im.format, im.size, im.mode)
im = im.convert("RGBA")
if im.size[0] > 1000:
    im.thumbnail((1000, 1000), Image.LANCZOS)
for d in OUT_DIRS:
    dst = os.path.join(d, NAME)
    im.save(dst, "PNG", optimize=True)
    print("guardado:", dst, os.path.getsize(dst))

# vista previa en jpg
im.convert("RGB").save("/tmp/hcg_preview.jpg", "JPEG", quality=85)
print("preview listo")
