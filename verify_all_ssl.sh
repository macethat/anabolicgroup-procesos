#!/bin/bash
echo "=========== DNS ==========="
echo "apex:"; getent ahostsv4 anabolicgroup.com | awk '{print $1}' | sort -u
echo "www:";  getent ahostsv4 www.anabolicgroup.com | awk '{print $1}' | sort -u
echo "test:"; getent ahostsv4 test.anabolicgroup.com | awk '{print $1}' | sort -u

echo; echo "=========== APEX anabolicgroup.com ==========="
echo | timeout 15 openssl s_client -connect anabolicgroup.com:443 -servername anabolicgroup.com 2>/dev/null | openssl x509 -noout -subject -issuer -dates
curl -sS -o /dev/null -w "HTTPS: verify=%{ssl_verify_result} status=%{http_code}\n" https://anabolicgroup.com/ 2>&1
curl -sS -o /dev/null -w "HTTP : status=%{http_code} -> %{redirect_url}\n" http://anabolicgroup.com/ 2>&1

echo; echo "=========== WWW www.anabolicgroup.com ==========="
echo | timeout 15 openssl s_client -connect www.anabolicgroup.com:443 -servername www.anabolicgroup.com 2>/dev/null | openssl x509 -noout -subject -issuer -dates
curl -sS -o /dev/null -w "HTTPS: verify=%{ssl_verify_result} status=%{http_code}\n" https://www.anabolicgroup.com/ 2>&1 || echo "(curl reporto error de certificado)"
echo -n "WWW HTTP: "; curl -sS -o /dev/null -w "status=%{http_code} -> %{redirect_url}\n" http://www.anabolicgroup.com/ 2>&1
echo -n "WWW titulo (-k): "; curl -ksS --max-time 20 https://www.anabolicgroup.com/ | grep -oiE '<title>[^<]*</title>|<h1[^>]*>[^<]*</h1>' | head -1

echo; echo "=========== TEST test.anabolicgroup.com ==========="
echo | timeout 15 openssl s_client -connect test.anabolicgroup.com:443 -servername test.anabolicgroup.com 2>/dev/null | openssl x509 -noout -subject -issuer -dates