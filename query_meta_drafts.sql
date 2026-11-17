SELECT post_id, meta_key, meta_value FROM wp_buDIJ_postmeta
WHERE post_id IN (14995,14962,14601) AND meta_key IN ('_regular_price','_price','_sale_price','_stock','_stock_status','_manage_stock','_price')
ORDER BY post_id, meta_key;