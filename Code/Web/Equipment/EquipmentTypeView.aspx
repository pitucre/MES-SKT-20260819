<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentTypeView.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentTypeView" MasterPageFile="~/Masters/ViewMaster.master"%>
<asp:Content runat="server" ContentPlaceHolderID="viewcontent">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td id="tdParentType" class="Label1">
                 上级类型名
            </td>
            <td class="Field1">
                <asp:Label ID="lblParentTypeName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                 <%= Resources.lang.EquipmentTypeCode%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblEquipmentTypeCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.EquipmentTypeName%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblEquipmentTypeName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr name="trEquipment">
            <td class="Label1">
                 <%= Resources.lang.IsLoading%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblLoading"  runat="server"></asp:Label>
            </td>
        </tr>
        <tr name="trEquipment">
            <td class="Label1">
                 <%= Resources.lang.IsOffLine%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblOffLine"  runat="server"></asp:Label>
            </td>
        </tr>
        <tr name="trEquipment">
            <td class="Label1">
                 <%= Resources.lang.IsScanPos%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblScanPos"  runat="server"></asp:Label>
            </td>
        </tr>        
        <tr>
            <td class="Label1">
                 <%= Resources.lang.Remark%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblRemark"  runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>
        var name = '<%= Request.QueryString["name"] == null ? "" : Request.QueryString["name"].ToString() %>';
        $(document).ready(function(){
            if(name == "SteelTypeView"){
                $("tr[name='trEquipment']").css("display","none");
            }
        });

        //编辑
        function Edit() {
            if(name=="SteelTypeView"){
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentTypeEdit.aspx?name=SteelTypeEdit&Id=" + Id;
            }
            else{
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentTypeEdit.aspx?name=Equipment_EquipmentTypeEdit&Id=" + Id;
            }
	        $(".dlg-title.text", parent.window.document).html("<%= Resources.Pages.Equipment_EquipmentTypeEdit %>");
	        window.location.href = openWinUrl
        }
    </script>
</asp:Content>