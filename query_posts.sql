SELECT COUNT(*) AS total FROM wp_buDIJ_posts WHERE ID IN (4949,5252,71061,124808,124818,124828,124841,124852,124863,124877,124888,124899,124933,124942);
SELECT ID, post_title, post_type FROM wp_buDIJ_posts WHERE post_type IN ('elementor-hf','elementor_library','wp_template') AND post_status='publish';
