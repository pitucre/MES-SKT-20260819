<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.Container.ContainerList" CodeBehind="ContainerList.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                包装箱名称
            </td>
            <td class="Field2">
                <input type="text" id="txtContainerName" class="TextBox" runat="server" />
            </td>
             <td class="Label2">
                包装内容
            </td>
            <td class="Field2">
                <input type="text" id="txtPackingValue" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" 
        onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="包装箱名称" HeaderStyle-Width="180px" SortExpression="Name"/>
            <asp:BoundField DataField="PackingValue" HeaderText="包装内容" HeaderStyle-Width="100px" SortExpression="PackingValue"/>
            <asp:BoundField DataField="DataTypeName" HeaderText="包装箱类型" HeaderStyle-Width="100px" SortExpression="DataTypeName"/>
            <asp:BoundField DataField="MixShopOrders" HeaderText="工单混合包装" HeaderStyle-Width="80px" SortExpression="MixShopOrders"/>
            <asp:BoundField DataField="MixItems" HeaderText="产品混合包装" HeaderStyle-Width="80px" SortExpression="MixItems"/>
            <asp:BoundField DataField="Sequence" HeaderText="是否顺序包装" HeaderStyle-Width="80px" SortExpression="IsPackBySeq"/>
            <asp:BoundField DataField="Status" HeaderText="<%$ Resources:lang,Status %>" HeaderStyle-Width="60px" SortExpression="Status"/>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="Description" HeaderText="<%$ Resources:lang,Description %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Container.BLL.Container"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script language="javascript" type="text/javascript">
        isMultiple = false;
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        //增加 
        function Add()
        {
            dialog({ title: mesLang("新增容器"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Container/ContainerEdit.aspx?name=ContainerAdd&ID=-1", width: 850, height: 600, resizeable: true });
        }

        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: mesLang("编辑容器"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Container/ContainerEdit.aspx?name=ContainerEdit&ID=" + idStr, width: 850, height: 600, resizeable: true });
        }

        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: mesLang("查看容器"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Container/ContainerView.aspx?name=ContainerView&ID=" + idStr, width: 850, height: 600, resizeable: true });

        }
        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        //add by weixia  on  2015/3/31 打印
        function Print() {
            var idStr = getOneRecordId();
            debugger
            //xiang.yan 2024-4-26  列取值由索引改为列明,功能已去除
            // 1 改为 Name
            var name = getOneRecordCellTextByFiled("Name");
            if (idStr == "") return false;
            dialog({ title: mesLang("打印容器"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Container/ContainerPrint.aspx?name=ContainerPrint&typeValue=" + name + "&ID=" + idStr, width: 600, height: 400, resizeable: true });
        }
        //重打印
        function RePrint() {
            var idStr = getOneRecordId();
            //xiang.yan 2024-4-26  列取值由索引改为列明,功能已去除
            // 1 改为 Name
            var name = getOneRecordCellTextByFiled("Name");
            if (idStr == "") return false;
            dialog({ title: mesLang("打印容器"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Container/ContainerRePrint.aspx?name=ContainerRePrint&typeValue=" + name + "&ID=" + idStr, width: 600, height: 400, resizeable: true });
        }

        function UpdateList(strName) {
            $("#<%=this.txtContainerName.ClientID %>").val(strName);
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: mesLang("复制容器"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Container/ContainerEdit.aspx?name=ContainerCopy&ID=" + idStr + "&Action=Copy&rnd=" + Math.random(), width: 800, height: 400, resizeable: true });
        }
    </script>
</asp:Content>
