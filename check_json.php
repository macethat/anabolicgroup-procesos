<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
foreach (array(13263 => 'Inicio', 3784 => 'Header 4', 414 => 'Footer 1') as $pid => $name) {
    $data = get_post_meta($pid, '_elementor_data', true);
    $json = json_decode($data, true);
    $valid = $json !== null && json_last_error() === JSON_ERROR_NONE;
    echo "$pid | $name | len=" . strlen($data) . " | json=" . ($valid ? 'VALIDO' : 'INVALIDO: ' . json_last_error_msg()) . "\n";
    if (!$valid) {
        echo "  inicio del string: " . substr($data, 0, 200) . "\n";
    }
}
