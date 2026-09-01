<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="StationTypeView.aspx.cs" Inherits="SKT.LeanMES.Web.Station.StationTypeView"
    Title="View StationType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="<%= Resources.lang.BaseInfo%>">
                <%= Resources.lang.BaseInfo%>
            </li>
            <li title="已分配工位">已分配工位 </li>
        </ul>
        <!--基本信息-->
        <div class="tb_c">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label2">
                        工序类型
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtOpeType" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr style="display: none">
                    <td class="Label2">
                        UI模板
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtOperationUITemp" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        描述
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtDescription" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <!--分配工位-->
        <div>
        <asp:Localize runat="server" ID="llStationList"></asp:Localize>
        </div>
    </div>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationTypeEdit.aspx?name=Station_StationTypeEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
