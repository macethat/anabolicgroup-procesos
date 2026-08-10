<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
$data = get_post_meta(13263, '_elementor_data', true);
echo "len=" . strlen($data) . "\n";
echo "tiene 6099: " . (strpos($data, '6099') !== false ? 'SI' : 'NO') . "\n";
echo "tiene 6405: " . (strpos($data, '6405') !== false ? 'SI' : 'NO') . "\n";
echo "tiene \\n literal: " . (strpos($data, '\\n') !== false ? 'SI' : 'NO') . "\n";
// encontrar dónde falla el JSON
$json = json_decode($data, true);
echo "json error: " . json_last_error_msg() . "\n";
// probar si es que hay newlines reales que rompen JSON
preg_match('/[^{}\[\],:"\s\\\\][^{}\[\],:"\s\\\\]*\\n[^{}\[\],:"\s\\\\]*/', $data, $m);
if ($m) echo "posible newline real en: ..." . substr($data, max(0, strpos($data, $m[0])-60), 200) . "...\n";
// primeros 300 chars escapados
echo "INICIO RAW: " . substr($data, 0, 300) . "\n";
