#!/bin/bash
cd /tmp
echo "--- opciones de IP ---"
grep -oE '<option[^>]*>[^<]*</option>' addweb.html | head -20
echo "--- todos los elementos con name= ---"
grep -oE '<(input|select|textarea)[^>]*name="[^"]*"[^>]*>' addweb.html | sed 's/></>\n</g'
echo "--- opciones proxy / otros selects ---"
grep -oE '<select[^>]*name="[^"]*"[\s\S]*?</select>' addweb.html | head -c 2000