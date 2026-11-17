#!/bin/bash
DOC=/home/abgroup/web/test.anabolicgroup.com/public_html
echo "--- docroot ---"
ls -lad "$DOC" 2>&1
cat > "$DOC/index.html" <<'EOF'
<!doctype html>
<html lang="es"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>test.anabolicgroup.com</title>
<style>body{font-family:system-ui,-apple-system,Segoe UI,Roboto,sans-serif;background:#f5f5f5;color:#333;display:flex;align-items:center;justify-content:center;height:100vh;margin:0}.box{background:#fff;padding:40px 50px;border-radius:12px;box-shadow:0 6px 24px rgba(0,0,0,.08);text-align:center}h1{color:#2e7d32;margin:0 0 10px}code{background:#eee;padding:2px 6px;border-radius:4px}</style></head>
<body><div class="box"><h1>Subdominio activo</h1><p><code>test.anabolicgroup.com</code> esta funcionando.</p><p style="color:#888;font-size:14px">Sin WordPress vinculado.</p></div></body></html>
EOF
echo "--- contenido ---"
ls -la "$DOC"
echo "--- ssl conf? ---"
ls -1 /etc/nginx/conf.d/domains/ | grep -i test || echo "(sin ssl conf)"
echo "--- prueba origen HTTP (Host test) ---"
curl -sS --max-time 10 --resolve "test.anabolicgroup.com:80:127.0.0.1" http://test.anabolicgroup.com/ -o /tmp/testpage.html -w "HTTP=%{http_code}\n" && grep -oE '<h1>[^<]*</h1>' /tmp/testpage.html