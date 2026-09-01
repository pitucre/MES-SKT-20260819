<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="LoginDevice.aspx.cs" Inherits="SKT.LeanMES.Web.Client.LoginDevice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <link href="../Content/productioncollection.css" rel="Stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.tablelist.js"
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
                    <input type="text" id="txtSN" class="scan-center-sn" style="height: 30px; font-size: 15px;" />
                </td>
                <td align="center">
                    <input type="button" id="btnOpen" value=" 下 机 " onclick="UserLoginRemove()" />                     
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
                <th id="thFirstHeader" style="width: 160px;" scope="col"> 用户名称
                </th> 
                <th id="thSencondHeader" style="width: 150px;" scope="col">用户工号
                </th>
                 <th id="thBoxHeader" style="width: 160px;" scope="col">登陆时间
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
        var DeviceId = getQueryString("DeviceId");
        var userId = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>';
        var scanSN = "";

        $(document).ready(function () {
           
            if (DeviceId == "null" || DeviceId == "null") {
                alert("机台有误，无法正常登陆!");
            }
            loadTable()
            $("#txtSN").focus();
        });
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

        /**
        *   扫描触发事件
        **/
        function afterScan() {
            scanSN = $.trim($("#txtSN").val()); //扫描Sn
            if (scanSN == "") {
                alert("请扫描条码！");
                snFocus();
                return false;
            }
            else {
                LoginUser(scanSN);
            }
        }

        /**
        *   加载包装信息
        *   --根据容器加载容器装载信息        
        **/
        function LoginUser(scanSN) {
            var entity = {};
            entity.DeviceId = DeviceId;
            entity.UserNo = scanSN;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspLoginDevcie", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return;
            }
            loadTable();
            $("#txtSN").val("");
            snFocus();
        }

        function loadTable() {
            var entity = {};
            entity.DeviceId = DeviceId;        

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetLoginDevcie", JSON.stringify(entity));
            if (ajax.error != null) {
                alter(ajax.error.Message)
                return ;
            }
            $("#tbCompentList tr:not(.ListTableHeader)").remove();
            var row, cell;
            var entity = {};
            var flage = "";
            var entityAry = JSON.parse(ajax.value);
            var setTable = document.getElementById("tbCompentList");

            if (entityAry == null || entityAry.length == 0) {
                row = setTable.insertRow(1);
                row.className = 'ListTableOddRow';
                cell = row.insertCell(0);
                cell.align = "center";
                cell.colSpan = 5;
                if (entityAry == null) {
                    cell.innerHTML = "该机台目前没有登陆人员！";
                }
                else {
                    cell.innerHTML = "该机台目前没有登陆人员！";
                }
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
                    row.onclick = function () { try { clk(this); } catch (ex) { } };
                    row.onmouseover = function () { try { mi(this); } catch (ex) { } };
                    row.onmouseout = function () { try { mo(this); } catch (ex) { } };
                    row.ondblclick = function () { try { dblClk(this); } catch (ex) { } };

                    cell = row.insertCell(0);
                    cell.align = "center";
                    cell.innerHTML = "<input name=\"chkSelect\" onclick=\"chkClk(this)\" type=\"checkbox\" value='" + entity.Id + "'>";

                    cell = row.insertCell(1);
                    cell.align = "center";
                    cell.innerHTML = entity.CName;

                    cell = row.insertCell(2);
                    cell.align = "center";
                    cell.innerHTML = entity.EmployeeNo;

                    cell = row.insertCell(3);
                    cell.align = "center";
                    cell.innerHTML = entity.CreateTime;
                }
            }
        }

        /**
        *   移除包装信息
        **/
        function UserLoginRemove() {
            var idStr = getRecordIdString();
            if (idStr == "") return false;

            if (confirm("确认要下机吗 ？")) {
                var entity = {};
                entity.IdString = idStr;

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspRemoveLoginDevcie", JSON.stringify(entity));
                if (ajax.error != null) {
                    alter(ajax.error.Message)
                    return;
                }
                else {
                    alert("下机成功！");
                    $("#chkAll").attr("checked", false);
                }
                loadTable();
            }
        }

        function snFocus() {
            setTimeout(function () {
                $("#txtSN").focus();
            }, 100);
        }

    </script>
</asp:Content>