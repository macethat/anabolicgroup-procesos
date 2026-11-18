SELECT t.term_id, t.name, t.slug, tt.term_taxonomy_id, tt.parent, tt.count
FROM wp_buDIJ_terms t
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_id = t.term_id
WHERE tt.taxonomy = 'product_brand'
ORDER BY tt.parent, t.name;

SELECT '--- 14649 brand ---' AS x;
SELECT tr.term_taxonomy_id, t.name
FROM wp_buDIJ_term_relationships tr
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id = tr.term_taxonomy_id AND tt.taxonomy='product_brand'
JOIN wp_buDIJ_terms t ON t.term_id = tt.term_id
WHERE tr.object_id = 14649;

SELECT '--- 14643 precio ---' AS x;
SELECT pm.meta_key, pm.meta_value FROM wp_buDIJ_postmeta pm
WHERE pm.post_id = 14643 AND pm.meta_key IN ('_regular_price','_price','_sale_price');

SELECT '--- 14649 precio ---' AS x;
SELECT pm.meta_key, pm.meta_value FROM wp_buDIJ_postmeta pm
WHERE pm.post_id = 14649 AND pm.meta_key IN ('_regular_price','_price','_sale_price');