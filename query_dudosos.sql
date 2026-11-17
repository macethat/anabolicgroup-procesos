SELECT ID, post_title, post_status, post_type, post_name,
  (SELECT meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_price') AS precio,
  (SELECT meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock') AS stock,
  (SELECT meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock_status') AS stock_status
FROM wp_buDIJ_posts p
WHERE p.ID IN (14992, 14556)
ORDER BY p.ID;