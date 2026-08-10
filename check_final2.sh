#!/bin/bash
for url in "https://anabolicgroup.com/my-account/" "https://anabolicgroup.com/cart/" "https://anabolicgroup.com/checkout/"; do
  echo "=== $url ==="
  curl -sL "$url" -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' -H 'Cache-Control: no-cache' 2>/dev/null | grep -oE '<title>[^<]*</title>|6099-0195|60990195|6405-9959|64059959|elementor-3784|elementor-414|elementor-1381' | sort | uniq -c
done
