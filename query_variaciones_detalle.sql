SELECT v.ID AS var_id, v.post_parent AS padre, v.post_title AS var_title, v.post_status,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=v.ID AND pm.meta_key='_price') AS precio,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=v.ID AND pm.meta_key='_regular_price') AS regular,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=v.ID AND pm.meta_key='attribute_pa_presentacion') AS presentacion
FROM wp_buDIJ_posts v
WHERE v.post_type='product_variation' AND v.post_parent IN (15223,15229)
ORDER BY v.post_parent, v.ID;