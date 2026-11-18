SELECT option_name, option_value FROM wp_buDIJ_options
WHERE option_name IN ('siteurl','home','permalink_structure','woocommerce_permalinks','woocommerce_shop_page_id');
SELECT '--- productos ---' AS x;
SELECT ID, post_name, post_title, post_status FROM wp_buDIJ_posts
WHERE post_type='product' AND post_status NOT IN ('trash','auto-draft') ORDER BY ID;
