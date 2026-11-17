SELECT p.ID, p.post_title,
  SUBSTRING(p.post_content, LOCATE('<table', p.post_content), 600) AS tabla
FROM wp_buDIJ_posts p
WHERE p.ID IN (15425, 15415, 15413, 15244)
  AND p.post_content LIKE '%<table%';