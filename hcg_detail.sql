SELECT p.ID, p.post_title, p.post_status,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_price') AS price,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_stock') AS qty,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_stock_status') AS stock,
 (SELECT GROUP_CONCAT(t.name SEPARATOR ' | ') FROM wp_buDIJ_term_relationships tr
   JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_cat'
   JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id WHERE tr.object_id=p.ID) AS cat
FROM wp_buDIJ_posts p WHERE p.ID=14995;
