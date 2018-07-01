<?php

$error = False;
$state = "nope";
$str1 = "null";
$str2 = "null";
$result = "No data";

$mysqli = new mysqli($_ENV["PHP_DB_HOST"],
                     $_ENV["PHP_DB_USER"],
                     $_ENV["PHP_DB_PASS"],
                     $_ENV["PHP_DB_BASE"]);

if ($mysqli->connect_errno) {
    $error = "Не удалось подключиться к MySQL: ($mysqli->connect_errno) $mysqli->connect_error";
} else {
  $state = "connected";
}

if (!$mysqli->set_charset("utf8")) {
    $error = "Не удалось установить кодировку utf8: $mysqli->error";
}

$query_idx = "SELECT id FROM test1";
if ($stmt = $mysqli->prepare($query_idx)) {
    $stmt->execute();
    $stmt->store_result();
    $rand_index = rand(1, $stmt->num_rows);
    $stmt->close();
}

$query_get = "SELECT t1.name, t2.name from test_db.test1 AS t1 LEFT JOIN test_db.test2 as t2 ON t1.id = t2.id WHERE t1.id=?";
if ($stmt = $mysqli->prepare($query_get)) {
    $stmt->bind_param("s", $rand_index);
    $stmt->execute();
    $stmt->store_result();
    $stmt->bind_result($str1, $str2);
    $stmt->fetch();
    $result = ("$str1 $str2 -- " . gethostname());
    $stmt->close();
}

print_r($str1, $str2, $result, gethostname());
