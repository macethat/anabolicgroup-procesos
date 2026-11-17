#!/bin/bash
IP=159.195.16.126
echo "--- vhost conf ---"
sed -n '1,40p' /etc/nginx/conf.d/domains/test.anabolicgroup.com.conf
echo "--- origen HTTP ---"
curl -sS --max-time 10 --resolve "test.anabolicgroup.com:80:$IP" http://test.anabolicgroup.com/ -o /tmp/t80.html -w "HTTP80=%{http_code}\n"; grep -oE '<h1>[^<]*</h1>' /tmp/t80.html 2>/dev/null
echo "--- origen HTTPS ---"
curl -sk --max-time 10 --resolve "test.anabolicgroup.com:443:$IP" https://test.anabolicgroup.com/ -o /tmp/t443.html -w "HTTP443=%{http_code}\n" 2>&1; head -c 200 /tmp/t443.html 2>/dev/null | tr -d '\n'; echo