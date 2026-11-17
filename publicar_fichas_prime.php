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

$ids = array(14511, 14502, 14508, 14995);

foreach ($ids as $id) {
    // Publicar
    $wpdb->update($wpdb->posts, array('post_status' => 'publish'), array('ID' => $id));

    // Existencia segun regla historica (stock 100, instock, manejo manual)
    set_meta($id, '_manage_stock', 'yes');
    set_meta($id, '_stock', '100');
    set_meta($id, '_stock_status', 'instock');
    set_meta($id, '_backorders', 'no');
    set_meta($id, '_sold_individually', 'no');
    set_meta($id, '_visibility', 'visible');

    // Asegurar que existe _price y _regular_price
    $reg = $wpdb->get_var($wpdb->prepare(
        "SELECT meta_value FROM {$wpdb->postmeta} WHERE post_id=%d AND meta_key='_regular_price' LIMIT 1", $id));
    if ($reg !== null && $reg !== '') {
        set_meta($id, '_price', $reg);
    }

    echo "PUBLICADO ID {$id} | stock=100 instock\n";
}
echo "DONE\n";
