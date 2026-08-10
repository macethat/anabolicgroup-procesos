<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
$data = get_post_meta(13263, '_elementor_data', true);
echo "Inicio data len: " . strlen($data) . "\n";
$pos = 0; $count = 0;
while (($pos = strpos($data, '6405', $pos)) !== false && $count < 10) {
    echo "  @$pos: ..." . str_replace(array("\n","\t"), ' ', substr($data, max(0,$pos-150), 250)) . "...\n";
    $pos += 4; $count++;
}
echo "count=$count\n";
