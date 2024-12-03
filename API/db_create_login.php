<?php
include 'db_connection.php';
include 'db_json_handler.php';

header("Access-Control-Allow-Origin: *");
header(header: "Access-Control-Allow-Methods: POST, DELETE, PUT");  

if (json_last_error() === JSON_ERROR_NONE) {
    if (isset($data['username']) && isset($data['password'])) {
        $username = $data['username'];
        $password = $data['password'];

        // Prepara la llamada al procedimiento almacenado
        $stmt = $conn->prepare("CALL CreateLogin(?, ?, 'admin', @userid)");

        if ($stmt === false) {
            echo json_encode(["error" => "Prepare failed: " . $conn->error]);
            exit();
        }

        $stmt->bind_param('ss', $username, $password);

        if ($stmt->execute()) {
            // Consulta el valor de salida del procedimiento almacenado
            $resultQuery = $conn->query("SELECT @userid AS userId");
            if ($resultQuery) {
                $resultRow = $resultQuery->fetch_assoc();
                $userId = $resultRow['userId'];

                if ($userId !== null) {
                    echo json_encode(["message" => "Login successful", "userId" => $userId]);
                } else {
                    echo json_encode(["message" => "Login failed", "error" => "User not found or inactive"]);
                }
            } else {
                echo json_encode(["error" => "Output query failed: " . $conn->error]);
            }
        } else {
            echo json_encode(["error" => "Execute failed: " . $stmt->error]);
        }

        $stmt->close();
    } else {
        echo json_encode(["error" => "Invalid input data"]);
    }
} else {
    echo json_encode(["error" => "JSON decode error: " . json_last_error_msg()]);
}

$conn->close();
?>