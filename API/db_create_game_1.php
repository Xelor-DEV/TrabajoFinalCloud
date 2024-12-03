<?php
include 'db_connection.php';
include 'db_json_handler.php';

if (json_last_error() === JSON_ERROR_NONE) {
    // Check if all necessary fields are present
    if (isset($data['userid']) && isset($data['time_in_seconds']) && isset($data['created_by'])) {
        $userid = $data['userid']; 
        $time_in_seconds = $data['time_in_seconds']; 
        $created_by = $data['created_by'];

        // Prepare the stored procedure call
        $stmt = $conn->prepare("CALL CreateGame1(?, ?, ?)");

        // Check if the preparation was successful
        if ($stmt === false) {
            echo json_encode(["error" => "Prepare failed: " . $conn->error]);
            exit();
        }

        // Bind the parameters
        $stmt->bind_param('sss', $userid, $time_in_seconds, $created_by);

        // Execute the statement
        if ($stmt->execute()) {
            echo json_encode(["message" => "New game entry inserted successfully"]);
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