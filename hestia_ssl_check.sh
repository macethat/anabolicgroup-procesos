#!/bin/bash
IP=159.195.16.126
cd /tmp
echo "--- confs test ---"
ls -1 /etc/nginx/conf.d/domains/ | grep -i test
echo "--- letsencrypt ---"
ls -1 /etc/letsencrypt/live/ 2>/dev/null | grep -i test || echo "(sin live test)"
echo "--- origen 443 ---"
curl -sk --max-time 10 --resolve "test.anabolicgroup.com:443:$IP" https://test.anabolicgroup.com/ -o /tmp/o443.html -w "HTTP443=%{http_code}\n" 2>&1
grep -oE '<h1>[^<]*</h1>' /tmp/o443.html 2>/dev/null || head -c 120 /tmp/o443.html 2>/dev/null | tr -d '\n'; echo
echo "--- log hestia reciente (le) ---"
tail -n 20 /var/log/hestia/nginx-error.log 2>/dev/null | grep -iE 'ssl|letsencrypt|acme|test.anabolic' | tail -10 || echo "(sin acceso/registros)"