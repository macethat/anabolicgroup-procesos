SELECT id, code, name, slug, price, stock_status, is_published, image, wc_id
FROM products
WHERE brand_id = (SELECT id FROM brands WHERE name='LANDERLAN')
  AND (name LIKE '%Bolden%' OR name LIKE '%Metenolona%' OR name LIKE '%Primoboland%'
       OR name LIKE '%Testoland%' OR name LIKE '%Propionato%' OR name LIKE '%Propinato%'
       OR name LIKE '%Trembolona%')
ORDER BY name;
SELECT '--- XTL ---' AS x;
SELECT id, code, name, slug, price, stock_status, is_published, image, wc_id
FROM products
WHERE brand_id = (SELECT id FROM brands WHERE name='XTLABS')
  AND (name LIKE '%Boldeplex%' OR name LIKE '%Mastaplex%' OR name LIKE '%Tremboplex%'
       OR name LIKE '%Trembolona%')
ORDER BY name;
