-- Actualizacion de precios segun maestro Numbers (Lista_Anabolicgroup_Maestra)
-- 2026-08-29  -  productos simples publicados con match confirmado

-- 1. Mastaplex 100 mg (XTLABS) [MASTEPLEX - P] 47.99 -> 64.99
UPDATE wp_buDIJ_postmeta SET meta_value='64.99' WHERE post_id=14614 AND meta_key IN ('_regular_price','_price');

-- 2. Trembolona Acetato 100 mg (XTLABS) [TREMBOPLEX ACETATO] 65.99 -> 74.99
UPDATE wp_buDIJ_postmeta SET meta_value='74.99' WHERE post_id=14364 AND meta_key IN ('_regular_price','_price');

-- 3. Clenbutrex Ultra 0.60 mg (XTLABS) [CLEMBUTEROL ULTRA 0.60MCG] 51.99 -> 64.99
UPDATE wp_buDIJ_postmeta SET meta_value='64.99' WHERE post_id=14603 AND meta_key IN ('_regular_price','_price');

-- 4. Arimidex 1 mg Anastrozol (XTLABS) [ARIMIDEXT 1MG] 48.99 -> 59.99
UPDATE wp_buDIJ_postmeta SET meta_value='59.99' WHERE post_id=14293 AND meta_key IN ('_regular_price','_price');

-- 5. Clenbutrex HCL 0.40 mg (XTLABS) [CLEMBUTEROL 0.40MCG] 48.99 -> 59.99
UPDATE wp_buDIJ_postmeta SET meta_value='59.99' WHERE post_id=14602 AND meta_key IN ('_regular_price','_price');

-- 6. Boldenona 250 mg (LANDERLAN) [Boldenona 200mg Gold] 58.99 -> 64.99
UPDATE wp_buDIJ_postmeta SET meta_value='64.99' WHERE post_id=14556 AND meta_key IN ('_regular_price','_price');

-- 7. Testosterona Propionato 100 mg (LANDERLAN) [Testo Propionato x10ml] 30.23 -> 64.99
UPDATE wp_buDIJ_postmeta SET meta_value='64.99' WHERE post_id=14580 AND meta_key IN ('_regular_price','_price');

-- 8. Trembolona Enantato 200 mg (LANDERLAN) [Trembolona Enantato Gold] 64.99 -> 74.99
UPDATE wp_buDIJ_postmeta SET meta_value='74.99' WHERE post_id=14599 AND meta_key IN ('_regular_price','_price');

-- 9. Semaglutide 5mg (VMS) 120.00 -> 110.00
UPDATE wp_buDIJ_postmeta SET meta_value='110.00' WHERE post_id=15256 AND meta_key IN ('_regular_price','_price');

-- 10. Stanozoland 50 mg - 15 ml (LANDERLAN) [Stanozolol 50mg - 15ml] 38.99 -> 64.99
UPDATE wp_buDIJ_postmeta SET meta_value='64.99' WHERE post_id=14850 AND meta_key IN ('_regular_price','_price');

-- 11. Decaprime NPP 100 mg (EMINENCE) [Nandrolona (NPP) 100mg] 51.99 -> 59.99
UPDATE wp_buDIJ_postmeta SET meta_value='59.99' WHERE post_id=14491 AND meta_key IN ('_regular_price','_price');