#!/bin/bash
cd /tmp
curl -sk -b cj.txt -e "https://127.0.0.1:8083/list/web/" "https://127.0.0.1:8083/list/web/" -o lw.html
echo "--- links ssl/edit ---"
grep -oE 'href="[^"]*(ssl|edit/web)[^"]*"' lw.html | sort -u | head -20
echo "--- probar rutas ssl ---"
for u in "/edit/web/?domain=test.anabolicgroup.com" "/add/web/ssl/?domain=test.anabolicgroup.com" "/edit/web/ssl/?domain=test.anabolicgroup.com"; do
  code=$(curl -sk -b cj.txt -e "https://127.0.0.1:8083/list/web/" "https://127.0.0.1:8083$u" -o "p_$(echo $u | md5sum | cut -c1-6).html" -w "%{http_code}")
  echo "GET $u -> $code"
done