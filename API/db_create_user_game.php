<?php
include 'db_connection.php';
include 'db_json_handler.php';

header("Access-Control-Allow-Origin: *");
header(header: "Access-Control-Allow-Methods: POST, DELETE, PUT");  

// Verifica que no haya errores en el JSON
if (json_last_error() === JSON_ERROR_NONE) {
    // Verifica si todos los campos necesarios están presentes
    if (isset($data['username']) && isset($data['email']) && isset($data['password']) && isset($data['created_by'])) {
        $username = $data['username'];
        $email = $data['email'];
        $password = $data['password'];
        $created_by = $data['created_by'];

        // Prepara la llamada al procedimiento almacenado
        $stmt = $conn->prepare("CALL CreateUserGame(?, ?, ?, ?)");

        // Verifica si la preparación fue exitosa
        if ($stmt === false) {
            echo json_encode(["error" => "Prepare failed: " . $conn->error]);
            exit();
        }

        // Vincula los parámetros
        $stmt->bind_param('ssss', $username, $password, $email, $created_by);

        // Ejecuta la declaración
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
