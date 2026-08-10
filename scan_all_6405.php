<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
global $wpdb;
$rows = $wpdb->get_results("SELECT post_id, meta_value FROM {$wpdb->postmeta} WHERE meta_key='_elementor_data'", ARRAY_A);
$needles = array('6405', '6405-9959', '64059959', '50764059959');
$results = array();
foreach ($rows as $r) {
    $hit = array();
    foreach ($needles as $n) { if (strpos($r['meta_value'], $n) !== false) $hit[] = $n; }
    if ($hit) $results[$r['post_id']] = $hit;
}
foreach ($results as $pid => $hits) {
    $t = get_post_field('post_title', $pid);
    $ty = get_post_field('post_type', $pid);
    $st = get_post_field('post_status', $pid);
    echo "$pid | $ty | $st | $t | " . implode(',', $hits) . "\n";
}
echo "---DONE---\n";
