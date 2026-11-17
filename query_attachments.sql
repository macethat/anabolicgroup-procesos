SELECT p.ID, p.post_title, p.post_mime_type,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_wp_attached_file') AS archivo
FROM wp_buDIJ_posts p
WHERE p.ID IN (14316,14319,14324,14686,14996) AND p.post_type='attachment'
ORDER BY p.ID;