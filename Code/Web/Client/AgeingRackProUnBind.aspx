<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="AgeingRackProUnBind.aspx.cs" Inherits="SKT.LeanMES.Web.Client.AgeingRackProUnBind" %>

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
                    <%-- <input type="checkbox" id="cbxforceuppercase" value="yes" checked /><%=Resources.lang.ForcingUpperCase %>--%>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <input type="text" id="txtSN" class="scan-center-sn" style="height: 30px; font-size: 15px;" />
                </td>
                <td align="center">
                    <input type="button" id="btnOpen" value=" 移 除 " onclick="ContainerRemove()" />
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    <table class="ListTable" id="tbCompentList" style="border-width: 0px; width: 100%; border-collapse: collapse;"
        cellspacing="0" cellpadding="2">
        <tbody>
            <tr class="ListTableHeader">
                <%--                <th style="width: 35px;" scope="col">
                    <input name="chkAll" id="chkAll" onclick="checkAll(this.checked);" type="checkbox" />
                </th>--%>
                <th id="thFirstHeader" style="width: 160px; text-align: center" scope="col">序号
                </th>
                <th id="thFirstHeader1" style="width: 160px;" scope="col">条码
                </th>
                <th id="thFirstHeader2" style="width: 160px;" scope="col">操作
                </th>
                <%--                <th id="thSencondHeader" style="width: 150px;" scope="col">
                </th>--%>
            </tr>
        </tbody>
    </table>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
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
        var SNList = [];
        $(function () {
            $("#txtSN").focus();
        });
        //扫描框回车事件
        $("#txtSN").keydown(
            function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                SN = $("#txtSN").val();
                if (curKey == 13) {
                    stopDefault(e);
                    if ($.inArray(SN, SNList) != -1) {
                        alert("SN已扫描");
                        return false;
                    }
                    var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.Unbind(SN);
                    if (data.error != null) {
                        alert(data.error.Message);
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, SN, data.error.Message);
                        return false;
                    }
                    show();
                    SNList.push($("#txtSN").val())
                    setTimeout(function () { $("#txtSN").val("").focus(); }, 100);
                }
            }
        );
        var show = function () {
            var Number = $("#tbCompentList tbody tr").length;
            $("#tbCompentList tbody").append("<tr class='ListTableOddRow' style='text-align:center'><td>" + Number + "</td><td>" + $("#txtSN").val() + "</td><td onclick='Del(this)'>删除</td></tr>");
            //$("#tbCompentList tbody").append("<tr class='ListTableOddRow'><td></td><td>" + $("#txtSN").val() + "</td><td></td</tr>");
        }
        var Del = function (data) {
            $(data).parent().find("td:eq(1)").html();
            SNList.shift();
            $(data).parent().remove();

        }
        var ContainerRemove = function () {
            if (SNList.length <= 0) {
                alert("请扫描SN");
                return false;
            }
            var data = SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing.RemoveBySNList(JSON.stringify(SNList));
            if (data.error != null) {
                alert(data.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, SNList, data.error.Message);
                return false;
            }
            alert("移除成功");
            $("#tbCompentList tr:gt(0)").remove();
        }
    </script>
</asp:Content>
