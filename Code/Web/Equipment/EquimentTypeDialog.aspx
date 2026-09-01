<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="EquimentTypeDialog.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquimentTypeDialog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <link href="../Content/plugin/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/zTree/js/jquery.ztree.core.js" type="text/javascript"></script>
    <%--<div ><%=Resources.Messages.CtrlCanChooseMore%></div>--%>
    <div id="InspectionItemTree" class="ztree">
    </div>
    <script type="text/javascript">


        var zTree = null;
        /*Add by QiQuan.Zhong 2016-04-1*/
        $(document).ready(function () {

            var setting = {
                async: {
                    enable: true,
                    url: getAsyncUrl
                },
                view: {
                    selectedMulti: false //禁止多选
                }
            };
            zTree = $.fn.zTree.init($("#InspectionItemTree"), setting);

        });

        /*Add by QiQuan.Zhong 2016-04-1*/
        function getAsyncUrl(treeId, treeNode) {
            //var id = -1;
            var controlId = '<%=controlId%>';
            var id = "(1,1)";
            if (controlId != 'controlId') {
                id = "(" + controlId + "," + controlId + ")";
            }
           
           
            if (treeNode != null) {
                id = treeNode.id;
            }
            return "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/EquipmentTree.ashx?id=" + id;
        };

        function Save() {
            var list = new Array();
            var nodes = zTree.getSelectedNodes();
            var value = "";
            for (var i = 0; i < nodes.length; i++) {
                var entity = {};
                if (nodes[i].PID == -1) {
                    alert("不能选择根节点");
                    return false;
                }
                entity.id = nodes[0].id;
                entity.name = nodes[0].name;
                list.push(entity);
            }
            parent.SetValue(list);
        }

    </script>
</asp:Content>
