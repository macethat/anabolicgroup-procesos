SELECT p.ID, p.post_title,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS reg,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_price') AS price,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_sale_price') AS sale
FROM wp_buDIJ_posts p WHERE p.ID IN (15256);