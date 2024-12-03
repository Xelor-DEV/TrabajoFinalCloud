<?php
include 'db_connection.php';
include 'db_json_handler.php';

// Asumiendo que $data ya ha sido decodificado desde JSON
if (json_last_error() === JSON_ERROR_NONE) {
    // Verifica si todos los campos necesarios están presentes
    if (isset($data['userid']) && isset($data['time_in_seconds']) && isset($data['created_by'])) {
        $userid = $data['userid'];
        $time_in_seconds = $data['time_in_seconds'];
        $created_by = $data['created_by'];

        // Prepara la llamada al procedimiento almacenado
        $stmt = $conn->prepare("CALL InsertUser(?, ?, ?)");

        // Verifica si la preparación fue exitosa
        if ($stmt === false) {
            echo json_encode(["error" => "Prepare failed: " . $conn->error]);
            exit();
        }

        // Vincula los parámetros
        $stmt->bind_param('iis', $userid, $time_in_seconds, $created_by);

        // Ejecuta la instrucción
        if ($stmt->execute()) {
            echo json_encode(["message" => "New user inserted successfully"]);
        } else {
            echo json_encode(["error" => "Execute failed: " . $stmt->error]);
        }

        // Cierra la declaración
        $stmt->close();
    } else {
        echo json_encode(["error" => "Invalid input data"]);
    }
} else {
    echo json_encode(["error" => "JSON decode error: " . json_last_error_msg()]);
}

// Cierra la conexión
$conn->close();
?>
