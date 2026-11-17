#!/bin/bash
cd /tmp
curl -sk -b cj.txt -e "https://127.0.0.1:8083/list/web/" "https://127.0.0.1:8083/edit/web/?domain=test.anabolicgroup.com&token=<SESSION_TOKEN>" -o edit.html -w "EDIT_HTTP=%{http_code}\n"
echo "--- campos name (input/select) ---"
grep -oE '<(input|select)[^>]*name="[^"]*"[^>]*>' edit.html | sed 's/></>\n</g' | head -80
echo "--- menciones ssl (href/onclick/data/name) ---"
grep -oiE '[^ ]{0,20}ssl[^ ]{0,40}' edit.html | sort -u | head -40