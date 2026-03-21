<?php
//Please write back-end sign-in functions here

session_start();
if($_SESSION['role']==="player"){
    header("Location: player.html");
    exit();
}else if($_SESSION['role']==="manager"){
    header("Location: manager.html");
    exit();
}