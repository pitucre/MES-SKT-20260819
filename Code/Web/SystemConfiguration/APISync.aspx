<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" 
    CodeBehind="APISync.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.APISync" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
 <table id="tabMain" width="100%"  class="EditeContentTable">        
        <tr><td class="Label1"></td><td class="Field1"></td></tr>        
    </table>
    <script type="text/javascript">

    var id = <%= Request.QueryString["ID"] %>;
    var opeType = <%= Request.QueryString["Type"] %>;

    var sapFunc ="";       //处理函数
    var sapParams = "";    //传入参数
    var sapParamDesc = ""; //参数描述
    var sapTabName = "";   //SAP内表名
    var sapFields = "";    //SAP读取列
    var tarTabName = "";   //目标库表名
    var tarTabFields = ""; //目标表对应列

    $(function(){
        initPageParams();
    });

    /*初始化页面,构造参数列表*/
    function initPageParams(){
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSysConfiguration.GetAPIInfo(id);
        if(ajax.error != null){
            alert("获取同步参数失败："+ajax.error.Message);
            return;
        }
        entity = ajax.value;

        sapFunc = entity.FuncName;      
        sapParams = entity.SapParam;    
        sapParamDesc = entity.SapParamDesc; 
        sapTabName = entity.SapTabName;   
        sapFields = entity.SapFields;    
        tarTabName = entity.TargetTabName;   
        tarTabFields = entity.TargetTabFields; 

        sapParams = sapParams.replace(/，/g, ",");
        sapParamDesc = sapParamDesc.replace(/，/g, ",");
        var arysapParams = sapParams.split(",");
        var arysapParamDesc = sapParamDesc.split(",");

        var $tabMain = $("#tabMain");
        var trString = "";
        for(var i = 0; i < arysapParams.length; i++){
            trString += "<tr><td class='Label1'>"+(typeof(arysapParamDesc[i])=="undefined"?"未加描述":arysapParamDesc[i])+"</td><td class='Field1'><input type='text' name='txtSapParam' class='TextBox'/></td></tr>";
        }
        if(trString != ""){
            trString += "<tr><td class='Field1' colspan='2' style='text-align:center;'><input type='button' value='开始执行' onclick='APISync()' style='cursor:pointer'></td></tr> ";
        }

        $tabMain.html(trString);
    }

    function APISync(){
        if(opeType == 0){
            doReadData();
        }
        else if(opeType == 1){
            doWriteData();
        }
    }

    function doReadData(){
       var sapParamsVal = "";
       var valsCtrl = document.getElementsByName("txtSapParam");
       for(var i = 0; i < valsCtrl.length; i++){
            sapParamsVal += valsCtrl[i].value + ",";
       }
       sapParamsVal = sapParamsVal.substring(0, sapParamsVal.length-1);

       showWaiting();
       setTimeout(function(){
           var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSAP.APISyncRead(sapFunc,  sapParams, sapParamsVal ,sapTabName, tarTabName, tarTabFields);

           closeWaiting();

           if(ajax.error != null){
                alert(ajax.error.Message);
           }else{
                alert(ajax.value);
           }        
       },50);        
    }

    function doWriteData(){
       var sapParamsVal = "";
       var valsCtrl = document.getElementsByName("txtSapParam");
       for(var i = 0; i < valsCtrl.length; i++){
            sapParamsVal += valsCtrl[i].value + ",";
       }
       sapParamsVal = sapParamsVal.substring(0, sapParamsVal.length-1);

       showWaiting();
       setTimeout(function(){
           var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSAP.APISyncWrite(sapFunc,  sapParams, sapParamsVal);

           closeWaiting();

           if(ajax.error != null){
                alert(ajax.error.Message);
           }else{
                alert(ajax.value);
           }        
       },50);           
    }

    </script>
</asp:Content>
