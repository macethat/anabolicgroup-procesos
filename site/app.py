import os
import re
import html
from urllib.parse import quote
import pymysql
from flask import Flask, render_template, jsonify, abort, redirect, request, Response
from dotenv import load_dotenv
from werkzeug.middleware.proxy_fix import ProxyFix

load_dotenv()

WA_NUMBER = os.environ.get("WHATSAPP_NUMBER", "50760990195")
SITE_NAME = os.environ.get("SITE_NAME", "Anabolic Group")

def get_db():
    return pymysql.connect(
        host=os.environ.get("DB_HOST", "127.0.0.1"),
        port=int(os.environ.get("DB_PORT", "3306")),
        user=os.environ.get("DB_USER", ""),
        password=os.environ.get("DB_PASSWORD", ""),
        database=os.environ.get("DB_NAME", ""),
        charset="utf8mb4",
        cursorclass=pymysql.cursors.DictCursor,
        autocommit=True,
    )

def wa_link(msg):
    return "https://wa.me/%s?text=%s" % (WA_NUMBER, quote(msg))


def tagline(value, limit=90):
    """Texto plano de una linea: quita HTML, entidades y recorta."""
    txt = re.sub(r"<[^>]+>", " ", str(value or ""))
    txt = html.unescape(txt)
    txt = re.sub(r"\s+", " ", txt).strip()
    if limit and len(txt) > limit:
        txt = txt[:limit].rsplit(" ", 1)[0].rstrip(",;:.-") + "…"
    return txt

PRODUCT_SQL = """
SELECT p.id, p.name, p.slug, p.excerpt, p.description, p.presentation,
       p.price, p.currency, p.stock_status, p.image,
       b.name AS brand, b.slug AS brand_slug,
       c.name AS category, c.slug AS category_slug
FROM products p
JOIN brands b ON b.id = p.brand_id
LEFT JOIN categories c ON c.id = p.category_id
WHERE p.is_published = 1
"""

def create_app():
    app = Flask(__name__)
    # Respeta X-Forwarded-* del proxy PHP para generar URLs absolutas correctas.
    app.wsgi_app = ProxyFix(app.wsgi_app, x_for=1, x_proto=1, x_host=1, x_port=0)
    app.config["SECRET_KEY"] = os.environ.get("SECRET_KEY", "dev-only")
    app.add_template_filter(tagline)

    def img_ver(path):
        """Version de cache por archivo de imagen (mtime)."""
        try:
            rel = str(path or "").lstrip("/")
            if rel.startswith("static/"):
                rel = rel[len("static/"):]
            return int(os.path.getmtime(os.path.join(app.static_folder, rel)))
        except Exception:
            return ASSET_VER

    app.add_template_filter(img_ver)
    try:
        ASSET_VER = str(int(os.path.getmtime(os.path.join(app.root_path, "static", "style.css"))))
    except Exception:
        ASSET_VER = "1"

    @app.context_processor
    def inject_globals():
        return dict(site_name=SITE_NAME, whatsapp=WA_NUMBER, wa_link=wa_link,
                    year=2026, asset_ver=ASSET_VER)

    def query(sql, args=None):
        conn = get_db()
        try:
            with conn.cursor() as cur:
                cur.execute(sql, args or ())
                return cur.fetchall()
        finally:
            conn.close()

    def get_brands():
        return query(
            """SELECT b.id, b.name, b.slug, COUNT(p.id) AS n
               FROM brands b LEFT JOIN products p ON p.brand_id = b.id AND p.is_published = 1
               GROUP BY b.id, b.name, b.slug ORDER BY b.sort_order, b.name"""
        )

    def get_categories():
        return query(
            """SELECT c.id, c.name, c.slug, COUNT(p.id) AS n
               FROM categories c LEFT JOIN products p ON p.category_id = c.id AND p.is_published = 1
               GROUP BY c.id, c.name, c.slug ORDER BY c.name"""
        )

    @app.get("/")
    def index():
        return render_template("index.html", hero=True, brands=get_brands(),
                               categories=get_categories(), products=query(
                                   PRODUCT_SQL + " ORDER BY b.sort_order, b.name, p.sort_order, p.name"),
                               active_brand=None, active_cat=None, q="")

    @app.get("/marca/<slug>/")
    def brand(slug):
        brands = get_brands()
        cats = get_categories()
        current = next((b for b in brands if b["slug"] == slug), None)
        if not current:
            abort(404)
        products = query(PRODUCT_SQL + " AND b.slug = %s ORDER BY p.sort_order, p.name", (slug,))
        return render_template("index.html", hero=False, brands=brands, categories=cats,
                               products=products, active_brand=slug, active_cat=None, q="")

    @app.get("/categoria/<slug>/")
    def categoria(slug):
        brands = get_brands()
        cats = get_categories()
        current = next((c for c in cats if c["slug"] == slug), None)
        if not current:
            abort(404)
        products = query(PRODUCT_SQL + " AND c.slug = %s ORDER BY b.sort_order, p.sort_order, p.name", (slug,))
        return render_template("index.html", hero=False, brands=brands, categories=cats,
                               products=products, active_brand=None, active_cat=slug, q="")

    @app.get("/buscar")
    def buscar():
        q = (request.args.get("q") or "").strip()
        marca = (request.args.get("marca") or "").strip()
        cat = (request.args.get("cat") or "").strip()
        sql = PRODUCT_SQL
        args = []
        if q:
            sql += " AND p.name LIKE %s"
            args.append("%" + q + "%")
        if marca:
            sql += " AND b.slug = %s"
            args.append(marca)
        if cat:
            sql += " AND c.slug = %s"
            args.append(cat)
        sql += " ORDER BY b.sort_order, b.name, p.sort_order, p.name"
        return render_template("index.html", hero=False, brands=get_brands(),
                               categories=get_categories(), products=query(sql, args),
                               active_brand=marca or None, active_cat=cat or None, q=q)

    @app.get("/producto/<slug>/")
    def product(slug):
        rows = query(PRODUCT_SQL + " AND p.slug = %s LIMIT 1", (slug,))
        if not rows:
            abort(404)
        p = rows[0]
        presentations = query(
            "SELECT label, price, stock_status FROM presentations WHERE product_id = %s ORDER BY sort_order",
            (p["id"],),
        )
        related = query(
            PRODUCT_SQL + " AND p.slug <> %s AND b.slug = %s ORDER BY RAND() LIMIT 4",
            (slug, p["brand_slug"]),
        )
        jsonld = {
            "@context": "https://schema.org",
            "@type": "Product",
            "name": p["name"],
            "description": p["excerpt"] or p["name"],
            "image": [request.url_root.rstrip("/") + p["image"]] if p["image"] else [],
            "brand": {"@type": "Brand", "name": p["brand"]},
            "category": p["category"] or "Anabolicos",
            "offers": {
                "@type": "Offer",
                "priceCurrency": "USD",
                "price": (f'{p["price"]:.2f}' if p["price"] is not None else ""),
                "availability": ("https://schema.org/InStock" if p["stock_status"] == "instock"
                                 else "https://schema.org/OutOfStock"),
                "url": request.base_url,
            },
        }
        return render_template("producto.html", p=p, related=related,
                               presentations=presentations, jsonld=jsonld)

    @app.get("/api/producto/<slug>")
    def api_product(slug):
        rows = query(PRODUCT_SQL + " AND p.slug = %s LIMIT 1", (slug,))
        if not rows:
            return jsonify(error="not found"), 404
        return jsonify(rows[0])

    @app.get("/contacto")
    def contacto():
        return redirect(wa_link("Hola, quiero información sobre el catálogo de Anabolic Group."))

    @app.get("/privacidad")
    def privacidad():
        return render_template("legal.html", title="Política de privacidad",
                               body=("Los datos que compartas por WhatsApp se usan únicamente para responder tu consulta. "
                                     "No vendemos ni compartimos tu información con terceros."))

    @app.get("/terminos")
    def terminos():
        return render_template("legal.html", title="Términos y condiciones",
                               body=("La información de este catálogo es referencial y no constituye consejo médico. "
                                     "Los productos son de uso referencial y requieren asesoría y supervisión de un "
                                     "profesional de la salud. No automedicarse. Uso bajo responsabilidad del comprador."))

    @app.get("/descargo")
    def descargo():
        return render_template("legal.html", title="Descargo de responsabilidad",
                               body=("Consulta a tu médico antes de consumir este tipo de productos. Anabolic Group "
                                     "no se hace responsable por el uso indebido de los productos. La información "
                                     "publicada tiene fines informativos y no sustituye una consulta médica."))

    @app.get("/robots.txt")
    def robots():
        return Response("User-agent: *\nDisallow: /\n", mimetype="text/plain")

    @app.get("/health")
    def health():
        try:
            conn = get_db()
            with conn.cursor() as cur:
                cur.execute("SELECT 1 AS ok")
                row = cur.fetchone()
            conn.close()
            return jsonify(status="ok", db=row["ok"])
        except Exception as e:
            return jsonify(status="error", error=str(e)), 500

    return app

app = create_app()

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8000, debug=True)