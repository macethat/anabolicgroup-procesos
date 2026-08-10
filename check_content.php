<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
foreach (array(3784 => 'Header 4', 414 => 'Footer 1', 13263 => 'Inicio') as $pid => $name) {
    $content = get_post_field('post_content', $pid);
    echo "$pid | $name | content len=" . strlen($content) . "\n";
    echo "  6099 en content: " . (strpos($content, '6099') !== false ? 'SI' : 'NO') . "\n";
    echo "  6405 en content: " . (strpos($content, '6405') !== false ? 'SI' : 'NO') . "\n";
    echo "  5076099 en content: " . (strpos($content, '5076099') !== false ? 'SI' : 'NO') . "\n";
    echo "  5076405 en content: " . (strpos($content, '5076405') !== false ? 'SI' : 'NO') . "\n";
    // mostrar un fragmento
    if (strpos($content, 'wa.me') !== false) {
        preg_match('/wa\.me\/[0-9]+/', $content, $m);
        echo "  wa.me: " . (isset($m[0]) ? $m[0] : 'none') . "\n";
    }
}
