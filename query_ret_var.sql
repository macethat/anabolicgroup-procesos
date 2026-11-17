SELECT p.ID, p.post_title, p.post_type, p.post_status, p.post_parent,
  MAX(CASE WHEN pm.meta_key='_regular_price' THEN pm.meta_value END) AS regular_price,
  MAX(CASE WHEN pm.meta_key='_price' THEN pm.meta_value END) AS price,
  MAX(CASE WHEN pm.meta_key='_stock' THEN pm.meta_value END) AS stock,
  MAX(CASE WHEN pm.meta_key='_stock_status' THEN pm.meta_value END) AS stock_status,
  MAX(CASE WHEN pm.meta_key='attribute_pa_presentacion' THEN pm.meta_value END) AS attr_presentacion,
  MAX(CASE WHEN pm.meta_key='_thumbnail_id' THEN pm.meta_value END) AS img
FROM wp_buDIJ_posts p
LEFT JOIN wp_buDIJ_postmeta pm ON pm.post_id=p.ID AND pm.meta_key IN ('_regular_price','_price','_stock','_stock_status','attribute_pa_presentacion','_thumbnail_id')
WHERE p.ID IN (15229, 15403, 15404, 15405)
GROUP BY p.ID
ORDER BY p.post_parent, p.ID;
