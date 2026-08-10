<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
global $wpdb;

$map = array(
    '6405-9959'    => '6099-0195',
    '64059959'     => '60990195',
    '50764059959'  => '50760990195',
);

$targets = array(3784, 414, 13263);

foreach ($targets as $pid) {
    // 1. Elementor data via update_post_meta (SEGURO, sin filtros WP)
    $data = get_post_meta($pid, '_elementor_data', true);
    if ($data) {
        $newData = strtr($data, $map);
        if ($newData !== $data) {
            update_post_meta($pid, '_elementor_data', $newData);
            echo "PID $pid: elementor_data actualizado (meta)\n";
            // validar JSON
            $json = json_decode($newData, true);
            echo "PID $pid: JSON " . ($json !== null ? 'VALIDO' : 'INVALIDO') . "\n";
        }
    }

    // 2. post_content via SQL directo (evita wp_update_post/hooks)
    $content = get_post_field('post_content', $pid);
    if ($content) {
        $newContent = strtr($content, $map);
        if ($newContent !== $content) {
            $wpdb->update(
                $wpdb->posts,
                array('post_content' => $newContent),
                array('ID' => $pid)
            );
            echo "PID $pid: post_content actualizado (SQL directo)\n";
        }
    }
}

// 3. Opcion Click to Chat
$opt = get_option('ht_ctc_chat_options');
if (is_array($opt) && isset($opt['number']) && strpos($opt['number'], '6405') !== false) {
    $old = $opt['number'];
    $opt['number'] = str_replace(array('6405-9959','64059959','50764059959'), array('6099-0195','60990195','50760990195'), $opt['number']);
    update_option('ht_ctc_chat_options', $opt);
    echo "ht_ctc_chat_options: '$old' -> '{$opt['number']}'\n";
} elseif (is_array($opt)) {
    echo "ht_ctc_chat_options: sin cambio (numero actual: " . (isset($opt['number']) ? $opt['number'] : '?') . ")\n";
} else {
    echo "ht_ctc_chat_options: no array\n";
}

echo "---FIN---\n";
