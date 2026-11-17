SELECT p.ID, p.post_title, p.post_status AS estado,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_regular_price') AS reg,
  (SELECT pm.meta_value FROM wp_buDIJ_postmeta pm WHERE pm.post_id=p.ID AND pm.meta_key='_price') AS price
FROM wp_buDIJ_posts p
WHERE p.ID IN (14483,14668,14487,14489,14495,14501,14326,14508,14344,14318,14512,14513,14515,14315,14547,14548,14053,14083,14557,14095,15199,14577,14001,15193,14600,14613,14274,14283,14632,14447,14653,14995,14962,14601)
ORDER BY p.ID;