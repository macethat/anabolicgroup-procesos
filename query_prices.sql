SELECT p.ID, p.post_title,
  MAX(CASE WHEN pm.meta_key='_regular_price' THEN pm.meta_value END) AS regular_price,
  MAX(CASE WHEN pm.meta_key='_price' THEN pm.meta_value END) AS price,
  MAX(CASE WHEN pm.meta_key='_sale_price' THEN pm.meta_value END) AS sale_price,
  MAX(CASE WHEN pm.meta_key='_stock' THEN pm.meta_value END) AS stock,
  MAX(CASE WHEN pm.meta_key='_stock_status' THEN pm.meta_value END) AS stock_status
FROM wp_buDIJ_posts p
JOIN wp_buDIJ_postmeta pm ON pm.post_id=p.ID AND pm.meta_key IN ('_regular_price','_price','_sale_price','_stock','_stock_status')
WHERE p.post_type='product'
  AND p.post_status IN ('publish','draft','private','pending')
  AND (p.post_title LIKE '%GLOW%' OR p.post_title LIKE '%MOST%' OR p.post_title LIKE '%GHK%'
       OR p.post_title LIKE '%TESAMORELIN%' OR p.post_title LIKE '%IPAMORELIN%' OR p.post_title LIKE '%CJC%'
       OR p.post_title LIKE '%TB500%' OR p.post_title LIKE '%BPC%' OR p.post_title LIKE '%NAD%'
       OR p.post_title LIKE '%AOD%' OR p.post_title LIKE '%Tirzepatide%' OR p.post_title LIKE '%Retatrutide%')
GROUP BY p.ID
ORDER BY p.post_title;
