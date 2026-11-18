SELECT p.ID, p.post_title,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_thumbnail_id') AS principal,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_product_image_gallery') AS galeria
FROM wp_buDIJ_posts p
WHERE p.post_type='product' AND (p.post_title LIKE '%stanoz%' OR p.post_title LIKE '%stanoprime%' OR p.post_title LIKE '%stanoplex%')
  AND p.post_status <> 'trash' ORDER BY p.post_title;
