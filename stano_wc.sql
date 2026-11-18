SELECT p.ID, p.post_title, p.post_name, p.post_status,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_price') AS price,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_stock_status') AS stock,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_stock') AS qty
FROM wp_buDIJ_posts p
WHERE p.post_type='product' AND (p.post_title LIKE '%stanoz%' OR p.post_title LIKE '%stanoprime%' OR p.post_title LIKE '%stanoplex%')
  AND p.post_status <> 'trash'
ORDER BY p.post_title;
