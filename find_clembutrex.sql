SELECT p.ID, p.post_title, p.post_name, p.post_mime_type,
       (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_wp_attached_file') AS archivo
FROM wp_buDIJ_posts p
WHERE p.post_type='attachment'
  AND (p.post_title LIKE '%clemb%' OR p.post_name LIKE '%clemb%' OR p.guid LIKE '%clemb%');
SELECT '--- productos clembutrex ---' AS x;
SELECT p.ID, p.post_title, p.post_status,
       (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_thumbnail_id') AS thumb
FROM wp_buDIJ_posts p WHERE p.post_type='product' AND p.post_title LIKE '%clemb%';
