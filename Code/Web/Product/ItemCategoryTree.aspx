<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ItemCategoryTree.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemCategoryTree" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
 <link href="../Content/plugin/ligerTree/skins/Aqua/css/ligerui-tree.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/ligerTree/js/core/base.js"" type="text/javascript"></script>  
    <script src="../Content/plugin/ligerTree/js/plugins/ligerTree.js"" type="text/javascript"></script> 
    <div style="padding:3px; position:relative; height:25px;"><div style=" position:absolute; top:8px; left:3px; font-weight:bold;"><img src="../Content/images/icon/openrouter.png" style="vertical-align:middle;" />选择上级类别</div><div style=" position:absolute; top:3px; right:0px;"><input type="button" value="选择" class="SearchButton" onclick="getChooseValue()"/></div></div>
    <div style="width:98%;   overflow:auto;  ">
        <ul id="ItemCategory">     
        </ul>
    </div>  
<script type="text/javascript">     
     var categoryId = 0;
     var categoryName = "";
     $(function () {
         $("#ItemCategory").height($(window).height() - 38);
         $("#ItemCategory").ligerTree({
             nodeDraggable: true,
             idFieldName: 'id',
             parentIDFieldName: 'pid',
             data: loadCategoryTree(),
             isExpand: 4,
             checkbox: false,
             nodeWidth: 170,
             onSelect: function (node) {
                 categoryId = node.data.id;
                 categoryName = node.data.text;
             }
         });
     });

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
             data.push({ "text": entity.CategoryName, "id": entity.ItemCategoryId, "pid": entity.ParentId });
         }

         return data;
     }

     function getChooseValue() {
         if (categoryId ==0) {
             alert("请选择类别！");
             return false;
         }
         if (categoryId == -1) {
             categoryName = "";
         }
         window.parent.getCategory(categoryId, categoryName);
     }
     </script>
</asp:Content>
