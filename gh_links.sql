SELECT ID, post_title, post_name, post_status,
  (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_price') AS price
FROM wp_buDIJ_posts p
WHERE p.post_type='product' AND (p.post_title LIKE '%Gentropin%' OR p.post_title LIKE '%Hutrope%')
  AND p.post_status <> 'trash';
