<?php
require '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
echo 'theme=' . get_option('stylesheet') . PHP_EOL;
echo 'template=' . get_option('template') . PHP_EOL;
echo 'fn=' . (function_exists('nutritix_form_login') ? 'yes' : 'no') . PHP_EOL;
$handles = array('nutritix-child-table-fix');
foreach ($handles as $h) {
    echo "handle $h registered=" . (wp_style_is($h, 'registered') ? 'yes' : 'no') . PHP_EOL;
}