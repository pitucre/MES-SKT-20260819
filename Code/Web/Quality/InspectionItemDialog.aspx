<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="InspectionItemDialog.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionItemDialog" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <link href="../Content/plugin/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/zTree/js/jquery.ztree.core.js" type="text/javascript"></script>
      <div ><%=Resources.Messages.CtrlCanChooseMore%></div>
    <div id="InspectionItemTree"  class="ztree">
    </div>
    <script type="text/javascript">


        var zTree = null ;
        /*Add by QiQuan.Zhong 2016-04-1*/
        $(document).ready(function () {

            var setting = {
                async: {
                    enable: true,
                    url: getAsyncUrl
                }
            };
            zTree = $.fn.zTree.init($("#InspectionItemTree"), setting);

        });

        /*Add by QiQuan.Zhong 2016-04-1*/
        function getAsyncUrl(treeId, treeNode) {
            var id = -1;
            if (treeNode != null) {
                id = treeNode.id;
            }
            return "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/InspectionItemList.ashx?id=" + id;
        };

        function Save() {
            var list = new Array();
            var nodes = zTree.getSelectedNodes();
            var value = "";
            for (var i = 0; i < nodes.length; i++) {
                var entity = {};
                
                entity.InspectionItemId = nodes[i].id;
                entity.InspectionItemName = nodes[i].name;
                entity.IsParent = nodes[i].isParent;
                entity.InspectionMethodId = nodes[i].InspectionMethodId;
                entity.TestMethod = nodes[i].TestMethod;
                entity.UnitName = nodes[i].UnitName;
                entity.OffsetUnitName = nodes[i].OffsetUnitName;
                entity.CheckFashion = nodes[i].Inpsectionmethods;
                list.push(entity);
            }

            parent.SetValue(list);
        }

    </script>
</asp:Content>
