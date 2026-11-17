SELECT p.ID, p.post_title AS nombre, p.post_status AS estado,
  (SELECT t.name FROM wp_buDIJ_term_relationships tr
     JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_brand' AND tt.parent<>0
     JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
     WHERE tr.object_id=p.ID LIMIT 1) AS marca,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS precio
FROM wp_buDIJ_posts p
WHERE p.ID IN (14483,14668,14487,14489,14495,14501,14326,14508,14344,14318,14512,14513,14515,14315,14547,14548,14053,14083,14557,14095,15199,14577,14001,15193,14600,14613,14274,14283,14632,14447,14653,14995,14962,14601)
ORDER BY p.ID;