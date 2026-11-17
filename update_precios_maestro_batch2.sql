-- Actualizacion de precios segun maestro Numbers (lote 2) - confirmados por marca
-- 2026-08-29

-- 1. Cloprime 50 mg (EMINENCE) [Clomifeno 50mg x50 comp] 46.99 -> 49.99
UPDATE wp_buDIJ_postmeta SET meta_value='49.99' WHERE post_id=14487 AND meta_key IN ('_regular_price','_price');

-- 2. Metenolona Enantato 100 mg (LANDERLAN) [Primoboland Enantato Gold] 83.12 -> 99.99
UPDATE wp_buDIJ_postmeta SET meta_value='99.99' WHERE post_id=14773 AND meta_key IN ('_regular_price','_price');

-- 3. Metandrostenolona 10 mg (LANDERLAN) [Dianabol 10mg x100 comp] 47.99 -> 64.99
UPDATE wp_buDIJ_postmeta SET meta_value='64.99' WHERE post_id=14044 AND meta_key IN ('_regular_price','_price');

-- 4. OXANDROLAND 10mg (LANDERLAN) [Oxandrolona 10mg x50 comp] 57.93 -> 74.99
UPDATE wp_buDIJ_postmeta SET meta_value='74.99' WHERE post_id=14050 AND meta_key IN ('_regular_price','_price');