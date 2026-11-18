UPDATE products SET name = 'Klenprime 40 mcg', slug = 'klenprime-40-mcg' WHERE id = 6;
UPDATE products SET name = 'Klenprime 60 mcg', slug = 'klenprime-60-mcg' WHERE id = 13;
SELECT id, code, name, slug, price, is_published FROM products WHERE id IN (6,13);
