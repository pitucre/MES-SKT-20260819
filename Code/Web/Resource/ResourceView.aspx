<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="ResourceView.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.ResourceView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current" title="<%= Resources.lang.BaseInfo%>">
                <%= Resources.lang.BaseInfo%>
            </li>
            <li title="<%= Resources.lang.Tab_License%>">
                <%= Resources.lang.Tab_License%>
            </li>
        </ul>
        <!--资源基本信息-->
        <div class="tb_c">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.ResName%>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="lblResName" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        资源类型
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="lblResType" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.Line%>
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblLine" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="Label2">
                        <%=Resources.lang.Status%>
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        设备名称
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="lblEquipmentName" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.StartTime%>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="lblValidTime" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.Description%>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="lblDescription" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <!--授权证书-->
        <div>
            <asp:Localize ID="llCertificationList" runat="server"></asp:Localize>
        </div>
    </div>
     <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/tabs/jPlugin-tabs.js" type="text/javascript"></script>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/ResourceEdit.aspx?name=Resource_ResourceEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true&rnd=" + Math.random();
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
