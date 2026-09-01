<%@ Page Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true"
    CodeBehind="PalletProCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.PalletProCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle">
                            请扫描包装箱条码 </span> &nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                            </div>
                    </td>
                    <td align="right" style="padding-right: 20px;">
                    <input type="checkbox" id="chkRePrint" title="如果您的栈板标签需要重打，点击选择此复选框" value="0" />
                        <span>重印</span>&nbsp;&nbsp;
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked />
                        <span><%=Resources.lang.ForcingUpperCase %></span>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <input type="text" id="txtSN" class="scan-center-sn" />
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <table>
                            <tr>
                                <td>
                                    <span class="scan-center-title">
                                        <%=Resources.lang.LastStation %>：</span>
                                </td>
                                <td>
                                    <div class="dropdown-station" id="laststationfirst">
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="right">
                        <table>
                            <tr>
                                <td>
                                    <span class="scan-center-title">
                                        <%=Resources.lang.NextStation %>：</span>
                                </td>
                                <td>
                                    <div class="dropdown-station" id="nextstationfirst">
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!--数据分析统计展示及操作区-->
        <div id="datastatistic" class="data-statistic">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td valign="top" style="width: 50%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                <%=Resources.lang.CollectionDetailTable %></div>
                            <table cellpadding="0" cellspacing="0" border="0" class="ListTable">
                                <thead>
                                    <tr class="ListTableHeader">
                                        <th style="width: 100px;">
                                            <%=Resources.lang.Sequence%>
                                        </th>
                                        <th style="width: 300px;">
                                            <%=Resources.lang.SerialNumber %>
                                        </th>
                                        <th style="width: 100px;">
                                            <%=Resources.lang.Status %>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="collectionlist">
                                </tbody>
                            </table>
                        </div>
                    </td>
                    <td valign="top" style="width: 50%">
                        <div class="dds-panel">
                            <div class="leftmenu-new-header">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td style="width: 33%">
                                        </td>
                                        <td style="width: 33%; font-size: 12px !important;" align="center" class="mesLang">
                                            栈板明细表:
                                        </td>
                                        <td id="tdPackNo" align="left" style="width: 33%">
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="data-statistic-relinfo">
                                <div id="packingTree">
                                    <table width="100%" class="ListTable" id="packingList" >
                                        <tr id="PackingDetailHeader" class="ListTableHeader">
                                            <th style="display: none">
                                                ContainerId
                                            </th>
                                            <th width="45%">
                                                栈板号
                                            </th>
                                            <th width="55%">
                                                包装箱号
                                            </th>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
            <div id="activeinfoarea" class="active-info-area" ></div>
        </div>
    </div>
     <input type="hidden" id="hidIsScaning" value="0" />
     <input type="hidden" id="hidScanOrderId" value="0" />
     <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
   <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.client.print.js?v=20211012" type="text/javascript"></script>
   <script language="javascript" type="text/javascript">
       var boxSN = "";
       var scanSN = "";
       var packSN = "";
       var packQty = 0;
       var maxPackQty = 0;
       var resourceId = 0;
       var stationId = 0;

       $(document).ready(function () {
           //加载按钮
           setTimeout(
                function () {
                    loadClientButton('Pallet_ProCollectionUI');
                },
                10
            );
           lableType = -5; //包装打印
           lableSequence = 4//序号                 
       });

       /**
       *扫描触发事件
       **/
       function afterScan() {          
           if ($("#txtSN").val() != "") {
               //**开始对投入SN进行验证
               if ($("#cbxforceuppercase").prop("checked")) {
                   $("#txtSN").val($.trim($("#txtSN").val()).toUpperCase());
               }
               resourceId = $("#hdnCurrResourceId").val();
               stationId = $("#hdnCurrStationId").val();
               scanSN = $.trim($("#txtSN").val()); //扫描Sn

               if (packSN == "") {//如果未扫描过包装箱
                   var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetPalletNumberBySN(scanSN, stationId, resourceId);
                   if (ajax.error != null) {
                       updateCollectionList(scanSN, 'NG');
                       showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                       $("#txtSN").val("").focus();
                       //写入日志
                       SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                       return false;
                   }
                   packSN = ajax.value[0];
                   packQty = parseInt(ajax.value[1]);
                   maxPackQty = parseInt(ajax.value[2]);

                   updateCollectionList(scanSN, 'OK');
                   getSNInfo(scanSN);
                   showAreaMessge(scanSN + ':' + "已打开栈板[" + packSN + "](" + packQty + "/" + maxPackQty + ")", "messageGreen");
                   getPackingPalletDetail(packSN, 2); //1为包装Level,2为栈板Level
                   if (packQty == maxPackQty) {
                       if (maxPackQty == 1) {
                           checkPackPrint(); //检查是否需要打印包装箱条码信息
                           showAreaMessge('自动关闭栈板[' + packSN + ']！', "messageGreen");
                       }
                       packSN = "";
                       packQty = 0;
                       maxPackQty = 0;                      
                   }
               }
               else {//已获取到包装箱号
                   //验证产品条码，将产品SN包装到包装箱内
                   var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.CollectPalletSN(scanSN, packSN, stationId, resourceId);
                   if (ajax.error != null) {
                       updateCollectionList(scanSN, 'NG');
                       showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                       $("#txtSN").val("").focus();
                       //写入日志
                       SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                       return false;
                   }
                   packQty = parseInt(ajax.value[0]);
                   maxPackQty = parseInt(ajax.value[1]);
                   getSNInfo(scanSN);
                   updateCollectionList(scanSN, 'OK');
                   showAreaMessge(scanSN + ':包装成功！栈板[' + packSN + '](' + packQty + '/' + maxPackQty + ')', "messageGreen");
                   getPackingPalletDetail(packSN, 2); //1为包装Level,2为栈板Level
                   if (packQty == maxPackQty) {
                       $("#txtSN").val("").focus();
                       checkPackPrint(); //检查是否需要打印包装箱条码信息
                       showAreaMessge('自动关闭栈板[' + packSN + ']！', "messageGreen");
                       packSN = "";
                       packQty = 0;
                       maxPackQty = 0;
                   }
               }
           }
           $("#txtSN").val("");
       }

       /*
       *检查是否需要打印包装箱条码
       */
       function checkPackPrint() {
           labelStr = packSN;
           //如果勾选了重印复选框，则必定会调动打印功能。
           if ($("#chkRePrint").prop("checked")) {
               print();
           }
           else {
               //查询当前工单所跑路由在当前工序是否需要打印包装箱条码。
               var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CheckIsPrintSN(packSN, 2, stationId);
               if (ajax.error != null) {
                   showAreaMessge(packSN + ':' + ajax.error.Message, "messageRed");
                   $("#txtSN").val("").focus();
                   //写入日志
                   SaveUserUILog("一般", stationId, resourceId, packSN, ajax.error.Message);
                   return false;
               }
               if (ajax.value == true) {
                   print();
               }
           }

       }

       /**
       * 获取包装内的第一个SN产品信息,刷新工序信息 2017-10-16
       **/
       function getSNInfo(scanSN)
       {
           
           var packSnAjax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetPackingSN(scanSN);
           if (packSnAjax.error != null) {
               updateCollectionList(scanSN, 'NG');
               showAreaMessge(scanSN + ':' + packSnAjax.error.Message, "messageRed");
               $("#txtSN").val("").focus();
               //写入日志
               SaveUserUILog("一般", stationId, resourceId, scanSN, packSnAjax.error.Message);
               return false;
           }
           if (packSnAjax.value != null && packSnAjax.value != "") {
                refreshProInfoBySN(packSnAjax.value);
           }           
       }
        
       function loadTable(list) {
           var row, cell;
           var setTable = document.getElementById("packingList");

           /***动态创建表***/
           for (var i = 0; i < list.Rows.length; i++) {
               entity = list[i];
               if (i == 0) {
                   PackSN = list.Rows[i].ContainerSN;
                   packStatusId = list.Rows[i].StatusId;
               }
               row = setTable.insertRow(setTable.rows.length);
               if (i % 2 == 0) {
                   row.className = 'ListTableOddRow';
               }
               else {
                   row.className = 'ListTableEvenRow';
               }

               cell = row.insertCell(0);
               cell.align = "center";
               cell.style.display = "none";
               cell.innerHTML = list.Rows[i].CCDataId;

               cell = row.insertCell(1);
               cell.align = "center";
               cell.innerHTML = list.Rows[i].ContainerSN;

               cell = row.insertCell(2);
               cell.align = "center";
               cell.innerHTML = list.Rows[i].SerialNumber;
           }
       }
        
    </script>
</asp:Content>
