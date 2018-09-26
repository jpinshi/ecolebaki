app.controller('ViewPupilsCtrl',function($scope,$http){
   // alert(document.querySelector('#lbl_year').innerHTML);
    $http.get('listyears').then(function(response){
        $scope.list_years=response.data.splice(1);
        $scope.activeTab=response.data[0];
        console.log($scope.list_years);
        $(document).ready(function() {
            
            var table=$('#dataTables-example').DataTable({
                ajax: {
                    url: "listpayments",
                    dataSrc:'',
                    
                },
                
                responsive:'true',
                columns:[
                    
                    { "data": "matricule" },
                    { "data": "name_pupil" },
                    { "data": "gender" },
                    { "data": "level" },
                    {"data":"section"}
                ]
            });
                
            $('#dataTables-example tbody').on('click', 'tr', function (e) {
                var data = table.data();
                var index=e.target._DT_CellIndex.row;
                console.log(data);

              document.querySelector('#btn_date_after').click();
               document.querySelector('#LabelName').innerHTML=data[index].name_pupil;
               console.log("List pay: ",JSON.stringify(data[index].payinfo));
               var tablePay=$('#dataTables-paiement').DataTable({
                aaData:data[index].payinfo,                
                responsive:'true',
                aoColumns:[
                    
                    { "mDataProp": "_IDPAY" },
                    { "mDataProp": "_CODE_SLICE" },
                    { "mDataProp": "_OBJECT" },
                    { "mDataProp": "_AMOUNT" },
                    { "mDataProp": "_DATEPAY" }

                    
                    
                ]
            });
               // alert( 'You clicked on '+data[index].id+'\'s row' );
               
                
        } );
    
        });
       
     document.querySelector('#loader').style="display:none";
     document.querySelector('#tableView').style="display:normal";
    },function(error){
console.error(error)
    });

var table=undefined;
var iTable;
    $scope.get_list_pupils=function(year,index){

        
        var title_navbar=document.querySelector('#title_navbar');
        title_navbar=title_navbar.innerHTML.split('|')[1].trim();
        //alert(title_navbar);
        var url_get_list='listpupils/'+title_navbar+'/SUB/'+year;
        console.log('URL:',url_get_list);
        $(document).ready(function() {
            
            if (table==undefined) 
                {
                    iTable=index;
                    $scope.toFillTable(index,url_get_list);
                   
        }else{
            if (index==iTable) {
                table.destroy();
                $scope.toFillTable(index,url_get_list);

            } else {

            }
        }
            

        });
        }
        
    
    $scope.toFillTable=function(index,url){
        $http.get(url).then(function(response){
            console.log(response.data);
        },function(error){
            console.log(error)
        })
         table=$('#dataTables'+index).DataTable({
                ajax: {
                    url: url,
                    dataSrc:'',
                    
                },
                
                responsive:'true',
                columns:[
                    
                    { "data": "matricule" },
                    { "data": "name_pupil" },
                    { "data": "gender" },
                    { "data": "level" },
                    {"data":"section"}
                ]
            });

                
            $('#dataTables'+index+' tbody').on('click', 'tr', function (e) {
                var data = table.data();
                var index=e.target._DT_CellIndex.row;
                console.log('Data: ',data[index]);
                document.querySelector('#btn_date_after').click();
               document.querySelector('#LabelName').innerHTML=data[index].name_pupil;
               

                
        });
    }
  
    $scope.requestHttp=function(url,method,callback){
        if (method=='GET') {
            $http.get(url).then(function(response){
                callback(response);
            },function(error){
                callback(response);
            });
        }else{

        }
    }
})