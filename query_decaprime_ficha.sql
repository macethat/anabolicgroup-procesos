SELECT t.term_id, t.name AS term, t.slug, tt.term_taxonomy_id, tt.taxonomy
FROM wp_buDIJ_terms t
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_id=t.term_id
WHERE tt.taxonomy='product_brand' AND (t.name LIKE '%EMINENCE%' OR t.slug LIKE '%eminence%');

SELECT p.ID, p.post_title, p.post_status, p.post_name, p.post_excerpt,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_thumbnail_id') AS thumb,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS precio,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_stock') AS stock
FROM wp_buDIJ_posts p WHERE p.ID=14491;

SELECT p.ID, p.post_title FROM wp_buDIJ_posts p WHERE p.ID=14993;