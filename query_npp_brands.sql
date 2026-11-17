SELECT p.ID, p.post_title, p.post_status,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_thumbnail_id') AS thumb,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS precio,
  GROUP_CONCAT(DISTINCT CONCAT(tt.taxonomy,':',t.name) SEPARATOR ' | ') AS terminos
FROM wp_buDIJ_posts p
LEFT JOIN wp_buDIJ_term_relationships tr ON tr.object_id=p.ID
LEFT JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy IN ('product_brand','product_cat','product_type')
LEFT JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
WHERE p.ID IN (14491, 14577)
GROUP BY p.ID
ORDER BY p.ID;