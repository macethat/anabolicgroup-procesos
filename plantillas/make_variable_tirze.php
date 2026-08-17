<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
global $wpdb;

$parent_id   = 15223;
$tax_slug    = 'presentacion';
$taxonomy    = 'pa_presentacion';
$att_label   = 'Presentacion';
$default_attr = '30mg';

// terminos a asegurar: [slug, label]
$term_names = array('10mg', '15mg', '30mg', '60mg');

// 1. Tipo variable
wp_set_object_terms($parent_id, 'variable', 'product_type');

// 2. Atributo en el producto
$attributes = array(
    $taxonomy => array(
        'name' => $taxonomy,
        'value' => '',
        'position' => 0,
        'is_visible' => 1,
        'is_variation' => 1,
        'is_taxonomy' => 1,
    ),
);
update_post_meta($parent_id, '_product_attributes', $attributes);
update_post_meta($parent_id, '_default_attributes', array($taxonomy => $default_attr));

// 3. Limpiar metas de precio/stock del padre
foreach (array('_regular_price','_price','_sale_price','_stock','_stock_status') as $k) {
    delete_post_meta($parent_id, $k);
}
update_post_meta($parent_id, '_manage_stock', 'no');

// 4. Asegurar attribute global existe
if (!taxonomy_exists($taxonomy)) {
    register_taxonomy($taxonomy, array('product'));
}
$exists = $wpdb->get_var($wpdb->prepare(
    "SELECT attribute_id FROM {$wpdb->prefix}woocommerce_attribute_taxonomies WHERE attribute_name=%s", $tax_slug));
if (!$exists) {
    $wpdb->insert("{$wpdb->prefix}woocommerce_attribute_taxonomies", array(
        'attribute_name' => $tax_slug,
        'attribute_label' => $att_label,
        'attribute_type' => 'select',
        'attribute_orderby' => 'menu_order',
        'attribute_public' => 0,
    ));
    echo "Atributo global $tax_slug creado (id={$wpdb->insert_id})\n";
} else {
    echo "Atributo global $tax_slug ya existe (id=$exists)\n";
}
if (function_exists('wc_clear_cached_attributes')) { wc_clear_cached_attributes(); }

// 5. Crear terminos faltantes + obtener term_ids
$term_ids = array();
foreach ($term_names as $nm) {
    $tid = $wpdb->get_var($wpdb->prepare(
        "SELECT t.term_id FROM {$wpdb->terms} t
         JOIN {$wpdb->term_taxonomy} tt ON tt.term_id=t.term_id
         WHERE t.slug=%s AND tt.taxonomy=%s", $nm, $taxonomy));
    if (!$tid) {
        $tx = term_exists($nm, $taxonomy);
        if (!$tx) {
            $t = wp_insert_term($nm, $taxonomy);
            if (is_wp_error($t)) { echo "ERROR termino $nm: " . $t->get_error_message() . "\n"; continue; }
            $tid = $t['term_id'];
        } else {
            $tid = $tx;
        }
        echo "Termino $nm creado (term_id=$tid)\n";
    }
    $term_ids[$nm] = (int) $tid;
    // term_taxonomy_id para term_relationships
}

// 6. Crear variaciones: [slug, precio, stock, estado, img]
//  10mg = sin imagen (se sube mas tarde -> 0)
$vars = array(
    array('10mg', '120.00', 0,   'outofstock', 0),
    array('15mg', '130.00', 0,   'outofstock', 15406),
    array('30mg', '160.00', 100, 'instock', 15235),
    array('60mg', '220.00', 100, 'instock', 15407),
);

foreach ($vars as $v) {
    list($slug, $precio, $stock, $estado, $img) = $v;
    if (!isset($term_ids[$slug])) { echo "SALTADO $slug (sin termino)\n"; continue; }
    // evitar duplicados: no recrear si ya existe variacion con ese term
    $existing = $wpdb->get_var($wpdb->prepare(
        "SELECT v.post_id FROM {$wpdb->postmeta} v
         WHERE v.meta_key='attribute_pa_presentacion' AND v.meta_value=%s AND v.post_id IN
         (SELECT ID FROM {$wpdb->posts} WHERE post_type='product_variation' AND post_parent=%d)", $slug, $parent_id));
    if ($existing) { echo "Variacion $slug ya existe (id=$existing), omite\n"; continue; }

    $vid = wp_insert_post(array(
        'post_title'   => 'Variación #' . $slug,
        'post_status'  => 'publish',
        'post_type'    => 'product_variation',
        'post_parent'  => $parent_id,
        'menu_order'   => 0,
    ), true);
    if (is_wp_error($vid)) { echo "ERROR variacion $slug: " . $vid->get_error_message() . "\n"; continue; }
    update_post_meta($vid, 'attribute_pa_presentacion', $slug);
    update_post_meta($vid, '_variation_attributes', array($taxonomy => $slug));
    update_post_meta($vid, '_regular_price', $precio);
    update_post_meta($vid, '_price', $precio);
    update_post_meta($vid, '_manage_stock', 'yes');
    update_post_meta($vid, '_stock', $stock);
    update_post_meta($vid, '_stock_status', $estado);
    update_post_meta($vid, '_backorders', 'no');
    update_post_meta($vid, '_sold_individually', 'no');
    if ($img) { update_post_meta($vid, '_thumbnail_id', $img); }
    update_post_meta($vid, '_variation_visible', 'yes');
    update_post_meta($vid, '_variation_has_price', 'yes');
    echo "Variacion $slug creada: id=$vid precio=$precio stock=$stock estado=$estado img=" . ($img?:'PENDIENTE') . "\n";
}

// 7. term_relationships del padre con los terminos de presentacion
foreach ($term_ids as $slug => $tid) {
    $ttid = $wpdb->get_var($wpdb->prepare(
        "SELECT term_taxonomy_id FROM {$wpdb->term_taxonomy} WHERE term_id=%d AND taxonomy=%s", $tid, $taxonomy));
    if (!$ttid) continue;
    $wpdb->query($wpdb->prepare(
        "INSERT IGNORE INTO {$wpdb->term_relationships} (object_id, term_taxonomy_id, term_order) VALUES (%d,%d,0)", $parent_id, $ttid));
    $cnt = $wpdb->get_var($wpdb->prepare(
        "SELECT COUNT(*) FROM {$wpdb->term_relationships} WHERE term_taxonomy_id=%d", $ttid));
    $wpdb->update($wpdb->term_taxonomy, array('count' => $cnt), array('term_taxonomy_id' => $ttid));
    echo "Term $slug (tt=$ttid) asociado al padre, count=$cnt\n";
}

// 8. Stock del padre en instock + transients
update_post_meta($parent_id, '_stock_status', 'instock');
if (function_exists('wc_delete_product_transients')) { wc_delete_product_transients($parent_id); }
$p = wc_get_product($parent_id);
if ($p && method_exists($p, 'save')) {
    $p->set_default_attributes(array($taxonomy => $default_attr));
    $p->save();
}
echo "== DONE ==\n";