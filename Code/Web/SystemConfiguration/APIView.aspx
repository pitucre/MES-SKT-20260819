<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="APIView.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.APIView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr><td colspan="4" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td></tr>
        <tr>
            <td class="Label2">业务名称</td>
            <td class="Field2">
                <label id="lblBusinessName" style="width:80%" runat="server"></label>
            </td>
            <td class="Label2">SAP内表名</td>
            <td class="Field2">
                <label id="lblSapTabName" style="width:80%" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">处理函数</td>
            <td class="Field2">
                <label id="lblFuncName" style="width:80%" runat="server"></label>
            </td>
            <td class="Label2">目标库表名</td>
            <td class="Field2">
                <label id="lblTargetTabName" style="width:80%" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">传入参数</td>
            <td class="Field2" colspan="3">
                <label id="lblSapParam" style="width:80%" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">参数描述</td>
            <td class="Field2" colspan="3">
                <label id="lblSapParamDesc" style="width:80%" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">SAP读取列</td>
            <td class="Field2" colspan="3">
                <label id="lblSapFields" style="width:80%" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">目标表对应列</td>
            <td class="Field2" colspan="3">
                <label id="lblTargetTabFields" style="width:80%" runat="server"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">备注</td>
            <td class="Field2" colspan="3">
                <label id="lblRemark" style="width:80%" runat="server"></label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/APIEdit.aspx?name=System_APIListEdit&ID="  + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
