#!/bin/bash
cd /tmp
curl -sk -b cj.txt -c cj.txt -e "https://127.0.0.1:8083/list/web/" "https://127.0.0.1:8083/add/web/" -o addweb.html -w "ADDWEB_HTTP=%{http_code}\n"
echo "--- token ---"
grep -o 'name="token" value="[^"]*"' addweb.html | head -1
echo "--- inputs ---"
grep -oE '<input[^>]*name="[^"]*"[^>]*>' addweb.html | head -60
echo "--- selects con name ---"
grep -oE '<select[^>]*name="[^"]*"' addweb.html | head -20
echo "--- form ---"
grep -oE '<form[^>]*>' addweb.html | head -3