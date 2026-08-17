<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
require_once ABSPATH . 'wp-admin/includes/image.php';
require_once ABSPATH . 'wp-admin/includes/file.php';
require_once ABSPATH . 'wp-admin/includes/media.php';

$precio     = '160.00';
$stock      = 100;
$estado     = 'instock';
$nombre     = 'GLOW 70mg';
$slug       = 'glow-70mg';
$img_path   = '/home/abgroup/web/anabolicgroup.com/glow-70mg.jpg';
$img_title  = 'GLOW 70mg';
$img_alt    = 'GLOW 70mg péptido de vainilla glow up';
$img_caption= 'GLOW 70 mg - complejo de péptidos de lucidez (GHK-Cu, BPC-157, TB-500)';
$img_desc   = 'GLOW 70 mg complejo de péptidos para la recuperación, piel y bienestar de VMS Molecular Science';
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
<h2>GLOW 70mg: la Sinergia de Péptidos para la Recuperación y la Vitalidad</h2>
<p>El <b>GLOW 70mg</b> de la marca <b>VMS Molecular Science</b> es un complejo de péptidos diseñado para promover la recuperación profunda, la salud de la piel y el bienestar general. Su fórmula combina la acción regenerativa del <b>GHK-Cu</b> con los beneficios reparadores de <b>BPC-157</b> y <b>TB-500</b>, creando un protocolo integral ideal para la regeneración de tejidos y el mantenimiento de la salud celular.</p>

<h3>Principales Beneficios del Complejo</h3>
<ul>
<li><b>Regeneración y Reparación de Tejidos:</b> La combinación de BPC-157 y TB-500 acelera la recuperación de músculos, tendones y ligamentos tras entrenamientos intensos o lesiones.</li>
<li><b>Salud y Elasticidad de la Piel:</b> El GHK-Cu estimula la producción de colágeno y elastina, mejorando la firmeza, la hidratación y la apariencia general de la piel.</li>
<li><b>Antiinflamatorio Natural:</b> Ayuda a reducir la inflamación sistémica y el dolor articular, favoreciendo una recuperación más rápida y completa.</li>
<li><b>Bienestar Integral y Energía:</b> Apoya la regulación de los procesos celulares responsables de la vitalidad, el ánimo y la calidad del sueño.</li>
</ul>

<h3>Ficha Técnica y Especificaciones</h3>
<table>
<thead>
<tr><td><strong>Característica</strong></td><td><strong>Detalle</strong></td></tr>
</thead>
<tbody>
<tr><td><strong>Concentración</strong></td><td>70 mg (por vial)</td></tr>
<tr><td><strong>Contenido</strong></td><td>Complejo GLOW con péptidos (GHK-Cu, BPC-157, TB-500)</td></tr>
<tr><td><strong>Formato</strong></td><td>Vial con liofilizado (polvo seco para reconstituir)</td></tr>
<tr><td><strong>Clase</strong></td><td>Complejo de péptidos regenerativos</td></tr>
<tr><td><strong>Marca</strong></td><td>VMS Molecular Science</td></tr>
<tr><td><strong>Pureza</strong></td><td>&gt;98% (Grado de investigación / farmacéutico)</td></tr>
<tr><td><strong>Almacenamiento</strong></td><td>Refrigerado entre 2°C y 8°C después de reconstituir. Proteger de la luz.</td></tr>
</tbody>
</table>

<h4>Usos en Investigación y Bienestar</h4>
<p>GLOW 70mg se utiliza en protocolos de investigación enfocados en la regeneración tisular, la salud de la piel, la recuperación deportiva y el estado general de bienestar. Es especialmente valorado en la comunidad de biohacking y salud regenerativa.</p>

<h4>Disclaimer:</h4>
<p>Este producto se distribuye con fines informativos y/o de investigación. Su uso debe ser evaluado, prescrito y supervisado por un profesional de la salud calificado. No automedicarse. Su uso está supeditado a la completa responsabilidad del comprador.</p>
HTML;

$excerpt = '<b>GLOW 70mg</b> complejo de péptidos <b>VMS Molecular Science</b> para la recuperación, la salud de la piel y el bienestar general.';

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