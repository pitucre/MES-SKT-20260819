<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetupTime.aspx.cs" Inherits="SKT.LeanMES.Web.Accessories.SetupTime"
MasterPageFile="~/Masters/EditMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/EditMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.Accessorie_SOLD_TYPE%><em>*</em>
            </td>
            <td class="Field2">
                <select id="selbCodeType">
                <option value='-1'>--请选择--</option>
                <option value="1">锡膏</option>
                <option value="2">红胶</option>
                </select>
            </td>
        </tr> 
        <tr>
            <td class="Label2">
                <%= Resources.lang.Accessorie_MINTHAW%><em>*</em>
            </td>
            <td class="Field2">
             <asp:TextBox ID="txtMINTHAW" runat="server" CssClass="TextBox" MaxLength="50"
                    ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr> 
        <tr>
            <td class="Label2">
                <%= Resources.lang.Accessorie_MAXVOID%><em>*</em>
            </td>
            <td class="Field2" >
             <asp:TextBox ID="txtMAXVOID" runat="server" CssClass="TextBox" MaxLength="50"
                    ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr> 
        <tr>
            <td class="Label2">
                <%= Resources.lang.Accessorie_MAXUSE%><em>*</em>
            </td>
            <td class="Field2">
             <asp:TextBox ID="txtMAXUSE" runat="server" CssClass="TextBox" MaxLength="50"
                    ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr> 
    </table>
    <div class="clear5">
    </div>
    <script type="text/javascript">
        function Save() {
            var errStr = "";

            var selbCodeType = $("#selbCodeType").val();
            if (!isNumber(selbCodeType)) {

                errStr += "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }

            var txtMINTHAW = $("#txtMINTHAW").val();
            if (isNull(txtMINTHAW)) {
                errStr = "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }
            var txtMAXVOID = $("#txtMAXVOID").val();
            if (isNull(txtMAXVOID)) {
                errStr = "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }
            var txtMAXUSE = $("#txtMAXUSE").val();
            if (isNull(txtMAXUSE)) {
                errStr = "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }
            if (errStr != "") {
                alert(errStr.toString());
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceSolderLog.AddSetTime(selbCodeType, txtMINTHAW, txtMAXVOID, txtMAXUSE);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("<%=Resources.Messages.SaveInSuccess %>");
           // parent.window.UpdateList(txtBarCode);
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
</asp:Content>
