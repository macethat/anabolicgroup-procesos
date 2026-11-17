#!/bin/bash
cd /tmp
echo "--- flash en list/web ---"
curl -sk -b cj.txt -e "https://127.0.0.1:8083/edit/web/" "https://127.0.0.1:8083/list/web/" -o lw3.html
grep -oE 'role="alert"[\s\S]{0,200}' lw3.html | sed 's/<[^>]*>/ /g' | tr -s ' ' | head -5
sed 's/<[^>]*>/ /g' lw3.html | tr -s ' ' | grep -oiE 'error[^.]{0,160}|success[^.]{0,160}|ssl[^.]{0,160}' | sort -u | head -15
echo "--- estado sslEnabled en edit ---"
curl -sk -b cj.txt -e "https://127.0.0.1:8083/list/web/" "https://127.0.0.1:8083/edit/web/?domain=test.anabolicgroup.com&token=<SESSION_TOKEN>" -o edit2.html
grep -oE 'sslEnabled[^,]{0,20}|letsEncryptEnabled[^,]{0,20}' edit2.html | head -5
echo "--- conf principal: 443/ssl? ---"
grep -nE 'listen|ssl_certificate|ssl ' /etc/nginx/conf.d/domains/test.anabolicgroup.com.conf | head -20