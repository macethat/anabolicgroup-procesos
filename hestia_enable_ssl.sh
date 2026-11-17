#!/bin/bash
cd /tmp
TOKEN=$(grep -o 'name="token" value="[^"]*"' edit.html | head -1 | sed 's/.*value="//;s/"$//')
echo "TOKEN=$TOKEN"
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
  --data-urlencode "v_letsencrypt=on" \
  -o editres.html -w "EDIT_POST=%{http_code} REDIR=%{redirect_url}\n"
echo "--- mensajes ---"
sed 's/<[^>]*>/ /g' editres.html | tr -s ' ' | grep -oiE 'error[^.]{0,140}|success[^.]{0,140}|letsencrypt[^.]{0,140}|failed[^.]{0,140}|invalid[^.]{0,140}' | sort -u | head -20
echo "--- ssl conf ---"
ls -1 /etc/nginx/conf.d/domains/ | grep -i 'test.anabolicgroup.*ssl' || echo "(sin ssl conf aun)"