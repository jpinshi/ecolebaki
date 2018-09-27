<?php
session_start();
include_once 'paymentController.php';

if (isset($_SESSION['uid'])) {
  $payment=new payments();
  if ($_SERVER['REQUEST_METHOD']='GET') {
      if (!isset($_GET['name'])) {
         echo $payment->getPaiementsPupilsActual();
      }
  }
}else{
echo '<meta http-equiv="refresh" content=0;URL=login>';
}
