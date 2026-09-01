<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="FactoryView.aspx.cs" Inherits="SKT.LeanMES.Web.Factory.FactoryView"
    Title="View Factory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label1" id="tdFactoryName">
                <%= Resources.lang.FactoryName%>
            </td>
            <td class="Field1" >
                <asp:Label ID="lblFactoryName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1" id="tdFactoryCode">
                <%= Resources.lang.FactoryCode %>
            </td>
            <td class="Field1">
                <asp:Label ID="lblFactoryCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field1">
                <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">

        $(function () {
           var typeId =  <%= Request.QueryString["TypeId"] == null ? 1 : Convert.ToInt32(Request.QueryString["TypeId"].ToString())%>;
            if (typeId == 2)
            {
                $("#tdFactoryName").text(mesLang("公司名称"));
                $("#tdFactoryCode").text(mesLang("公司代码"));
            }
        });
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Factory/FactoryEdit.aspx?name=FactoryEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
