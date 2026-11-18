SELECT code, name, price, stock_status, is_published, image FROM products WHERE slug='stanoprime-50-mg';
SELECT COUNT(*) AS total, SUM(is_published) AS publicados FROM products;
SELECT b.name, COUNT(*) n FROM products p JOIN brands b ON b.id=p.brand_id GROUP BY b.name ORDER BY b.sort_order, b.name;
