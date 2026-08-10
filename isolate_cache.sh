#!/bin/bash
echo "=== DIRECTO AL ORIGEN (sin Cloudflare) ==="
curl -sk "https://159.195.16.126/" -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' -H 'Host: anabolicgroup.com' -H 'Cache-Control: no-cache' 2>/dev/null | grep -oE '6099-0195|60990195|6405-9959|64059959|50760990195|50764059959|elementor-13263' | sort | uniq -c
echo "=== VIA CLOUDFLARE con cache-buster ==="
curl -sL "https://anabolicgroup.com/?cb=999999" -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' -H 'Cache-Control: no-cache' 2>/dev/null | grep -oE '6099-0195|60990195|6405-9959|64059959|50760990195|50764059959' | sort | uniq -c
