<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="LineView.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.LineView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="<%= Resources.lang.BaseInfo%>">
                <%= Resources.lang.BaseInfo%>
            </li>
            <li title="<%= Resources.lang.Tab_BindResource%>">
                <%= Resources.lang.Tab_BindResource%>
            </li>
            <li title="生产时段">生产时段 </li>
        </ul>
        <!--基础信息-->
        <div class="tb_c">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.Line%>
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtLineName" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.Description%>
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtDescription" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <!--绑定资源-->
        <div>
            <asp:Localize ID="llResourcesList" runat="server"></asp:Localize>
        </div>
        <!--生产时段-->
        <div>
            <asp:Localize ID="llPeriodList" runat="server"></asp:Localize>
        </div>
    </div>
    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/tabs/jPlugin-tabs.js" type="text/javascript"></script>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/LineEdit.aspx?name=Resource_LineEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
