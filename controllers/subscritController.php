<?php
session_start();
include_once 'db.php';
include_once 'LoadPicture.php';

class SubscritController
{

    public function __construct(){

    }
    public function ViewProperties(){
        echo json_encode($this);
    }

    public function Add($name,$sex,$phone,$town,$address,$born_town,$birthday,$section,$level,$picture){
        try{
        $matrGenerate=$_SESSION['direction'].time();
        if (strlen($picture)>0) {
               $fileImage=convertBase64ToImage($picture,time().".png");

        }else{
            $picture='avatar.png';
        }
        $db=getDB();
        $db->beginTransaction();
        $Query="INSERT INTO t_students (_MAT,_NAME,_SEX,_ADRESS,_PROVINCE,_BIRTHDAY,_BIRTHPLACE,_PHONE,_PICTURE)".
        " VALUES(:matr,:nom,:sex,:address,:province,:birthday,:birthplace,:phone,:picture)";

        $query_execute=$db->prepare($Query);
        $query_execute->execute(array(
            'matr'=>$matrGenerate,
            'nom'=>$name,
            'sex'=>$sex,
            'address'=>$address,
            'province'=>$town,
            'birthday'=>$birthday,
            'birthplace'=>$born_town,
            'phone'=>$phone,
            'picture'=>$fileImage
        ));
        $db->commit();
        $payGenerate="PAY-".time();

        $Query="INSERT INTO t_payment (_IDPAY,_MATR,_CODE_SLICE,_OBJECT,_DATEPAY,_TIMEPAY,_AMOUNT,_ANASCO,_USER_AGENT,_DEPARTMENT)".
               " VALUES (:idpay,:matr,:codeSlice,:object,:datepay,:timepay,:amount,:anasco,:userAgent,:department)";
               $db->beginTransaction();
               $query_execute=$db->prepare($Query);
               $query_execute->execute(array(
                   "idpay"=>$payGenerate,
                   "matr"=>$matrGenerate,
                   "codeSlice"=>"SUB",
                   "object"=>"SUB",
                   "datepay"=>__DATE__,
                   "timepay"=>__TIME__,
                   "amount"=>"10",
                   "anasco"=>$_SESSION['anasco'],
                   "userAgent"=>$_SESSION['uid'],
                   "department"=>$_SESSION['direction']
               ));
               $db->commit();


            $Query="INSERT INTO t_subscription (_MATR_PUPIL,_CODE_CLASS,_CODE_SECTION,_DATE_SUB,_CODE_PAY,_CODE_AGENT) ".
            " VALUES (:matr,:codeClass,:codeSection,:dateSub,:codePay,:codeAgent)";
            $db->beginTransaction();
            $query_execute=$db->prepare($Query);
            $query_execute->execute(array(
                "matr"=>$matrGenerate,
                "codeClass"=>($level==1?$level.'ere':$level.'eme'),
                "codeSection"=>$section,
                "dateSub"=>__DATE__,
                "codePay"=>$payGenerate,
                "codeAgent"=>$_SESSION['uid']

            ));
            $db->commit();

            $_SESSION['idpay']=$payGenerate;
            $_SESSION['namePupil']=$name;
            if($data->niveau==1){
                $_SESSION["level"]=$niveau."ere ".$section;
            }else{
                $_SESSION["level"]=$niveau."eme ".$section;
            }
            $_SESSION['subject']="Inscription";
            //$this->getPDFInvoiceLayout();

         echo '<meta http-equiv="refresh" content=0;URL=layoutinvoice>';
       }catch(Exception $e){
           echo $e->getMessage();
       }
    }
    public function get_list_pupils($direction,$year,$object){
        $db=getDB();
        $query_sql="SELECT pupils._ID as id, pupils._MAT as matricule,pupils._NAME AS name_pupil,pupils._SEX AS gender,subscrit._CODE_CLASS AS level,
        subscrit._CODE_SECTION AS section,pupils._PICTURE as picture,pupils._PHONE AS phone, pupils._ADRESS AS adress, pupils._BIRTHDAY AS datenaiss,pupils._BIRTHPLACE as townBorn,pupils._PROVINCE AS townFrom "
                    ."FROM t_students AS pupils JOIN t_payment AS payments "
                    ."ON pupils._MAT=payments._MATR JOIN t_subscription subscrit ON pupils._MAT=subscrit._MATR_PUPIL ".
                    "WHERE _DEPARTMENT=:department AND _ANASCO=:year AND (_OBJECT='RESUB' OR _OBJECT='SUB')";
        $query_execute=$db->prepare($query_sql);
        $query_execute->execute
        (
            array
            (
                'department'=>$direction,
                'year'=>$year,
                //'object'=>$object,
                //'resub'=>'RESUB'
            )
        );
        $tabs=$query_execute->fetchAll(PDO::FETCH_OBJ);
        $response=json_encode($tabs);
        echo $response;
    }
    public function get_list_pupils_actuals(){


        $db=getDB();
        $query_sql="SELECT pupils._ID as id, pupils._MAT as matricule,UPPER(pupils._NAME) AS name_pupil,pupils._SEX AS gender,subscrit._CODE_CLASS AS level,
        subscrit._CODE_SECTION as section "
                    ."FROM t_students AS pupils JOIN t_payment AS payments "
                    ."ON pupils._MAT=payments._MATR JOIN t_subscription subscrit ON pupils._MAT=subscrit._MATR_PUPIL ".
                    "WHERE _DEPARTMENT=:department AND _ANASCO=:year AND (_OBJECT='SUB' OR _OBJECT='RESUB')";
        $query_execute=$db->prepare($query_sql);
        $query_execute->execute
        (
            array
            (
                'department'=>$_SESSION['direction'],
                'year'=>$_SESSION['anasco']
            )
        );
        $tabs=$query_execute->fetchAll(PDO::FETCH_OBJ);
        $response=json_encode($tabs);
        $_SESSION['list_current_pupils']=$response;
        $_SESSION['counter_pupil']=sizeof(json_decode($response));
        echo $response;
    }
    public function get_list_years(){
        $db=getDB();
        $query="SELECT * FROM t_years_school ORDER BY year DESC LIMIT 0,3";
        $query_execute=$db->prepare($query);
        $query_execute->execute();
        $response=$query_execute->fetchAll(PDO::FETCH_OBJ);
        return $response;
    }


}
