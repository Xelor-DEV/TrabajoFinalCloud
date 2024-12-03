<?php
include 'db_connection.php';
include 'db_json_handler.php';

header("Access-Control-Allow-Origin: *");
header(header: "Access-Control-Allow-Methods: POST, DELETE, PUT");  

if (json_last_error() === JSON_ERROR_NONE) {
    // Check if all necessary fields are present
    if (isset($data['user_id'])) {  // Cambiado de 'userid' a 'user_id'
        $user_id = $data['user_id']; 

        // Prepare the stored procedure call
        $stmt = $conn->prepare("CALL DeleteUserGame(?)");

        // Check if the preparation was successful
        if ($stmt === false) {
            echo json_encode(["error" => "Prepare failed: " . $conn->error]);
            exit();
        }

        // Bind the parameter
        $stmt->bind_param('s', $user_id);

        // Execute the statement
        if ($stmt->execute()) {
            echo json_encode(["message" => "User game entry deleted successfully"]);
        } else {
            echo json_encode(["error" => "Execute failed: " . $stmt->error]);
        }

        // Close the statement
        $stmt->close();
    } else {
        echo json_encode(["error" => "Invalid input data"]);
    }
} else {
    echo json_encode(["error" => "JSON decode error: " . json_last_error_msg()]);
}

// Close the connection
$conn->close();
?>
