<?php
// Compara el _elementor_data corrupto actual vs el del backup limpio
require_once '/home/abgroup/web/anabolicgroup.com/public_html/wp-load.php';
$current = get_post_meta(13263, '_elementor_data', true);

// Extraer del backup limpio (db-before-phone-safe)
$backupFile = '/home/abgroup/web/anabolicgroup.com/backups/db-before-phone-safe-20260810.sql';
$sql = file_get_contents($backupFile);
echo "backup size: " . strlen($sql) . "\n";

// Buscar la fila con meta_id 71061 en el backup
preg_match_all('/\(71061,[^;]*?\)/', $sql, $matches);
echo "fila encontrada: " . count($matches[0]) . "\n";
if ($matches[0]) {
    $row = $matches[0][0];
    echo "longitud fila backup: " . strlen($row) . "\n";
    // extraer meta_value (entre comillas simples)
    preg_match("/'((?:[^'\\\\]|\\\\.)*)'\\)?$/", $row, $mv);
    if ($mv) {
        $backupValue = stripslashes($mv[1]);
        echo "backup meta_value len: " . strlen($backupValue) . "\n";
        echo "backup tiene 6099: " . (strpos($backupValue, '6099') !== false ? 'SI' : 'NO') . "\n";
        echo "backup tiene 6405: " . (strpos($backupValue, '6405') !== false ? 'SI' : 'NO') . "\n";
        $j = json_decode($backupValue, true);
        echo "backup JSON: " . ($j !== null ? 'VALIDO' : 'INVALIDO ' . json_last_error_msg()) . "\n";
    }
}
