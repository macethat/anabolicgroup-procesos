<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
global $wpdb;

$parent_id = 15229;

// 1. Cambiar tipo de producto a variable (taxonomia product_type)
wp_set_object_terms($parent_id, 'variable', 'product_type');

// 2. Asignar atributo pa_presentacion al producto
$attributes = array(
    'pa_presentacion' => array(
        'name' => 'pa_presentacion',
        'value' => '',
        'position' => 0,
        'is_visible' => 1,
        'is_variation' => 1,
        'is_taxonomy' => 1,
    ),
);
update_post_meta($parent_id, '_product_attributes', $attributes);

// 3. Default attributes (60mg o 30mg como default)
$default = array('pa_presentacion' => '30mg');
update_post_meta($parent_id, '_default_attributes', $default);

// 4. Limpiar metas de precio/stock del padre (los manejan las variaciones)
delete_post_meta($parent_id, '_regular_price');
delete_post_meta($parent_id, '_price');
delete_post_meta($parent_id, '_sale_price');
delete_post_meta($parent_id, '_stock');
delete_post_meta($parent_id, '_stock_status');
update_post_meta($parent_id, '_manage_stock', 'no');

// 5. Crear variaciones
// [term slug, precio, stock, estado, imagen id]
$vars = array(
    array('10mg', '160.00', 100, 'instock', 15401),
    array('30mg', '200.00', 100, 'instock', 15233),
    array('60mg', '250.00', 0, 'outofstock', 15402),
);

$term_ids = array();
foreach (array('10mg','30mg','60mg') as $t) {
    $tt = get_term_by('slug', $t, 'pa_presentacion');
    $term_ids[$t] = $tt->term_id;
}

foreach ($vars as $v) {
    list($slug, $precio, $stock, $estado, $img) = $v;
    // insertar post product_variation
    $vid = wp_insert_post(array(
        'post_title' => 'Variación #' . $slug . ' de Retatrutide',
        'post_status' => 'publish',
        'post_type' => 'product_variation',
        'post_parent' => $parent_id,
        'menu_order' => 0,
    ), true);
    if (is_wp_error($vid)) { echo "ERROR creando variacion $slug: " . $vid->get_error_message() . "\n"; continue; }

    // atributo de la variacion
    update_post_meta($vid, 'attribute_pa_presentacion', $slug);
    update_post_meta($vid, '_variation_attributes', array('pa_presentacion' => $slug));

    // precio
    update_post_meta($vid, '_regular_price', $precio);
    update_post_meta($vid, '_price', $precio);

    // stock
    update_post_meta($vid, '_manage_stock', 'yes');
    update_post_meta($vid, '_stock', $stock);
    update_post_meta($vid, '_stock_status', $estado);
    update_post_meta($vid, '_backorders', 'no');
    update_post_meta($vid, '_sold_individually', 'no');

    // imagen
    update_post_meta($vid, '_thumbnail_id', $img);

    // visibilidad
    update_post_meta($vid, '_variation_visible', 'yes');
    update_post_meta($vid, '_variation_has_price', 'yes');

    echo "Variacion $slug creada: id=$vid precio=$precio stock=$stock estado=$estado img=$img\n";
}

// 6. Forzar recalculo de precios del producto variable
if (function_exists('wc_delete_product_transients')) {
    wc_delete_product_transients($parent_id);
}
if (function_exists('wc_update_product_lookup_tables_column')) {
    wc_update_product_lookup_tables_column('total_sales');
}
// refrescar cache de variaciones
if (class_exists('WC_Product_Variable')) {
    $product = wc_get_product($parent_id);
    if ($product) {
        $product->set_default_attributes($default);
        $product->save();
    }
}
echo "DONE\n";
