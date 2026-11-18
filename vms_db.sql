SELECT p.code, p.name, p.slug, p.price, p.stock_status, p.is_published,
  (SELECT GROUP_CONCAT(CONCAT(label,' ',FORMAT(price,2)) ORDER BY sort_order SEPARATOR ' | ')
   FROM presentations WHERE product_id=p.id) AS pres
FROM products p JOIN brands b ON b.id=p.brand_id
WHERE b.name='VMS' ORDER BY p.name;
