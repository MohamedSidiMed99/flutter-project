<?php

error_reporting(0);
include("../connect.php");

$userid = $_POST['userid'];

$sql  = "SELECT * FROM posts ORDER BY id DESC";
$res = $con->query($sql);

while($row = $res->fetch_assoc()){

    $postid = $row['id'];
    
    $sql1  = "SELECT * FROM `like` WHERE userid = $userid AND postid = $postid ";
    $res1 = $con->query($sql1);
    while($row1 = $res1->fetch_assoc()){
        $count = $res1->num_rows;

        if($count > 0){
            $row['like'] = "true";
        }
    }


    $sql1  = "SELECT * FROM `like` WHERE  postid = $postid ";
    $res1 = $con->query($sql1);
    while($row1 = $res1->fetch_assoc()){
        $count = $res1->num_rows;

        if($count > 0){
            $row['likesnumber'] = $count;
        }
    }

   

    $data[] = $row;


}

echo json_encode($data);