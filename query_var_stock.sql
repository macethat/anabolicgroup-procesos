SELECT vp.post_parent AS padre,
  SUM(CAST(vm_stock.meta_value AS DECIMAL)) AS stock_total,
  MIN(CAST(vm_price.meta_value AS DECIMAL)) AS precio_min,
  MAX(CAST(vm_price.meta_value AS DECIMAL)) AS precio_max
FROM wp_buDIJ_posts vp
JOIN wp_buDIJ_postmeta vm_stock ON vm_stock.post_id=vp.ID AND vm_stock.meta_key='_stock'
JOIN wp_buDIJ_postmeta vm_price ON vm_price.post_id=vp.ID AND vm_price.meta_key='_regular_price'
WHERE vp.post_type='product_variation' AND vp.post_status='publish'
GROUP BY vp.post_parent;