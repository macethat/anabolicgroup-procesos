#!/bin/bash
urls=(
  "https://anabolicgroup.com/"
  "https://anabolicgroup.com/shop/"
  "https://anabolicgroup.com/mi-cuenta/"
  "https://anabolicgroup.com/carrito/"
  "https://anabolicgroup.com/checkout/"
  "https://anabolicgroup.com/lista-de-deseos/"
  "https://anabolicgroup.com/tienda/"
)
for url in "${urls[@]}"; do
  result=$(curl -sL "$url" -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' -H 'Cache-Control: no-cache' 2>/dev/null | grep -oE '6405-9959|64059959|50764059959|6099-0195|60990195|50760990195' | sort | uniq -c | tr '\n' ' ')
  echo "$url => $result"
done
