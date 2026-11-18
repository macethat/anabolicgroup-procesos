SELECT p.code, p.name, p.slug, p.price, p.is_published, p.image,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.wc_id AND meta_key='_thumbnail_id') AS wc_thumb
FROM products p WHERE p.slug IN ('decaprime-npp-100-mg','chorionic-gonadotrophin');
SELECT '--- adjuntos ---' AS x;
SELECT p.ID, p.post_title,
 (SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_price') AS price,
 (SELECT att.meta_value FROM wp_buDIJ_postmeta att
   WHERE att.post_id=(SELECT meta_value FROM wp_buDIJ_postmeta WHERE post_id=p.ID AND meta_key='_thumbnail_id')
     AND att.meta_key='_wp_attached_file') AS img
FROM wp_buDIJ_posts p WHERE p.post_type='product'
 AND (p.post_title LIKE '%DECAPRIME%' OR p.post_title LIKE '%HORMOPRIME%' OR p.post_title LIKE '%HCG%');
