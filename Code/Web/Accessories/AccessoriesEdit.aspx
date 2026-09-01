<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccessoriesEdit.aspx.cs"
    Inherits="SKT.LeanMES.Web.Accessories.AccessoriesEdit" MasterPageFile="~/Masters/EditMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%=Resources.lang.Accessorie_PN  %><em>*</em>
            </td>
            <td class="Field2">
                <select id="slePartId">
                </select>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Accessorie_SOLD_TYPE%><em>*</em>
            </td>
            <td class="Field2">
                <select id="selbCodeType">
                    <option value='0'>--请选择--</option>
                    <option value="1">锡膏</option>
                    <option value="2">红胶</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Accessorie_QUANTITY%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtQuantity" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Accessorie_EXPIREDDATE%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtExpiredTime" ReadOnly="True" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        _isHms = true;

        var barCodeId = '<%=Request.QueryString["ID"] %>';
        $(document).ready(function () {
            var ajaxRes = SKT.LeanMES.Web.Controls.PageSQLService.Search("GObKeXx5k1wSFA0G3rckUE6A3g67AkMC", "59Re+XIyDOk=", "eh5TlS/OJw3Ea0Ef+IHT25MFsdf9BJqg",
            "", "");
            if (ajaxRes.error == null) {
                var objArr = ajaxRes.value;
                if (objArr != null && objArr != "") {
                    MakeOption(objArr)
                }
            }
            //alert(ajaxRes.error.Message);
            return false;
        });
        //添加option子项
        function MakeOption(objArr) {
            for (var i = 0; i < objArr.length; i++) {
                $("#slePartId").append('<option value=' + objArr[i].Field1 + '>' + objArr[i].Field2 + '</option>');
            }
            $("#slePartId").prepend("<option value='0'>--请选择--</option>");
        }

        function Save() {
            var errStr = "";

            var slePartId = $("#slePartId").val();
            if (!isNumber(slePartId)) {
                errStr = "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }
            var txtQuantity = $("#txtQuantity").val();
            if (!isNumber(txtQuantity)) {
                errStr = "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }
            var txtExpiredTime = $("#txtExpiredTime").val();
            if (isNull(txtExpiredTime)) {
                errStr = "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }

            var selbCodeType = $("#selbCodeType").val();
            if (!isNumber(selbCodeType)) {
                errStr = "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }
            if (errStr != "") {
                alert(errStr.toString());
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceSolderBarcode.AddSoldbarcodeInfo(slePartId, txtQuantity, txtExpiredTime, selbCodeType);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList();

        }
        function isNull(str) {
            if (str == "") return true;
            var regu = "^[ ]+$";
            var re = new RegExp(regu);
            return re.test(str);
        }
        function isNumber(s) {
            var regu = "^[0-9]+$";
            var re = new RegExp(regu);
            if (s.search(re) != -1) {
                return true;
            } else {
                return false;
            }
        }
    </script>
    <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/formValidation.js?t=1.0.0"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
        type="text/javascript" charset="GBK"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
        type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $(".DateTimeBox").datepicker({
                showOn: "both",
                buttonImageOnly: true,
                buttonText: "<%=Resources.lang.ChooseDate %>"
            });
        });
    </script>
</asp:Content>
