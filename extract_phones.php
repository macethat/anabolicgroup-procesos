<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
global $wpdb;
$pages = array(13263, 5, 411, 7495, 7496, 8);
foreach ($pages as $pid) {
    $data = get_post_meta($pid, '_elementor_data', true);
    echo "=== PAGE $pid ===\n";
    if (!$data) { echo "(sin elementor data)\n"; continue; }
    preg_match_all('/6[0-9]{3}[- ]?[0-9]{3,5}|wa\.me\/[0-9+]+|api\.whatsapp\.com\/[0-9+]+|tel:\+?[0-9]+/', $data, $m);
    $matches = array_values(array_unique($m[0]));
    foreach ($matches as $x) { echo "  $x\n"; }
}
