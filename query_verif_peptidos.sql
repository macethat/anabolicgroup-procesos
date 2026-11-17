SELECT p.ID, p.post_title, p.post_name, p.post_status,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS precio,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock') AS stock,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock_status') AS estado,
  GROUP_CONCAT(DISTINCT CONCAT(tt.taxonomy,':',t.name) ORDER BY tt.taxonomy SEPARATOR ' | ') AS terminos,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_thumbnail_id') AS img
FROM wp_buDIJ_posts p
LEFT JOIN wp_buDIJ_term_relationships tr ON tr.object_id=p.ID
LEFT JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy IN ('product_cat','product_brand','product_type')
LEFT JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
WHERE p.ID IN (15415,15417,15419,15421,15423,15413)
GROUP BY p.ID
ORDER BY p.ID;