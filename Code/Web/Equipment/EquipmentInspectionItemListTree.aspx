<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Masters.master" AutoEventWireup="true" CodeBehind="EquipmentInspectionItemListTree.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentInspectionItemListTree" %>

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
    <div id="InspectionItemTree" class="ztree">
    </div>
    <input id="selectValue" type="hidden" value="" />
    <script type="text/javascript">

        /*Add by QiQuan.Zhong 2016-04-1 页面树对象*/
        var zTree = null;

        /*Add by QiQuan.Zhong 2016-04-1 需要重新加载的节点*/
        var asyncNode = null;

        /*Add by QiQuan.Zhong 2016-04-1*/
        function Add() {

            var node = getCurrentNode();

            if (node == null) {
                alert("请选择某一项添加子节点！");
                return;
            }


            /*如果添加成功将刷新asyncNode节点*/
            asyncNode = node;

            /* 获取当前节点的第一节点属性值 */
            var parentId = node.id;
            var parentName = node.name;

            node.isParent = true;
            zTree.updateNode(node);
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>"
                + "/Equipment/EquipmentInspectionItemEdit.aspx?name=Equipment_InspectionItemAdd&ID=-1&parentId=" + parentId + "&parentName=" + parentName;
            dialog({ title: "<%=Resources.Pages.QC_InspectionItemAdd %>", src: openWinUrl, width: 650, height: 400 });
        }

        /*Add by QiQuan.Zhong 2016-04-1*/
        function Edit() {
            /* 获取当前节点 */
            var node = getCurrentNode();

            /* 获取当前节点的第一节点属性值 */
            var parentId = node.id;
            var parentName = node.name;

            asyncNode = getParentNode();

            if (parseInt(parentId) <= 0) {
                alert("根节级点不可操作");
                return;
            }
            actionFalg = 2;
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentInspectionItemEdit.aspx?name=Equipment_InspectionItemEdit&ID=" + parentId + "&controld=selectValue";
            dialog({ title: mesLang("新增点检检验项"), src: openWinUrl, width: 600, height: 400 });

        }

        function Delete() {
            var node = getCurrentNode();
            if (node == null) {
                alert("请选择删除节点！");
                return;
            }
            if (parseInt(node.id) <= 0) {
                alert("根节级点不可操作");
                return;
            }
            asyncNode = getParentNode();

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.GetInspectionItemDelete(node.id);
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

        /*Add by QiQuan.Zhong 2016-04-1*/
        function UpdateList() {
            closeWaiting();
            zTree.reAsyncChildNodes(asyncNode, "refresh");
        }

        /*Add by QiQuan.Zhong 2016-04-1*/
        function filter(treeId, parentNode, childNodes) {
            if (!childNodes) return null;
            for (var i = 0, l = childNodes.length; i < l; i++) {
                childNodes[i].name = childNodes[i].name;
            }
            return childNodes;
        }

        /*Add by QiQuan.Zhong 2016-04-1*/
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
            zTree = $.fn.zTree.init($("#InspectionItemTree"), setting);
            
            setTimeout(function () {
                var nodes = zTree.getNodes();               
                for (var i = 0; i < nodes.length; i++) { //设置节点展开                    
                    zTree.expandNode(nodes[i], true, false, true);                     
                }
            }, 200);
        });

        /*Add by QiQuan.Zhong 2016-04-1*/
        function getAsyncUrl(treeId, treeNode) {
            var id = -1;
            if (treeNode != null) {
                id = treeNode.id;
            }
            return "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/EquipmentInspectionItemList.ashx?id=" + id;
        };
        //导入Excel
        function ImportToExcel() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentInspectionItemListTreeImport.aspx?name=Equipment_InspectionItemEdit&ID=-1";
            dialog({ title: mesLang("导入"), src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 200) });
        }

    </script>
</asp:Content>
