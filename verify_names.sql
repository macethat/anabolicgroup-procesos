SELECT COUNT(*) AS productos,
       SUM(name = UPPER(name)) AS todo_mayusculas,
       SUM(name REGEXP '[0-9](mg|mcg|ml|comp|tab)\\b') AS unidad_pegada
FROM products;
SELECT code, name FROM products WHERE name IN ('Klenprime 0.40 mg','Boldenona Undecilenato','Clembutrex 0.40 mg','HCG 5000 UI','AOD9604 10 mg');
SELECT product_id, label FROM presentations ORDER BY product_id, sort_order;
