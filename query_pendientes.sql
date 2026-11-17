SELECT p.ID, p.post_title, p.post_status
FROM wp_buDIJ_posts p
WHERE p.post_type='product'
  AND (p.post_title LIKE '%iothy%' OR p.post_title LIKE '% T3%' OR p.post_title LIKE '%T3 %'
   OR p.post_title LIKE '%arber%' OR p.post_title LIKE '%MOST%' OR p.post_title LIKE '%MOTS%'
   OR p.post_title LIKE '%CLEMBUTEBOL%' OR p.post_title LIKE '%Stanozolol 50%'
   OR p.post_title LIKE '%BPC-157%' OR p.post_title LIKE '%Stanozolol 50mg%')
ORDER BY p.post_status, p.post_title;