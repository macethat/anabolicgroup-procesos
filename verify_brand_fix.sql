SELECT '--- primary brand ---' AS x;
SELECT meta_value, COUNT(*) AS n FROM wp_buDIJ_postmeta WHERE meta_key='rank_math_primary_product_brand' GROUP BY meta_value;
SELECT '--- 14649 brand ---' AS x;
SELECT tr.term_taxonomy_id, t.name FROM wp_buDIJ_term_relationships tr
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_brand'
JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id WHERE tr.object_id=14649;
SELECT '--- precios ---' AS x;
SELECT post_id, meta_key, meta_value FROM wp_buDIJ_postmeta WHERE post_id IN (14643,14649) AND meta_key IN ('_regular_price','_price') ORDER BY post_id, meta_key;