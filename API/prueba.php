<?php
include 'db_connection.php';
include 'db_json_handler.php';

if (json_last_error() === JSON_ERROR_NONE) {
    // Check if all necessary fields are present
    if (isset($data['username']) && isset($data['email']) && isset($data['password'])) {
        $username = $data['username'];
        $email = $data['email'];
        $password = $data['password'];

        // Prepare the stored procedure call
        $stmt = $conn->prepare("CALL InsertUser(?, ?, ?)");

        // Check if the preparation was successful
        if ($stmt === false) {
            echo json_encode(["error" => "Prepare failed: " . $conn->error]);
            exit();
        }

        // Bind the parameters
        $stmt->bind_param('sss', $username, $email, $password);

        // Execute the statement
        if ($stmt->execute()) {
            echo json_encode(["message" => "New user inserted successfully"]);
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