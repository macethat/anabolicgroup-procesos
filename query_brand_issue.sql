SELECT '--- terminos con marcas ---' AS x;
SELECT t.term_id, t.name, t.slug, tt.taxonomy, tt.parent, tt.count
FROM wp_buDIJ_terms t
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_id = t.term_id
WHERE t.name LIKE '%marcas%' OR t.slug LIKE '%marcas%';

SELECT '--- productos con relacion al term 199 (MARCAS) ---' AS x;
SELECT COUNT(*) AS total FROM wp_buDIJ_term_relationships WHERE term_taxonomy_id = 199;

SELECT '--- rank_math primary brand ---' AS x;
SELECT meta_value, COUNT(*) AS n FROM wp_buDIJ_postmeta
WHERE meta_key = 'rank_math_primary_product_brand' GROUP BY meta_value;

SELECT '--- 14649 brand rels ---' AS x;
SELECT tr.term_taxonomy_id, t.name
FROM wp_buDIJ_term_relationships tr
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id = tr.term_taxonomy_id AND tt.taxonomy='product_brand'
JOIN wp_buDIJ_terms t ON t.term_id = tt.term_id
WHERE tr.object_id = 14649;