SELECT p.ID, p.post_title AS nombre,
  COALESCE((SELECT t.name FROM wp_buDIJ_term_relationships tr
     JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_brand' AND tt.parent<>0
     JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
     WHERE tr.object_id=p.ID LIMIT 1),'') AS marca,
  (SELECT GROUP_CONCAT(t.name SEPARATOR ' / ') FROM wp_buDIJ_term_relationships tr
     JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_cat'
     JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
     WHERE tr.object_id=p.ID) AS cats
FROM wp_buDIJ_posts p
WHERE p.post_type='product' AND p.post_status='publish'
ORDER BY p.post_title;