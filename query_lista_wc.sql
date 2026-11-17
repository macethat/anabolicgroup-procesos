SELECT p.ID, p.post_title AS nombre, p.post_status AS estado,
  (SELECT t.name FROM wp_buDIJ_term_relationships tr
     JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_brand' AND tt.parent<>0
     JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
     WHERE tr.object_id=p.ID LIMIT 1) AS marca
FROM wp_buDIJ_posts p
WHERE p.post_type='product'
  AND p.post_status IN ('publish','draft','trash','pending','private','future')
ORDER BY marca, p.post_status, p.post_title;