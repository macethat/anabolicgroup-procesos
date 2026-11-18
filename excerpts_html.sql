SELECT b.name AS marca, p.name, p.excerpt
FROM products p JOIN brands b ON b.id=p.brand_id
WHERE p.excerpt LIKE '%<%' ORDER BY b.name, p.name;
SELECT '--- con entidades ---' AS x;
SELECT b.name AS marca, p.name, p.excerpt FROM products p JOIN brands b ON b.id=p.brand_id
WHERE p.excerpt LIKE '%&%;%' ORDER BY b.name, p.name;
