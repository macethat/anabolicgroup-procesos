SELECT post_id, meta_key, LEFT(meta_value, 200) AS mv FROM wp_buDIJ_postmeta WHERE meta_key IN ('_elementor_conditions','hfe_template_conditions') LIMIT 30;
