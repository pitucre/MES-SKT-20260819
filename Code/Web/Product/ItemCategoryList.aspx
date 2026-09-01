<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ItemCategoryList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemCategoryList" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
 <link href="../Content/plugin/ligerTree/skins/Aqua/css/ligerui-tree.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/ligerTree/js/core/base.js"" type="text/javascript"></script>  
    <script src="../Content/plugin/ligerTree/js/plugins/ligerTree.js"" type="text/javascript"></script> 
<div style="width:98%;  margin-top:10px; padding-left:10px;  overflow:auto;  ">
        <ul id="ItemCategory">     
        </ul>
    </div>  
        <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
 <script type="text/javascript">
     var openWinUrl = "";
     var categoryId = -1;
     var categoryName = "";
     var hdnOperate = $("#hdnOperate");
     var hdnIdString = $("#hdnIdString");
     $(function () {
         loadTree();
     });

     function loadTree() {
         $("#ItemCategory").ligerTree({
             nodeDraggable: true,
             idFieldName: 'id',
             parentIDFieldName: 'pid',
             data: loadCategoryTree(),
             isExpand: 4,
             checkbox: false,
             nodeWidth: 370,
             onSelect: function (node) {
                 categoryId = node.data.id;
                 categoryName = categoryId==-1?"":node.data.text;
             }
         });
     }

     function loadCategoryTree() {
         var data = [];
         var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetCategoryTree();
         if (ajax.error != null) {
             alert(ajax.error.Message);
             return false;
         }

         var list = ajax.value;

         data.push({ "text": "产品类别", "id": -1, "pid": 0 });

         for (var i = 0; i < list.length; i++) {
             var entity = list[i];
              data.push({ "text": entity.CategoryName, "id": entity.ItemCategoryId,"pid":entity.ParentId });           
         }

         return data;
     }

     function Add() {
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemCategoryEdit.aspx?name=Product_CategoryAdd&ID=-1&ParentId=" + categoryId+"&ParentName=" + escape(categoryName);
         dialog({ title: "<%=Resources.Pages.Product_CategoryAdd %>", src: openWinUrl, width: 690, height: 400 });
     }
                                                                                                
     function Edit() {
         if (categoryId == -1) {
             alert("请选择具体的产品类别！");
             return false;
         }

         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemCategoryEdit.aspx?name=Product_CategoryEdit&ID=" + categoryId;
         dialog({ title: "<%=Resources.Pages.Product_CategoryEdit %>", src: openWinUrl, width: 690, height: 400 });
     }

     function Delete() {
         if (categoryId == -1) {
             alert("请选择具体的产品类别！");
             return false;
         }
         if (confirm("确定删除当前产品类别？")) {
             hdnOperate.val("delete");
             hdnIdString.val(categoryId);
             document.forms[0].submit();
         }
     }
     
 </script>
</asp:Content>
