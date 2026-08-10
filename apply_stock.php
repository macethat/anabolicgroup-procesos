<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
global $wpdb;

$data = json_decode(file_get_contents('/home/abgroup/web/anabolicgroup.com/apply_updates.json'), true);
if (!$data) { echo "ERROR JSON\n"; exit; }

$ok = 0;
foreach ($data as $u) {
    $id = intval($u['id']);
    $precio = isset($u['precio']) && $u['precio'] !== null ? number_format((float)$u['precio'], 2, '.', '') : null;
    $stock = intval($u['stock']);
    $estado = $u['estado'];

    $post = $wpdb->get_var($wpdb->prepare("SELECT post_type FROM {$wpdb->posts} WHERE ID=%d", $id));
    if ($post !== 'product') { echo "SKIP $id: no es producto (post_type=$post)\n"; continue; }

    // Precio
    if ($precio !== null) {
        update_post_meta($id, '_regular_price', $precio);
        // solo _price si no hay sale activo
        $sale = get_post_meta($id, '_sale_price', true);
        update_post_meta($id, '_price', $sale && $sale !== '' ? $sale : $precio);
    }

    // Stock
    update_post_meta($id, '_manage_stock', 'yes');
    update_post_meta($id, '_stock', $stock);
    update_post_meta($id, '_stock_status', $estado === 'Agotado' ? 'outofstock' : 'instock');

    $ok++;
}

// Limpiar caché WC
if (function_exists('wc_delete_product_transients')) {
    foreach ($data as $u) { wc_delete_product_transients(intval($u['id'])); }
}
echo "ACTUALIZADOS: $ok\n";
