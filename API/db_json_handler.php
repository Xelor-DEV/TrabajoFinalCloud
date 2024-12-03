<?php

$contentType = $_SERVER["CONTENT_TYPE"] ?? '';

if (strpos($contentType, "application/json") !== false) {
    $postData = file_get_contents("php://input");
    $data = json_decode($postData, true);
} elseif (strpos($contentType, "multipart/form-data") !== false) {
    $data = $_POST;
    $files = $_FILES;
} else {
    http_response_code(415);
    echo json_encode(["error" => "Unsupported content type"]);
    exit;
}

?>

