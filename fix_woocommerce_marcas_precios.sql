-- Correcciones WooCommerce (2026-11-18)
-- 1) Tremboplex 100 mg (14649): marca LANDERLAN (198) y precio 84.99
DELETE FROM wp_buDIJ_term_relationships WHERE object_id=14649 AND term_taxonomy_id IN (199,200);
INSERT IGNORE INTO wp_buDIJ_term_relationships (object_id, term_taxonomy_id, term_order) VALUES (14649,198,0);
UPDATE wp_buDIJ_postmeta SET meta_value='84.99' WHERE post_id=14649 AND meta_key IN ('_regular_price','_price');

-- 2) Quitar el termino padre MARCAS (199) de todos los productos
DELETE FROM wp_buDIJ_term_relationships WHERE term_taxonomy_id=199;

-- 3) Marca primaria de Rank Math: 199 (MARCAS) -> marca hija
UPDATE wp_buDIJ_postmeta pm
JOIN (
  SELECT tr.object_id, MIN(tt.term_id) AS term_id
  FROM wp_buDIJ_term_relationships tr
  JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy='product_brand' AND tt.parent<>0
  GROUP BY tr.object_id
) b ON b.object_id = pm.post_id
SET pm.meta_value = b.term_id
WHERE pm.meta_key='rank_math_primary_product_brand' AND pm.meta_value='199';

-- 4) Testoplex-E 300 mg (14643): precio 44.99 -> 74.99
UPDATE wp_buDIJ_postmeta SET meta_value='74.99' WHERE post_id=14643 AND meta_key IN ('_regular_price','_price');