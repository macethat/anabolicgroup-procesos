-- Revertir Semaglutide 5mg (15256) a su precio original 120.00
UPDATE wp_buDIJ_postmeta SET meta_value='120.00' WHERE post_id=15256 AND meta_key IN ('_regular_price','_price');