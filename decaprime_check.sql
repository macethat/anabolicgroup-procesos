SELECT p.ID, p.post_title, p.post_status,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_price') AS price,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_stock') AS qty,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_stock_status') AS stock,
 (SELECT att.meta_value FROM wp_buDIJ_postmeta att
   WHERE att.post_id=(SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_thumbnail_id')
     AND att.meta_key='_wp_attached_file') AS img,
 LEFT(p.post_excerpt,200) AS extracto
FROM wp_buDIJ_posts p WHERE p.post_type='product'
 AND (p.post_title LIKE '%DECAPRIME%' OR p.post_title LIKE '%DACAPRIME%');
