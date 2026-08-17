<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
global $wpdb;

// 1. Registrar atributo en woocommerce_attribute_taxonomies
$slug = 'presentacion';
$exists = $wpdb->get_var($wpdb->prepare("SELECT attribute_id FROM {$wpdb->prefix}woocommerce_attribute_taxonomies WHERE attribute_name=%s", $slug));
if (!$exists) {
    $wpdb->insert("{$wpdb->prefix}woocommerce_attribute_taxonomies", array(
        'attribute_name' => $slug,
        'attribute_label' => 'Presentacion',
        'attribute_type' => 'select',
        'attribute_orderby' => 'menu_order',
        'attribute_public' => 0,
    ));
    echo "Atributo $slug creado (id={$wpdb->insert_id})\n";
} else {
    echo "Atributo $slug ya existe (id=$exists)\n";
}

// 2. Limpiar cache de WC para los atributos
if (function_exists('wc_clear_cached_attributes')) {
    wc_clear_cached_attributes();
}

// 3. Crear terminos en pa_presentacion
$tax = 'pa_' . $slug;
if (!taxonomy_exists($tax)) {
    register_taxonomy($tax, array('product'));
}
foreach (array('10mg', '30mg', '60mg') as $term) {
    $existing = term_exists($term, $tax);
    if (!$existing) {
        $t = wp_insert_term($term, $tax);
        echo "Termino $term: " . (is_wp_error($t) ? $t->get_error_message() : "ok (term_id={$t['term_id']})") . "\n";
    } else {
        echo "Termino $term ya existe\n";
    }
}
echo "DONE\n";
