SELECT p.ID, p.post_title, p.post_status,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='attribute_pa_presentacion') AS presentacion,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_thumbnail_id') AS thumb,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS precio,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock') AS stock,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock_status') AS stock_status
FROM wp_buDIJ_posts p
WHERE p.post_parent = 15223 AND p.post_type='product_variation'
ORDER BY p.ID;

SELECT pm.meta_value FROM wp_buDIJ_postmeta pm
WHERE pm.post_id=15223 AND pm.meta_key='_product_attributes';

SELECT ID, post_title FROM wp_buDIJ_posts WHERE ID IN (15235, 15406, 15407);