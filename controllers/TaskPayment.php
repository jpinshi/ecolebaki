<?php

session_start();
include_once 'paymentController.php';
include_once 'RepportController.php';

if (isset($_SESSION['uid'])) {
    $payment = new payments();
    $repport = new RepportController();
    if ($_SERVER['REQUEST_METHOD'] == 'GET') {
        if (isset($_GET['getslices'])) {
            $payment->loadSlicesList();
        } else if (isset($_GET['invoice'])) {
            $repport->generateInvoice();
        } else if (isset($_GET['departement'])) {
          echo $payment->getPaymentsCustomized($_GET);
        } else if (!isset($_GET['name'])) {
            echo $payment->getPaiementsPupilsActual();
        } 
    } else {
        $payment->addPayment($_POST);
    }
} else {
    echo '<meta http-equiv="refresh" content=0;URL=login>';
}
