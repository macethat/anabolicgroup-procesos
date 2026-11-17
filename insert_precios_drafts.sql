-- Insertar precio a drafts que no tenian fila de meta (2026-10-20)

-- CHORIONIC GONADOTROPHIN (14995) = 64.99
INSERT INTO wp_buDIJ_postmeta (post_id, meta_key, meta_value)
SELECT 14995, '_regular_price', '64.99' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM wp_buDIJ_postmeta WHERE post_id=14995 AND meta_key='_regular_price');
INSERT INTO wp_buDIJ_postmeta (post_id, meta_key, meta_value)
SELECT 14995, '_price', '64.99' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM wp_buDIJ_postmeta WHERE post_id=14995 AND meta_key='_price');

-- TESTOLAND DEPOT 200 MG (14962) = 74.99
INSERT INTO wp_buDIJ_postmeta (post_id, meta_key, meta_value)
SELECT 14962, '_regular_price', '74.99' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM wp_buDIJ_postmeta WHERE post_id=14962 AND meta_key='_regular_price');
INSERT INTO wp_buDIJ_postmeta (post_id, meta_key, meta_value)
SELECT 14962, '_price', '74.99' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM wp_buDIJ_postmeta WHERE post_id=14962 AND meta_key='_price');