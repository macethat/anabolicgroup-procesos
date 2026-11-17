#!/bin/bash
cd /tmp
rm -f cj.txt login.html out.html
curl -sk -c cj.txt "https://127.0.0.1:8083/login/" -o login.html
TOKEN=$(grep -o 'name="token" value="[^"]*"' login.html | head -1 | sed 's/.*value="//;s/"$//')
echo "TOKEN=$TOKEN"
curl -sk -b cj.txt -c cj.txt -X POST "https://127.0.0.1:8083/login/" \
  --data-urlencode "token=$TOKEN" \
  --data-urlencode "user=abgroup" \
  --data-urlencode "password=<HESTIA_PASSWORD>" \
  -o out.html -w "LOGIN_HTTP=%{http_code} REDIR=%{redirect_url}\n"
echo "--- senales en respuesta ---"
grep -oiE 'incorrect|invalid|two-factor|2fa|verification|list/web|error' out.html | sort -u | head
echo "--- cookies ---"
grep HESTIASID cj.txt | awk '{print $NF}' | tail -1
