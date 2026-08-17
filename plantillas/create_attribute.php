<?php
// ============================================================
// PLANTILLA: Crear atributo global + terminos (si no existen)
// Subir a /home/abgroup/web/anabolicgroup.com/<nombre>.php y: php <nombre>.php
// Nota: el make_variable.php ya hace esto idempotente; usar solo
// si se quiere crear el atributo por separado.
// ============================================================
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
global $wpdb;

global $wpdb;
if (!function_exists('wp_insert_term') || !function_exists('term_exists')) {
    require_once ABSPATH . 'wp-includes/taxonomy.php';
}

// ============ CONFIGURACION ============
$tax_slug  = 'presentacion';   // attribute_name SIN prefijo pa_
$tax       = 'pa_' . $tax_slug; // pa_presentacion
$att_label = 'Presentacion';
$terms     = array('10mg', '30mg', '60mg');
// ========================================

// 1. Attribute taxonomy row
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
    echo "Atributo $tax_slug creado (id={$wpdb->insert_id})\n";
} else {
    echo "Atributo $tax_slug ya existe (id=$exists)\n";
}
if (function_exists('wc_clear_cached_attributes')) { wc_clear_cached_attributes(); }

// 2. Terminos
if (!taxonomy_exists($tax)) {
    register_taxonomy($tax, array('product'));
}
foreach ($terms as $term) {
    $existing = term_exists($term, $tax);
    if (!$existing) {
        $t = wp_insert_term($term, $tax);
        echo "Termino $term: " . (is_wp_error($t) ? $t->get_error_message() : "ok (term_id={$t['term_id']}, term_taxonomy_id={$t['term_taxonomy_id']})");
        echo "\n";
    } else {
        $tt = get_term_by('slug', $term, $tax);
        echo "Termino $term ya existe (term_id={$tt->term_id}, term_taxonomy_id={$tt->term_taxonomy_id})\n";
    }
}
echo "DONE\n";
// IMPORTANTE: anotar term_taxonomy_id por cada termino (los necesita el PASO 5b)
// Despues: DELETE transient wc_attribute_taxonomies (PASO 5a procedimiento)