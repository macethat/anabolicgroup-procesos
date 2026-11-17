SELECT p.ID, p.post_title, p.post_excerpt,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS precio,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock') AS stock,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock_status') AS estado,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_thumbnail_id') AS thumb
FROM wp_buDIJ_posts p WHERE p.ID=14491;