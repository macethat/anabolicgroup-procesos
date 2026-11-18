DELETE FROM products WHERE id IN (32,35,36,39,66,70,92);
SELECT COUNT(*) AS total, SUM(is_published) AS publicados FROM products;
SELECT b.name AS marca, COUNT(*) AS n FROM products p JOIN brands b ON b.id=p.brand_id GROUP BY b.name ORDER BY b.name;
