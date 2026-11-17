SELECT tr.term_taxonomy_id, tt.taxonomy, t.name, t.slug
FROM wp_buDIJ_term_relationships tr
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id
JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
WHERE tr.object_id=15256
ORDER BY tt.taxonomy, t.slug;