<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="AccessoryPartEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Accessories.AccessoryPartEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.ItemName%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1"
                    ClientIDMode="Static">
                </asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.PartType%><em>*</em>
            </td>
            <td class="Field1">
                <select name="txtPartType" id="txtPartType">
                    <option value="-1" selected="selected">--选择--</option>
                    <option value="0">
                        <%= Resources.Pages.PartType0%></option>
                    <option value="1">
                        <%= Resources.Pages.PartType1%></option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                供应商<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSupplier" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1"
                    Enabled="false" ClientIDMode="Static">
                </asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectSupplier()" />
                <asp:HiddenField ID="hdnSupplierId" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                入厂时间<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtFactoryTime" runat="server" CssClass="DateTimeBox" IsRequired="1"
                    ClientIDMode="Static">
                </asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                批次号<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtBatchNO" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1"
                    ClientIDMode="Static">
                </asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                重量<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtWeight" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1"
                    IsNumber='1' ClientIDMode="Static">
                </asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                规格<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSpec" runat="server" CssClass="TextBox" IsRequired="1" ClientIDMode="Static">
                </asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var flag = -1;
        var PartID = '<%=Request.QueryString["ID"] %>';
        _isHms = true;

        function Save() {
            var errStr = "";

            var txtItemName = $("#txtItemName").val();
            var txtPartType = $("#txtPartType").val();
            var hdnSupplierId = $("#hdnSupplierId").val();
            var txtFactoryTime = $("#txtFactoryTime").val();
            var txtBatchNO = $("#txtBatchNO").val();
            var txtWeight = $("#txtWeight").val();
            var txtSpec = $("#txtSpec").val();

            if (txtPartType == "-1") {
                errStr += "<%= Resources.lang.PartType + Resources.Messages.PRNotNull%>\n";
            }

            if (errStr != "") {
                alert(errStr);
                return false;
            }

            var entity = {};

            entity.ID = PartID;
            entity.ItemName = txtItemName;
            entity.LeedFree = txtPartType;
            entity.SupplierId = hdnSupplierId;
            entity.FactoryTime = txtFactoryTime;
            entity.BatchNO = txtBatchNO;
            entity.Weight = parseFloat(txtWeight);
            entity.Spec = txtSpec;
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";

            var ajax_Edit = SKT.LeanMES.Web.AjaxServices.AjaxAccessoryPart.EditAccessoryPart(entity);

            if (ajax_Edit.error != null) {
                alert(ajax_Edit.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess %>');

            parent.window.UpdateList(txtItemName);
        }


        /*选择供应商*/
        function selectSupplier() {
            chooseFlag = 34;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
            if (chooseFlag == 34) {
                $("#<%=this.txtSupplier.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnSupplierId.ClientID %>").val(list[0][0]);
            }
        }
    </script>
</asp:Content>
