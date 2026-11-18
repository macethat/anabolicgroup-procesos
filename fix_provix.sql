UPDATE products SET category_id = (SELECT id FROM categories WHERE name='Orales')
WHERE name = 'PROVIX 25MG - 50TAB';
SELECT c.name, COUNT(*) AS n FROM products p JOIN categories c ON c.id = p.category_id GROUP BY c.name;