<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="NCGroupView.aspx.cs" Inherits="SKT.LeanMES.Web.NCCode.NCGroupView"
    Title="View NCGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current">基本信息</li>
            <li>已选不良代码</li>
            <li>已绑定工序</li>
        </ul>
        <div class="tb_c">
            <table width="100%" class="ContentTable">
                <tr>
                    <td class="Label1">
                        <%= Resources.lang.NCGroup%>
                    </td>
                    <td class="Field1">
                        <asp:Label ID="lblNCGroupName" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        绑定所有工位
                    </td>
                    <td class="Field1">
                        <asp:Label ID="lblBindAllStation" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        <%= Resources.lang.Description%>
                    </td>
                    <td class="Field1">
                        <asp:Label ID="lblDescription" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <asp:Localize ID="llNCCodeList" runat="server"></asp:Localize>
        </div>
        <div>
            <asp:Localize ID="llStationList" runat="server"></asp:Localize>
        </div>
    </div>
    <script type="text/javascript">
        function Edit()
        {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/NCCode/NCGroupEdit.aspx?name=NCCode_NCGroupEdit&ID="+<%= Request.QueryString["ID"] %>;
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
