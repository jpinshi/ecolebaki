<?php
session_start();

if (isset($_SESSION['uid'])) {
  include_once 'subscritController.php';
  $sub=new subscritController();
  if ($_SERVER['REQUEST_METHOD']=='POST') {


      $sub->Add(
        $_POST['name'],
        $_POST['sex'],
        $_POST['phone'],
        $_POST['town'],
        $_POST['address'],
        $_POST['born_town'],
        $_POST['birthday'],
        $_POST['section'],
        $_POST['level'],
        $_POST['picture']
      );


  }else {
      if (isset($_GET['depart']) && isset($_GET['year']) && isset($_GET['object'])) {
        $sub->get_list_pupils($_GET['depart'],$_GET['object'],$_GET['year']);
      }else{
       $current_page=$_SERVER['REQUEST_URI'];
       if (strpos($current_page,'listpupils')) {
        $sub->get_list_pupils_actuals();
       }
       if (strpos($current_page,'listyears')) {
         echo json_encode($sub->get_list_years());
       }

      }
  }

}else {
  echo '<meta http-equiv="refresh" content=0;URL=login>';
}
