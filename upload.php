<?php

error_reporting(0);
include("connect.php");

$id =$_POST['id'];
$img[] = $_FILES['img']['name'];
$img_tmp[] = $_FILES['img']['tmp_name'];

foreach($img as $key =>$value){
    foreach($img_tmp as $key =>$tmpvalue){
       if(move_uploaded_file($tmpvalue,'images/'.$value)){
           $sql = "INSERT INTO `imgs`(img,userid)VALUES ('$value',$id)";
           $res = $con->query($sql);
           if($res){
               echo json_encode("success");
           }else{
               echo json_encode("error");
           }

       }
    }
}



?>