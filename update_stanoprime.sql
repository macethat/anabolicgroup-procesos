-- Stanoprime 50 mg (14546): precio 59.99 y agotado
UPDATE wp_buDIJ_postmeta SET meta_value='59.99' WHERE post_id=14546 AND meta_key IN ('_regular_price','_price');
UPDATE wp_buDIJ_postmeta SET meta_value='0' WHERE post_id=14546 AND meta_key='_stock';
UPDATE wp_buDIJ_postmeta SET meta_value='outofstock' WHERE post_id=14546 AND meta_key='_stock_status';