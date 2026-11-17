<?php
// Proxy PHP -> app Python (127.0.0.1:8000)
// Permite publicar la app sin reverse proxy en nginx (proxy_http no disponible).
$backend = 'http://127.0.0.1:8000';
$uri = $_SERVER['REQUEST_URI'] ?? '/';
$method = $_SERVER['REQUEST_METHOD'] ?? 'GET';

function req_headers() {
    if (function_exists('getallheaders')) {
        $h = getallheaders();
        if ($h) return $h;
    }
    $h = [];
    foreach ($_SERVER as $k => $v) {
        if (strpos($k, 'HTTP_') === 0) {
            $name = str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($k, 5)))));
            $h[$name] = $v;
        }
    }
    return $h;
}

$headers = [];
foreach (req_headers() as $k => $v) {
    $lk = strtolower($k);
    if (in_array($lk, ['host','content-length','connection','accept-encoding'])) continue;
    $headers[] = "$k: $v";
}

$resp_headers = [];
$ch = curl_init($backend . $uri);
curl_setopt_array($ch, [
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_CUSTOMREQUEST  => $method,
    CURLOPT_HTTPHEADER     => $headers,
    CURLOPT_FOLLOWLOCATION => false,
    CURLOPT_TIMEOUT        => 30,
    CURLOPT_HEADERFUNCTION => function ($ch, $header) use (&$resp_headers) {
        $parts = explode(':', $header, 2);
        if (count($parts) === 2) {
            $name = strtolower(trim($parts[0]));
            $val  = trim($parts[1]);
            if (in_array($name, ['location', 'set-cookie', 'content-disposition', 'cache-control'])) {
                $resp_headers[] = [$name, $val];
            }
        }
        return strlen($header);
    },
]);
if (!in_array($method, ['GET','HEAD'])) {
    curl_setopt($ch, CURLOPT_POSTFIELDS, file_get_contents('php://input'));
}
$body   = curl_exec($ch);
$status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$ctype  = curl_getinfo($ch, CURLINFO_CONTENT_TYPE);
$err    = curl_error($ch);
curl_close($ch);

if ($body === false) {
    http_response_code(502);
    header('Content-Type: text/plain; charset=utf-8');
    echo "Bad Gateway: " . $err;
    exit;
}

http_response_code($status ?: 502);
foreach ($resp_headers as [$name, $val]) {
    if ($name === 'set-cookie') {
        header('Set-Cookie: ' . $val, false);
    } else {
        header(ucwords($name) . ': ' . $val);
    }
}
if ($ctype) header('Content-Type: ' . $ctype);
echo $body;
