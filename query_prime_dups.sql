SELECT p.ID, p.post_title, p.post_status AS estado,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS precio
FROM wp_buDIJ_posts p
WHERE p.post_type='product'
  AND (p.post_title LIKE '%prime%' OR p.post_title LIKE '%hormoprime%' OR p.post_title LIKE '%metaprime%')
ORDER BY p.post_title;