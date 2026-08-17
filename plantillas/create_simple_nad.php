<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
require_once ABSPATH . 'wp-admin/includes/image.php';
require_once ABSPATH . 'wp-admin/includes/file.php';
require_once ABSPATH . 'wp-admin/includes/media.php';

$precio     = '140.00';
$stock      = 100;
$estado     = 'instock';
$nombre     = 'NAD+ 500mg';
$slug       = 'nad-500mg';
$img_path   = '/home/abgroup/web/anabolicgroup.com/nad-500mg.jpg';
$img_title  = 'NAD+ 500mg';
$img_alt    = 'NAD+ 500mg nicotinamida adenina dinucleotido para energia celular';
$img_caption= 'NAD+ 500 mg - nicotinamida adenina dinucleótido';
$img_desc   = 'NAD+ 500mg nicotinamida adenina dinucleotido de VMS Molecular Science';
$cats  = array(205, 206);
$brand = array(208);

$attach_id = media_handle_sideload(array(
    'name' => basename($img_path),
    'tmp_name' => $img_path,
), 0);
if (is_wp_error($attach_id)) {
    echo "ERROR subiendo imagen: " . $attach_id->get_error_message() . "\n";
    $attach_id = 0;
} else {
    wp_update_post(array(
        'ID' => $attach_id,
        'post_title' => $img_title,
        'post_content' => $img_desc,
        'post_excerpt' => $img_caption,
    ));
    update_post_meta($attach_id, '_wp_attachment_image_alt', $img_alt);
    echo "Imagen subida: ID=$attach_id\n";
}

$content = <<<HTML
<h2>NAD+ 500mg: Energía Celular y Vitalidad Avanzada</h2>
<p>El <b>NAD+ 500mg</b> (Nicotinamida Adenina Dinucleótido) de la marca <b>VMS Molecular Science</b> es una coenzima esencial que participa en la producción de energía celular y en los procesos de reparación del ADN. Con el paso del tiempo los niveles de NAD+ disminuyen de forma natural, y su suplementación es uno de los campos de investigación más activos en salud y longevidad, asociado a mayor energía, mejor rendimiento cognitivo y vitalidad general.</p>

<h3>Beneficios Principales</h3>
<ul>
<li><b>Producción de Energía Celular:</b> Favorece la síntesis de ATP, la principal moneda energética de las células, combatiendo el cansancio y la fatiga.</li>
<li><b>Reparación del ADN:</b> Apoya la activación de las sirtuinas, implicadas en la reparación celular y en la protección contra el estrés oxidativo.</li>
<li><b>Rendimiento Cognitivo:</b> Contribuye a la claridad mental y al mantenimiento de la función neuronal.</li>
<li><b>Vitalidad y Longevidad:</b> Es uno de los compuestos más estudiados en investigaciones sobre salud, energía y envejecimiento saludable.</li>
</ul>

<h3>Ficha Técnica y Especificaciones</h3>
<table>
<thead>
<tr><td><strong>Característica</strong></td><td><strong>Detalle</strong></td></tr>
</thead>
<tbody>
<tr><td><strong>Concentración</strong></td><td>500 mg</td></tr>
<tr><td><strong>Formato</strong></td><td>Vial con liofilizado (polvo seco para reconstituir)</td></tr>
<tr><td><strong>Clase</strong></td><td>Coenzima NAD+ (Nicotinamida Adenina Dinucleótido)</td></tr>
<tr><td><strong>Marca</strong></td><td>VMS Molecular Science</td></tr>
<tr><td><strong>Pureza</strong></td><td>&gt;98% (Grado de investigación / farmacéutico)</td></tr>
<tr><td><strong>Almacenamiento</strong></td><td>Refrigerado entre 2°C y 8°C después de reconstituir. Proteger de la luz.</td></tr>
</tbody>
</table>

<h4>Usos en Investigación</h4>
<p>El NAD+ se estudia por su papel en la producción de energía celular, la reparación del ADN, la activación de sirtuinas y los procesos vinculados al envejecimiento saludable y al rendimiento cognitivo.</p>

<h4>Disclaimer:</h4>
<p>Este producto se distribuye con fines informativos y/o de investigación. Su uso debe ser evaluado, prescrito y supervisado por un profesional de la salud calificado. No automedicarse. Su uso está supeditado a la completa responsabilidad del comprador.</p>
HTML;

$excerpt = '<b>NAD+ 500mg</b> coenzima de la marca <b>VMS Molecular Science</b> para la producción de energía celular, la reparación del ADN y la vitalidad general.';

$pid = wp_insert_post(array(
    'post_title'    => $nombre,
    'post_name'     => $slug,
    'post_content'  => $content,
    'post_excerpt'  => $excerpt,
    'post_status'   => 'publish',
    'post_type'     => 'product',
    'comment_status'=> 'closed',
    'ping_status'   => 'closed',
), true);
if (is_wp_error($pid)) { echo "ERROR creando producto: " . $pid->get_error_message() . "\n"; exit(1); }
echo "Producto creado: ID=$pid\n";

wp_set_object_terms($pid, $cats, 'product_cat');
wp_set_object_terms($pid, $brand, 'product_brand');
wp_set_object_terms($pid, 'simple', 'product_type');

update_post_meta($pid, '_regular_price', $precio);
update_post_meta($pid, '_price', $precio);
update_post_meta($pid, '_manage_stock', 'yes');
update_post_meta($pid, '_stock', $stock);
update_post_meta($pid, '_stock_status', $estado);
update_post_meta($pid, '_backorders', 'no');
update_post_meta($pid, '_sold_individually', 'no');
update_post_meta($pid, '_virtual', 'no');
update_post_meta($pid, '_downloadable', 'no');
update_post_meta($pid, '_featured', 'no');
update_post_meta($pid, '_visibility', 'visible');
if ($attach_id) update_post_meta($pid, '_thumbnail_id', $attach_id);
update_post_meta($pid, '_product_version', '10.9.4');

if (function_exists('wc_delete_product_transients')) { wc_delete_product_transients($pid); }
if (function_exists('wc_update_product_lookup_tables')) { wc_update_product_lookup_tables(); }

echo "DONE: $nombre creado, precio=$precio stock=$stock img=$attach_id\n";