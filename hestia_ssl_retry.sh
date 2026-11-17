#!/bin/bash
cd /tmp
TOKEN=$(grep -o 'name="token" value="[^"]*"' edit2.html | head -1 | sed 's/.*value="//;s/"$//')
post_ssl () {
  local ca="$1"
  local args=(--data-urlencode "token=$TOKEN" --data-urlencode "save=save"
    --data-urlencode "v_domain=test.anabolicgroup.com" --data-urlencode "v_ip=159.195.16.126"
    --data-urlencode "v_template=default" --data-urlencode "v_backend_template=default"
    --data-urlencode "v_stats=none" --data-urlencode "v_proxy_template=default"
    --data-urlencode "v_ssl=on" --data-urlencode "v_ssl_key_algo=rsa"
    --data-urlencode "v_ssl_crt@/tmp/test.crt" --data-urlencode "v_ssl_key@/tmp/test.key")
  if [ "$ca" = "1" ]; then args+=(--data-urlencode "v_ssl_ca@/tmp/test.crt"); fi
  curl -sk -b cj.txt -c cj.txt -e "https://127.0.0.1:8083/edit/web/?domain=test.anabolicgroup.com" \
    -X POST "https://127.0.0.1:8083/edit/web/" "${args[@]}" -o /tmp/sslres.html -w "POST=%{http_code}\n"
}
echo "== intento A (sin CA) =="; post_ssl 0
ls -1 /etc/nginx/conf.d/domains/ | grep -i 'test.anabolicgroup.*ssl' || echo "no ssl conf"
echo "== intento B (con CA=cert) =="; post_ssl 1
ls -1 /etc/nginx/conf.d/domains/ | grep -i 'test.anabolicgroup.*ssl' || echo "no ssl conf"
echo "--- origen 443 ---"
curl -sk --max-time 10 --resolve "test.anabolicgroup.com:443:159.195.16.126" https://test.anabolicgroup.com/ -o /tmp/o443c.html -w "HTTP443=%{http_code}\n"
grep -oE '<h1>[^<]*</h1>' /tmp/o443c.html 2>/dev/null || head -c 80 /tmp/o443c.html | tr -d '\n'; echo