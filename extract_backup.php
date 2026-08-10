<?php
// Extrae postmeta originales del backup y los restaura para los 3 posts afectados
$backupFile = '/home/abgroup/web/anabolicgroup.com/backups/db-before-phone-20260810.sql';
$data = file_get_contents($backupFile);
echo "Backup size: " . strlen($data) . "\n";

// Buscar los INSERT de postmeta
preg_match_all('/INSERT INTO `wp_buDIJ_postmeta` VALUES(.*?);\s/s', $data, $m);
echo "Insert postmeta encontrados: " . count($m[1]) . "\n";
foreach ($m[1] as $i => $chunk) {
    if (preg_match('/\((\d+),\d+,\'([^\']*?)\',\'(.*?)\'\)/', $chunk, $match)) {
        // No confiable con regex multiline - mejor buscar por post_id
    }
}
echo "Nota: busqueda via SQL directo es mas fiable\n";
