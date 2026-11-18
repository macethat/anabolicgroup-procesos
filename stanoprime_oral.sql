SELECT p.ID, p.post_title, p.post_status,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_price') AS price,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_regular_price') AS regular,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_stock') AS qty,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_stock_status') AS stock,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_thumbnail_id') AS thumb,
 (SELECT att.meta_value FROM wp_buDIJ_postmeta att
   WHERE att.post_id=(SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_thumbnail_id')
     AND att.meta_key='_wp_attached_file') AS img,
 (SELECT GROUP_CONCAT(t.name SEPARATOR ' | ') FROM wp_buDIJ_term_relationships tr
   JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_cat'
   JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id WHERE tr.object_id=p.ID) AS cat,
 (SELECT GROUP_CONCAT(t.name SEPARATOR ' | ') FROM wp_buDIJ_term_relationships tr
   JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_brand'
   JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id WHERE tr.object_id=p.ID) AS marca
FROM wp_buDIJ_posts p WHERE p.ID IN (14523);
