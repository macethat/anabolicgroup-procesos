SELECT p.code, p.name, b.name AS marca, p.price, p.is_published, p.image
FROM products p JOIN brands b ON b.id=p.brand_id
WHERE p.name LIKE '%HCG%' OR p.slug LIKE '%hcg%' OR p.name LIKE '%Hormoprime%'
ORDER BY b.name;
SELECT '--- stanoplex ---' AS x;
SELECT code, name, image FROM products WHERE slug LIKE 'stanoplex%';
