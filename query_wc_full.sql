SELECT p.ID, p.post_title AS name, p.post_name AS slug, p.post_status AS status,
  (SELECT t.name FROM wp_buDIJ_term_relationships tr
     JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_brand' AND tt.parent<>0
     JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
     WHERE tr.object_id=p.ID LIMIT 1) AS brand,
  (SELECT GROUP_CONCAT(t.name SEPARATOR ' | ') FROM wp_buDIJ_term_relationships tr
     JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_cat'
     JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
     WHERE tr.object_id=p.ID) AS cats,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock_status') AS stock_status,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock') AS stock,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS price,
  (SELECT att.meta_value FROM wp_buDIJ_postmeta att
     WHERE att.post_id=(SELECT pm2.meta_value FROM wp_buDIJ_postmeta pm2 WHERE pm2.post_id=p.ID AND pm2.meta_key='_thumbnail_id')
       AND att.meta_key='_wp_attached_file') AS image,
  LENGTH(p.post_excerpt) AS exc_len, LENGTH(p.post_content) AS content_len
FROM wp_buDIJ_posts p
WHERE p.post_type='product' AND p.post_status IN ('publish','draft','trash','pending','private')
ORDER BY p.post_title;