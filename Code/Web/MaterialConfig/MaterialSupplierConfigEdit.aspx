<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="MaterialSupplierConfigEdit.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialConfig.MaterialSupplierConfigEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
 <div class="infoTips">
            <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                供应商<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSupplier" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                    IsRequired='1' Text=""></asp:TextBox><input type="button" id="btnSelectOpeType" class="ButtonBox"
                        value="..." title="Select" onclick="selectSupplier();" />
                <asp:HiddenField ID="hdnSupplierId" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnSupplierCode" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                物料编码<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                    IsRequired='1' Text=""></asp:TextBox><input type="button" id="Button1" class="ButtonBox"
                        value="..." title="Select" onclick="selectItem();" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnItemCode" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                打印方式
            </td>
            <td class="Field1">
                <asp:DropDownList runat="server" ID="ddlPrintType" ClientIDMode="Static">
                    <asp:ListItem Value="1">IQC检验前</asp:ListItem>
                    <asp:ListItem Value="2">IQC检验后</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                备注
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var supplerConfigId = '<%=Request.QueryString["ID"]%>';
        var factoryCode = "";
        var flag = -1;
        function selectSupplier() {
            flag = 34;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }

        function selectItem() {
            flag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }


        function getChooseValue(list) {
            if (flag == 34) {
                $("#txtSupplier").val(list[0][2]);
                $("#hdnSupplierCode").val(list[0][1]);
                $("#hdnSupplierId").val(list[0][0]);
                factoryCode = list[0][3];
            } else if (flag == 1) {
                $("#txtItemName").val(list[0][1]);
                $("#hdnItemCode").val(list[0][2]);
                $("#hdnItemId").val(list[0][0]);
            }
            flag = -1;
        }

        function Save() {
            var txtSupplierId = $("#hdnSupplierId").val();
            var txtVendorCode = $("#hdnSupplierCode").val();
            var txtItemId = $("#hdnItemId").val();
            var txtItemCode = $("#hdnItemCode").val();
            var txtPrintTypeId = $("#ddlPrintType").val();
            var txtPrintType = $("#ddlPrintType").find(":selected").text();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.ID = supplerConfigId;
            entity.SupplierId = txtSupplierId;
            entity.VendorCode = txtVendorCode;
            entity.ItemId = txtItemId;
            entity.ItemCode = txtItemCode;
            entity.PrintTypeId = txtPrintTypeId;
            entity.PrintType = txtPrintType;
            entity.Remark = txtRemark;
            entity.Site = factoryCode;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.MaterialSupperEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.UpdateList(txtVendorCode);
        }
    </script>
</asp:Content>
