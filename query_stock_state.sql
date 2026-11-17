SELECT p.ID, p.post_type, p.post_status,
  MAX(CASE WHEN pm.meta_key='_stock' THEN pm.meta_value END) AS stock,
  MAX(CASE WHEN pm.meta_key='_stock_status' THEN pm.meta_value END) AS stock_status,
  MAX(CASE WHEN pm.meta_key='_manage_stock' THEN pm.meta_value END) AS manage_stock,
  MAX(CASE WHEN pm.meta_key='_backorders' THEN pm.meta_value END) AS backorders,
  MAX(CASE WHEN pm.meta_key='_price' THEN pm.meta_value END) AS price
FROM wp_buDIJ_posts p
LEFT JOIN wp_buDIJ_postmeta pm ON pm.post_id=p.ID
WHERE p.ID IN (15229,15403,15404,15405)
GROUP BY p.ID
ORDER BY p.ID;