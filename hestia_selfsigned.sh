#!/bin/bash
cd /tmp
# 1) Certificado autofirmado
openssl req -x509 -newkey rsa:2048 -nodes -keyout test.key -out test.crt -days 825 \
  -subj "/CN=test.anabolicgroup.com" \
  -addext "subjectAltName=DNS:test.anabolicgroup.com" >/dev/null 2>&1
echo "cert generado: $(ls -l test.crt test.key | wc -l) archivos"

TOKEN=$(grep -o 'name="token" value="[^"]*"' edit.html | head -1 | sed 's/.*value="//;s/"$//')

# 2) POST edit con SSL autofirmado
curl -sk -b cj.txt -c cj.txt -e "https://127.0.0.1:8083/edit/web/?domain=test.anabolicgroup.com" -X POST "https://127.0.0.1:8083/edit/web/" \
  --data-urlencode "token=$TOKEN" \
  --data-urlencode "save=save" \
  --data-urlencode "v_domain=test.anabolicgroup.com" \
  --data-urlencode "v_ip=159.195.16.126" \
  --data-urlencode "v_template=default" \
  --data-urlencode "v_backend_template=default" \
  --data-urlencode "v_stats=none" \
  --data-urlencode "v_proxy_template=default" \
  --data-urlencode "v_ssl=on" \
  --data-urlencode "v_ssl_crt@/tmp/test.crt" \
  --data-urlencode "v_ssl_key@/tmp/test.key" \
  -o editres2.html -w "EDIT_POST=%{http_code} REDIR=%{redirect_url}\n"

echo "--- mensajes ---"
sed 's/<[^>]*>/ /g' editres2.html | tr -s ' ' | grep -oiE 'error[^.]{0,140}|success[^.]{0,140}|invalid[^.]{0,140}|failed[^.]{0,140}' | sort -u | head
echo "--- ssl conf ---"
ls -1 /etc/nginx/conf.d/domains/ | grep -i 'test.anabolicgroup.*ssl' || echo "(sin ssl conf)"
echo "--- origen 443 ---"
curl -sk --max-time 10 --resolve "test.anabolicgroup.com:443:159.195.16.126" https://test.anabolicgroup.com/ -o /tmp/o443b.html -w "HTTP443=%{http_code}\n"
grep -oE '<h1>[^<]*</h1>' /tmp/o443b.html 2>/dev/null || head -c 100 /tmp/o443b.html | tr -d '\n'; echo