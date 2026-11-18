SELECT c.name AS categoria, COUNT(*) AS n FROM products p
JOIN categories c ON c.id=p.category_id GROUP BY c.name ORDER BY n DESC;
SELECT COUNT(*) AS total, SUM(is_published) AS publicados FROM products;
