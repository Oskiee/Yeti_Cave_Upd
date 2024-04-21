<?php
session_start();
$is_auth = $_SESSION['user'] ?? false;
if ($is_auth) {
    $user_name = $_SESSION['user']['username'];
}
if ($is_auth) {
    session_destroy();
    header('Location: /localhost/index.php');
    exit();
}
?>
