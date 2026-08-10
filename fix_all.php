<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
global $wpdb;

$map = array(
    '6405-9959'    => '6099-0195',
    '64059959'     => '60990195',
    '50764059959'  => '50760990195',
);

$ok = true;
foreach (array(3784, 414, 13263) as $pid) {
    // Elementor data (render principal) - update_post_meta directo
    $data = get_post_meta($pid, '_elementor_data', true);
    if ($data) {
        $newData = strtr($data, $map);
        $json = json_decode($newData, true);
        if ($json === null) { echo "PID $pid: DATA JSON INVALIDO, NO APLICAR\n"; $ok = false; continue; }
        if ($newData !== $data) {
            update_post_meta($pid, '_elementor_data', $newData);
            echo "PID $pid: elementor_data -> 6099 (JSON VALIDO)\n";
        } else {
            echo "PID $pid: elementor_data sin cambios\n";
        }
    }
    // post_content via SQL directo
    $content = get_post_field('post_content', $pid);
    if ($content) {
        $newContent = strtr($content, $map);
        if ($newContent !== $content) {
            $wpdb->update($wpdb->posts, array('post_content' => $newContent), array('ID' => $pid));
            echo "PID $pid: post_content -> 6099\n";
        }
    }
}

// Opcion Click to Chat
$opt = get_option('ht_ctc_chat_options');
if (is_array($opt) && isset($opt['number']) && strpos($opt['number'], '6405') !== false) {
    $opt['number'] = str_replace(array('6405-9959','64059959','50764059959'), array('6099-0195','60990195','50760990195'), $opt['number']);
    update_option('ht_ctc_chat_options', $opt);
    echo "ht_ctc_chat_options -> {$opt['number']}\n";
}

echo $ok ? "---COMPLETO---\n" : "---ERROR---\n";
