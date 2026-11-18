SELECT COUNT(*) AS mayusculas_totales FROM products WHERE BINARY name = BINARY UPPER(name);
SELECT COUNT(*) AS unidades_pegadas FROM products WHERE BINARY name REGEXP '[0-9](mg|mcg|ml|comp|tab)$';
SELECT name FROM products ORDER BY id;
