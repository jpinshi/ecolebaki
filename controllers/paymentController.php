<?php
session_start();
include_once 'db.php';
class payments 
{
    public function getPaiementsPupils($direction,$year){
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
        for ($i=0; $i <sizeof($tabs) ; $i++) { 
            
        }
        $response=json_encode($tabs);
        echo $response;
    }
    public function getPaiementsPupilsActual(){

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
        $array_paie=array();
        for ($i=0; $i < sizeof($tabs); $i++) { 
            $matricule=$tabs[$i]->matricule;
            $query_paiement="SELECT * FROM t_payment pay JOIN t_school_fees sfees ON pay._CODE_SLICE=sfees._CODE  ".
                            "JOIN t_slice_payment spay ON spay._CODESLICE=pay._OBJECT WHERE pay._MATR=:matr AND pay._ANASCO=:anasco";
            $query_execute=$db->prepare($query_paiement);
            $query_execute->execute
        (
            array
            (
                'matr'=>$matricule,
                'anasco'=>$_SESSION['anasco']
            )
        );
        $array_get=array
        (
            'id'=>$tabs[$i]->id,
            'matricule'=>$matricule,
            'name_pupil'=>$tabs[$i]->name_pupil,
            'gender'=>$tabs[$i]->gender,
            'level'=>$tabs[$i]->level,
            'section'=>$tabs[$i]->section,
            'payinfo'=>$query_execute->fetchAll(PDO::FETCH_OBJ)
        );
        $array_paie[$i]=$array_get;
        }
       // echo 'Anne: '. $_SESSION['anasco'];
       return json_encode($array_paie);
    }
    public function getFees(){
        $db=getDB();
        $query="SELECT * FROM t_school_fees WHERE _STATUS=:status";
        $query_execute=$db->prepare($query);
        $query_execute->execute
        (
            array
            (
                'status'=>'active'
            )
        );
        return $query_execute->fetchAll(PDO::FETCH_OBJ);

    }
}
