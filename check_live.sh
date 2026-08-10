#!/bin/bash
for url in "https://anabolicgroup.com/" "https://anabolicgroup.com/shop/" "https://anabolicgroup.com/mi-cuenta/" "https://anabolicgroup.com/carrito/"; do
  echo "=== $url ==="
  curl -sL "$url" -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' 2>/dev/null | grep -oE '6099-0195|60990195|6405-9959|64059959|wa.me/[0-9]+|data-settings="[^"]*number[^"]*"' | sort | uniq -c
done
