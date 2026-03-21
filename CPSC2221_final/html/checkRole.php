<?php
session_start();
if($_POST['role']==="player"){
    $_SESSION['role']="player";
}else if($_POST['role']==="manager"){
    $_SESSION['role']="manager";
}