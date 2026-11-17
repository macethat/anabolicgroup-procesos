SELECT option_name, LEFT(option_value, 2000) AS valor
FROM wp_buDIJ_options
WHERE option_name IN ('custom_css_and_customized_css', 'custom_css', 'theme_mods_nutritix')
OR option_name LIKE 'custom_css%'
OR option_name LIKE '%elementor%global%css%'
OR option_name LIKE '%extra_css%';

SELECT ID, post_title, post_type, post_status
FROM wp_buDIJ_posts
WHERE post_type = 'custom_css'
ORDER BY ID;

SELECT o.option_name, LEFT(o.option_value, 3000) AS valor
FROM wp_buDIJ_options o
WHERE o.option_name IN ('elementor_css_print_method', 'elementor_active_kit')
   OR o.option_name LIKE 'elementor_global_css';