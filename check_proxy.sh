#!/bin/bash
echo "===== modulos Apache cargados (proxy) ====="
apache2ctl -M 2>/dev/null | grep -iE 'proxy|rewrite|fcgid|cgi' || echo "(apache2ctl sin permiso, reviso archivos)"
echo
echo "===== mods-available proxy* ====="
ls /etc/apache2/mods-available/ 2>/dev/null | grep -iE 'proxy' | sort
echo
echo "===== mods-enabled (completo) ====="
ls /etc/apache2/mods-enabled/ 2>/dev/null | sort | tr '\n' ' '
echo
echo "===== prueba enable-linger (persistencia user services) ====="
loginctl show-user abgroup 2>&1 | grep -i linger
loginctl enable-linger abgroup 2>&1 || echo "(enable-linger requiere root; usaremos cron @reboot)"
echo
echo "===== test proxy_http con .htaccess (module present?) ====="
[ -f /etc/apache2/mods-enabled/proxy_http.load ] && echo "proxy_http ENABLED" || echo "proxy_http NO habilitado"