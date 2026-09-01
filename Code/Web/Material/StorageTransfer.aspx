<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StorageTransfer.aspx.cs"
    MasterPageFile="~/Masters/ViewMaster.master" Inherits="SKT.LeanMES.Web.Material.StorageTransfer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label1">
                包装袋号<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" id="txtGRN" class="TextBox" style="width: 250px; height: 25px;
                    font-size: 16px; font-weight: bold;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                库位条码<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" id="txtCode" class="TextBox" style="width: 250px; height: 25px;
                    font-size: 16px; font-weight: bold;" />
            </td>
        </tr>
    </table>
     <div style="text-align: center;" class="Tips" id="msg">
        <span id="showMessage"></span>
    </div>
    <script type="text/javascript">
        var flag = 0;
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

        $(function () {
            $("#txtGRN").focus();
            //扫描GRN自动验证是否存在
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($("#txtGRN").val() != "") {
                        $("#txtCode").focus();
                    }
                    else {
                        flag = 1;
                        Save();
                    }
                }
            });
            //扫描库位条码
            $("#txtCode").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    flag = 2;
                    Save();
                }
            });
        });
        // 保存事件
        function Save() {

            var txtGRN = $("#txtGRN").val();
            if (txtGRN == "") {
                setMessage("包装袋号不能为空,请扫描包装条码！", "red");
                setInputValue("txtGRN");
                return false;
            }
            var txtCode = $("#txtCode").val();
            if (txtCode == "") {
                setMessage("库位条码不能为空,请重新扫描！", "red");
                setInputValue("txtCode");
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.StorageTransfer(txtGRN, txtCode, userName, flag)
            if (ajax.error != null) {
                setMessage(ajax.error.Message,"red");
                return false;
            }
            if (flag == 2) {
                setMessage("库位转移成功！","green")
                $("input[type='text']").val("");
                $("#txtGRN").select();
            }
        }
        /*显示提示信息*/
        function setMessage(msg, color) {
            $("#showMessage").html(msg);
            $("#showMessage").css("color",color);
        }
        /*清空指定信息，并聚焦*/
        function setInputValue(inputName) {
            var txtInputName = $("#" + inputName);
            txtInputName.val("");
            txtInputName.focus();
         }
    </script>
</asp:Content>
