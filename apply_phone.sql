-- Actualizar _elementor_data por SQL directo (NO usar update_post_meta)
UPDATE wp_buDIJ_postmeta
SET meta_value = REPLACE(REPLACE(REPLACE(meta_value,
    '6405-9959', '6099-0195'),
    '64059959', '60990195'),
    '50764059959', '50760990195')
WHERE meta_key = '_elementor_data'
  AND (meta_value LIKE '%6405%');

-- Actualizar post_content por SQL directo
UPDATE wp_buDIJ_posts
SET post_content = REPLACE(REPLACE(REPLACE(post_content,
    '6405-9959', '6099-0195'),
    '64059959', '60990195'),
    '50764059959', '50760990195')
WHERE ID IN (3784, 414, 13263)
  AND post_content LIKE '%6405%';
