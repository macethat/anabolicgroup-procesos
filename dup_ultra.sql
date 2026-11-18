SELECT id, code, name, slug, price, stock_status, is_published, image, wc_id
FROM products WHERE slug IN ('clenbutrex-ultra-0-60-mg','clembuterol-ultra-0-60mcg') OR name LIKE '%Ultra%';
