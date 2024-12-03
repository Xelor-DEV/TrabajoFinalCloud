<?php
include 'db_connection.php';
include 'db_json_handler.php';

if (json_last_error() === JSON_ERROR_NONE) {
    // Verificar si el campo necesario está presente
    if (isset($data['gameid'])) {
        $gameid = $data['gameid']; 

        // Preparar la llamada al procedimiento almacenado
        $stmt = $conn->prepare("CALL DeleteGame3(?)");

        // Verificar si la preparación fue exitosa
        if ($stmt === false) {
            echo json_encode(["error" => "Prepare failed: " . $conn->error]);
            exit();
        }

        // Vincular el parámetro
        $stmt->bind_param('s', $gameid);

        // Ejecutar la declaración
        if ($stmt->execute()) {
            echo json_encode(["message" => "Game entry deleted successfully"]);
        } else {
            echo json_encode(["error" => "Execute failed: " . $stmt->error]);
        }

        // Cerrar la declaración
        $stmt->close();
    } else {
        echo json_encode(["error" => "Invalid input data"]);
    }
} else {
    echo json_encode(["error" => "JSON decode error: " . json_last_error_msg()]);
}

// Cerrar la conexión
$conn->close();
?>
