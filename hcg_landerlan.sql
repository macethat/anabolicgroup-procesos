SELECT code, name, slug, price, is_published, image, wc_id, wc_url FROM products WHERE code='LAN-REC-018';
SELECT '--- WC: todos los HCG ---' AS x;
SELECT p.ID, p.post_title, p.post_name, p.post_status,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_price') AS price,
 (SELECT GROUP_CONCAT(t.name SEPARATOR ' | ') FROM wp_buDIJ_term_relationships tr
   JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_brand'
   JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id WHERE tr.object_id=p.ID) AS marca
FROM wp_buDIJ_posts p WHERE p.post_type='product' AND p.post_status <> 'trash'
 AND (p.post_title LIKE '%HCG%' OR p.post_title LIKE '%Gonadotrop%' OR p.post_title LIKE '%Hormoprime%');
