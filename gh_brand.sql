SELECT p.id, p.code, p.name, p.slug, b.name AS marca, p.price, p.is_published
FROM products p JOIN brands b ON b.id=p.brand_id
WHERE p.name LIKE '%Gentropin%' OR p.name LIKE '%Hutrope%';
