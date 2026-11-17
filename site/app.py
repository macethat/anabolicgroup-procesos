import os
import pymysql
from flask import Flask, render_template, jsonify, abort
from dotenv import load_dotenv

load_dotenv()

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

def create_app():
    app = Flask(__name__)
    app.config["SECRET_KEY"] = os.environ.get("SECRET_KEY", "dev-only")

    @app.get("/")
    def index():
        total = 0
        brands = []
        try:
            conn = get_db()
            with conn.cursor() as cur:
                cur.execute("SELECT COUNT(*) AS n FROM products")
                total = cur.fetchone()["n"]
                cur.execute("SELECT name, slug FROM brands ORDER BY sort_order, name")
                brands = cur.fetchall()
            conn.close()
        except Exception:
            pass
        return render_template(
            "index.html",
            total=total,
            brands=brands,
            whatsapp=os.environ.get("WHATSAPP_NUMBER", ""),
        )

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

    @app.get("/api/products")
    def api_products():
        try:
            conn = get_db()
            with conn.cursor() as cur:
                cur.execute(
                    """
                    SELECT p.id, p.name, p.slug, p.price, p.currency,
                           b.name AS brand, c.name AS category
                    FROM products p
                    LEFT JOIN brands b ON b.id = p.brand_id
                    LEFT JOIN categories c ON c.id = p.category_id
                    WHERE p.is_published = 1
                    ORDER BY b.sort_order, p.sort_order, p.name
                    """
                )
                rows = cur.fetchall()
            conn.close()
            return jsonify(count=len(rows), products=rows)
        except Exception as e:
            return jsonify(status="error", error=str(e)), 500

    return app

app = create_app()

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8000, debug=True)
