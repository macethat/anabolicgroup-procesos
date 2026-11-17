<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';

global $wpdb;
$pid = 14491;

$titulo = 'Decaprime NPP 100 mg: Volumen Rapido + Articulaciones';

$excerpt = '<b>Decaprime NPP 100 mg</b> (Nandrolona Fenilpropionato, NPP) de la marca <b>Eminence Labs</b>: volumen magro, recuperacion articular y fuerza solida.';

$content = <<<HTML
<h2>Decaprime NPP 100 mg: Volumen Rapido + Articulaciones</h2>
<p>El <b>Decaprime NPP 100 mg</b> (Nandrolona Fenilpropionato, NPP) de la marca <b>Eminence Labs</b> es la version de accion rapida del clasico Deca (Nandrolona Decanoato). Con ester fenilpropionato de vida media corta (2-4 dias), genera volumen limpio, masa magra y una marcada lubricacion articular, ideal para ciclos de ganancia solida con minima retencion hidrica y recuperacion rapida entre dosis.</p>

<h3>Beneficios Principales</h3>
<ul>
<li><b>Masa Muscular Magra:</b> Estimula la sintesis proteica favoreciendo ganancias de calidad (musculo denso, sin hinchazon excesiva).</li>
<li><b>Recuperacion Articular y Tendinosa:</b> Mejora el colageno y el trofismo de cartilagos y tendones, ideal bajo cargas pesadas.</li>
<li><b>Accion Rapida:</b> Su ester corto entra y sale del organismo mas rapido que el decanoato, permitiendo control y ajustes de dosis mas precisos.</li>
<li><b>Fuerza Sostenida:</b> Aporte anabolico constante que se traduce en progresion en el entrenamiento.</li>
</ul>

<h3>Ficha Tecnica y Especificaciones</h3>
<table>
<thead>
<tr><td><strong>Caracteristica</strong></td><td><strong>Detalle</strong></td></tr>
</thead>
<tbody>
<tr><td><strong>Concentracion</strong></td><td>100 mg/ml</td></tr>
<tr><td><strong>Formato</strong></td><td>Vial 10 ml</td></tr>
<tr><td><strong>Compuesto</strong></td><td>Nandrolona Fenilpropionato (NPP)</td></tr>
<tr><td><strong>Marca</strong></td><td>Eminence Labs</td></tr>
<tr><td><strong>Via de administracion</strong></td><td>Inyeccion intramuscular</td></tr>
<tr><td><strong>Ciclo tipico</strong></td><td>8 a 12 semanas</td></tr>
<tr><td><strong>Almacenamiento</strong></td><td>Lugar fresco y seco, protegido de la luz</td></tr>
</tbody>
</table>

<h4>Uso Recomendado (Referencial)</h4>
<p>Hombres: 200-400 mg/semana administrados en dias alternos. Mujeres: 50-100 mg/semana. Puede combinarse con testosterona o esteres orales segun el objetivo del ciclo. La dosis y la duracion deben ser evaluadas por un profesional de la salud calificado.</p>

<h4>Disclaimer:</h4>
<p>Este producto se distribuye con fines informativos y/o de investigacion. Su uso debe ser evaluado, prescrito y supervisado por un profesional de la salud calificado. No automedicarse. Su uso esta supeditado a la completa responsabilidad del comprador.</p>
HTML;

$sql = "UPDATE {$wpdb->posts} SET post_title = %s, post_excerpt = %s, post_content = %s WHERE ID = %d";
$prepared = $wpdb->prepare($sql, $titulo, $excerpt, $content, $pid);
$result = $wpdb->query($prepared);

if ($result === false) {
    echo "ERROR: " . $wpdb->last_error . "\n";
    exit(1);
}
echo "UPDATE OK (filas afectadas: $result)\n";

wc_delete_product_transients($pid);
echo "DONE\n";