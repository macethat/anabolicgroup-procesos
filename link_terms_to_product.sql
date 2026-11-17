INSERT IGNORE INTO wp_buDIJ_term_relationships (object_id, term_taxonomy_id, term_order) VALUES
(15229, 210, 0),
(15229, 211, 1),
(15229, 212, 2);
UPDATE wp_buDIJ_term_taxonomy SET count = (SELECT COUNT(*) FROM wp_buDIJ_term_relationships WHERE term_taxonomy_id = 210) WHERE term_taxonomy_id = 210;
UPDATE wp_buDIJ_term_taxonomy SET count = (SELECT COUNT(*) FROM wp_buDIJ_term_relationships WHERE term_taxonomy_id = 211) WHERE term_taxonomy_id = 211;
UPDATE wp_buDIJ_term_taxonomy SET count = (SELECT COUNT(*) FROM wp_buDIJ_term_relationships WHERE term_taxonomy_id = 212) WHERE term_taxonomy_id = 212;