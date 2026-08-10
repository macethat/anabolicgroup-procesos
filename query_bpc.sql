SELECT p.ID, p.post_title,
  MAX(CASE WHEN pm.meta_key='_regular_price' THEN pm.meta_value END) AS regular_price,
  MAX(CASE WHEN pm.meta_key='_price' THEN pm.meta_value END) AS price,
  MAX(CASE WHEN pm.meta_key='_stock' THEN pm.meta_value END) AS stock,
  MAX(CASE WHEN pm.meta_key='_stock_status' THEN pm.meta_value END) AS stock_status
FROM wp_buDIJ_posts p
JOIN wp_buDIJ_postmeta pm ON pm.post_id=p.ID AND pm.meta_key IN ('_regular_price','_price','_stock','_stock_status')
WHERE p.ID=15244
GROUP BY p.ID;
