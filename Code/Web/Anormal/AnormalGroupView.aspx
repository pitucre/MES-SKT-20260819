<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="AnormalGroupView.aspx.cs" Inherits="SKT.LeanMES.Web.Anormal.AnormalGroupView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                异常类型名称
            </td>
            <td class="Field2">
                <asp:Label ID="lblGroupName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                异常类型代码
            </td>
            <td class="Field2">
                <asp:Label ID="lblGroupCode" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        //编辑
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Anormal/AnormalGroupEdit.aspx?name=Anormal_GroupEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
