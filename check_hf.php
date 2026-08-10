<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
$templates = array(
    414 => 'Footer 1',
    635 => 'Footer 2',
    1038 => 'Footer 3',
    1381 => 'Footer bar',
    3382 => 'Header 1',
    3549 => 'Header 2',
    3662 => 'Header 3',
    3784 => 'Header 4',
);
foreach ($templates as $id => $name) {
    $data = get_post_meta($id, '_elementor_data', true);
    $content = get_post_field('post_content', $id);
    $hasOld = (stripos($data, '6405') !== false) ? 'VIEJO' : (stripos($data, '64059959') !== false ? 'VIEJO(sin guion)' : 'limpio');
    $hasNew = (stripos($data, '6099') !== false) ? 'NUEVO' : 'sin-nuevo';
    echo "$id | $name | elementor: $hasOld / $hasNew | post_content len: " . strlen($content) . "\n";
}
