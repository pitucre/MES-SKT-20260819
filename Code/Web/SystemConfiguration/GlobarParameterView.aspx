<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="GlobarParameterView.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.GlobarParameterView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">       
        <tr>
            <asp:HiddenField runat="server" ID="txtHideID" Value="-1" />
            <td class="Label2">
                编号
            </td>
            <td class="Field2">
                <label id="lblParaType" runat="server" ></label>
            </td>            
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.ParaDescription %>
            </td>
            <td class="Field2">
                <label id="lblParaDescription" runat="server" ></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.ParaName %>
            </td>
            <td class="Field2">
                <label id="lblParaName" runat="server" ></label>
            </td>
           
        </tr>
        <tr>
         <td class="Label2">
                <%=Resources.lang.ParaValue %>
            </td>
            <td class="Field2" >
                <label id="lblParaValue" runat="server" ></label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/GlobarParameterEdit.aspx?name=GlobarParameterEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
