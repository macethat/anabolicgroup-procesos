<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
// Revisar todos los templates que pueden renderizar en el sitio
$candidates = array(
    3784, 414, 1381, 5179, 635, 1038, 3382, 3549, 3662, 3382
);
foreach ($candidates as $pid) {
    $t = get_post_field('post_title', $pid);
    $ty = get_post_field('post_type', $pid);
    $data = get_post_meta($pid, '_elementor_data', true);
    $content = get_post_field('post_content', $pid);
    $inData = $data ? (strpos($data, '6405') !== false ? 'VIEJO' : (strpos($data, '6099') !== false ? 'NUEVO' : '-')) : 'sin-data';
    $inContent = $content ? (strpos($content, '6405') !== false ? 'VIEJO' : (strpos($content, '6099') !== false ? 'NUEVO' : '-')) : 'sin-content';
    echo "$pid | $ty | $t | data:$inData | content:$inContent\n";
}
echo "---FIN---\n";
