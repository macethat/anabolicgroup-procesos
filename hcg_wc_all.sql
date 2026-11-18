SELECT p.ID, p.post_title, p.post_name, p.post_status,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_price') AS price,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_stock') AS qty,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_thumbnail_id') AS thumb
FROM wp_buDIJ_posts p
WHERE p.post_type='product' AND p.post_status <> 'trash'
  AND (p.post_title LIKE '%HCG%' OR p.post_title LIKE '%Gonadotrop%' OR p.post_title LIKE '%Hormoprime%');
