<?php
global $wpdb;

function set_meta($post_id, $key, $value) {
    global $wpdb;
    $meta_id = $wpdb->get_var($wpdb->prepare(
        "SELECT meta_id FROM {$wpdb->postmeta} WHERE post_id=%d AND meta_key=%s LIMIT 1",
        $post_id, $key
    ));
    if ($meta_id) {
        $wpdb->update($wpdb->postmeta, array('meta_value' => $value), array('meta_id' => $meta_id));
    } else {
        $wpdb->insert($wpdb->postmeta, array('post_id' => $post_id, 'meta_key' => $key, 'meta_value' => $value));
    }
}

$disclaimer = '<p>Este producto se distribuye con fines informativos y/o de investigación. Su uso debe ser evaluado, prescrito y supervisado por un profesional de la salud calificado. No automedicarse. Su uso está supeditado a la completa responsabilidad del comprador.</p>';

$aviso = '<p><b>Consulta a tu médico antes de consumir este tipo de productos.</b> No se recomienda su uso sin prescripción y seguimiento de un profesional de la salud. Esta ficha es informativa y no indica dosis ni protocolos de uso.</p>';

// ---------- 14511 MetaPrime 10 mg ----------
$p_14511 = array(
  'id' => 14511,
  'title' => 'MetaPrime 10 mg (Dianabol)',
  'slug' => 'metaprime-10-mg',
  'price' => '59.99',
  'thumb' => 14688,
  'alt' => 'MetaPrime 10 mg Methandienone Eminence Labs 50 tabletas',
  'seo_title' => 'MetaPrime 10 mg (Dianabol) Eminence | 50 Tabletas',
  'seo_desc' => 'MetaPrime 10 mg de Eminence Labs: Methandienone (Dianabol) 10 mg en 50 tabletas. Ficha técnica y precio en USD. Consulta a tu médico antes de consumir.',
  'kw' => 'metaprime 10 mg',
  'content' => '<h2>MetaPrime 10 mg (Dianabol)</h2>
<p>El <b>MetaPrime 10 mg</b> de <b>Eminence Labs</b> contiene Methandienone (metandrostenolona, conocida comercialmente como Dianabol) en tabletas de 10 mg. Se presenta en caja de 50 tabletas de uso oral.</p>
<h3>Ficha Técnica y Especificaciones</h3>
<table>
<thead><tr><td><strong>Característica</strong></td><td><strong>Detalle</strong></td></tr></thead>
<tbody>
<tr><td><strong>Compuesto</strong></td><td>Methandienone (metandrostenolona / Dianabol)</td></tr>
<tr><td><strong>Concentración</strong></td><td>10 mg por tableta</td></tr>
<tr><td><strong>Presentación</strong></td><td>Caja con 50 tabletas</td></tr>
<tr><td><strong>Vía de administración</strong></td><td>Oral</td></tr>
<tr><td><strong>Marca</strong></td><td>Eminence Labs</td></tr>
<tr><td><strong>Categoría</strong></td><td>Anabólicos orales</td></tr>
<tr><td><strong>Almacenamiento</strong></td><td>Lugar fresco y seco, protegido de la luz</td></tr>
</tbody>
</table>
<h4>Uso Referencial</h4>
' . $aviso . '
<h4>Disclaimer</h4>
' . $disclaimer,
  'excerpt' => '<b>MetaPrime 10 mg</b> de <b>Eminence Labs</b>: tabletas de Methandienone (Dianabol) 10 mg, caja de 50 unidades. Producto de uso referencial; consulta a tu médico antes de consumir.',
);

// ---------- 14502 KlenPrime 60 mcg ----------
$p_14502 = array(
  'id' => 14502,
  'title' => 'KlenPrime 60 mcg (Clenbuterol)',
  'slug' => 'klenprime-60-mcg',
  'price' => '64.99',
  'thumb' => 14684,
  'alt' => 'KlenPrime 60 mcg Clenbuterol HCL Eminence Labs 50 tabletas',
  'seo_title' => 'KlenPrime 60 mcg (Clenbuterol) Eminence | 50 Tabletas',
  'seo_desc' => 'KlenPrime 60 de Eminence Labs: Clenbuterol HCL 60 mcg en 50 tabletas. Ficha técnica y precio en USD. Consulta a tu médico antes de consumir.',
  'kw' => 'klenprime 60 mcg',
  'content' => '<h2>KlenPrime 60 mcg (Clenbuterol)</h2>
<p>El <b>KlenPrime 60</b> de <b>Eminence Labs</b> contiene Clenbuterol HCL en tabletas de 60 mcg (0,06 mg). Se presenta en caja de 50 tabletas de uso oral.</p>
<h3>Ficha Técnica y Especificaciones</h3>
<table>
<thead><tr><td><strong>Característica</strong></td><td><strong>Detalle</strong></td></tr></thead>
<tbody>
<tr><td><strong>Compuesto</strong></td><td>Clenbuterol HCL</td></tr>
<tr><td><strong>Concentración</strong></td><td>60 mcg (0,06 mg) por tableta</td></tr>
<tr><td><strong>Presentación</strong></td><td>Caja con 50 tabletas</td></tr>
<tr><td><strong>Vía de administración</strong></td><td>Oral</td></tr>
<tr><td><strong>Marca</strong></td><td>Eminence Labs</td></tr>
<tr><td><strong>Categoría</strong></td><td>Anabólicos orales</td></tr>
<tr><td><strong>Almacenamiento</strong></td><td>Lugar fresco y seco, protegido de la luz</td></tr>
</tbody>
</table>
<h4>Uso Referencial</h4>
' . $aviso . '
<h4>Disclaimer</h4>
' . $disclaimer,
  'excerpt' => '<b>KlenPrime 60</b> de <b>Eminence Labs</b>: tabletas de Clenbuterol HCL 60 mcg, caja de 50 unidades. Producto de uso referencial; consulta a tu médico antes de consumir.',
);

// ---------- 14508 LioPrime 25 mcg ----------
$p_14508 = array(
  'id' => 14508,
  'title' => 'LioPrime 25 mcg (T3 / Liotironina)',
  'slug' => 'lioprime-25-mcg',
  'price' => '64.99',
  'thumb' => 14686,
  'alt' => 'LioPrime 25 mcg Liothyronine Sodium Eminence Labs 50 tabletas',
  'seo_title' => 'LioPrime 25 mcg (T3) Eminence | 50 Tabletas',
  'seo_desc' => 'LioPrime 25 mcg de Eminence Labs: Liothyronine Sodium (T3) 25 mcg en 50 tabletas. Ficha técnica y precio en USD. Consulta a tu médico antes de consumir.',
  'kw' => 'lioprime 25 mcg',
  'content' => '<h2>LioPrime 25 mcg (T3 / Liotironina)</h2>
<p>El <b>LioPrime 25 mcg</b> de <b>Eminence Labs</b> contiene Liothyronine Sodium (liotironina, T3) en tabletas de 25 mcg. Se presenta en caja de 50 tabletas de uso oral.</p>
<h3>Ficha Técnica y Especificaciones</h3>
<table>
<thead><tr><td><strong>Característica</strong></td><td><strong>Detalle</strong></td></tr></thead>
<tbody>
<tr><td><strong>Compuesto</strong></td><td>Liothyronine Sodium (T3 / liotironina sódica)</td></tr>
<tr><td><strong>Concentración</strong></td><td>25 mcg por tableta</td></tr>
<tr><td><strong>Presentación</strong></td><td>Caja con 50 tabletas</td></tr>
<tr><td><strong>Vía de administración</strong></td><td>Oral</td></tr>
<tr><td><strong>Marca</strong></td><td>Eminence Labs</td></tr>
<tr><td><strong>Categoría</strong></td><td>Anabólicos / Orales</td></tr>
<tr><td><strong>Almacenamiento</strong></td><td>Lugar fresco y seco, protegido de la luz</td></tr>
</tbody>
</table>
<h4>Uso Referencial</h4>
' . $aviso . '
<h4>Disclaimer</h4>
' . $disclaimer,
  'excerpt' => '<b>LioPrime 25 mcg</b> de <b>Eminence Labs</b>: tabletas de Liothyronine Sodium (T3) 25 mcg, caja de 50 unidades. Producto de uso referencial; consulta a tu médico antes de consumir.',
);

// ---------- 14995 Hormoprime HCG 5000 UI ----------
$p_14995 = array(
  'id' => 14995,
  'title' => 'Hormoprime HCG 5000 UI',
  'slug' => 'hormoprime-hcg-5000-ui',
  'price' => '64.99',
  'thumb' => 14996,
  'alt' => 'Hormoprime HCG 5000 UI Eminence Labs vial liofilizado',
  'seo_title' => 'Hormoprime HCG 5000 UI Eminence | 1 Vial',
  'seo_desc' => 'Hormoprime HCG 5000 UI de Eminence Labs: gonadotropina coriónica liofilizada, 1 vial de 5000 UI. Ficha técnica y precio en USD. Consulta a tu médico.',
  'kw' => 'hormoprime hcg 5000 ui',
  'content' => '<h2>Hormoprime HCG 5000 UI</h2>
<p>El <b>Hormoprime HCG 5000 UI</b> de <b>Eminence Labs</b> contiene gonadotropina coriónica humana (HCG) liofilizada, 5000 UI por vial. Se presenta en 1 vial para inyección intramuscular o subcutánea (requiere reconstituir).</p>
<h3>Ficha Técnica y Especificaciones</h3>
<table>
<thead><tr><td><strong>Característica</strong></td><td><strong>Detalle</strong></td></tr></thead>
<tbody>
<tr><td><strong>Compuesto</strong></td><td>Gonadotropina coriónica humana (HCG)</td></tr>
<tr><td><strong>Concentración</strong></td><td>5000 UI por vial</td></tr>
<tr><td><strong>Presentación</strong></td><td>1 vial con liofilizado para reconstituir</td></tr>
<tr><td><strong>Vía de administración</strong></td><td>Inyección intramuscular o subcutánea</td></tr>
<tr><td><strong>Marca</strong></td><td>Eminence Labs</td></tr>
<tr><td><strong>Categoría</strong></td><td>Anabólicos / Inyectables</td></tr>
<tr><td><strong>Almacenamiento</strong></td><td>Refrigerado entre 2 y 8 °C tras reconstituir; proteger de la luz</td></tr>
</tbody>
</table>
<h4>Uso Referencial</h4>
' . $aviso . '
<h4>Disclaimer</h4>
' . $disclaimer,
  'excerpt' => '<b>Hormoprime HCG 5000 UI</b> de <b>Eminence Labs</b>: gonadotropina coriónica (HCG) liofilizada, 1 vial de 5000 UI para inyección. Producto de uso referencial; consulta a tu médico.',
);

$products = array($p_14511, $p_14502, $p_14508, $p_14995);

foreach ($products as $p) {
    $wpdb->update($wpdb->posts,
        array(
            'post_title' => $p['title'],
            'post_name' => $p['slug'],
            'post_content' => $p['content'],
            'post_excerpt' => $p['excerpt'],
        ),
        array('ID' => $p['id'])
    );
    set_meta($p['id'], '_regular_price', $p['price']);
    set_meta($p['id'], '_price', $p['price']);
    set_meta($p['id'], 'rank_math_title', $p['seo_title']);
    set_meta($p['id'], 'rank_math_description', $p['seo_desc']);
    set_meta($p['id'], 'rank_math_focus_keyword', $p['kw']);
    set_meta($p['thumb'], '_wp_attachment_image_alt', $p['alt']);
    echo "OK ficha ID {$p['id']} -> {$p['title']} | USD {$p['price']}\n";
}

$dup = array(14315, 14318, 14326, 15206);
foreach ($dup as $d) {
    $wpdb->update($wpdb->posts, array('post_status' => 'trash'), array('ID' => $d));
    echo "PAPELERA ID {$d}\n";
}

echo "DONE\n";
