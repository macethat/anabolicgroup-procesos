#!/bin/bash
# Muestra estructura del header en el HTML renderizado de inicio
echo "=== INICIO: estructura header/footer ==="
curl -sk "https://159.195.16.126/" -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' -H 'Host: anabolicgroup.com' -H 'Cache-Control: no-cache' 2>/dev/null > /tmp/inicio.html
wc -c /tmp/inicio.html
echo "Elementor IDs:"
grep -oE 'elementor [0-9]+|data-elementor-id="[0-9]+"' /tmp/inicio.html | sort | uniq -c
echo "Titulo:"
grep -oE '<title>[^<]*</title>' /tmp/inicio.html
echo "números:"
grep -oE '6099-0195|60990195|6405-9959|64059959' /tmp/inicio.html | sort | uniq -c
