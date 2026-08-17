<?php
// ============================================================
// PLANTILLA: Convertir producto simple -> VARIABLE con variaciones
// Adaptar variables en la seccion CONFIGURACION y subir a
// /home/abgroup/web/anabolicgroup.com/<nombre>.php y ejecutar:
// php <nombre>.php
// Despues: aplicar PASO 5 del PROCEDIMIENTO_PRODUCTO_VARIABLE.md
// (transient + term_relationships + stock del padre)
// ============================================================
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
global $wpdb;

// ============ CONFIGURACION ============
$parent_id   = 15229;              // ID del producto padre (simple actual)
$tax_slug    = 'presentacion';     // attribute_name SIN prefijo pa_
$taxonomy    = 'pa_presentacion';  // taxonomia global
$att_label   = 'Presentacion';     // etiqueta visible
$default_attr = '30mg';            // slug del term por defecto

// [slug_term, precio, stock, estado, attachment_image_id]
$vars = array(
    array('10mg', '160.00', 100, 'instock', 15401),
    array('30mg', '200.00', 100, 'instock', 15233),
    array('60mg', '250.00', 0, 'outofstock', 15402),
);
// ========================================

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

// 4. Asegurar atributo global + terminos (idempotente)
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

// 5. Terminos por slug (buscar por term_id directo por si get_term_by falla solo)
$term_ids = array();
foreach ((array) $vars as $v) {
    $slug = $v[0];
    $tid = $wpdb->get_var($wpdb->prepare(
        "SELECT t.term_id FROM {$wpdb->terms} t
         JOIN {$wpdb->term_taxonomy} tt ON tt.term_id=t.term_id
         WHERE t.slug=%s AND tt.taxonomy=%s", $slug, $taxonomy));
    if (!$tid) {
        $t = wp_insert_term($slug, $taxonomy);
        if (is_wp_error($t)) { echo "ERROR termino $slug: " . $t->get_error_message() . "\n"; continue; }
        $tid = $t['term_id'];
        echo "Termino $slug creado (term_id=$tid)\n";
    }
    $term_ids[$slug] = (int) $tid;
}

// 6. Crear variaciones
foreach ($vars as $v) {
    list($slug, $precio, $stock, $estado, $img) = $v;
    if (!isset($term_ids[$slug])) { echo "SALTADO $slug (sin termino)\n"; continue; }
    $vid = wp_insert_post(array(
        'post_title'   => 'Variación #' . $slug,
        'post_status'  => 'publish',
        'post_type'    => 'product_variation',
        'post_parent'  => $parent_id,
        'menu_order'   => 0,
    ), true);
    if (is_wp_error($vid)) { echo "ERROR variacion $slug: " . $vid->get_error_message() . "\n"; continue; }
    update_post_meta($vid, 'attribute_' . $taxonomy, $slug);
    update_post_meta($vid, '_variation_attributes', array($taxonomy => $slug));
    update_post_meta($vid, '_regular_price', $precio);
    update_post_meta($vid, '_price', $precio);
    update_post_meta($vid, '_manage_stock', 'yes');
    update_post_meta($vid, '_stock', $stock);
    update_post_meta($vid, '_stock_status', $estado);
    update_post_meta($vid, '_backorders', 'no');
    update_post_meta($vid, '_sold_individually', 'no');
    update_post_meta($vid, '_thumbnail_id', $img);
    update_post_meta($vid, '_variation_visible', 'yes');
    update_post_meta($vid, '_variation_has_price', 'yes');
    echo "Variacion $slug creada: id=$vid precio=$precio stock=$stock estado=$estado img=$img\n";
}

// 7. Recalcular transients del producto
if (function_exists('wc_delete_product_transients')) { wc_delete_product_transients($parent_id); }
$p = wc_get_product($parent_id);
if ($p && method_exists($p, 'save')) {
    $p->set_default_attributes(array($taxonomy => $default_attr));
    $p->save();
}

echo "== DONE. Ahora aplicar PASO 5 del procedimiento (transient + term_relationships + stock padre instock) ==\n";