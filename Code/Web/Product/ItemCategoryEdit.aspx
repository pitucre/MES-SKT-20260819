<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ItemCategoryEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemCategoryEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
 <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
 
        <tr>
            <td class="Label1">
                上级类别
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtParentName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectCategory" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectCategory();" />               
                <asp:HiddenField ID="hdnParentId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.CategoryCode %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtCategoryCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
          <tr>
          <td class="Label1">
              是否上料
          </td>
          <td class="Field1">
               <asp:CheckBox ID="chkIsLoadMateril" runat="server" ClientIDMode="Static" />
          </td>
      </tr>
        <tr>
            <td class="Label1">
              类别名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtCategoryName" runat="server" CssClass="TextArea" TextMode="MultiLine" Width="260px" Height="80px"  ClientIDMode="Static" ></asp:TextBox>
            </td>
        </tr>         
    </table>
    <script type="text/javascript">

        var categoryId = '<%=Request.QueryString["ID"] %>';
        var parentId = '<%=Request.QueryString["ParentId"] %>';
        var parentName = '<%=Request.QueryString["ParentName"] %>';

        $(function () {
            if (parentId != "") {
                $("#txtParentName").val(parentName);
                $("#hdnParentId").val(parentId);
            }
        });

        function selectCategory() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Product/ItemCategoryTree.aspx?rnd=" + Math.random(), width: 300, height: 300 });
        }

        function getCategory(id,name) {
            $("#txtParentName").val(name);
            $("#hdnParentId").val(id);
            closeDialog();
        }

        function Save() {
            var txtParentId = $("#hdnParentId").val();
            var txtCategoryName = $("#txtCategoryName").val();
            var txtCategoryCode = $("#txtCategoryCode").val();
            
            var entity = {};
            entity.ParentId = txtParentId;
            entity.ItemCategoryId = categoryId;
            entity.CategoryName = txtCategoryName;
            entity.CategoryCode = txtCategoryCode;
            entity.IsLoadMateril = $("#chkIsLoadMateril").prop("checked")==true?1:0
            if (entity.CategoryName=="")
            {
                alert("请填写类别名称");
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.CategoryEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            window.parent.loadTree();
            window.parent.closeDialog();
        }     
    </script>
</asp:Content>