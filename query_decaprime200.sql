SELECT p.ID, p.post_title, p.post_status, p.post_name,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS precio,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock') AS stock,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_sku') AS sku,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_thumbnail_id') AS thumb
FROM wp_buDIJ_posts p
WHERE p.ID = 14493;

SELECT tr.object_id, t.name AS brand
FROM wp_buDIJ_term_relationships tr
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_brand'
JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
WHERE tr.object_id = 14493;

SELECT ID, post_title, post_status FROM wp_buDIJ_posts
WHERE post_title LIKE '%DECAPRIME%' OR post_title LIKE '%Decaprime%'
ORDER BY post_title;