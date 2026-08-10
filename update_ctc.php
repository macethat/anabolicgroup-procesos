<?php
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';

$opt = get_option('ht_ctc_chat_options');
if ($opt && isset($opt['number']) && strpos($opt['number'], '6405') !== false) {
    $old = $opt['number'];
    $opt['number'] = str_replace(array('6405-9959','64059959','50764059959'), array('6099-0195','60990195','50760990195'), $opt['number']);
    update_option('ht_ctc_chat_options', $opt);
    echo "ht_ctc_chat_options: '$old' -> '{$opt['number']}'\n";
} else {
    echo "sin cambio en ht_ctc_chat_options\n";
    if ($opt) echo "actual number: " . (isset($opt['number']) ? $opt['number'] : '(no key)') . "\n";
}

// Oneclick whatsapp order
$opt2 = get_option('oneclick_whatsapp_order_settings');
if (is_string($opt2) && strpos($opt2, '6405') !== false) {
    $new = str_replace(array('6405-9959','64059959','50764059959'), array('6099-0195','60990195','50760990195'), $opt2);
    update_option('oneclick_whatsapp_order_settings', $new);
    echo "oneclick_whatsapp_order_settings actualizado\n";
} else {
    echo "oneclick_whatsapp_order_settings: " . (is_string($opt2) ? 'sin 6405' : gettype($opt2)) . "\n";
}
echo "---FIN---\n";
