SELECT ID, post_title, post_status, post_date, post_type FROM wp_buDIJ_posts WHERE ID IN (14992, 14993) ORDER BY ID;

SELECT post_id, meta_key, meta_value FROM wp_buDIJ_postmeta
WHERE post_id IN (14992, 14993)
  AND meta_key IN ('_regular_price','_sale_price','_thumbnail_id','_sku','_stock','_stock_status','_wp_attached_file','_wp_attachment_metadata')
ORDER BY post_id, meta_key;

SELECT tr.object_id, t.name AS brand
FROM wp_buDIJ_term_relationships tr
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_brand'
JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
WHERE tr.object_id IN (14992, 14577, 14491);