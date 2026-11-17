#!/bin/bash
cd /tmp
for name in v_ip v_template v_backend_template v_stats v_ssl_key_algo v_proxy_template; do
  echo "=== $name ==="
  # extraer el bloque select de ese name y mostrar opciones selected o todas
  awk "/<select[^>]*name=\"$name\"/,/<\/select>/" edit.html | grep -oE '<option[^>]*>[^<]*</option>' | head -20
done