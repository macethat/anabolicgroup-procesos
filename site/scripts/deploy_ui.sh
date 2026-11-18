#!/bin/bash
set -e
APP=/home/abgroup/catalogo
DOC=/home/abgroup/web/test.anabolicgroup.com/public_html
export XDG_RUNTIME_DIR=/run/user/$(id -u)
cp -f "$APP/static/style.css" "$DOC/static/style.css"
cp -f "$APP/static/app.js" "$DOC/static/app.js"
mkdir -p "$DOC/static/img"
cp -f "$APP/static/img/logo.png" "$DOC/static/img/logo.png"
chmod 644 "$DOC/static/style.css" "$DOC/static/app.js" "$DOC/static/img/logo.png"
systemctl --user restart catalogo.service
sleep 2
echo "service: $(systemctl --user is-active catalogo.service)"
echo "health: $(curl -s http://127.0.0.1:8000/health)"
echo "--- doc static ---"
ls -la "$DOC/static" | head
echo "--- logo ---"
ls -la "$DOC/static/img/logo.png"