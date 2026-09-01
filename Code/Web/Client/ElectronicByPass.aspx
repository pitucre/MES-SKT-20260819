<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ElectronicByPass.aspx.cs" Inherits="SKT.LeanMES.Web.Client.ElectronicByPass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">

    <div class="wrap_tb">
        <div class="tb_c">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">当前扫描条码：</td>
                    <td class="Field1">
                        <span id="lblSN"></span>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">重量异常：</td>
                    <td class="Field1">
                        <span id="lblWeightError" style="line-height:22px;"></span>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">用户名：</td>
                    <td class="Field1">
                        <input type="text" id="txtUserName" isrequired="1" />
                    </td>
                </tr>
                <tr>
                    <td class="Label1">密码：</td>
                    <td class="Field1">
                        <input type="password" id="txtPassword" class="TextBox" isrequired="1" />
                    </td>
                </tr>
                <tr>
                    <td class="Label1"></td>
                    <td class="Field1">
                        <input type="button" style="cursor: pointer;" value=" 强制过站 " onclick="passWeight()" /> <input type="button" style="cursor: pointer; margin-left:10px;" value=" 关闭 " onclick="    closeWeight()" />
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <script type="text/javascript">
        var sn = getQueryString("sn");
        var weightMsg = getQueryString("weightmsg");
        var stationid = getQueryString("stationid");
        var resourceid = getQueryString("resourceid");
        var weight = getQueryString("weight");

        $(document).ready(function () {
            $("#lblSN").html(sn);
            $("#lblWeightError").html(weightMsg);
            $("#txtUserName").select();
        });

        function passWeight() {
            if (!SubmitValidation()) {
                return false;
            }
            var userName = $("#txtUserName").val();
            var password = $("#txtPassword").val();

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxContainerWeight.ByPassSNWeight(sn, parseFloat(weight), stationid, resourceid, userName, password);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                setTimeout(function () {
                    $("#txtUserName").select();
                }, 100);             
                return false;
            }
            alert(sn + ":强制过站操作成功！");
            window.parent.updateCollectionList(sn, 'OK');
            window.parent.showAreaMessge(sn + ":强制过站操作成功！", "messageGreen");
            window.parent.snFocus();
            window.parent.closeDialog();
        }

        function closeWeight() {
            window.parent.snFocus();
            window.parent.closeDialog();
        }

    </script>
</asp:Content>
