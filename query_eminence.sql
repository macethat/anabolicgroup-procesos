SELECT p.ID, p.post_title, p.post_status,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS precio,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_thumbnail_id') AS thumb
FROM wp_buDIJ_posts p
JOIN wp_buDIJ_term_relationships tr ON tr.object_id=p.ID
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_brand'
JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
WHERE p.post_type='product' AND t.name LIKE '%EMINENCE%'
ORDER BY p.post_status DESC, p.ID;