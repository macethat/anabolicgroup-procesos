#!/bin/bash
cd /tmp
curl -sk -b cj.txt -c cj.txt "https://127.0.0.1:8083/add/web/" -o addweb.html -w "ADDWEB_HTTP=%{http_code}\n"
echo "--- token ---"
grep -o 'name="token" value="[^"]*"' addweb.html | head -1
echo "--- inputs/selects (name + value/selected) ---"
grep -oE '<input[^>]*name="[^"]*"[^>]*>' addweb.html | sed 's/></>\n</g' | head -60
echo "--- selects ---"
grep -oE '<select[^>]*name="[^"]*"' addweb.html | head -20
echo "--- form action ---"
grep -oE '<form[^>]*action="[^"]*"' addweb.html | head -5