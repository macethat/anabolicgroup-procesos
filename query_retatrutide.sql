SELECT p.ID, p.post_title, p.post_type, p.post_status,
  MAX(CASE WHEN pm.meta_key='_regular_price' THEN pm.meta_value END) AS regular_price,
  MAX(CASE WHEN pm.meta_key='_price' THEN pm.meta_value END) AS price,
  MAX(CASE WHEN pm.meta_key='_sale_price' THEN pm.meta_value END) AS sale_price,
  MAX(CASE WHEN pm.meta_key='_stock' THEN pm.meta_value END) AS stock,
  MAX(CASE WHEN pm.meta_key='_stock_status' THEN pm.meta_value END) AS stock_status,
  MAX(CASE WHEN pm.meta_key='_manage_stock' THEN pm.meta_value END) AS manage_stock,
  MAX(CASE WHEN pm.meta_key='_thumbnail_id' THEN pm.meta_value END) AS thumb
FROM wp_buDIJ_posts p
LEFT JOIN wp_buDIJ_postmeta pm ON pm.post_id=p.ID AND pm.meta_key IN ('_regular_price','_price','_sale_price','_stock','_stock_status','_manage_stock','_thumbnail_id')
WHERE p.ID=15229
GROUP BY p.ID;
