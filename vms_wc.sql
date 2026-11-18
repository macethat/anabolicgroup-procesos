SELECT t.term_id, t.name, t.slug, tt.taxonomy, tt.parent FROM wp_buDIJ_terms t
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_id=t.term_id
WHERE t.name LIKE '%VMS%' OR t.slug LIKE '%vms%';
SELECT '--- productos VMS ---' AS x;
SELECT p.ID, p.post_title, p.post_name, p.post_status,
  (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_price') AS price,
  (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_stock_status') AS stock,
  (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_product_attributes') AS attrs
FROM wp_buDIJ_posts p
WHERE p.post_type='product' AND p.post_status <> 'trash'
  AND p.ID IN (SELECT tr.object_id FROM wp_buDIJ_term_relationships tr
               JOIN wp_buDIJ_term_taxonomy tt2 ON tt2.term_taxonomy_id=tr.term_taxonomy_id
               JOIN wp_buDIJ_terms t2 ON t2.term_id=tt2.term_id
               WHERE t2.name LIKE '%VMS%')
ORDER BY p.post_title;
