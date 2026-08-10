<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';

$map = array(
    '6405-9959' => '6099-0195',
    '64059959'  => '60990195',
    '50764059959' => '50760990195',
);

$targets = array(3784, 414, 13263);

foreach ($targets as $pid) {
    $updated = false;

    $data = get_post_meta($pid, '_elementor_data', true);
    if ($data) {
        $newData = strtr($data, $map);
        if ($newData !== $data) {
            update_post_meta($pid, '_elementor_data', $newData);
            echo "PID $pid: elementor_data actualizado\n";
            $updated = true;
        }
    }

    $content = get_post_field('post_content', $pid);
    if ($content) {
        $newContent = strtr($content, $map);
        if ($newContent !== $content) {
            wp_update_post(array('ID' => $pid, 'post_content' => $newContent));
            echo "PID $pid: post_content actualizado\n";
            $updated = true;
        }
    }

    if (!$updated) echo "PID $pid: sin cambios\n";
}
echo "---FIN---\n";
