SELECT p.ID, p.post_title,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_thumbnail_id') AS thumb,
 (SELECT att.meta_value FROM wp_buDIJ_postmeta att
   WHERE att.post_id=(SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_thumbnail_id')
     AND att.meta_key='_wp_attached_file') AS archivo,
 (SELECT att.post_title FROM wp_buDIJ_posts att
   WHERE att.ID=(SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_thumbnail_id')) AS titulo_img
FROM wp_buDIJ_posts p
WHERE p.post_type='product' AND (p.post_title LIKE '%stanoz%' OR p.post_title LIKE '%stanoprime%')
  AND p.post_status <> 'trash' ORDER BY p.post_title;
