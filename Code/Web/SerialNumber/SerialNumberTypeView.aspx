<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    Codebehind="SerialNumberTypeView.aspx.cs" Inherits="SKT.LeanMES.Web.SerialNumber.SerialNumberTypeView" Title="View SerialNumberType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label1">分类类型</td>
            <td class="Field1">
                <asp:Label ID="lblSerialNumberType" runat="server"></asp:Label>
            </td>
            </tr>
            <tr>
            <td class="Label1">备注</td>
            <td class="Field1">
                <asp:Label ID="lblSerialNumberDesc" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        function Edit()
        {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/SerialNumberTypeEdit.aspx?name=SerialNumber_SerialNumberTypeEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
            location.href = openWinUrl;
        }
    </script>
</asp:Content>