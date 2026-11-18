UPDATE products SET name = 'Clenbutrex HCL 0.04 mg', slug = 'clenbutrex-hcl-0-04-mg'
WHERE id = 43;
DELETE FROM products WHERE id = 68;
SELECT id, code, name, slug, price, stock_status, is_published FROM products WHERE id = 43;
SELECT COUNT(*) AS total, SUM(is_published) AS publicados FROM products;
