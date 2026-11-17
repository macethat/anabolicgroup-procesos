UPDATE wp_buDIJ_posts SET post_status='trash' WHERE ID=14992;
SELECT ID, post_title, post_status FROM wp_buDIJ_posts WHERE ID=14992;
SELECT meta_id FROM wp_buDIJ_term_relationships WHERE object_id=14992 LIMIT 10;