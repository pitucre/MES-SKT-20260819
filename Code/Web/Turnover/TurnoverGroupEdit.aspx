<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TurnoverGroupEdit.aspx.cs"
    Inherits="SKT.LeanMES.Web.Turnover.TurnoverGroupEdit" MasterPageFile="~/Masters/EditMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.TurnoverGroupName%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTurnoverGroupName" runat="server" CssClass="TextBox" MaxLength="50"
                    ClientIDMode="Static" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.TurnoverTypeName%><em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlTurnoverType" runat="server" ClientIDMode="Static" Width="100"
                    IsRequired='1'>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.ItemsName%>&nbsp;
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItem" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                    Width="100">
                </asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="Select"
                    onclick="selectItem();" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MinStowQty%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMinStowQty" runat="server" CssClass="NumericBox50" Width="60px" MaxLength="50"
                    ClientIDMode="Static" IsRequired='1' IsNumber='1' onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" Text="1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MaxStowQty%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMaxStowQty" runat="server" CssClass="NumericBox50" Width="60px" MaxLength="50"
                    ClientIDMode="Static" IsRequired='1' IsNumber='1' onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" Text="1"></asp:TextBox>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <script type="text/javascript" language="javascript">
        var Id = '<%= Request.QueryString["Id"]%>';
        function selectItem() {
            dialog({ title: "<%=Resources.Pages.Product_ItemList %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function getChooseValue(list) {
            $("#hdnItemId").val(list[0][0]);
            $("#txtItem").val(list[0][1]);
        }

        function Save() {
            var txtTurnoverGroupName = $("#txtTurnoverGroupName").val();
            var txtMinStowQty = $("#txtMinStowQty").val();
            var txtMaxStowQty = $("#txtMaxStowQty").val();
            var txtItemId = $("#hdnItemId").val();
            var strError = "";
            var ddlTurnoverTypeId = $("#ddlTurnoverType").val();
            if (ddlTurnoverTypeId == "-1") {
                strError += "请选择周转工具种类";
            }
            if (txtMinStowQty == "0") {
                strError += "<%=Resources.Messages.MinStowQtyMustGreaterZero %>";
            }
            if (parseInt(txtMinStowQty) > parseInt(txtMaxStowQty)) {
                strError += "最小装载数量不能大于最大装载数量！";                 
            }
            if (!isNull(strError)) {
                alert(strError.toString());
                return false;
            }
            var entity = {};
            var action = '<%=Request.QueryString["Action"] %>';
            if (action == "Copy") {
                entity.TurnoverGroupId = -1;
            }
            else {
                entity.TurnoverGroupId = Id;
            }
            entity.TurnoverGroupName = txtTurnoverGroupName;
            entity.TurnoverTypeId = ddlTurnoverTypeId;
            entity.ItemId = txtItemId;
            entity.MinQty = txtMinStowQty;
            entity.MaxQty = txtMaxStowQty;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxTurnover.EditTurnoverGroup(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveSuccess %>');
            parent.window.UpdateList(txtTurnoverGroupName)
        }

    </script>
</asp:Content>
