SELECT p.ID, p.post_title, p.post_name AS slug, p.post_status AS estado,
  LENGTH(p.post_content) AS len_cont, LENGTH(p.post_excerpt) AS len_exc,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS precio,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='rank_math_title') AS seo_title,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='rank_math_focus_keyword') AS seo_kw
FROM wp_buDIJ_posts p
WHERE p.ID IN (14511,14502,14508,14995,14315,14318,14326,15206,14546)
ORDER BY p.ID;