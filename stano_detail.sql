SELECT p.ID, p.post_title, p.post_status,
 LEFT(REPLACE(REPLACE(p.post_excerpt,'\n',' '),'\r',' '), 300) AS extracto,
 LEFT(REPLACE(REPLACE(p.post_content,'\n',' '),'\r',' '), 500) AS contenido,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_price') AS price,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_stock') AS qty,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_stock_status') AS stock,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_weight') AS peso,
 (SELECT GROUP_CONCAT(t.name SEPARATOR ' | ') FROM wp_buDIJ_term_relationships tr
   JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_cat'
   JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id WHERE tr.object_id=p.ID) AS cat
FROM wp_buDIJ_posts p
WHERE p.ID IN (14546,14523,14579,14850,14578,14280,14236);
