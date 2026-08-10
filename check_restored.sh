#!/bin/bash
for url in "https://anabolicgroup.com/" "https://anabolicgroup.com/shop/"; do
  echo "=== $url ==="
  curl -sL "$url" -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' -H 'Cache-Control: no-cache' 2>/dev/null | grep -oE '<title>[^<]*</title>|elementor-13263|elementor-3784|elementor-414|elementor-1381|6099-0195|6405-9959|64059959' | sort | uniq -c
done
