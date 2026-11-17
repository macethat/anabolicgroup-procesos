SELECT p.ID, p.post_title, p.post_status AS estado,
  LENGTH(p.post_content) AS len_cont, LENGTH(p.post_excerpt) AS len_exc,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS precio,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_thumbnail_id') AS thumb,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock') AS stock,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock_status') AS stock_status,
  (SELECT att.meta_value FROM wp_buDIJ_postmeta att WHERE att.post_id=(SELECT pm2.meta_value FROM wp_buDIJ_postmeta pm2 WHERE pm2.post_id=p.ID AND pm2.meta_key='_thumbnail_id') AND att.meta_key='_wp_attached_file') AS imagen
FROM wp_buDIJ_posts p
WHERE p.ID IN (14315,14318,14326,14508,14995,14546,14511,14502,15206)
ORDER BY p.ID;