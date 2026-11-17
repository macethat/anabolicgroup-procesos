<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
require_once ABSPATH . 'wp-admin/includes/image.php';
require_once ABSPATH . 'wp-admin/includes/file.php';
require_once ABSPATH . 'wp-admin/includes/media.php';

$path = '/home/abgroup/web/anabolicgroup.com/tirzepatide-10mg.jpg';

$attach_id = media_handle_sideload(array(
    'name' => 'tirzepatide-10mg.jpg',
    'tmp_name' => $path,
), 0);

if (is_wp_error($attach_id)) {
    echo "ERROR: " . $attach_id->get_error_message() . "\n";
    exit(1);
}

wp_update_post(array(
    'ID' => $attach_id,
    'post_title' => 'Tirzepatide 10mg',
    'post_content' => 'Tirzepatide 10 mg para control de peso y optimizacion metabolica - triple agonista GIP/GLP-1',
    'post_excerpt' => 'Tirzepatide 10 mg - triple agonista GIP/GLP-1',
));
update_post_meta($attach_id, '_wp_attachment_image_alt', 'Tirzepatide 10mg triple agonista GIP/GLP-1 metabolico');

echo "ID=$attach_id\n";
echo "DONE\n";