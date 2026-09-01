<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="MouldItemEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldItemEdit" %>

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
            <td class="Label1">产品编码<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="Select"
                        onclick="openChoosePage(1);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">标准模穴<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMoldCavity" runat="server" CssClass="TextBox" IsRequired='1' ClientIDMode="Static" Text="0"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">使用模穴<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtUseMoldCavity" runat="server" CssClass="TextBox" IsRequired='1' ClientIDMode="Static" Text="0"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="button" style="margin-right: 5px" value="保存" onclick="save()" />
                <input type="button" style="margin-left: 5px" value="取消" onclick="cancel()" />
                <asp:HiddenField ID="hdnEquipmentId" runat="server" />
                <asp:HiddenField ID="hdncid" runat="server" />
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var action = '<%=Request.QueryString["action"].ToString()%>'
        var cid = '<%=Request.QueryString["cid"].ToString()%>'

        $(function () {

            if (cid != '' && cid != '-1') {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMoldFixtureItem.GetInfo(cid);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var data = ajax.value;

                $("#<%= hdnEquipmentId.ClientID %>").val(data.EquipmentId);
                $("#<%=hdnItemId.ClientID %>").val(data.ItemId);
                $("#<%=txtItemCode.ClientID %>").val(data.ItemCode);
                $("#<%=this.txtMoldCavity.ClientID %>").val(data.MoldCavity);
                $("#<%=this.txtUseMoldCavity.ClientID %>").val(data.UseMoldCavity);
            }
        })

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
            var itemid = $("#<%=hdnItemId.ClientID %>").val();
            var txtMoldCavity = parseFloat($("#<%=this.txtMoldCavity.ClientID %>").val());
            var txtUseMoldCavity = parseFloat($("#<%=this.txtUseMoldCavity.ClientID %>").val());
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMoldFixtureItem.Edit(itemid, equipmentId, txtMoldCavity, txtUseMoldCavity, cid);
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
