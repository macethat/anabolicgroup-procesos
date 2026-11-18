SELECT p.ID, p.post_title,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_thumbnail_id') AS thumb,
 (SELECT att.meta_value FROM wp_buDIJ_postmeta att
   WHERE att.post_id=(SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_thumbnail_id')
     AND att.meta_key='_wp_attached_file') AS img
FROM wp_buDIJ_posts p WHERE p.ID IN (14995, 15199);
