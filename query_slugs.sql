SELECT ID, post_name, post_title, post_status
FROM wp_buDIJ_posts
WHERE post_type='product'
  AND (ID IN (14511,14502,14508,14995)
    OR post_name IN ('metaprime-10-mg-dianabol','klenprime-60-mcg','lioprime-25-mcg','hormoprime-hcg-5000-ui','metaprime-10-mg','klenprime-0-60-mg','lioprime-25-mcg','hormoprime'))
ORDER BY ID;