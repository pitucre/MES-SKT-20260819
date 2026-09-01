<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" 
    AutoEventWireup="true" CodeBehind="ItemTypeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemTypeEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                物料类型编码：<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemTypeCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                物料类型名称：<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemTypeName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                备注：
            </td>
            <td class="Field2">
               <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" ClientIDMode="Static" TextMode="MultiLine"></asp:TextBox>
            </td>
            
        </tr>
    </table>
    <script language="javascript" type="text/javascript">
        var ItemTypeID = '<%=Request.QueryString["ID"] %>';
        $(function () {
        });
        //保存数据
        function Save() {
            //获取界面上控件元素
            var txtItemTypeCode = $("#<%=this.txtItemTypeCode.ClientID %>");
            var txtItemTypeName = $("#<%=this.txtItemTypeName.ClientID %>");
            var txtRemark = $("#<%=this.txtRemark.ClientID %>");

            if (ItemTypeID == -1) {
                /*验证带*是否为空*/
                if (isNull(txtItemTypeCode.val())) {
                    alert("带*项不能为空！");
                    txtItemTypeCode.focus();
                    return false;
                }
                if (isNull(txtItemTypeName.val())) {
                    alert("带*项不能为空！");
                    txtItemTypeName.focus();
                    return false;
                }
            }

            var entity = {};
            entity.ItemTypeID = ItemTypeID;
            entity.ItemTypeCode = txtItemTypeCode.val();
            entity.ItemTypeName = txtItemTypeName.val();
            entity.Remark = txtRemark.val();

            var ajaxsave = SKT.LeanMES.Web.AjaxServices.AjaxProduct.SaveItemTypeInfo(entity);

            if (ajaxsave.error == null) {
                alert('<%=Resources.Messages.SaveInSuccess %>');
                parent.window.UpdateList(txtItemTypeName.val());
            }
            else {
                alert(ajaxsave.error.Message);
                return false;
            }
        }
    </script>
</asp:Content>
