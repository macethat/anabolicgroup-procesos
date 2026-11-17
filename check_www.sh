#!/bin/bash
echo "=== DNS www / apex (resolucion del servidor) ==="
getent hosts www.anabolicgroup.com
getent hosts anabolicgroup.com
echo
echo "=== Certificado EN EL ORIGEN para apex ==="
echo | timeout 15 openssl s_client -connect 159.195.16.126:443 -servername anabolicgroup.com 2>/dev/null | openssl x509 -noout -subject -issuer -dates
echo
echo "=== Certificado EN EL ORIGEN para www ==="
echo | timeout 15 openssl s_client -connect 159.195.16.126:443 -servername www.anabolicgroup.com 2>/dev/null | openssl x509 -noout -subject -issuer -dates
echo
echo "=== certs LE existentes en el servidor ==="
ls -1 /etc/letsencrypt/live/ 2>/dev/null
echo "=== conf ssl del dominio principal (fechas) ==="
grep -E 'ssl_certificate|listen' /etc/nginx/conf.d/domains/anabolicgroup.com.ssl.conf 2>/dev/null | head