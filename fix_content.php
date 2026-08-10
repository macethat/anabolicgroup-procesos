<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
global $wpdb;

$map = array(
    '6405-9959'    => '6099-0195',
    '64059959'     => '60990195',
    '50764059959'  => '50760990195',
);

foreach (array(3784, 414, 13263) as $pid) {
    $content = get_post_field('post_content', $pid);
    if (!$content) { echo "PID $pid: sin content\n"; continue; }
    $newContent = strtr($content, $map);
    $lenBefore = strlen($content);
    $lenAfter = strlen($newContent);
    $changed = ($newContent !== $content);
    if ($changed) {
        $wpdb->update($wpdb->posts, array('post_content' => $newContent), array('ID' => $pid));
    }
    echo "PID $pid | len $lenBefore -> $lenAfter | " . ($changed ? 'ACTUALIZADO' : 'sin cambios') . "\n";
    echo "  6405 restante: " . (strpos($newContent, '6405') !== false ? 'SI (restos en "6405-" o similar)' : 'NO') . "\n";
    echo "  6099 presente: " . (strpos($newContent, '6099') !== false ? 'SI' : 'NO') . "\n";
}
echo "---FIN---\n";
