<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
require_once ABSPATH . 'wp-admin/includes/image.php';
require_once ABSPATH . 'wp-admin/includes/file.php';
require_once ABSPATH . 'wp-admin/includes/media.php';

$pid      = 14491;
$img_path = '/home/abgroup/web/anabolicgroup.com/decaprime-1000.jpg';

$attach_id = media_handle_sideload(array(
    'name' => 'decaprime-npp-100-mg.jpg',
    'tmp_name' => $img_path,
), 0);

if (is_wp_error($attach_id)) {
    echo "ERROR subiendo imagen: " . $attach_id->get_error_message() . "\n";
    exit(1);
}

wp_update_post(array(
    'ID' => $attach_id,
    'post_title' => 'Decaprime NPP 100 mg',
    'post_content' => 'Decaprime NPP 100 mg - nandrolona fenilpropionato (NPP) de Eminence Labs',
    'post_excerpt' => 'Decaprime NPP 100 mg - nandrolona fenilpropionato (NPP)',
));
update_post_meta($attach_id, '_wp_attachment_image_alt', 'Decaprime NPP 100 mg nandrolona fenilpropionato Eminence Labs');

update_post_meta($pid, '_thumbnail_id', $attach_id);

$res = wp_set_object_terms($pid, array(201), 'product_brand');
if (is_wp_error($res)) {
    echo "ERROR marca: " . $res->get_error_message() . "\n";
} else {
    echo "Marca EMINENCE asignada (term 201)\n";
}

wc_delete_product_transients($pid);
wc_update_product_lookup_tables();

echo "Imagen subida: ID=$attach_id\n";
echo "Thumbnail asignado a $pid\n";
echo "DONE\n";