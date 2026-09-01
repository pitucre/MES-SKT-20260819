<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.Master" AutoEventWireup="true"
    CodeBehind="NCDataReceive.aspx.cs" Inherits="SKT.LeanMES.Web.Client.NCDataReceive" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr style="height: 30px; line-height: 30px;">
            <td class="Label2">
                接收人<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                    IsRequired="1" Style="height: 25px; line-height: 25px;"></asp:TextBox><input type="button"
                        id="btnSelectUser" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(12);"
                        style="height: 27px;" />
                <asp:HiddenField ID="hdnUserId" runat="server" Value="0" ClientIDMode="Static" />
            </td>
        </tr>
        <tr style="height: 30px; line-height: 30px;">
            <td class="Label2">
                SN条码<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSN" runat="server" CssClass="TextBox" ClientIDMode="Static" IsRequired="1"
                    Style="width: 90%; height: 26px; line-height: 25px; text-transform: uppercase;
                    font-size: 25px; font-weight: bold;"></asp:TextBox>
            </td>
        </tr>         
    </table>
    <div style="width:90%;color:Red;margin:15px 0px 0px 10px;font-size:13px;" id = "errorMsg"></div>
    <script type="text/javascript">
        var stationid = getQueryString("sid");
        var resourceid = getQueryString("resId");
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var userId = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId%>';
        $(document).ready(function () {
            //扫描框回车事件
         //   $("#txtSN").keydown(
         //   function (e) {
         //       var curKey = 0, e = e || window.event;
         //       curKey = e.keyCode || e.which || e.charCode;

         //       if (curKey == 13) {
         //           stopDefault(e);
         //           checkScanSN();
         //           return false;
         //       }
         //       if (curKey == 46) {
         //           $("#txtSN").val("");
         //       }
         //   }
         //);
            $("#txtSN").val("").focus();
            $("#txtUserName").val(userName);
            $("#hdnUserId").val(userId);
        });

        function openChoosePage(flags) {
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags +
                "&Multiple=false&rnd=" +
                Math.random(),
                width: 670,
                height: 300
            });
        }

        function getChooseValue(list) {
            $("#txtUserName").val(list[0][2]);
            $("#hdnUserId").val(list[0][0]);

            setTimeout(function () {
                $("#txtSN").val("").focus(); 
            }, 100);
            
        }

        function afterScan() {
            if ($("#txtSN").val() != "") {
                //执行维修相关操作
                checkScanSN();
            }
            $("#txtSN").val("");
            $("#txtSN").focus();
        }

        /*
        *检测扫描的SN条码信息是否需要维修，是否已经接收过
        */
        function checkScanSN() {
            var scanSN = $.trim($("#txtSN").val());
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.CheckReceiveSN(scanSN);
            if (ajax.error != null) {
                $("#errorMsg").html(scanSN+": "+ajax.error.Message);
                $("#txtSN").val("").focus();

                //写入日志
                SaveUserUILog("一般", stationid, resourceid, scanSN, ajax.error.Message);
                return false;
            }
            var mainSN = ajax.value;

            Save(mainSN);
        }

        function Save(scanSN) {
            var receiveUserId = $("#hdnUserId").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.CollectReceiveSN(scanSN, receiveUserId, stationid, resourceid);
            if (ajax.error != null) {
                $("#errorMsg").html(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationid, resourceid, scanSN, ajax.error.Message);
                $("#txtSN").val("").focus();
                return false;
            }
            $("#errorMsg").html(scanSN + ":不良接收成功！");

            setTimeout(function () { $("#errorMsg").html(""); },2000);
            $("#txtSN").val("").focus();
        }
    </script>
</asp:Content>
