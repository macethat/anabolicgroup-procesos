<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
$ids = array(3784 => 'Header 4 (activo)', 1381 => 'Footer bar (activo)', 414 => 'Footer 1', 635 => 'Footer 2', 1038 => 'Footer 3', 3382 => 'Header 1', 3549 => 'Header 2', 3662 => 'Header 3');
foreach ($ids as $id => $name) {
    $data = get_post_meta($id, '_elementor_data', true);
    $content = get_post_field('post_content', $id);
    $hits = array();
    foreach (array('6405-9959', '64059959', '50764059959', '6099-0195', '60990195', '50760990195') as $needle) {
        if (strpos($data, $needle) !== false) $hits[] = "data:$needle";
        if (strpos($content, $needle) !== false) $hits[] = "content:$needle";
    }
    echo "$id | $name | " . (empty($hits) ? 'lim' : implode(', ', $hits)) . "\n";
}
