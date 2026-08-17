<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
require_once ABSPATH . 'wp-admin/includes/image.php';
require_once ABSPATH . 'wp-admin/includes/file.php';
require_once ABSPATH . 'wp-admin/includes/media.php';

$cats  = array(205, 206);   // Peptidos, Inyectables
$brand = array(208);        // VMS

// ============ PRODUCTOS ============
// [precio, stock, nombre, slug, img_path, alt, caption, desc_img, excerpt_intro, h2, intro, beneficios[], concentracion, clase, usos]
$productos = array(
    array(
        'precio' => '150.00', 'stock' => 100, 'estado' => 'instock',
        'nombre' => 'CJC1295 (Without DAC) 10mg', 'slug' => 'cjc1295-without-dac-10mg',
        'img' => '/home/abgroup/web/anabolicgroup.com/cjc1295-without-dac-10mg.jpg',
        'img_alt' => 'CJC1295 Without DAC 10mg péptido de liberación de la hormona del crecimiento',
        'img_caption' => 'CJC1295 Without DAC 10 mg - péptido liberador de la hormona de crecimiento',
        'img_desc' => 'CJC1295 Without DAC 10mg péptido GHRH de VMS Molecular Science',
        'excerpt' => '<b>CJC1295 (Without DAC) 10mg</b> péptido de la marca <b>VMS Molecular Science</b> que estimula la liberación endógena de la hormona del crecimiento.',
        'content' => <<<HTML
<h2>CJC1295 (Without DAC) 10mg: Estimulador Natural de la Hormona del Crecimiento</h2>
<p>El <b>CJC1295 (Without DAC) 10mg</b> de <b>VMS Molecular Science</b> es un péptido GHRH que actúa estimulando la liberación endógena de la hormona del crecimiento (GH) en el organismo. Sin el DAC, ofrece una semi-vida más corta con pulsos de GH más naturales, lo que lo convierte en una opción práctica para protocolos de investigación enfocados en la recuperación, la composición corporal y el bienestar anabólico.</p>

<h3>Beneficios Principales</h3>
<ul>
<li><b>Picos de GH Más Naturales:</b> Favorece la secreción pulsátil de la hormona del crecimiento, imitando los patrones fisiológicos del cuerpo.</li>
<li><b>Recuperación Acelerada:</b> Apoya la reparación de tejidos y la recuperación tras el esfuerzo físico.</li>
<li><b>Mejora de la Composición Corporal:</b> Contribuye a la pérdida de grasa y al mantenimiento de la masa magra.</li>
<li><b>Bienestar General:</b> Favorece la calidad del sueño, la vitalidad y la salud metabólica.</li>
</ul>

<h3>Ficha Técnica y Especificaciones</h3>
<table>
<thead>
<tr><td><strong>Característica</strong></td><td><strong>Detalle</strong></td></tr>
</thead>
<tbody>
<tr><td><strong>Concentración</strong></td><td>10 mg</td></tr>
<tr><td><strong>Formato</strong></td><td>Vial con liofilizado (polvo seco para reconstituir)</td></tr>
<tr><td><strong>Clase</strong></td><td>Péptido liberador de la hormona del crecimiento (GHRH), sin DAC</td></tr>
<tr><td><strong>Marca</strong></td><td>VMS Molecular Science</td></tr>
<tr><td><strong>Pureza</strong></td><td>&gt;98% (Grado de investigación / farmacéutico)</td></tr>
<tr><td><strong>Almacenamiento</strong></td><td>Refrigerado entre 2°C y 8°C después de reconstituir. Proteger de la luz.</td></tr>
</tbody>
</table>

<h4>Usos en Investigación</h4>
<p>CJC1295 (Without DAC) se utiliza en estudios relacionados con la secreción de la hormona del crecimiento, la recuperación muscular, la densidad ósea y la composición corporal.</p>

<h4>Disclaimer:</h4>
<p>Este producto se distribuye con fines informativos y/o de investigación. Su uso debe ser evaluado, prescrito y supervisado por un profesional de la salud calificado. No automedicarse. Su uso está supeditado a la completa responsabilidad del comprador.</p>
HTML
    ),
    array(
        'precio' => '130.00', 'stock' => 100, 'estado' => 'instock',
        'nombre' => 'IPAMORELIN 10mg', 'slug' => 'ipamorelin-10mg',
        'img' => '/home/abgroup/web/anabolicgroup.com/ipamorelin-10mg.jpg',
        'img_alt' => 'IPAMORELIN 10mg péptido secretagogo de la hormona del crecimiento',
        'img_caption' => 'IPAMORELIN 10 mg - secretagogo de la hormona de crecimiento',
        'img_desc' => 'IPAMORELIN 10mg péptido secretagogo de VMS Molecular Science',
        'excerpt' => '<b>IPAMORELIN 10mg</b> péptido de la marca <b>VMS Molecular Science</b> que estimula la liberación de la hormona del crecimiento de forma selectiva y segura.',
        'content' => <<<HTML
<h2>IPAMORELIN 10mg: Secretagogo Selectivo de la Hormona del Crecimiento</h2>
<p>El <b>IPAMORELIN 10mg</b> de <b>VMS Molecular Science</b> es un péptido secretagogo que estimula la liberación de la hormona del crecimiento (GH) de manera selectiva, sin afectar significativamente los niveles de cortisol ni del hambre. Su perfil de acción limpio lo convierte en uno de los péptidos más utilizados en protocolos de investigación sobre envejecimiento saludable, recuperación y composición corporal.</p>

<h3>Beneficios Principales</h3>
<ul>
<li><b>Secreción Selectiva de GH:</b> Estimula la GH sin elevar el cortisol, ofreciendo un perfil de acción más cómodo.</li>
<li><b>Mejora de la Recuperación:</b> Acelera la recuperación muscular y favorece la reparación de tejidos.</li>
<li><b>Composición Corporal:</b> Promueve la pérdida de grasa y el mantenimiento de la masa magra.</li>
<li><b>Bienestar y Sueño:</b> Asociado a una mejor calidad del sueño y una mayor vitalidad.</li>
</ul>

<h3>Ficha Técnica y Especificaciones</h3>
<table>
<thead>
<tr><td><strong>Característica</strong></td><td><strong>Detalle</strong></td></tr>
</thead>
<tbody>
<tr><td><strong>Concentración</strong></td><td>10 mg</td></tr>
<tr><td><strong>Formato</strong></td><td>Vial con liofilizado (polvo seco para reconstituir)</td></tr>
<tr><td><strong>Clase</strong></td><td>Péptido secretagogo de la hormona del crecimiento (GHRP)</td></tr>
<tr><td><strong>Marca</strong></td><td>VMS Molecular Science</td></tr>
<tr><td><strong>Pureza</strong></td><td>&gt;98% (Grado de investigación / farmacéutico)</td></tr>
<tr><td><strong>Almacenamiento</strong></td><td>Refrigerado entre 2°C y 8°C después de reconstituir. Proteger de la luz.</td></tr>
</tbody>
</table>

<h4>Usos en Investigación</h4>
<p>IPAMORELIN se estudia por su capacidad de estimular la secreción de GH, la recuperación deportiva, la ganancia de masa magra y la reducción de grasa corporal.</p>

<h4>Disclaimer:</h4>
<p>Este producto se distribuye con fines informativos y/o de investigación. Su uso debe ser evaluado, prescrito y supervisado por un profesional de la salud calificado. No automedicarse. Su uso está supeditado a la completa responsabilidad del comprador.</p>
HTML
    ),
    array(
        'precio' => '160.00', 'stock' => 100, 'estado' => 'instock',
        'nombre' => 'TB500 10mg', 'slug' => 'tb500-10mg',
        'img' => '/home/abgroup/web/anabolicgroup.com/tb500-10mg.jpg',
        'img_alt' => 'TB500 10mg péptido de recuperación y reparación de tejidos',
        'img_caption' => 'TB500 10 mg - péptido de recuperación y reparación',
        'img_desc' => 'TB500 10mg péptido de recuperación de VMS Molecular Science',
        'excerpt' => '<b>TB500 10mg</b> péptido de la marca <b>VMS Molecular Science</b> orientado a la recuperación y a la reparación de tejidos.',
        'content' => <<<HTML
<h2>TB500 10mg: Recuperación y Reparación de Tejidos</h2>
<p>El <b>TB500 10mg</b> (Thymosin Beta-4) de <b>VMS Molecular Science</b> es un péptido sintético conocido por su capacidad de acelerar la recuperación y favorecer la reparación de tejidos. Su mecanismo actúa promoviendo la migración celular, la angiogénesis y la regeneración muscular, lo que lo convierte en un aliado destacado en protocolos de recuperación deportiva y de salud articular.</p>

<h3>Beneficios Principales</h3>
<ul>
<li><b>Recuperación Acelerada:</b> Reduce el tiempo de recuperación tras entrenamientos intensos o lesiones.</li>
<li><b>Reparación de Tejidos:</b> Favorece la regeneración de músculos, tendones y ligamentos.</li>
<li><b>Reducción de la Inflamación:</b> Ayuda a modular la inflamación y el dolor articular.</li>
<li><b>Salud y Flexibilidad:</b> Mejora la salud de los tejidos conectivos y la movilidad.</li>
</ul>

<h3>Ficha Técnica y Especificaciones</h3>
<table>
<thead>
<tr><td><strong>Característica</strong></td><td><strong>Detalle</strong></td></tr>
</thead>
<tbody>
<tr><td><strong>Concentración</strong></td><td>10 mg</td></tr>
<tr><td><strong>Formato</strong></td><td>Vial con liofilizado (polvo seco para reconstituir)</td></tr>
<tr><td><strong>Clase</strong></td><td>Péptido tímicos (Thymosin Beta-4)</td></tr>
<tr><td><strong>Marca</strong></td><td>VMS Molecular Science</td></tr>
<tr><td><strong>Pureza</strong></td><td>&gt;98% (Grado de investigación / farmacéutico)</td></tr>
<tr><td><strong>Almacenamiento</strong></td><td>Refrigerado entre 2°C y 8°C después de reconstituir. Proteger de la luz.</td></tr>
</tbody>
</table>

<h4>Usos en Investigación</h4>
<p>TB500 se estudia por su papel en la recuperación de lesiones, la regeneración de tejidos, la salud articular y el rendimiento deportivo.</p>

<h4>Disclaimer:</h4>
<p>Este producto se distribuye con fines informativos y/o de investigación. Su uso debe ser evaluado, prescrito y supervisado por un profesional de la salud calificado. No automedicarse. Su uso está supeditado a la completa responsabilidad del comprador.</p>
HTML
    ),
    array(
        'precio' => '160.00', 'stock' => 100, 'estado' => 'instock',
        'nombre' => 'TESAMORELIN 10mg', 'slug' => 'tesamorelin-10mg',
        'img' => '/home/abgroup/web/anabolicgroup.com/tesamorelin-10mg.jpg',
        'img_alt' => 'TESAMORELIN 10mg péptido estimulador de la hormona del crecimiento',
        'img_caption' => 'TESAMORELIN 10 mg - péptido estimulador de la hormona de crecimiento',
        'img_desc' => 'TESAMORELIN 10mg péptido GHRH de VMS Molecular Science',
        'excerpt' => '<b>TESAMORELIN 10mg</b> péptido de la marca <b>VMS Molecular Science</b> que estimula la liberación sostenida de la hormona del crecimiento.',
        'content' => <<<HTML
<h2>TESAMORELIN 10mg: Liberación Sostenida de la Hormona del Crecimiento</h2>
<p>El <b>TESAMORELIN 10mg</b> de <b>VMS Molecular Science</b> es un análogo del factor de liberación de la hormona del crecimiento (GHRH) que estimula la producción endógena de GH. Es ampliamente estudiado en protocolos de investigación por su capacidad de mejorar la composición corporal, promover la lipólisis y favorecer la recuperación, mostrando también un papel relevante en la reducción de la grasa visceral.</p>

<h3>Beneficios Principales</h3>
<ul>
<li><b>Estimulación Sostenida de GH:</b> Favorece una liberación de la hormona del crecimiento más prolongada y consistente.</li>
<li><b>Reducción de la Grasa Visceral:</b> Asociado a una disminución del tejido adiposo abdominal en investigaciones.</li>
<li><b>Composición Corporal:</b> Contribuye al mantenimiento de la masa magra y a la pérdida de grasa.</li>
<li><b>Recuperación y Bienestar:</b> Apoya la reparación muscular y el bienestar general.</li>
</ul>

<h3>Ficha Técnica y Especificaciones</h3>
<table>
<thead>
<tr><td><strong>Característica</strong></td><td><strong>Detalle</strong></td></tr>
</thead>
<tbody>
<tr><td><strong>Concentración</strong></td><td>10 mg</td></tr>
<tr><td><strong>Formato</strong></td><td>Vial con liofilizado (polvo seco para reconstituir)</td></tr>
<tr><td><strong>Clase</strong></td><td>Análogo del GHRH (factor de liberación de la hormona del crecimiento)</td></tr>
<tr><td><strong>Marca</strong></td><td>VMS Molecular Science</td></tr>
<tr><td><strong>Pureza</strong></td><td>&gt;98% (Grado de investigación / farmacéutico)</td></tr>
<tr><td><strong>Almacenamiento</strong></td><td>Refrigerado entre 2°C y 8°C después de reconstituir. Proteger de la luz.</td></tr>
</tbody>
</table>

<h4>Usos en Investigación</h4>
<p>TESAMORELIN se utiliza en estudios sobre la secreción de GH, la reducción de grasa abdominal, la composición corporal y la recuperación deportiva.</p>

<h4>Disclaimer:</h4>
<p>Este producto se distribuye con fines informativos y/o de investigación. Su uso debe ser evaluado, prescrito y supervisado por un profesional de la salud calificado. No automedicarse. Su uso está supeditado a la completa responsabilidad del comprador.</p>
HTML
    ),
);

foreach ($productos as $p) {
    $attach_id = media_handle_sideload(array(
        'name' => basename($p['img']),
        'tmp_name' => $p['img'],
    ), 0);
    if (is_wp_error($attach_id)) {
        echo "ERROR subiendo " . basename($p['img']) . ": " . $attach_id->get_error_message() . "\n";
        $attach_id = 0;
    } else {
        wp_update_post(array(
            'ID' => $attach_id,
            'post_title' => $p['nombre'],
            'post_content' => $p['img_desc'],
            'post_excerpt' => $p['img_caption'],
        ));
        update_post_meta($attach_id, '_wp_attachment_image_alt', $p['img_alt']);
        echo "Imagen subida: ID=$attach_id ('" . basename($p['img']) . "')\n";
    }

    $pid = wp_insert_post(array(
        'post_title'    => $p['nombre'],
        'post_name'     => $p['slug'],
        'post_content'  => $p['content'],
        'post_excerpt'  => $p['excerpt'],
        'post_status'   => 'publish',
        'post_type'     => 'product',
        'comment_status'=> 'closed',
        'ping_status'   => 'closed',
    ), true);
    if (is_wp_error($pid)) { echo "ERROR creando " . $p['nombre'] . ": " . $pid->get_error_message() . "\n"; continue; }
    echo "Producto creado: ID=$pid '" . $p['nombre'] . "'\n";

    wp_set_object_terms($pid, $cats, 'product_cat');
    wp_set_object_terms($pid, $brand, 'product_brand');
    wp_set_object_terms($pid, 'simple', 'product_type');

    update_post_meta($pid, '_regular_price', $p['precio']);
    update_post_meta($pid, '_price', $p['precio']);
    update_post_meta($pid, '_manage_stock', 'yes');
    update_post_meta($pid, '_stock', $p['stock']);
    update_post_meta($pid, '_stock_status', $p['estado']);
    update_post_meta($pid, '_backorders', 'no');
    update_post_meta($pid, '_sold_individually', 'no');
    update_post_meta($pid, '_virtual', 'no');
    update_post_meta($pid, '_downloadable', 'no');
    update_post_meta($pid, '_featured', 'no');
    update_post_meta($pid, '_visibility', 'visible');
    if ($attach_id) update_post_meta($pid, '_thumbnail_id', $attach_id);
    update_post_meta($pid, '_product_version', '10.9.4');

    if (function_exists('wc_delete_product_transients')) { wc_delete_product_transients($pid); }
}

if (function_exists('wc_update_product_lookup_tables')) { wc_update_product_lookup_tables(); }
echo "DONE\n";