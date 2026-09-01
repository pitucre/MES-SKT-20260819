<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="StationView.aspx.cs" Inherits="SKT.LeanMES.Web.Station.StationView"
    Title="View Station" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="<%= Resources.lang.BaseInfo%>">
                <%= Resources.lang.BaseInfo%>
            </li>
            <li title="工序技能证书">工序技能证书 </li>
        </ul>
        <!--基本信息-->
        <div class="tb_c">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label2">
                        工序名称
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="txtOperation" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        工序编码
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="lblShortLetter" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        工序类型
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="txtOpeType" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        状态
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        资源类型
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtResType" runat="server"></asp:Label>
                    </td>
                    <td class="Label2">
                        工序默认绑定资源
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtResDefault" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr style=" display:none;">
                    <td class="Label2">
                        UI模板
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="txtOperationUITemp" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        版本 
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtVersion" runat="server"></asp:Label>
                    </td>
                    <td class="Label2">
                        是否当前版本
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblIsCurrent" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        描述
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="txtDescription" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <!--工序技能证书-->
        <div>
            <asp:Localize runat="server" ID="llStationSkill"></asp:Localize>
        </div>
    </div>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationEdit.aspx?name=Station_StationEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
