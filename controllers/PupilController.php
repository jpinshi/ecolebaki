<?php

session_start();
include_once 'db.php';

class PupilController {

   
    private static $reqGetActualPupilsList = "SELECT DISTINCT(pupils._ID) AS id, pupils._MAT AS matricule,UPPER(pupils._NAME) AS name_pupil,pupils._SEX AS gender,subscrit._CODE_CLASS AS level,subscrit._CODE_SECTION AS section
                    FROM t_students pupils
                    JOIN t_payment payments ON pupils._MAT=payments._MATR
                    JOIN t_subscription subscrit ON pupils._MAT=subscrit._MATR_PUPIL
                    WHERE _DEPARTMENT=:department AND subscrit._ANASCO=:year";
    private static $reqGetPupilsToReEnrol = "SELECT DISTINCT(pupils._ID) AS id, pupils._MAT AS matricule,UPPER(pupils._NAME) AS name_pupil,pupils._SEX AS gender,subscrit._CODE_CLASS AS level,subscrit._CODE_SECTION AS section
                    FROM t_students pupils
                    JOIN t_payment payments ON pupils._MAT=payments._MATR
                    JOIN t_subscription subscrit ON pupils._MAT=subscrit._MATR_PUPIL
                    WHERE _DEPARTMENT=:department AND subscrit._ANASCO=:year
                    AND subscrit._MATR_PUPIL NOT IN (SELECT _MATR_PUPIL FROM t_subscription WHERE _ANASCO=:actualyear)";
    private static $reqInsertPay = "INSERT INTO t_payment (_IDPAY,_MATR,_CODE_SLICE,_OBJECT,_DATEPAY,_TIMEPAY,_AMOUNT,_ANASCO,_USER_AGENT,_DEPARTMENT) 
                    VALUES(:idpay,:matr,:codeslice,:objectpay,:datepay,:timepay,:amount,:anasco,:user,:department)";
    private static $reqInsertCollegeYears = "INSERT INTO t_subscription (_MATR_PUPIL,_CODE_CLASS,_CODE_SECTION,_DATE_SUB,_CODE_PAY,_CODE_AGENT,_ANASCO)
                    VALUES (:matr,:codeClass,:codeSection,:dateSub,:codePay,:codeAgent,:anasco)";
    private static $reqGetSlice = "SELECT * FROM t_slice_payment WHERE _CODESLICE = ?";
    private static $reqGetSliceInfos = "SELECT spay.*, sfees._LABEL AS _OBJECT_PAY FROM t_slice_payment spay
                    JOIN t_school_fees sfees ON sfees._CODE = spay._CODE_FEES
                    WHERE spay._CODESLICE = ?";
    private static $getSliceSumPaidByPupil = "SELECT SUM(_AMOUNT) AS sum_slice_paid FROM t_payment WHERE _CODE_SLICE = ? AND _MATR = ?";


    public static function getPupilsToReEnrol() {
        
        $query_execute = queryDB(self::$reqGetPupilsToReEnrol, [
            'department' => $_SESSION['direction'],
            'year' => self::getLastYear(),
            'actualyear'    =>  $_SESSION['anasco']
        ]);
        
        $ds = $query_execute->fetchAll();
        return json_encode($ds);
    }

    public static function getFees() {
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
        return $query_execute->fetchAll();
    }

    public static function addPayment($data) {
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

    

    public static function reEnrolPupil($data) {
        $payGenerate = "PAY-" . time();
        $db = getDB();
        
        try {

            $db->beginTransaction();

            $execQuery1 = $db->prepare(self::$reqInsertPay);
            $execQuery1->execute([
                'idpay' => $payGenerate,
                'matr' => $data['mat_pupil'],
                'codeslice' => '1TRF',
                'objectpay' => 'FRSCO',
                'datepay' => date('d/m/Y'),
                'timepay' => date('H:i:s'),
                'amount' => $data['amount'],
                'anasco' => $_SESSION['anasco'],
                'user' => $_SESSION['uid'],
                'department' => $_SESSION['direction']
            ]);

            $execQuery2 = $db->prepare(self::$reqInsertCollegeYears);
            $execQuery2->execute([
                "matr" => $data['mat_pupil'],
                "codeClass" => $data['new_level'], //je dois verifier si la transaction fonctionne, pour cela je dois mettre une valeur vide ici
                "codeSection" => $data['new_section'],
                "dateSub" => date('d/m/Y'),
                "codePay" => $payGenerate,
                "codeAgent" => $_SESSION['uid'],
                "anasco" => $_SESSION['anasco']
            ]);

            $resultSliceInfos = $db->prepare(self::$reqGetSlice);
            $resultSliceInfos->execute(['1TRF']);

            $db->commit();

            $sliceAmount = $resultSliceInfos->fetch();
            $total1TRF = $sliceAmount->_AMOUNT;
            $remaining_amount = $total1TRF - $data['amount'];
            
            $_SESSION['namePupil'] = $data['name_pupil'];
            $_SESSION['idpay'] = $payGenerate;
            $_SESSION['level'] = ($data['new_level'] == 1) ? $data['new_level'] . "ère " . $data['new_section'] : $data['new_level'] . "ème " . $data['new_section'];
            $_SESSION['amount'] = $data['amount'];
            $_SESSION['motifPay'] = $remaining_amount == 0 ? "1ERE TRANCHE - FRAIS SCOLAIRE" : "ACOMPTE - 1ERE TRANCHE - FRAIS SCOLAIRE";
            $_SESSION['remaining_amount'] = $remaining_amount;
            return 1;
        } catch (PDOException $e){
            $db->rollBack();
            return json_encode($e->getMessage());
        } catch (\Throwable $th){
            $db->rollBack();
            return json_encode($th->getMessage());
        }
    }

    public static function getLastYear(){
        $result = queryDB("SELECT * FROM t_years_school ORDER BY year DESC LIMIT 0,2");
        $ds = $result->fetchAll();
        return $ds[1]->year;
    }

}
