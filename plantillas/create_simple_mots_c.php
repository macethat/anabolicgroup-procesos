<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
require_once ABSPATH . 'wp-admin/includes/image.php';
require_once ABSPATH . 'wp-admin/includes/file.php';
require_once ABSPATH . 'wp-admin/includes/media.php';

$precio     = '160.00';
$stock      = 100;
$estado     = 'instock';
$nombre     = 'MOTS-C 40mg';
$slug       = 'mots-c-40mg';
$img_path   = '/home/abgroup/web/anabolicgroup.com/mots-c-40mg.jpg';
$img_title  = 'MOTS-C 40mg';
$img_alt    = 'MOTS-C 40mg peptido mitocondrial VMS Molecular Science';
$img_caption= 'MOTS-C 40 mg - péptido mitocondrial regulador metabólico';
$img_desc   = 'MOTS-C 40mg péptido mitocondrial de VMS Molecular Science para salud metabolica y longevidad';
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
<h2>MOTS-C 40mg: Salud Metabólica y Longevidad Celular</h2>
<p>El <b>MOTS-C 40mg</b> de la marca <b>VMS Molecular Science</b> es un péptido mitocondrial codificado en el ADN mitocondrial que actúa como un regulador metabólico de amplio espectro. Promueve la actividad de la proteína AMPK, clave en la homeostasis energética, la sensibilidad a la insulina y la oxidación de grasas, convirtiéndolo en uno de los péptidos más estudiados en investigaciones sobre salud metabólica, composición corporal y longevidad.</p>

<h3>Beneficios Principales</h3>
<ul>
<li><b>Homeostasis Metabólica:</b> A través de la activación de AMPK favorece el balance energético, la captación de glucosa y una mejor sensibilidad a la insulina.</li>
<li><b>Oxidación de Grasas:</b> Estimula la utilización de ácidos grasos como fuente de energía, apoyando la pérdida de tejido adiposo y la preservación de masa muscular.</li>
<li><b>Ejercicio y Resistencia:</b> Contribuye a la adaptación metabólica al ejercicio, ayudando a aumentar la resistencia y la capacidad de entrenamiento.</li>
<li><b>Salud Mitocondrial:</b> Apoya la función y densidad de las mitocondrias, asociadas a mayor energía y a procesos de envejecimiento saludable.</li>
</ul>

<h3>Ficha Técnica y Especificaciones</h3>
<table>
<thead>
<tr><td><strong>Característica</strong></td><td><strong>Detalle</strong></td></tr>
</thead>
<tbody>
<tr><td><strong>Concentración</strong></td><td>40 mg</td></tr>
<tr><td><strong>Formato</strong></td><td>Vial con liofilizado (polvo seco para reconstituir)</td></tr>
<tr><td><strong>Clase</strong></td><td>Péptido mitocondrial (Mitochondrial Open Reading Frame)</td></tr>
<tr><td><strong>Marca</strong></td><td>VMS Molecular Science</td></tr>
<tr><td><strong>Pureza</strong></td><td>&gt;98% (Grado de investigación / farmacéutico)</td></tr>
<tr><td><strong>Almacenamiento</strong></td><td>Refrigerado entre 2°C y 8°C. Proteger de la luz.</td></tr>
</tbody>
</table>

<h4>Usos en Investigación</h4>
<p>El MOTS-C se estudia por su papel en la regulación del metabolismo energético, la activación de AMPK, la sensibilidad a la insulina, la oxidación de lípidos y los mecanismos asociados al envejecimiento saludable y a la función muscular.</p>

<h4>Disclaimer:</h4>
<p>Este producto se distribuye con fines informativos y/o de investigación. Su uso debe ser evaluado, prescrito y supervisado por un profesional de la salud calificado. No automedicarse. Su uso está supeditado a la completa responsabilidad del comprador.</p>
HTML;

$excerpt = '<b>MOTS-C 40mg</b> péptido mitocondrial de la marca <b>VMS Molecular Science</b> para la salud metabólica, la oxidación de grasas y la longevidad celular.';

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