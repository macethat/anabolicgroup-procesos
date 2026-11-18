UPDATE products SET name = 'Clenbutrex Ultra 60 mcg', slug = 'clenbutrex-ultra-60-mcg'
WHERE id = 44;
DELETE FROM products WHERE id = 67;
SELECT id, code, name, slug, price, stock_status, is_published FROM products WHERE id = 44;
SELECT COUNT(*) AS total, SUM(is_published) AS publicados FROM products;
