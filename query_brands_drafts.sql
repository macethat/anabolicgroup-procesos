SELECT p.ID, p.post_title,
  GROUP_CONCAT(DISTINCT CONCAT(tt.taxonomy,':',IFNULL(t.name,'')) ORDER BY tt.taxonomy SEPARATOR ' | ') AS terminos
FROM wp_buDIJ_posts p
LEFT JOIN wp_buDIJ_term_relationships tr ON tr.object_id=p.ID
LEFT JOIN wp_buDIJ_term_taxonomy tt ON tt.term_taxonomy_id=tr.term_taxonomy_id AND tt.taxonomy LIKE '%brand%'
LEFT JOIN wp_buDIJ_terms t ON t.term_id=tt.term_id
WHERE p.ID IN (14833,14835,14837,14839,14841,14843,15188,15190,15193,15197,15199,15206,14558,14559,14566,14601,14458,14460,14461,14462,14463,14464,14465,14466,14467,14468,14469)
GROUP BY p.ID
ORDER BY p.ID;