<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
foreach (array(3784, 414, 13263) as $pid) {
    $data = get_post_meta($pid, '_elementor_data', true);
    $json = json_decode($data, true);
    echo "$pid | len=" . strlen($data) . " | JSON " . ($json !== null ? 'VAL' : 'INV') . " | 6099:" . (strpos($data,'6099')!==false?'SI':'NO') . " | 6405:" . (strpos($data,'6405')!==false?'SI':'NO') . "\n";
}
