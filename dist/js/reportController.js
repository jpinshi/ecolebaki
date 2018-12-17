app.controller('CtrlStudent', function (factoryStudent,$scope,$filter) {
    // alert(document.querySelector('#lbl_year').innerHTML);

    $scope.isVisibilityPay = false;
    $scope.sendRequestTab = function () {
        if ($scope.cbo_year != undefined && $scope.cbo_frais != undefined && $scope.cbo_promotion != undefined) {
            $scope.tabGroupPupils = [];
            var promotion = $scope.cbo_promotion.toString().trim().split(" ");
            console.log(promotion.length);
            var level = promotion[0].substring(0, 1);
            var option = promotion[1];
            console.log("Level is :" + level + " option is:" + option);
            //console.log("FRAIS :"+$scope.cbo_frais+" PROMOTION :"+$scope.cbo_promotion+" ANNEE SCOLAIRE:"+$scope.cbo_year);
            $scope.arrayGroup = "";
            $scope.pupilGroup = [];
            var departement = document.querySelector('#lbldepartement').innerHTML;
            var url = "../controllers/TaskPayment.php?departement=" + departement + "&year=" + $scope.cbo_year + "&frais=" + $scope.cbo_frais + "&level=" + level + "&option=" + option;
            factoryStudent.getListPayment($scope.cbo_year,level,option,$scope.cbo_frais,departement).then(
                function(response){
                    console.log('Response:',response);
                   if (response.pupils!=undefined) {
                        $scope.isVisibilityPay=true;
    
                   }
                    $scope.tablePay=response.pupils;
                    $scope.totalSlice=0;
                    //console.log("Total slice: ",$scope.totalSlice);
                    switch ($scope.cbo_frais.trim()) {
                        case "1TRF":
                            $scope.totalSlice=parseInt(document.querySelector('#lbl1TRF').innerHTML);
                            break;
                        case "2TRF":
                            $scope.totalSlice=parseInt(document.querySelector('#lbl2TRF').innerHTML);
                            break;
                        case "3TRF":
                            $scope.totalSlice=parseInt(document.querySelector('#lbl3TRF').innerHTML);
                            break;
                        case "SUB":
                            $scope.totalSlice=parseInt(document.querySelector('#lblSUB').innerHTML);
                            break;
                        case "RESUB":
                            $scope.totalSlice=parseInt(document.querySelector('#lblRESUB').innerHTML);
                            break;
                        default:
                            break;
                    }
                    $scope.totalPupils=parseInt(response.counter[0].COUNTER);
                    $scope.totalGlobal=parseInt($scope.totalPupils) * parseInt($scope.totalSlice);
                    console.log("Total pupils: ",$scope.totalPupils);
                    console.log("Total slice: ",$scope.totalSlice);
                    console.log("Total global: ",$scope.totalGlobal);
                 //   alert($scope.totalSlice);
                   // alert($scope.totalPupils)
                    $scope.totalTabpay=0;
                    angular.forEach($scope.tablePay,function(value,key){
                        $scope.totalTabpay+=parseInt(value._AMOUNT);
    
                    });
                       $scope.resteTabpay = parseInt($scope.totalGlobal) - parseInt($scope.totalTabpay);
                        console.log("Total pay:",$scope.totalTabpay);
                        console.log("Rows Students :"+$scope.pupilGroup.length);
    
                },
                function(error){
                    console.log(error);
                }
            );

        }
    }
    $scope.tablePayFormat=[];
    $scope.isVisibeCtrl=false;
    $scope.PrinteTabPay=function(){


        $scope.totalGlobal=parseInt($scope.totalPupils) * parseInt($scope.totalSlice);

        $scope.nameCurrent="";
        $scope.amount=0;
        $scope.tbPrint=[];
        angular.forEach($scope.tablePay,function(value,key){
            $scope.tbPrint[key]=value;
        })
        angular.forEach($scope.tbPrint,function(value,key){
            if ($scope.nameCurrent!=value._NAME) {
                angular.forEach($scope.tablePay,function(data,index){
                    if(data._NAME==value._NAME){
                        $scope.amount+=parseInt(data._AMOUNT);
                        delete $scope.tbPrint[index];
                    }
                });
            }
            var pupilFormat={
                mat:value._MAT,
                namePupil:value._NAME,
                sexPupil:value._SEX,
                amount:$scope.amount
            };
            $scope.tablePayFormat.push(pupilFormat);
            $scope.amount=0;
            $scope.nameCurrent="";
        })
        console.log("Datas Format:",JSON.stringify($scope.tablePayFormat));
        $scope.totalPayPrint=0;
        $scope.totalrestePay=0;
        angular.forEach($scope.tablePayFormat,function(value,key){
            $scope.totalPayPrint+=value.amount;
        });
        $scope.totalrestePay=$scope.totalGlobal-$scope.totalPayPrint;

        $scope.isVisibeCtrl=true;
        document.querySelector('#menuBar').style.display="none";

    }
    $scope.print=function(){
        document.querySelector('#btnprint').style.display="none";
        document.querySelector('#btnqprint').style.display="none";
        window.print();
        window.location.reload();
        //$scope.isVisibeCtrl=false;
        //document.querySelector('#menuBar').style.display="block";

    }
    $scope.quitprint = function(){
        window.location.reload();
    }

});