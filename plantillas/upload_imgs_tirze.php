<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
require_once ABSPATH . 'wp-admin/includes/image.php';
require_once ABSPATH . 'wp-admin/includes/file.php';
require_once ABSPATH . 'wp-admin/includes/media.php';

$files = array(
    array('/home/abgroup/web/anabolicgroup.com/tirzepatide-15mg.jpg', 'Tirzepatide 15mg', 'Tirzepatide 15mg triple agonista GIP/GLP-1 metabolico', 'Tirzepatide 15 mg - triple agonista GIP/GLP-1', 'Tirzepatide 15 mg para control de peso y optimizacion metabolica'),
    array('/home/abgroup/web/anabolicgroup.com/tirzepatide-60mg.jpg', 'Tirzepatide 60mg', 'Tirzepatide 60mg triple agonista GIP/GLP-1 metabolico', 'Tirzepatide 60 mg - triple agonista GIP/GLP-1', 'Tirzepatide 60 mg para control de peso y optimizacion metabolica'),
);

foreach ($files as $f) {
    list($path, $titulo, $alt, $caption, $descripcion) = $f;
    if (!file_exists($path)) { echo "NO EXISTE: $path\n"; continue; }

    $attach_id = media_handle_sideload(array(
        'name' => basename($path),
        'tmp_name' => $path,
    ), 0);

    if (is_wp_error($attach_id)) {
        echo "ERROR subiendo " . basename($path) . ": " . $attach_id->get_error_message() . "\n";
        continue;
    }

    wp_update_post(array(
        'ID' => $attach_id,
        'post_title' => $titulo,
        'post_content' => $descripcion,
        'post_excerpt' => $caption,
    ));
    update_post_meta($attach_id, '_wp_attachment_image_alt', $alt);

    echo "Subida: ID=$attach_id | " . basename($path) . " | alt='$alt'\n";
}
echo "DONE\n";