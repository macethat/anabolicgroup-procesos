-- ============================================================
-- PLANTILLA: FIXES POST-CREACION de producto variable (PASO 5)
-- Reemplazar <PADRE>, <TT_10MG>, <TT_30MG>, <TT_60MG> por IDs reales
-- Ejecutar: wp db query < fix_variable.sql --path=public_html
-- ============================================================

-- a) Invalidar transient de atributos globales (impediria registrar
--    la taxonomia pa_ en el front -> tbody vacio, sin selector)
DELETE FROM wp_buDIJ_options
WHERE option_name IN ('_transient_wc_attribute_taxonomies','_transient_timeout_wc_attribute_taxonomies');

-- b) Asociar terminos al producto padre (sin esto el dropdown sale VACIO,
--    o muestra solo "Elige una opcion")
--    NOTA: usar los term_taxonomy_id de los terminos (== term_id usualmente)
INSERT IGNORE INTO wp_buDIJ_term_relationships (object_id, term_taxonomy_id, term_order) VALUES
(<PADRE>, <TT_10MG>, 0),
(<PADRE>, <TT_30MG>, 1),
(<PADRE>, <TT_60MG>, 2);

--    Actualizar count de cada termino (primer INSERT es para term_taxonomy_id 210)
UPDATE wp_buDIJ_term_taxonomy SET count=(SELECT COUNT(*) FROM wp_buDIJ_term_relationships WHERE term_taxonomy_id=<TT_10MG>) WHERE term_taxonomy_id=<TT_10MG>;
UPDATE wp_buDIJ_term_taxonomy SET count=(SELECT COUNT(*) FROM wp_buDIJ_term_relationships WHERE term_taxonomy_id=<TT_30MG>) WHERE term_taxonomy_id=<TT_30MG>;
UPDATE wp_buDIJ_term_taxonomy SET count=(SELECT COUNT(*) FROM wp_buDIJ_term_relationships WHERE term_taxonomy_id=<TT_60MG>) WHERE term_taxonomy_id=<TT_60MG>;

-- c) Stock del PADRE en instock (quedo 'outofstock' del producto simple;
--    causa badge "Out of Stock" junto al titulo aunque haya variaciones)
UPDATE wp_buDIJ_postmeta SET meta_value='instock'
WHERE post_id=<PADRE> AND meta_key='_stock_status';

-- d) (opcional) Verificacion
SELECT tr.object_id, t.name, t.slug FROM wp_buDIJ_term_relationships tr
JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id
JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
WHERE tr.object_id=<PADRE>;