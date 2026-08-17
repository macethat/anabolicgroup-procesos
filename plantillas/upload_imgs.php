<?php
// ============================================================
// PLANTILLA: Subir imagenes de presentaciones con SEO
// Subir la plantilla + los JPG a /home/abgroup/web/anabolicgroup.com/
// Ejecutar: php upload_imgs.php
// Anotar los attachment_id devueltos -> usarlos en make_variable.php
// ============================================================
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
require_once ABSPATH . 'wp-admin/includes/image.php';
require_once ABSPATH . 'wp-admin/includes/file.php';
require_once ABSPATH . 'wp-admin/includes/media.php';

// ============ CONFIGURACION ============
// [path_en_servidor, titulo, alt, caption, descripcion]
$files = array(
    array('/home/abgroup/web/anabolicgroup.com/producto-10mg.jpg', 'Producto 10mg', 'Producto 10mg alt SEO', 'Producto 10 mg - caption', 'Producto 10 mg descripcion'),
    array('/home/abgroup/web/anabolicgroup.com/producto-60mg.jpg', 'Producto 60mg', 'Producto 60mg alt SEO', 'Producto 60 mg - caption', 'Producto 60 mg descripcion'),
);
// ========================================

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