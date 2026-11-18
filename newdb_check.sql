SELECT id, name, image, is_published, stock_status FROM products WHERE image IS NULL OR image = '';
SELECT '--- general ---' AS x;
SELECT p.id, p.name, p.is_published FROM products p
JOIN categories c ON c.id = p.category_id WHERE c.name = 'General';
SELECT '--- publicados ---' AS x;
SELECT COUNT(*) AS pub FROM products WHERE is_published = 1;
SELECT '--- sin publicar por marca ---' AS x;
SELECT b.name, COUNT(*) AS n FROM products p JOIN brands b ON b.id=p.brand_id
WHERE p.is_published = 0 GROUP BY b.name;