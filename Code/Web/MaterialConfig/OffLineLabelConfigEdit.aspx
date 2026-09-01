<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="OffLineLabelConfigEdit.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialConfig.OffLineLabelConfigEdit" %>

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
                    IsRequired='1' Text="*"></asp:TextBox><input type="button" id="btnSelectOpeType" class="ButtonBox"
                        value="..." title="Select" onclick="selectSupplier();" />
                <asp:HiddenField ID="hdnSupplierId" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnSupplierCode" runat="server" Value="*" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                分隔符<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="txtDelimiter" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
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
        var LabelID = '<%=Request.QueryString["ID"]%>';
        var flag = -1;
        function selectSupplier() {
            flag = 34;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 700, height: 400 });
        }

        function getChooseValue(list) {
            if (flag == 34) {
                if (list[0][0] == "-1") {
                    $("#txtSupplier").val("*");
                    $("#hdnSupplierCode").val("*");
                    $("#hdnSupplierId").val(list[0][0]);
                } else {
                    $("#txtSupplier").val(list[0][2]);
                    $("#hdnSupplierCode").val(list[0][1]);
                    $("#hdnSupplierId").val(list[0][0]);
                }
            }
            flag = -1;
        }

        function Save() {
            var VendorID = $("#hdnSupplierId").val();
            var VendorCode = $("#hdnSupplierCode").val();
            var VendorName = $("#txtSupplier").val();
            var Delimiter = $("#txtDelimiter").val();
            var Remark = $.trim($("#<%=this.txtRemark.ClientID%>").val());

            var entity = {};

            entity.LabelID = LabelID;
            entity.VendorID = VendorID;
            entity.VendorCode = VendorCode;
            entity.VendorName = VendorName;
            entity.Delimiter = Delimiter;
            entity.Remark = Remark;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.OffLineLabelConfigEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.UpdateList(VendorCode);
        }
    </script>
</asp:Content>
