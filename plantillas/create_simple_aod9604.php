<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
require_once ABSPATH . 'wp-admin/includes/image.php';
require_once ABSPATH . 'wp-admin/includes/file.php';
require_once ABSPATH . 'wp-admin/includes/media.php';

// ============ CONFIGURACION ============
$precio     = '150.00';
$stock      = 100;
$estado     = 'instock';
$nombre     = 'AOD9604 10mg';
$slug       = 'aod9604-10mg';
$img_path   = '/home/abgroup/web/anabolicgroup.com/aod9604-10mg.jpg';
$img_title  = 'AOD9604 10mg';
$img_alt    = 'AOD9604 10mg péptido de crecimiento metabólico';
$img_caption= 'AOD9604 10 mg - fragmento lipolítico del péptido de crecimiento';
$img_desc   = 'AOD9604 10 mg péptido para la oxidación de grasa y metabolismo';
// categorias/term_ids existentes (ver Semaglutide 15256): 205 Peptidos, 206 Inyectables, 208 VMS brand
$cats  = array(205, 206);
$brand = array(208);
// ========================================

// 1. Subir imagen
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

// 2. Crear producto
$content = <<<HTML
<h2>AOD9604 10mg: Oxidación de Grasa y Metabolismo Acelerado</h2>
<p>El <b>AOD9604 10mg</b> (Fragmento AOD de la Hormona del Crecimiento) es un péptido de la marca <b>VMS Molecular Science</b>, diseñado específicamente para estimular la lipólisis y acelerar la oxidación de las grasas. A diferencia de otros compuestos metabólicos, AOD9604 imita los efectos termogénicos del HGH sin afectar los niveles de glucosa ni la secreción de insulina, lo que lo convierte en una opción segura y eficaz para la recomposición corporal.</p>

<h3>¿Qué Hace que AOD9604 sea Diferente?</h3>
<ul>
<li><b>Acción Lipolítica Selectiva:</b> Estimula la movilización de los triglicéridos almacenados para que sean utilizados como fuente de energía, sin comprometer la masa magra.</li>
<li><b>Sin Efecto sobre la Glucosa:</b> A diferencia de los agonistas GLP-1, AOD9604 actúa directamente sobre la lipólisis sin afectar la secreción de insulina ni los niveles de azúcar en sangre.</li>
<li><b>Aumento del Metabolismo Basal:</b> Favorece un mayor gasto energético en reposo, potenciando los resultados de cualquier plan de entrenamiento y nutrición.</li>
<li><b>Supresión del Almacenamiento de Grasa:</b> Reduce la acumulación de tejido adiposo, especialmente en zonas difíciles como el abdomen y los glúteos.</li>
</ul>

<h3>Ficha Técnica y Especificaciones</h3>
<table>
<thead>
<tr><td><strong>Característica</strong></td><td><strong>Detalle</strong></td></tr>
</thead>
<tbody>
<tr><td><strong>Concentración</strong></td><td>10 mg</td></tr>
<tr><td><strong>Formato</strong></td><td>Vial con liofilizado (polvo seco para reconstituir)</td></tr>
<tr><td><strong>Clase</strong></td><td>Fragmento lipolítico del péptido de crecimiento (HGH frag 176-191)</td></tr>
<tr><td><strong>Marca</strong></td><td>VMS Molecular Science</td></tr>
<tr><td><strong>Pureza</strong></td><td>&gt;98% (Grado de investigación / farmacéutico)</td></tr>
<tr><td><strong>Almacenamiento</strong></td><td>Refrigerado entre 2°C y 8°C después de reconstituir. Proteger de la luz.</td></tr>
</tbody>
</table>

<h4>Usos en Investigación y Fitness</h4>
<p>AOD9604 se utiliza en protocolos de investigación vinculados a la pérdida de peso, la reducción de porcentaje de grasa corporal y la mejora del rendimiento metabólico. Es especialmente apreciado en la comunidad fitness por su perfil de acción limpia, sin interferencias hormonales significativas.</p>

<h4>Disclaimer:</h4>
<p>Este producto se distribuye con fines informativos y/o de investigación. Su uso debe ser evaluado, prescrito y supervisado por un profesional de la salud calificado. No automedicarse. Su uso está supeditado a la completa responsabilidad del comprador.</p>
HTML;

$excerpt = '<b>AOD9604 10mg</b> péptido de la marca <b>VMS Molecular Science</b> para la oxidación de grasa y la aceleración del metabolismo, sin afectar los niveles de glucosa.';

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

// 3. Asignar categorias / marca / tipo
wp_set_object_terms($pid, $cats, 'product_cat');
wp_set_object_terms($pid, $brand, 'product_brand');
wp_set_object_terms($pid, 'simple', 'product_type');

// 4. Metas de producto
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

// 5. Limpiar transients de producto
if (function_exists('wc_delete_product_transients')) { wc_delete_product_transients($pid); }
if (function_exists('wc_update_product_lookup_tables')) { wc_update_product_lookup_tables(); }

echo "DONE: $nombre creado, precio=$precio stock=$stock img=$attach_id\n";