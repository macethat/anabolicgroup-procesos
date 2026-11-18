SELECT id, code, name, slug, price, stock_status, is_published, image, wc_id
FROM products
WHERE name LIKE '%Boldaplex%' OR name LIKE '%Boldeplex%'
   OR name LIKE '%Masteplex%' OR name LIKE '%Mastaplex%'
   OR name LIKE '%Tremboplex%' OR name LIKE '%Trenboplex%'
   OR name LIKE '%Trembolona%'
ORDER BY name;
