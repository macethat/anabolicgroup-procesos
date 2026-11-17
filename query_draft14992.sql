SELECT p.ID, p.post_title, p.post_status,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_thumbnail_id') AS thumb,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS precio,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock') AS stock
FROM wp_buDIJ_posts p WHERE p.ID=14992;

SELECT COUNT(*) AS relaciones FROM wp_buDIJ_term_relationships tr
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id
WHERE tr.object_id=14992 AND tt.taxonomy IN ('product_cat','product_brand');