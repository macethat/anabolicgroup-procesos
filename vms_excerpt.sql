SELECT p.name, LEFT(p.excerpt, 260) AS excerpt, CHAR_LENGTH(p.excerpt) AS largo
FROM products p JOIN brands b ON b.id=p.brand_id
WHERE b.name='VMS' ORDER BY p.name;
SELECT '--- largo de excerpt por marca ---' AS x;
SELECT b.name, MIN(CHAR_LENGTH(p.excerpt)) AS minimo, MAX(CHAR_LENGTH(p.excerpt)) AS maximo,
       ROUND(AVG(CHAR_LENGTH(p.excerpt))) AS promedio
FROM products p JOIN brands b ON b.id=p.brand_id GROUP BY b.name;
