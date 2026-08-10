<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
function scan($data, $pid, $name) {
    echo "=== $name ($pid) ===\n";
    $json = json_decode($data, true);
    if (!$json) { echo "  (JSON inválido)\n"; return; }
    $walk = function($el, &$walk) use ($pid, $name) {
        if (is_array($el)) {
            $txt = isset($el['text']) ? $el['text'] : (isset($el['title']) ? $el['title'] : '');
            if (is_string($txt) && strpos($txt, '6405') !== false) {
                echo "  id={$el['id']} widget={$el['elType']}: $txt\n";
            }
            foreach ($el as $k => $v) { if (is_array($v) || is_object($v)) { $walk($v, $walk); } }
        }
    };
    $walk($json, $walk);
}
scan(get_post_meta(414, '_elementor_data', true), 414, 'Footer 1');
scan(get_post_meta(3784, '_elementor_data', true), 3784, 'Header 4');
