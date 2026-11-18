SELECT p.code, p.name, b.name AS marca, p.price, p.stock_status, p.is_published, p.slug
FROM products p JOIN brands b ON b.id=p.brand_id
WHERE p.name LIKE '%Stan%' OR p.name LIKE '%stanoz%' ORDER BY b.name, p.name;
