#!/bin/bash
for url in "https://anabolicgroup.com/shop/?nocache=ABC123" "https://anabolicgroup.com/shop/"; do
  echo "=== $url ==="
  curl -sL "$url" -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' -H 'Cache-Control: no-cache' 2>/dev/null | grep -oE '"number":"[0-9]+"|64059959|60990195' | sort | uniq -c
done
