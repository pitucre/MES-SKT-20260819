<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="PackingProUnBind.aspx.cs" Inherits="SKT.LeanMES.Web.Client.PackingProUnBind" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <link href="../Content/productioncollection.css" rel="Stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.tablelist.js?v=20211209"
        type="text/javascript"></script>
    <div id="scancenter" class="scan-center">
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <td align="left">
                    <span class="scan-center-title" id="labscancentertitle"></span>&nbsp;&nbsp;&nbsp;&nbsp;<div
                        id="messageBox">
                    </div>
                </td>
                <td align="right" style="width: 180px;">                 
                </td>
            </tr>
            <tr>
                <td align="left">
                    <input type="text" id="txtUnbindSN" class="scan-center-sn" style="height: 30px; font-size: 15px;" />
                </td>
                <td align="center">
                    <input type="button" id="btnOpen" value=" 移 除 " onclick="ContainerRemove()" />            
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
                <th id="thSencondHeader" style="width: 150px;" scope="col">
                </th>
                 <th id="thBoxHeader" style="width: 160px;" scope="col">中箱号码
                </th>
               
            </tr>
        </tbody>
    </table>
    <script type="text/javascript">
        var isMultiple = true;
        var RequireOnlyOneRecord = "<%=Resources.Messages.RequireOnlyOneRecord %>";
        var RequireOperateRecord = "<%=Resources.Messages.RequireOperateRecord %>";
        var ConfirmDelete = "<%=Resources.Messages.ConfirmDelete %>";
        var currentRowIndex = -1;

        var ContainerType = '<%=Request.QueryString["ContainerType"]%>'; //容器类型,1:包装箱,2:栈板
        var stationid = getQueryString("stationid");
        var resourceid = getQueryString("resourceid");
        var userId = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>';
        var scanSN = "";

        $(document).ready(function () {
            ContainerType = (ContainerType == -5) ? 2 : 1;
          
            if (ContainerType == 1) { //包装箱
                $("#labscancentertitle").html("请扫描包装箱号或产品SN");
                $("#thFirstHeader").html("包装箱号");
                $("#thSencondHeader").html("产品序列号");
            }
            else if (ContainerType == 2) { //栈板
                $("#labscancentertitle").html("请扫描栈板号或包装箱号");
                $("#thFirstHeader").html("栈板号");
                $("#thSencondHeader").html("包装箱号");
            }
            else {//默认包装箱 
                $("#labscancentertitle").html("请扫描包装箱号或产品SN");
                $("#thFirstHeader").html("包装箱号");
                $("#thSencondHeader").html("产品序列号");
            }
            if (stationid == "null" || resourceid == "null") {
                alert("工序有错误,无法正常解绑!");
            }
            $("#txtUnbindSN").focus();
        });
        //扫描框回车事件
        $("#txtUnbindSN").keydown(
            function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;

                if (curKey == 13) {
                    stopDefault(e);
                    afterScan();

                }
                if (curKey == 46) {
                    $("#txtUnbindSN").val("");
                }
            }
        );
        /**
        *   扫描触发事件
        **/
        function afterScan() {
            scanSN = $.trim($("#txtUnbindSN").val()); //扫描Sn
            if (scanSN == "") {
                alert("请扫描条码！");
                snFocus();
                return false;
            }
            else {
                loadContainerDetail(scanSN);
            }
        }

        /**
        *   加载包装信息
        *   --根据容器加载容器装载信息        
        **/
        function loadContainerDetail(scanSN) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.GetPackIngPalletDetailByContainerSN(scanSN, ContainerType);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtUnbindSN").val("");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, scanSN, ajax.error.Message);
                snFocus();
                return false;
            }
            $("#tbCompentList tr:not(.ListTableHeader)").remove();
            loadTable(ajax);
            $("#txtUnbindSN").val("");
            snFocus();
        }

        function loadTable(list) {
            var row, cell;
            var entity = {};
            var flage = "";
            var entityAry = list.value;
            var setTable = document.getElementById("tbCompentList");

            if (entityAry == null || entityAry.Rows.length == 0) {
                row = setTable.insertRow(1);
                row.className = 'ListTableOddRow';
                cell = row.insertCell(0);
                cell.align = "center";
                cell.colSpan = 4;
                if (entityAry == null) {
                    cell.innerHTML = "未找到该包装箱相关信息！";
                }
                else {
                    cell.innerHTML = "未找到包装信息！";
                }
                $("#txtUnbindSN").val("");
                snFocus();
                return false;
            }

            if (entityAry.Rows.length > 0) {

                /***动态创建表***/
                for (var i = 0; i < entityAry.Rows.length; i++) {
                    entity = entityAry.Rows[i];
                    row = setTable.insertRow(setTable.rows.length);
                    if (i % 2 == 0) {
                        row.className = 'ListTableOddRow';
                    }
                    else {
                        row.className = 'ListTableEvenRow';
                    }
                    row.onclick = function () { try { clk(this); } catch (ex) { } };
                    row.onmouseover = function () { try { mi(this); } catch (ex) { } };
                    row.onmouseout = function () { try { mo(this); } catch (ex) { } };
                    row.ondblclick = function () { try { dblClk(this); } catch (ex) { } };

                    cell = row.insertCell(0);
                    cell.align = "center";
                    cell.innerHTML = "<input name=\"chkSelect\" onclick=\"chkClk(this)\" type=\"checkbox\" value='" + entity.PackDataId + "'>";

                    cell = row.insertCell(1);
                    cell.align = "center";
                    cell.innerHTML = entity.ContainerSN;

                    cell = row.insertCell(2);
                    cell.align = "center";
                    cell.innerHTML = entity.SerialNumber;

                    cell = row.insertCell(3);
                    cell.align = "center";
                    cell.innerHTML = entity.BoxSN;
                }
            }
        }

        /**
        *   移除包装信息
        **/
        function ContainerRemove() {
            var idStr = getRecordIdString();
            if (idStr == "") return false;
            var packSN = $("#tbCompentList  tr:not(.ListTableHeader)").eq(0).find("td").eq(1).html();
            var boxSN = $("#tbCompentList  tr:not(.ListTableHeader)").eq(0).find("td").eq(2).html();
            packSN = packSN == "" ? boxSN : packSN;

            var packMsg =  ContainerType == 1?"包装箱":"栈板";
            if (confirm("确认要从" + packMsg + "[" + packSN + "]中移除 ？")) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPacking.RemovePackData(idStr, ContainerType, packSN, userId, stationid, resourceid);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, packSN, ajax.error.Message);
                    snFocus();
                    return false;
                }
                else {
                    alert("移除包装信息成功！");
                    $("#chkAll").attr("checked", false);
                }
                loadContainerDetail(packSN);
                parent.packSNEmpty(packSN);
            }
        }
        function snFocus() {
            setTimeout(function () {
                $("#txtUnbindSN").focus();
            }, 100);
        }
    </script>
</asp:Content>
