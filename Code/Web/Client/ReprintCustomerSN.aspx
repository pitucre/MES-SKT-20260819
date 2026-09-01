<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ReprintCustomerSN.aspx.cs" Inherits="SKT.LeanMES.Web.Client.ReprintCustomerSN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <link href="../Content/productioncollection.css" rel="Stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.tablelist.js?v=20211209"
        type="text/javascript"></script>
    <div id="scancenter" class="scan-center">
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <td align="left">
                    <span class="scan-center-title" id="labscancentertitle">请扫描SN条码</span> &nbsp;
                </td>
                <td align="right" style="width: 180px;"></td>
            </tr>
            <tr>
                <td align="left">
                    <input type="text" id="txtSN" class="scan-center-sn" style="height: 30px; font-size: 15px;" />
                </td>
                <td align="center">
                    <input type="button" id="btnPrint" value=" 补 印 " onclick="print()" />
                </td>
            </tr>
        </table>
    </div>
    <table class="ListTable" id="tbCompentList" style="border-width: 0px; width: 100%; border-collapse: collapse;"
        cellspacing="0" cellpadding="2">
        <tbody>
            <tr class="ListTableHeader">
                <th style="width: 5%;" scope="col"></th>
                <th style="width: 55%;" scope="col">SN
                </th>
                <th style="width: 20%;" scope="col">标签名称
                </th>
                <th style="width: 20%;" scope="col">条码规则类型
                </th>
            </tr>
        </tbody>
    </table>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script type="text/javascript">
        var userId=<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>;
        var stationId = getQueryString("stationId");
        var resourceId = getQueryString("resourceId");
        var scanSN =""

        $().ready(function () { 
             
            //扫描框回车事件
            $("#txtSN").keydown(
                function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;

                    if (curKey == 13) {
                        stopDefault(e);
                        afterScan();
                        //return false;
                    }
                    if (curKey == 46) {
                        $("#txtSN").val("");
                    }
                }
            );
               
            $("#txtSN").focus();
        });

        /**
      *   扫描触发事件
      **/
        function afterScan() {
            scanSN = $.trim($("#txtSN").val()); //扫描Sn       
            if (scanSN == "") {
                alert("请扫描SN条码！");
                snFocus();
                return false;
            }
            else {
                loadDocuments();
            }
        }

        /**
       *   加载打印模板信息
       *   --根据SN加载关联模板信息        
       **/
        function loadDocuments() {             
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.GetReprintSNInfo(scanSN);
            //if (ajax.error != null) {
            //    alert(ajax.error.Message);
            //    $("#txtSN").val("");
            //    snFocus(); 
            //    //写入日志
            //    SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
            //    return false;
            //}
            var entity = {};
            entity.SN = scanSN;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetReprintSNCustomerInfo", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }else{
               var  entity=JSON.parse(ajax.value);
            }

            $("#tbCompentList tr:not(.ListTableHeader)").remove();
            loadTable(entity);  
            $("#txtSN").focus(); 
            setTimeout(function(){
                $("#txtSN").select();    
            },200 );         
        }

        function loadTable(list) {          
            var row, cell;           
            var entity = {};
            var flage = ""; 
            var entityAry = list.data; 
            var setTable = document.getElementById("tbCompentList");

            if(entityAry == null || entityAry.length==0){                
                row = setTable.insertRow(1);
                row.className = 'ListTableOddRow';                
                cell = row.insertCell(0);
                cell.align = "center";  
                cell.colSpan="4";             
                cell.innerHTML = "未找到关联的打印模板信息！";
                $("#txtSN").val("");
                snFocus(); 
                return false;
            }
                    
            if (entityAry.length > 0) {               

                /***动态创建表***/
                for (var i = 0; i < entityAry.length; i++) {
                    entity = entityAry[i];
                    row = setTable.insertRow(setTable.rows.length);
                    if (i % 2 == 0) {
                        row.className = 'ListTableOddRow';
                    } 
                    else {
                        row.className = 'ListTableEvenRow';
                    }
                    row.onclick = function(){check($(this).find("input[name='chkb']")[0])};
                    row.onmouseover = function(){ try{mi(this);}catch (ex){} };
                    row.onmouseout = function(){ try{mo(this);}catch (ex){} };                 
 
                    cell = row.insertCell(0);
                    cell.align = "center";
                    cell.innerHTML = "<input type='checkbox' name='chkb' style='height:15px;width:15px;' onclick='check(this)' value='" + entity.LabelDocumentId + "' /><input name='PrinterName' type='hidden' value='" + entity.PrinterName + "'/><input name='ItemId' type='hidden' value='" + entity.ItemId + "' /><input name='TypeId' type='hidden' value='" + entity.TypeId + "' /><input name='PlateQty' type='hidden' value='" + entity.PlateQty + "' /><input name='ProdOrderId' type='hidden' value='" + entity.ProdOrderId + "' /><input name='PrintWayId' type='hidden' value='" + entity.PrintWayId + "' /><input name='TemplatePath' type='hidden' value='" + entity.TemplatePath + "' />";

                    cell = row.insertCell(1);
                    cell.align = "center";
                    
                    cell.innerHTML = entity.SN;

                    cell = row.insertCell(2);
                    cell.align = "center";
                    cell.innerHTML = entity.DocumentName;

                    cell = row.insertCell(3);
                    cell.align = "center";
                    cell.innerHTML = entity.Document_Type;                                      
                }
            }
        }

        /*加上复选框按钮*/
        function check(obj) {
            $("input[type=checkbox]").each(function () {
                if (this != obj) {
                    $(this).attr("checked", false);
                    //$(this).parent("tr").removeClass("selected");
                }
                else {
                    $(this).attr("checked", true);
                    //$(this).parent("tr").removeClass("selected");
                }
            });
        }
        //打印功能
        var labelDocumentId = -1;
        var printName = "";     //打印机名称
        var itemId = -1;
        var typeId = 0;         //打印类型
        var lableTypeQty = 1;  //联版打印数量 
        var printWay = 0;       //文档打印方式
        var templatePath = "";  //Label标签模板路径
        var labelStr = "";
        var labelProdOrderId = -1;
        /**
        *   打印文档        
        **/
        function print() {
            $("[name='chkb'][checked]").each(function () {
                labelDocumentId = $(this).val();
                printName = $(this).parent().find("input[name=PrinterName]").val();
                itemId = $(this).parent().find("input[name=ItemId]").val(); 
                labelProdOrderId = $(this).parent().find("input[name=ProdOrderId]").val();
                lableTypeQty = $(this).parent().find("input[name=PlateQty]").val();         //连板数量
                typeId = $(this).parent().find("input[name=TypeId]").val();
                printWay = $(this).parent().find("input[name=PrintWayId]").val();
                templatePath = $(this).parent().find("input[name=TemplatePath]").val();
                labelStr = $.trim($(this).parent().next().text());
            });
            if(scanSN==""){
                alert("请扫描条码！");
                $("#txtSN").focus();
                return false;
            }
            if (labelDocumentId == -1) {
                alert("请选中对应的打印标签!");
                return false;
            } 
            mesLabLabelPrint();
        }
        
        /**
        *codesoft打印  Lab模板方式
        **/
        function mesLabLabelPrint() {
            var printdata = [];

            var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, itemId, labelProdOrderId);
            if (ajaxLabContent.error != null) {
                alert(ajaxLabContent.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajaxLabContent.error.Message);
                return false;
            }
            else {
                //接收打印的ZPL标签  
                try {
                    var list = ajaxLabContent.value;

                    if (list.length > 0) {
                        var page = { LabelContent: [] };
                        for (var h = 0; h < list.length; h++) {
                            page.LabelContent.push({ name: list[h].LabelName, value: list[h].LabelValue });
                        }
                        printdata.push(page);
                        if (printdata.length == 0)
                            return;
                        sendPrintContent(JSON.stringify(printdata), printName, 1, labelDocumentId);
                        //条码打印记录
                        var labelSNArr;
                        if (lableTypeQty == 1) { //单板
                            //labelSNArr = labelStr.split(",")[0];
                            recordPrint(labelStr);
                        } else { //连板
                            labelSNArr = labelStr.split(",");
                            for (var k = 0; k < labelSNArr.length - 1; k++) {
                                recordPrint(labelSNArr[k]);
                            }
                        }                   
                        snFocus();
                        return;
                    }
                } 
                catch (e) {
                    alert(e);
                    return false;
                }
            }
        }

        /**
        *插入打印记录
        **/
        function recordPrint(sn) {
            var printRecodeEntity = {};
            printRecodeEntity.RecordId = -1;
            printRecodeEntity.ActionType = 2; //打印方式(1:正常打 2：重打)
            printRecodeEntity.PrintType = typeId;//打印类型：(-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单)
            printRecodeEntity.PrintKey = sn;
            printRecodeEntity.StationId = stationId==""?-1:stationId;
            printRecodeEntity.ResourceId = resourceId==""?-1:resourceId;
            var ajaxPrintRecodes = SKT.LeanMES.Web.AjaxServices.AjaxClientController.RecodePrint(printRecodeEntity);
            if (ajaxPrintRecodes.error != null) {
                alert(ajaxPrintRecodes.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajaxPrintRecodes.error.Message);
                return false;
            }
        }
        function snFocus() {
            labelDocumentId = -1;             
            setTimeout(function () {
                $("#txtSN").focus();                           
            }, 100);
            setTimeout(function () {             
                $("#txtSN").select();             
            }, 300);
        }
        function SaveUserUILog(a, b,c,d,e) {
            if (!b) 
                b=-1;
            if (!c) 
                c=-1;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClient.SaveUserUILog(a, b, c, d, e);
            if (ajax.error != null) {
                return false;
            }
        }
    </script>
</asp:Content>
