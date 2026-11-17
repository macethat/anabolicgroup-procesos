SELECT p.ID, p.post_title, p.post_status FROM wp_buDIJ_posts p
WHERE p.post_type='product' AND (p.post_title LIKE '%MOT%' OR p.post_title LIKE '%MITOCH%')
ORDER BY p.post_title;