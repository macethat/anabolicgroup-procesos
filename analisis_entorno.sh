#!/bin/bash
echo "===== PYTHON ====="
which python3; python3 --version 2>&1
which pip3; pip3 --version 2>&1
python3 -c "import venv; print('venv OK')" 2>&1
python3 -c "import flask; print('flask', flask.__version__)" 2>&1 || echo "flask: no"
python3 -c "import django; print('django', django.get_version())" 2>&1 || echo "django: no"
python3 -c "import pymysql; print('pymysql OK')" 2>&1 || echo "pymysql: no"
python3 -c "import mysql.connector; print('mysql.connector OK')" 2>&1 || echo "mysql.connector: no"

echo; echo "===== MYSQL ====="
which mysql; mysql --version 2>&1

echo; echo "===== BIND PUERTO ALTO (prueba) ====="
python3 -c "import socket; s=socket.socket(); s.bind(('127.0.0.1', 8765)); print('bind 127.0.0.1:8765 OK'); s.close()" 2>&1

echo; echo "===== PROCESOS EN SEGUNDO PLANO ====="
which screen 2>&1; which tmux 2>&1; which systemctl 2>&1

echo; echo "===== TEMPLATES HESTIA (python/wsgi/proxy) ====="
ls -1 /usr/local/hestia/data/templates/web/nginx/ 2>&1 | head -30
ls -1 /usr/local/hestia/bin/ 2>/dev/null | grep -iE 'node|python|app|backend' | head

echo; echo "===== BACKENDS HESTIA DISPONIBLES ====="
ls -1 /usr/local/hestia/data/templates/web/ 2>&1 | head

echo; echo "===== PHP (alternativa) ====="
php -v 2>&1 | head -1

echo; echo "===== ESPACIO / LIMITES ====="
df -h /home/abgroup 2>&1 | tail -1
ulimit -a 2>&1 | grep -iE 'open files|max user processes|virtual memory' | head