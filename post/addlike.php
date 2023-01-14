<?php

error_reporting(0);

include("../connect.php");

$userid = $_POST['userid'];
$postid = $_POST['postid'];

$sql = "SELECT * FROM `like` WHERE userid = $userid AND postid =$postid ";
$res = $con->query($sql);

$count = $res->num_rows;

if($count > 0){
    $sql = "DELETE FROM `like` WHERE userid = $userid AND postid =$postid ";
    $res = $con->query($sql);

    // $sql = "SELECT * FROM `posts` WHERE id = $postid ";
    // $res = $con->query($sql);
    
    // while($row =$res->fetch_assoc()){
    //     $likes = $row['likes'];
    // }

    // $sql = "UPDATE posts SET likes = $likes - 1 WHERE id = $postid";
    // $res = $con->query($sql);

    if($res){
        echo json_encode("disliked");
    }
}else{

    $sql = "INSERT INTO `like` (userid,postid) VALUES ($userid,$postid)";
    $res = $con->query($sql);
    
    // $sql = "SELECT * FROM `posts` WHERE id = $postid ";
    // $res = $con->query($sql);
    
    // while($row =$res->fetch_assoc()){
    //     $likes = $row['likes'];
    // }

    // $sql = "UPDATE posts SET likes = $likes + 1 WHERE id = $postid";
    // $res = $con->query($sql);

    if($res){
        echo json_encode("liked");
    }
}