SELECT ID, SUBSTRING(post_content,1,320) AS inicio, SUBSTRING(post_content, LOCATE('Uso Referencial', post_content), 260) AS aviso
FROM wp_buDIJ_posts WHERE ID IN (14511,14995) ORDER BY ID;