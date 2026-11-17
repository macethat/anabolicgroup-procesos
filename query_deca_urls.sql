SELECT p.ID, p.post_title, p.post_status, p.post_name,
  (SELECT meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_price') AS precio,
  (SELECT meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock') AS stock
FROM wp_buDIJ_posts p
WHERE p.ID IN (14493, 14491, 14577, 14556, 14668, 14234, 14230)
ORDER BY p.ID;