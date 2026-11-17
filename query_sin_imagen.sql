SELECT p.ID, p.post_title, p.post_type, p.post_status,
  COALESCE(NULLIF((SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_thumbnail_id'),''),'(none)') AS thumbnail,
  CASE
    WHEN NOT EXISTS (SELECT 1 FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_thumbnail_id' AND pm.meta_value<>'') THEN 'SIN_IMAGEN_META'
    WHEN NOT EXISTS (SELECT 1 FROM wp_buDIJ_posts a JOIN wp_buDIJ_postmeta pm2 ON pm2.post_id=p.ID AND pm2.meta_key='_thumbnail_id' AND pm2.meta_value<>'' WHERE a.ID=pm2.meta_value AND a.post_type='attachment') THEN 'THUMB_INVALIDO'
    ELSE 'OK'
  END AS estado_img
FROM wp_buDIJ_posts p
WHERE p.post_type IN ('product','product_variation')
  AND (
    NOT EXISTS (SELECT 1 FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_thumbnail_id' AND pm.meta_value<>'')
    OR
    NOT EXISTS (SELECT 1 FROM wp_buDIJ_posts a JOIN wp_buDIJ_postmeta pm2 ON pm2.post_id=p.ID AND pm2.meta_key='_thumbnail_id' AND pm2.meta_value<>'' WHERE a.ID=pm2.meta_value AND a.post_type='attachment')
  )
ORDER BY p.post_status DESC, p.post_type, p.ID;