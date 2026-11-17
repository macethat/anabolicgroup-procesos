#!/bin/bash
cd /tmp
for u in "/list/web/" "/add/web/" "/add/web" "/add/web/index.php" "/web/add/"; do
  code=$(curl -sk -b cj.txt -c cj.txt "https://127.0.0.1:8083$u" -o "page$(echo $u | tr '/' '_').html" -w "%{http_code}")
  echo "GET $u -> $code"
done
echo "--- links 'add' en list/web ---"
grep -oE 'href="[^"]*"' page_list_web_.html 2>/dev/null | grep -i add | head -10
echo "--- version ---"
grep -oiE 'hestia[^<]{0,30}version|version[^<]{0,20}[0-9]+\.[0-9]+' page_list_web_.html 2>/dev/null | head -5
echo "--- titulo /login redirect? ---"
grep -oE '<title>[^<]*</title>' page_list_web_.html 2>/dev/null | head -1