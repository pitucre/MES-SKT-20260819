<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="SMTPackUnBind.aspx.cs" Inherits="SKT.LeanMES.Web.Client.SMTPackUnBind" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
  <link href="../Content/productioncollection.css" rel="Stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.tablelist.js?v=20211209"
        type="text/javascript"></script>
    <div id="scancenter" class="scan-center">
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <td align="left">
                    <span class="scan-center-title" id="labscancentertitle">请扫描SMT包装箱条码</span>&nbsp;&nbsp;&nbsp;&nbsp;<div
                        id="messageBox">
                    </div>
                </td>
                <td align="right" style="width: 180px;">
                </td>
            </tr>
            <tr>
                <td align="left">
                    <input type="text" id="txtSN" class="scan-center-sn" style="height: 30px; font-size: 15px;" />
                </td>
                <td align="center">
                    <input type="button" id="btnOpen" value=" 打 散 " onclick="smtPackEmpty()" />                   
                </td>
            </tr>
        </table>
    </div>
    <table class="ListTable" id="tbCompentList" style="border-width: 0px; width: 100%;
        border-collapse: collapse;" cellspacing="0" cellpadding="2">
        <tbody>
            <tr class="ListTableHeader">
                <th style="width: 35px;" scope="col">
                    <input name="chkAll" id="chkAll" onclick="checkAll(this.checked);" type="checkbox" />
                </th>
                <th id="thFirstHeader" style="width: 160px;" scope="col">
                </th>
                
            </tr>
        </tbody>
    </table>
     <script type="text/javascript">
         var isMultiple = true;
         var stationid = getQueryString("stationid");
         var resourceid = getQueryString("resourceid");
         var userId = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>';
         var scanSN = "";
         var packSNArr = [];

         $(document).ready(function () {
             //扫描框回车事件
             $("#txtSN").keydown(
                function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;

                    if (curKey == 13) {
                        stopDefault(e);
                        afterScan();

                    }
                    if (curKey == 46) {
                        $("#txtSN").val("");
                    }
                }
            );
         });

         function afterScan() {
             scanSN = $.trim($("#txtSN").val()); //扫描Sn
             if (scanSN == "") {
                 alert("请扫描条码！");
                 snFocus();
                 return false;
             }
             if (checkIsCanEmpty()) {//如果包装箱内的SN均已完成生产，则可以清空包装箱
                 buildTable();
             }
             snFocus();
         }

         function buildTable() {
             var setTable = document.getElementById("tbCompentList");
             var isBulid = true;
             //验证当前SN是否存在列表中
             $(setTable).find("tr td").each(
                function () {
                    if (this.innerText != "" && this.innerText == scanSN) {
                        alert("扫描条码" + scanSN + "已存在列表中，请勿重复扫描！");
                        snFocus();
                        isBulid = false;
                        return;
                    }
                }
             );
             if(!isBulid){
                return false;
             }
             row = setTable.insertRow(setTable.rows.length);
             row.onclick = function () { try { clk(this); } catch (ex) { } };            
             row.ondblclick = function () { try { dblClk(this); } catch (ex) { } };
             row.className = 'ListTableOddRow';

             cell = row.insertCell(0);
             cell.align = "center";
             cell.innerHTML = "<input name=\"chkSelect\" onclick=\"chkClk(this)\" type=\"checkbox\" >";

             cell = row.insertCell(1);
             cell.align = "center";
             cell.innerHTML = scanSN;
         }
         /*
         *检测是否可以清空包装箱
         */
         function checkIsCanEmpty() {
             var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.CheckIsSMTPackUnBind(scanSN);
             if (ajax.error != null) {
                 alert(ajax.error.Message);
                 snFocus();
                 //写入日志
                 SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                 return false;
             }
             return true;
         }

         /*
         *清空包装箱
         */
         function smtPackEmpty() {
             var packSN = "";
             $("#tbCompentList tr td input[type=checkbox]").each(function () {
                 if ($(this).prop("checked")) {
                     packSN = $.trim($(this).parent().next().text());
                     packSNArr.push(packSN);
                 }
             });

             packSN = (packSNArr.join(","));

             if (packSN == "") {
                 alert("请扫码SMT包装箱条码！");
                 snFocus();
                 return false;
             }
             if (confirm("是否确认解绑列表中的包装箱？")) {
                 var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.SMTPackUnBind(packSN, stationid, resourceid);
                 if (ajax.error != null) {
                     alert(ajax.error.Message);
                     snFocus();
                     //写入日志
                     SaveUserUILog("一般", stationId, resourceId, packSN, ajax.error.Message);
                     return false;
                 }
                 alert("解绑包装箱成功！");
                 $("#chkAll").prop("checked", false);
                 $("#tbCompentList tr:not(.ListTableHeader)").remove();
             }
         }

         function snFocus() {
             setTimeout(function () {
                 $("#txtSN").val("").focus();
             }, 50);
         }
     </script>
</asp:Content>
