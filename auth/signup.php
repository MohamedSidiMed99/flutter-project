<?php

error_reporting(0);
include("../connect.php");

$name = $_POST['name'];
$email = $_POST['email'];
$pass = $_POST['pass'];

$sql = "SELECT * FROM users WHERE email = '$email'  ";
$res = $con->query($sql);

$count = $res->num_rows;

if($count > 0){
   echo json_encode(array("result"=>"already"));
}else{


    $sql = "INSERT INTO users(username,email,password) VALUES ('$name','$email','$pass')";
    $res = $con->query($sql);

    if($res){
        echo json_encode(array("result"=>"done"));
    }
   
}