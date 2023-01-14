<?php


$host = "localhost";
$user = "root";
$pass = "";
$dbname = "project";

$con = mysqli_connect($host,$user,$pass,$dbname);

if(!$con){
    echo "connected";
}






?>