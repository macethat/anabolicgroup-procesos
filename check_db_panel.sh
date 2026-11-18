#!/bin/bash
cd /tmp
echo "=== sesion actual /list/db ==="
code=$(curl -sk -b cj.txt -e "https://127.0.0.1:8083/list/web/" "https://127.0.0.1:8083/list/db/" -o listdb.html -w "%{http_code}")
echo "list/db -> $code"
sed 's/<[^>]*>/ /g' listdb.html | tr -s ' ' | grep -oiE 'login|databases|base de datos|create|crear|abgroup_[a-z0-9_]+|web -' | sort -u | head -20
echo "=== /add/db (form) ==="
code2=$(curl -sk -b cj.txt -e "https://127.0.0.1:8083/list/db/" "https://127.0.0.1:8083/add/db/" -o addb.html -w "%{http_code}")
echo "add/db -> $code2"
grep -oE '<input[^>]*name="[^"]*"[^>]*>|<select[^>]*name="[^"]*"' addb.html 2>/dev/null | head -20
echo "=== texto visible add/db ==="
sed 's/<[^>]*>/ /g' addb.html | tr -s ' ' | grep -viE '^\s*$' | head -12