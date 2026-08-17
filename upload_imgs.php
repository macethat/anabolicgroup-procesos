<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
require_once ABSPATH . 'wp-admin/includes/image.php';
require_once ABSPATH . 'wp-admin/includes/file.php';
require_once ABSPATH . 'wp-admin/includes/media.php';

// [local_path, titulo, alt, caption, descripcion]
$files = array(
    array('/home/abgroup/web/anabolicgroup.com/retatrutide-10mg.jpg', 'Retatrutide 10mg', 'Retatrutide 10mg triple agonista metabolico', 'Retatrutide 10 mg - triple agonista GLP-1/GIP/Glucagon', 'Retatrutide 10 mg para control de peso y optimizacion metabolica'),
    array('/home/abgroup/web/anabolicgroup.com/retatrutide-60mg.jpg', 'Retatrutide 60mg', 'Retatrutide 60mg triple agonista metabolico', 'Retatrutide 60 mg - triple agonista GLP-1/GIP/Glucagon', 'Retatrutide 60 mg para control de peso y optimizacion metabolica'),
);

foreach ($files as $f) {
    list($path, $titulo, $alt, $caption, $desc) = $f;
    if (!file_exists($path)) { echo "NO EXISTE: $path\n"; continue; }

    $filetype = wp_check_filetype(basename($path), null);
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
        'post_content' => $desc,
        'post_excerpt' => $caption,
    ));
    update_post_meta($attach_id, '_wp_attachment_image_alt', $alt);

    echo "Subida: ID=$attach_id | " . basename($path) . " | alt='$alt'\n";
}
echo "DONE\n";
