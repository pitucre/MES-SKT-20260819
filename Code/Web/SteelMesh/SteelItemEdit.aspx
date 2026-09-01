<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="SteelItemEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelItemEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" colspan="6">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label1">
                产品编码<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="Select"
                    onclick="openChoosePage(1);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                面别<em>*</em>
            </td>
            <td class="Field1">                
                <asp:DropDownList ID="ddlLayout" runat="server" CssClass="TextBox" IsRequired='1'>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="button" style="margin-right:5px" value="保存" onclick="save()" />
                <input type="button" style="margin-left:5px" value="取消"  onclick="cancel()"/>
                <asp:HiddenField ID="hdnEquipmentId" runat="server" />
                <asp:HiddenField ID="hdnOptionType" runat="server" />
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        
        function openChoosePage(flags) {
            var condition = "";
            flag = flags;
            dialog({
                title: "<%= Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                flags +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&rnd=" +
                Math.random(),
                width: 650,
                height: 300
            });
        }

        function getChooseValue(list) {
            if (flag == 1) {
                $("#<%=txtItemCode.ClientID %>").val(list[0][2]);
                $("#<%=hdnItemId.ClientID %>").val(list[0][0]);
            }
        }

        function save() {
            var equipmentId = $("#<%= hdnEquipmentId.ClientID %>").val();
            var OptionType = $("#<%= hdnOptionType.ClientID %>").val();
            var itemid = $("#<%=hdnItemId.ClientID %>").val();
            var layout = $("#<%= ddlLayout.ClientID %>").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.AddSteelItem(equipmentId, itemid, layout, OptionType);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            window.parent.refush();
        }

        function cancel() {            
            window.parent.closeOpen();
        }
    </script>
</asp:Content>
