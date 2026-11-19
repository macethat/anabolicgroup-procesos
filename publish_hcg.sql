UPDATE products SET is_published=1 WHERE code='LAN-REC-018';
SELECT code, name, price, stock_status, is_published FROM products WHERE code='LAN-REC-018';
SELECT COUNT(*) AS total, SUM(is_published) AS publicados FROM products;
