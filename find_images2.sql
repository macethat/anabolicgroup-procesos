SELECT p.ID, p.post_title, p.post_status FROM wp_buDIJ_posts p
JOIN wp_buDIJ_postmeta m ON m.post_id=p.ID AND m.meta_key='_thumbnail_id' AND m.meta_value='14789'
WHERE p.post_type='product';
SELECT '--- adjuntos hcg / trembo ---' AS x;
SELECT a.ID, a.post_title,
       (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=a.ID AND meta_key='_wp_attached_file') AS archivo
FROM wp_buDIJ_posts a
WHERE a.post_type='attachment' AND (a.post_title LIKE '%HCG%' OR a.post_title LIKE '%TREMBOLONA%' OR a.post_title LIKE '%TREN%');
