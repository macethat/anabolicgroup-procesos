#!/bin/bash
echo "===== Apache vhost de test (DocumentRoot / AllowOverride) ====="
grep -iE 'DocumentRoot|AllowOverride|ServerName|ProxyPass' /etc/apache2/conf.d/domains/test.anabolicgroup.com.conf 2>&1 | head -20
echo
echo "===== modulos proxy/rewrite habilitados ====="
ls /etc/apache2/mods-enabled/ 2>/dev/null | grep -iE 'proxy|rewrite' | sort
echo
echo "===== systemd de usuario ====="
systemctl --user status 2>&1 | head -3
echo "XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-<vacio>}"
echo
echo "===== salida a internet (pypi) ====="
curl -sS -o /dev/null -w "pypi.org -> %{http_code}\n" --max-time 15 https://pypi.org/ 2>&1
curl -sS -o /dev/null -w "bootstrap.pypa.io -> %{http_code}\n" --max-time 15 https://bootstrap.pypa.io/get-pip.py 2>&1
echo
echo "===== cron del usuario ====="
which crontab 2>&1
crontab -l 2>&1 | head -5
echo
echo "===== procesos actuales del usuario ====="
ps -u abgroup -o pid,comm 2>/dev/null | head -10