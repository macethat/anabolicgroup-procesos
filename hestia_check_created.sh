#!/bin/bash
cd /tmp
echo "--- posibles mensajes ---"
grep -oiE 'error[^<]{0,120}|exists[^<]{0,80}|limit[^<]{0,80}|success[^<]{0,120}|created[^<]{0,120}|not allowed[^<]{0,80}' addresult.html | sed 's/  */ /g' | sort -u | head -20
echo "--- lista web (solo dominios) ---"
curl -sk -b cj.txt -e "https://127.0.0.1:8083/list/web/" "https://127.0.0.1:8083/list/web/" -o listweb2.html -w "LIST_HTTP=%{http_code}\n"
grep -oiE 'test\.anabolicgroup\.com|anabolicgroup\.com' listweb2.html | sort -u
echo "--- filesystem ---"
ls -1 /home/abgroup/web/ 2>&1
echo "--- nginx confs ---"
ls -1 /etc/nginx/conf.d/domains/ 2>&1 | grep -i test || echo "(sin conf test)"