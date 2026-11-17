#!/bin/bash
for h in anabolicgroup.com www.anabolicgroup.com test.anabolicgroup.com; do
  echo "=== $h ==="
  echo | timeout 15 openssl s_client -connect "$h:443" -servername "$h" 2>/dev/null | openssl x509 -noout -subject -issuer -dates -ext subjectAltName 2>/dev/null
  echo
done