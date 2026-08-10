<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
function scan_all($data, $pid, $name) {
    echo "=== $name ($pid) ===\n";
    if (strpos($data, '6405') === false) { echo "  (sin 6405 en data)\n"; return; }
    // encontrar posiciones de 6405 y mostrar contexto
    $pos = 0;
    $count = 0;
    while (($pos = strpos($data, '6405', $pos)) !== false && $count < 8) {
        $start = max(0, $pos - 120);
        $ctx = substr($data, $start, 300);
        echo "  @$pos: ..." . str_replace(array("\n", "\t"), ' ', $ctx) . "...\n";
        $pos += 4;
        $count++;
    }
}
scan_all(get_post_meta(414, '_elementor_data', true), 414, 'Footer 1');
scan_all(get_post_meta(3784, '_elementor_data', true), 3784, 'Header 4');
echo "=== Header 4 post_content ===\n";
$c = get_post_field('post_content', 3784);
$pos = 0; $count = 0;
while (($pos = strpos($c, '6405', $pos)) !== false && $count < 6) {
    echo "  @" . $pos . ": ..." . str_replace(array("\n","\t"), ' ', substr($c, max(0,$pos-100), 250)) . "...\n";
    $pos += 4; $count++;
}
echo "=== Footer 1 post_content ===\n";
$c = get_post_field('post_content', 414);
$pos = 0; $count = 0;
while (($pos = strpos($c, '6405', $pos)) !== false && $count < 6) {
    echo "  @" . $pos . ": ..." . str_replace(array("\n","\t"), ' ', substr($c, max(0,$pos-100), 250)) . "...\n";
    $pos += 4; $count++;
}
