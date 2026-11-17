#!/bin/bash
cd /tmp
curl -sk -b cj.txt -c cj.txt -e "https://127.0.0.1:8083/list/web/" "https://127.0.0.1:8083/add/web/" -o addweb.html
TOKEN=$(grep -o 'name="token" value="[^"]*"' addweb.html | head -1 | sed 's/.*value="//;s/"$//')
echo "TOKEN=$TOKEN"
curl -sk -b cj.txt -c cj.txt -e "https://127.0.0.1:8083/add/web/" -X POST "https://127.0.0.1:8083/add/web/" \
  --data-urlencode "token=$TOKEN" \
  --data-urlencode "ok=Add" \
  --data-urlencode "v_domain=test.anabolicgroup.com" \
  --data-urlencode "v_ip=159.195.16.126" \
  -o addresult.html -w "ADD_HTTP=%{http_code} REDIR=%{redirect_url}\n"
echo "--- resultado (texto) ---"
sed 's/<[^>]*>/ /g' addresult.html | tr -s ' ' | grep -viE '^\s*$' | head -50