<?php

error_reporting(0);
include("../connect.php");

$userid = $_POST['userid'];

$img = $_FILES['img']['name'];
$upload = "../images/".$img;
$tmp_name = $_FILES['img']['tmp_name'];
move_uploaded_file($tmp_name,$upload);

$sql = "INSERT INTO posts (userid,img) VALUES ($userid,'$img')";
$res = $con->query($sql);


