#!/bin/bash
curl -sL 'https://anabolicgroup.com/shop/' -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' 2>/dev/null | grep -oE 'data-elementor-id="[0-9]+"' | sort | uniq -c
