<?php

session_start();
include_once 'db.php';

class payments {

    private static $reqGetPupilPayInfos = "SELECT pay._IDPAY AS id_pay, spay._LABELSLICE AS slice_pay, sfees._LABEL AS fee_object, pay._AMOUNT AS amount_payed, pay._DATEPAY AS date_pay 
                    FROM t_payment pay 
                    JOIN t_school_fees sfees ON pay._OBJECT=sfees._CODE
                    JOIN t_slice_payment spay ON spay._CODESLICE=pay._CODE_SLICE 
                    WHERE pay._MATR=:matr AND pay._ANASCO=:anasco";
    private static $reqGetPaiementsPupilsActual = "SELECT DISTINCT(pupils._ID) as id, pupils._MAT as matricule,UPPER(pupils._NAME) AS name_pupil,pupils._SEX AS gender,subscrit._CODE_CLASS AS level,subscrit._CODE_SECTION as section
                    FROM t_students AS pupils JOIN t_payment AS payments
                    ON pupils._MAT=payments._MATR JOIN t_subscription subscrit ON pupils._MAT=subscrit._MATR_PUPIL
                    WHERE _DEPARTMENT=:department AND _ANASCO=:year";
    private static $reqInsertPay = "INSERT INTO t_payment (_IDPAY,_MATR,_CODE_SLICE,_OBJECT,_DATEPAY,_TIMEPAY,_AMOUNT,_ANASCO,_USER_AGENT,_DEPARTMENT) 
                    VALUES(:idpay,:matr,:codeslice,:objectpay,:datepay,:timepay,:amount,:anasco,:user,:department)";
    private static $reqGetSliceInfos = "SELECT spay.*, sfees._LABEL AS _OBJECT_PAY FROM t_slice_payment spay
                    JOIN t_school_fees sfees ON sfees._CODE = spay._CODE_FEES
                    WHERE spay._CODESLICE = ?";
    private static $getSliceSumPaidByPupil = "SELECT SUM(_AMOUNT) AS sum_slice_paid FROM t_payment WHERE _CODE_SLICE = ? AND _MATR = ?";

    public function getPaiementsPupils($direction, $year) {
        $db = getDB();
        $query_sql = "SELECT pupils._ID as id, pupils._MAT as matricule,pupils._NAME AS name_pupil,pupils._SEX AS gender,subscrit._CODE_CLASS AS level,
        subscrit._CODE_SECTION AS section,pupils._PICTURE as picture,pupils._PHONE AS phone, pupils._ADRESS AS adress, pupils._BIRTHDAY AS datenaiss,pupils._BIRTHPLACE as townBorn,pupils._PROVINCE AS townFrom
                    FROM t_students AS pupils JOIN t_payment AS payments
                    ON pupils._MAT=payments._MATR JOIN t_subscription subscrit ON pupils._MAT=subscrit._MATR_PUPIL
                    WHERE _DEPARTMENT=:department AND _ANASCO=:year";

        $query_execute = $db->prepare($query_sql);
        $query_execute->execute
                (
                array
                    (
                    'department' => $direction,
                    'year' => $year,
                //'object'=>$object,
                //'resub'=>'RESUB'
                )
        );

        $tabs = $query_execute->fetchAll(PDO::FETCH_OBJ);
        for ($i = 0; $i < sizeof($tabs); $i++) {
            
        }
        $response = json_encode($tabs);
        echo $response;
    }

    public function getPaiementsPupilsActual() {

        $query_execute = queryDB(self::$reqGetPaiementsPupilsActual, [
            'department' => $_SESSION['direction'],
            'year' => $_SESSION['anasco']
        ]);

        $tabs = $query_execute->fetchAll();
        $response = json_encode($tabs);
        $array_paie = array();
        for ($i = 0; $i < sizeof($tabs); $i++) {
            $matricule = $tabs[$i]->matricule;
            $pupil_payments_infos = queryDB(self::$reqGetPupilPayInfos, ['matr' => $matricule, 'anasco' => $_SESSION['anasco']]);
            $array_get = [
                'id' => $tabs[$i]->id,
                'matricule' => $matricule,
                'name_pupil' => $tabs[$i]->name_pupil,
                'gender' => $tabs[$i]->gender,
                'level' => $tabs[$i]->level,
                'section' => $tabs[$i]->section,
                'payinfo' => $pupil_payments_infos->fetchAll()
            ];

            $array_paie[$i] = $array_get;
        }
        // echo 'Anne: '. $_SESSION['anasco'];
        return json_encode($array_paie);
    }

    public function getFees() {
        $db = getDB();
        $query = "SELECT * FROM t_school_fees WHERE _STATUS=:status";
        $query_execute = $db->prepare($query);
        $query_execute->execute
                (
                array
                    (
                    'status' => 'active'
                )
        );
        return $query_execute->fetchAll(PDO::FETCH_OBJ);
    }

    public function addPayment($data) {
        $db = getDB();
        $payGenerate = "PAY-" . time();

        $resultSliceInfos = queryDB(self::$reqGetSliceInfos, [$data['slice']]);

        if ($resultSliceInfos == TRUE) {

            $ds = $resultSliceInfos->fetchAll();
            $sliceInfos = $ds[0];
            $resultInsert = queryDB(self::$reqInsertPay, [
                'idpay' => $payGenerate,
                'matr' => $data['mat_pupil'],
                'codeslice' => $data['slice'],
                'objectpay' => $sliceInfos->_CODE_FEES,
                'datepay' => date('d/m/Y'),
                'timepay' => date('H:i:s'),
                'amount' => $data['amount'],
                'anasco' => $_SESSION['anasco'],
                'user' => $_SESSION['uid'],
                'department' => $_SESSION['direction']
            ]);

            $result = queryDB(self::$getSliceSumPaidByPupil, [$data['slice'], $data['mat_pupil']]);
            $sliceSumPaid = $result->fetch();

            if ($resultInsert == TRUE) {
                //varaibles for the invoice data here
                $remaining_amount = $sliceInfos->_AMOUNT - $sliceSumPaid->sum_slice_paid;

                $_SESSION['namePupil'] = $data['name_pupil'];
                $_SESSION['idpay'] = $payGenerate;
                $_SESSION['level'] = ($data['level'] == 1) ? $data['level'] . "ère " . $data['section'] : $data['level'] . "ème " . $data['section'];
                $_SESSION['amount'] = $data['amount'];
                $_SESSION['motifPay'] = $sliceInfos->_LABELSLICE . "/" . $sliceInfos->_OBJECT_PAY;
                $_SESSION['remaining_amount'] = $remaining_amount;

                $result = 1;
            } else {

                $result = 0;
            }
        } else {

            $result = 0;
        }

        echo $result;
    }

    public function loadSlicesList() {
        $query = "SELECT _CODESLICE, _LABELSLICE FROM t_slice_payment LIMIT 0,4";
        $result = queryDB($query);

        $json = [];
        while ($data = $result->fetch()) {
            $json[$data->_CODESLICE][] = $data->_LABELSLICE;
        }

        // envoi du résultat au success
        echo json_encode($json);
    }

    public function getPaymentsCustomized($param) {
        
        
        $level = $param['level'];
        $option = $param['option'];
        $year = $param['year'];
        $departement = $param['departement'];
        $frais = $param['frais'];

        $Query = "SELECT pupils._MAT,pupils._NAME,pupils._SEX,payment._AMOUNT,payment._IDPAY,payment._DATEPAY,payment._TIMEPAY FROM t_payment payment JOIN t_students pupils ON payment._MATR=pupils._MAT
          JOIN t_subscription subscript ON pupils._MAT=subscript._MATR_PUPIL
          WHERE payment._ANASCO=:year AND payment._CODE_SLICE=:frais AND subscript._CODE_CLASS=:level AND subscript._CODE_SECTION=:option
          AND payment._DEPARTMENT=:departement ORDER BY payment._DATEPAY DESC";
        $db = getDB();
        $sql_prepare = $db->prepare($Query);
        $sql_prepare->execute(
                array(
                    "year" => $year,
                    "frais" => $frais,
                    "level" => $level,
                    "option" => $option,
                    "departement" => $departement
                )
        );
        $response = $sql_prepare->fetchAll();
        $Query = "SELECT count(DISTINCT(students._MAT)) AS COUNTER FROM t_students students JOIN t_payment payment ON students._MAT =payment._MATR" .
                " JOIN t_subscription subscript ON students._MAT=subscript._MATR_PUPIL" .
                " WHERE payment._ANASCO=:year AND subscript._CODE_CLASS=:level AND subscript._CODE_SECTION=:option AND payment._DEPARTMENT=:departement";

        $sql_prepare = $db->prepare($Query);
        $sql_prepare->execute(
                array(
                    "year" => $year,
                    "level" => $level,
                    "option" => $option,
                    "departement" => $departement
                )
        );
        $rowers_response = $sql_prepare->fetchAll();

        $tabPay = array();
        $tabCustomized = [];
        foreach ($response as $key => $value) {
            $tabCurrent = array(
                "_MAT" => $value->_MAT,
                "_NAME" => $value->_NAME,
                "_SEX" => $value->_SEX,
                "_AMOUNT" => $value->_AMOUNT,
                "_IDPAY" => $value->_IDPAY,
                "_DATEPAY" => $value->_DATEPAY,
                "_TIMEPAY" => $value->_TIMEPAY
            );
            $tabPay[$key] = $tabCurrent;
        }
        $tabCustomized["pupils"] = $tabPay;
        $tabCustomized["counter"] = $rowers_response;
        return json_encode($tabCustomized);
    }

}
