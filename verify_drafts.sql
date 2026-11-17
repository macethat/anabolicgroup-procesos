SELECT p.ID, p.post_title, p.post_status AS estado,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS reg,
  (SELECT t.name FROM wp_buDIJ_term_relationships tr
     JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_brand' AND tt.parent<>0
     JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
     WHERE tr.object_id=p.ID LIMIT 1) AS marca
FROM wp_buDIJ_posts p
WHERE p.ID IN (14995,14962,14601,14326,14508,14318,14315)
ORDER BY p.ID;