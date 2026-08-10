<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
// ht_ctc guarda override por página en postmeta
global $wpdb;
$rows = $wpdb->get_results("SELECT post_id, meta_key FROM {$wpdb->postmeta} WHERE meta_key LIKE '%ht_ctc%' OR meta_key LIKE '%ht_click%' OR meta_key LIKE '%click%chat%'", ARRAY_A);
foreach ($rows as $r) {
    $v = get_post_meta($r['post_id'], $r['meta_key'], true);
    if (is_string($v) && strpos($v, '6405') !== false) {
        echo "{$r['post_id']} | {$r['meta_key']} | VIEJO: " . substr($v, 0, 120) . "\n";
    } else {
        echo "{$r['post_id']} | {$r['meta_key']} | ok\n";
    }
}
echo "---FIN---\n";
