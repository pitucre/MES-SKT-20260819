<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/Masters.master" CodeBehind="SupplierExameContentTree.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.SupplierExameContentTree" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/zTree/js/jquery.ztree.core.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.InspectionItemName%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtInspectionItemName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>--%>
    <div id="SupplierExameContentTree" class="ztree">
    </div>
    <input id="selectValue" type="hidden" value="" />
    <script type="text/javascript">

        /*页面树对象*/
        var zTree = null;

        /*需要重新加载的节点*/
        var asyncNode = null;

        function Add() {

            var node = getCurrentNode();

            if (node == null) {
                alert("请选择某一项添加子节点！");
                return;
            }


            /*如果添加成功将刷新asyncNode节点*/
            asyncNode = node;

            /* 获取当前节点的第一节点属性值 */
            var parentId = node.SupplierExameContentId;
            var parentName = node.name;

            node.isParent = true;
            zTree.updateNode(node);
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>"
             + "/Warehouse/SupplierExameContentEdit.aspx?name=Warehouse_SupplierExameContentAdd&ID=-1&parentId=" + parentId + "&parentName=" + parentName;
            dialog({ title: "<%=Resources.Pages.Warehouse_SupplierExameContentAdd %>", src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            /* 获取当前节点 */
            var node = getCurrentNode();

            /* 获取当前节点的第一节点属性值 */
            var parentId = node.SupplierExameContentId;
            var parentName = node.name;

            asyncNode = getParentNode();

            if (parseInt(parentId) <= 1) {
                alert("根节级点不可操作");
                return;
            }
            actionFalg = 2;
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/SupplierExameContentEdit.aspx?name=Warehouse_SupplierExameContentEdit&ID=" + parentId + "&controld=selectValue";
            dialog({ title: "<%=Resources.Pages.Warehouse_SupplierExameContentEdit %>", src: openWinUrl, width: 600, height: 400 });

        }

        function Delete() {
            var node = getCurrentNode();
            if (node == null) {
                alert("请选择删除节点！");
                return;
            }
            if (parseInt(node.SupplierExameContentId) <= 0) {
                alert("根节级点不可操作");
                return;
            }
            asyncNode = getParentNode();

            if (!window.confirm("确定要删除考核项吗?")) {
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplierExame.SupplierExameContentDelete(node.SupplierExameContentId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.DeleteSuccess %>');
            zTree.reAsyncChildNodes(asyncNode, "refresh");
        }

        //获当前节点
        function getCurrentNode() {
            var node = zTree.getSelectedNodes()[0];
            return node;
        }

        //获取当前的父节点
        function getParentNode() {
            var nodes = getCurrentNode().getParentNode();
            return nodes;
        }


        function UpdateList() {
            closeWaiting();
            zTree.reAsyncChildNodes(asyncNode, "refresh");
        }

        function filter(treeId, parentNode, childNodes) {
            if (!childNodes) return null;
            for (var i = 0, l = childNodes.length; i < l; i++) {
                childNodes[i].name = childNodes[i].name;
            }
            return childNodes;
        }

        $(document).ready(function () {

            var setting = {
                async: {
                    enable: true,
                    url: getAsyncUrl
                },
                onClick: function () {
                    alert(1);
                }
            };
            zTree = $.fn.zTree.init($("#SupplierExameContentTree"), setting);
            
            setTimeout(function () {
                var nodes = zTree.getNodes();               
                for (var i = 0; i < nodes.length; i++) { //设置节点展开                    
                    zTree.expandNode(nodes[i], true, false, true);                     
                }
            }, 200);
        });

        function getAsyncUrl(treeId, treeNode) {
            var id = -1;
            if (treeNode != null) {
                id = treeNode.SupplierExameContentId;
            }
            return "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/SupplierExameContentTree.ashx?id=" + id;
        };


    </script>
</asp:Content>

