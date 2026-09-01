<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="AccessoryAndItemRelationDtlEdit.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryAndItemRelationDtlEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">辅料名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1' ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectAccessory(504);" />
                <asp:HiddenField ID="hdnItemCode" runat="server" Value="" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">单位用量<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtQty" runat="server" CssClass="TextBox" IsRequired='1' IsNumber='1' MinValue='0' ClientIDMode="Static"></asp:TextBox>&nbsp;
                <asp:Label ID="lblUnit" runat="server" ClientIDMode="Static"></asp:Label>
                <asp:Label runat="server" ID="txtUnitname"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var bomChildId = '<%=Request.QueryString["ID"] %>';
        var Pid = '<%=Request.QueryString["BOMID"] %>';
        var chooseFlag = 0;
        var username = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        function selectAccessory(i) {
            flag = 0;
            chooseFlag = 504;
            pageCondition = "";
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + chooseFlag + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValue(list) {
            $("#<%=this.hdnItemCode.ClientID %>").val(list[0][2]);
            $("#<%=this.txtItemName.ClientID %>").val(list[0][1]);
            $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);
            $("#lblUnit").html(list[0][5]);
        }

        function Save() {
            var ItemCode = $("#<%=this.txtItemName.ClientID %>").val();
            var model = {};
            model.Id = bomChildId;
            model.Pid = Pid;
            model.AccessoryCode = ItemCode;
            model.UnitName = $("#lblUnit").html() == "&nbsp;" ? "" : $("#lblUnit").html();
            model.CreateBy = username;
            model.Value = parseFloat($("#<%=this.txtQty.ClientID%>").val());
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessoryItemRelationDtl.Edit(model);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.update(Pid);
        }
    </script>
</asp:Content>
