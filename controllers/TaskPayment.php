<?php
include_once 'paymentController.php';
$payment=new payments();
if ($_SERVER['REQUEST_METHOD']='GET') {
    if (!isset($_GET['name'])) {
       echo $payment->getPaiementsPupilsActual();
    }
}