SELECT tr.object_id, tr.term_taxonomy_id, t.name, t.slug, tt.taxonomy
FROM wp_buDIJ_term_relationships tr
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id
JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
WHERE tr.object_id=15229;
SELECT tr.object_id, tr.term_taxonomy_id, t.name, tt.taxonomy, tt.count
FROM wp_buDIJ_term_relationships tr
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id
JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
WHERE tr.term_taxonomy_id IN (SELECT term_taxonomy_id FROM wp_buDIJ_term_taxonomy WHERE term_id IN (210,211,212));