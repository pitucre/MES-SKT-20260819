<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="EquipmentPositionEditDtl.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentPositionEditDtl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">备件<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1' ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectPart(504);" />
                <asp:HiddenField ID="hdnItemCode" runat="server" Value="" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">数量<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtQty" runat="server" CssClass="TextBox" IsRequired='1' IsNumber='1' MinValue='0' ClientIDMode="Static"></asp:TextBox>&nbsp;
            </td>
        </tr>

    </table>
    <div class="clear5">
    </div>
    <div style="text-align: center">
        <input type="button" class="button" value="确认" style="min-width: 70px"  onclick="Save()"/>
    </div>
    <script type="text/javascript">
        var EqCode = '<%=Request.QueryString["EqCode"] %>';
        var chooseFlag = 0;
        var PartCode = "";
        var username = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        /*部件*/
        function selectPart() {
            var pgC = " EquipmentCode='" + EqCode + "'";
            temp = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=672&PageCondition=" + pgC + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
            PartCode = list[0][1];
            $("#<%=this.txtItemName.ClientID %>").val(list[0][1]);
            $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);
            $("#lblUnit").html(list[0][5]);
        }

        function Save() {
            if (PartCode == "") {
                alert("请选择部件");
                return false;
            }
            if ($("#<%=this.txtQty.ClientID%>").val() == "") {
                alert("请输入数量");
                return false;
            }
            var str = PartCode + "|" + $("#<%=this.txtQty.ClientID%>").val();
            parent.window.update(str);
        }
    </script>
</asp:Content>
