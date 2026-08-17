SELECT p.ID, p.post_title, p.post_name,
  MAX(CASE WHEN pm.meta_key='_manage_stock' THEN pm.meta_value END) AS manage_stock,
  MAX(CASE WHEN pm.meta_key='_stock' THEN pm.meta_value END) AS stock,
  MAX(CASE WHEN pm.meta_key='_stock_status' THEN pm.meta_value END) AS stock_status,
  MAX(CASE WHEN pm.meta_key='_backorders' THEN pm.meta_value END) AS backorders
FROM wp_buDIJ_posts p
LEFT JOIN wp_buDIJ_postmeta pm ON pm.post_id=p.ID AND pm.meta_key IN ('_manage_stock','_stock','_stock_status','_backorders')
WHERE p.post_name='igf-1-lr3-1-ml'
GROUP BY p.ID;
