<%@ Page Language="C#" MasterPageFile="~/Masters/Masters.master" AutoEventWireup="true" CodeBehind="EquipmentTypeList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentTypeList" %>

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
        var name = '<%=Request.QueryString["name"]%>';
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
             + "/Equipment/EquipmentTypeEdit.aspx?name=Equipment_EquipmentTypeAdd&ID=-1&Pid=" + parentId + "&parentName=" + escape(parentName);
            dialog({ title: "<%=Resources.Pages.Equipment_EquipmentTypeAdd %>", src: openWinUrl, width: 650, height: 400 });
        }

        /*Add by QiQuan.Zhong 2016-04-1*/
        function Edit() {
            /* 获取当前节点 */
            var node = getCurrentNode();

            /* 获取当前节点的第一节点属性值 */
            var parentId = node.id;
            var parentName = node.name;
            var Pid = node.PID
            var ParentTypeName = node.ParentTypeName;
            asyncNode = getParentNode();
            
            if (parseInt(parentId) <= 4) {
                alert("根节级点不可操作");
                return;
            }
            actionFalg = 2;
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentTypeEdit.aspx?name=Equipment_EquipmentTypeEdit&ID=" + parentId + "&Pid=" + Pid + "&parentName=" + escape(ParentTypeName);
            dialog({ title: "<%=Resources.Pages.Equipment_EquipmentTypeEdit %>", src: openWinUrl, width: 600, height: 400 });

        }

        function Delete() {
           
            var node = getCurrentNode();
            if (node == null) {
                alert("请选择删除节点！");
                return;
            }
            if (parseInt(node.id) <= 4) {
                alert("根节级点不可操作");
                return;
            }
            asyncNode = getParentNode();

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EquipmentDelete(node.id);
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
        });

        /*查看*/
        function View() {
            var node = getCurrentNode();
            debugger;
            var idStr = node.id;
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentTypeView.aspx?name=SteelTypeView&Id=" + idStr;
            dialog({ title: mesLang("查看钢网刮刀类型"), src: openWinUrl, width: 650, height: 400 });
        }
        /*Add by QiQuan.Zhong 2016-04-1*/
        function getAsyncUrl(treeId, treeNode) {
            var id = -1;
            if (name == 'SteelType') {
                id = "(-2,-3)";
            } else {

            }
            if (treeNode != null) {
                id = treeNode.id;
            }
            return "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/EquipmentTree.ashx?id=" + id;
        };
    </script>
</asp:Content>


<%--<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentTypeList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentTypeList" MasterPageFile="~/Masters/ListMaster.master" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
               <%=Resources.lang.EquipmentTypeName%>
            </td>
            <td class="Field1">
                <input type="text" id="txtEquipmentTypeName" class="TextBox" runat="server" clientidmode="Static"/>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
             <asp:BoundField DataField="EquipmentTypeName" HeaderText="类型名称" />
            <asp:BoundField DataField="EquipmentTypeCode" HeaderText="类型编码" />
            <asp:BoundField DataField="ParentTypeName" HeaderText="上级类型名称" />
            <asp:BoundField DataField="Remark" HeaderText="描述" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" />
            <asp:BoundField DataField="IsSystem" HeaderText="是否系统内置" />

            <asp:BoundField DataField="EquipmentTypeCode" HeaderText="<%$ Resources:lang,EquipmentTypeCode %>" />
            <asp:BoundField DataField="EquipmentTypeName" HeaderText="<%$ Resources:lang,EquipmentTypeName %>"  />
            <asp:BoundField DataField="IsLoading" HeaderText="<%$ Resources:lang,IsLoading %>"/>
            <asp:BoundField DataField="IsOffLine" HeaderText="<%$ Resources:lang,IsOffLine %>"/>
            <asp:BoundField DataField="IsScanPos" HeaderText="<%$ Resources:lang,IsScanPos %>"/>
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang,Remark %>"/>

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.EquipmentType"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var menuType = '<%= Request.QueryString["name"]==null? "":Request.QueryString["name"].ToString() %>';

        //增加 
        function Add() {
            if(menuType=="SteelType"){
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentTypeEdit.aspx?name=SteelTypeAdd&Id=-1";
            }
            else{
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentTypeEdit.aspx?name=Equipment_EquipmentTypeAdd&Id=-1";
            }
            
            dialog({ title: "<%= Resources.Pages.Equipment_EquipmentTypeAdd %>", src: openWinUrl, width: 500, height: 350, resizeable: false });
        }

        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            if(menuType=="SteelType"){
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentTypeEdit.aspx?name=SteelTypeEdit&Id=" + idStr;
            }
            else{
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentTypeEdit.aspx?name=Equipment_EquipmentTypeEdit&Id=" + idStr;
            }
            dialog({ title: "<%= Resources.Pages.Equipment_EquipmentTypeEdit %>", src: openWinUrl, width: 500, height: 350, resizeable: false });
        }      
        //刷新 
        function refresh() {
            document.forms[0].submit();
        }

        function Delete() {
        //删除前要判断，该设备类型是否存在设备信息中，如果存在，不允许删除
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            $(hdnOperate).val("Delete");
            $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(equipmentTypeName) {
            $("#txtEquipmentTypeName").val(equipmentTypeName);
            document.forms[0].submit();
        }
    </script>
</asp:Content>

--%>
