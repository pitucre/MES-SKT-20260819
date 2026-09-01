<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="WarehouseCheckReport.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialCheck.WarehouseCheckReport" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">盘点单</td>
            <td class="Field2">
                <asp:TextBox ID="txtCheckNo" runat="server" class="TextBox" Style="width: 275px"></asp:TextBox>
                <input type="button" id="Button1" class="ButtonBox" value="..." onclick="selectCheckOrder()" /></td>
            <td class="Label2">盘点状态</td>
            <td class="Field2">
                <asp:DropDownList ID="ddlStatus" ClientIDMode="Static" Style="min-width: 205px" runat="server">
                    <%--                    <asp:ListItem value="0">已取消</asp:ListItem>--%>
                    <asp:ListItem Value="0">全部</asp:ListItem>
                    <asp:ListItem Value="1">已创建</asp:ListItem>
                    <asp:ListItem Value="2">已审核</asp:ListItem>
                    <asp:ListItem Value="3">盘点中</asp:ListItem>
                    <asp:ListItem Value="4">已完成</asp:ListItem>
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td class="Label2">仓库</td>
            <td class="Field2">
                <asp:TextBox ID="txtWarehouse" runat="server" class="TextBox" Style="width: 275px"></asp:TextBox>
                <input id="button1" class="ButtonBox" type="button" onclick="selectWhCodeList()"
                    value="..." title="选择仓库" />

                <%--                <td class="Label2">物料编码</td>
                <td class="Field2">
                    <input type="hidden" value="-1" id="hdnItemId" />
                    <input type="hidden" value="" id="txtMaCode" disabled="disabled" style="width: 275px" />
                    <input type="text" value="" isrequired="1" id="lbItemCode" /><input type="button" value="..." class="ButtonBox"
                        onclick="chooseMaterial()" />--%>
        </tr>
        <tr>
            <td class="Label2">盘点时间</td>
            <td class="Field2" colspan="3">
                <asp:TextBox type="text" runat="server" ID="stime" class="DateTimeBox" Style="min-width: 205px;"></asp:TextBox>---<asp:TextBox runat="server" ID="etime" class="DateTimeBox" Style="min-width: 205px"></asp:TextBox></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="CWhName" HeaderText="仓库" />
            <asp:BoundField DataField="CheckOrder" HeaderText="盘点单" />
            <asp:BoundField DataField="WarehouseCheckTypeName" HeaderText="盘点类型" />
            <asp:BoundField DataField="BeginDate" HeaderText="计划开始时间" />
            <asp:BoundField DataField="WarehouseCheckStatusName" HeaderText="状态" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateTime" HeaderText="盘点开始时间" />
            <asp:BoundField DataField="FinishDate" HeaderText="盘点结束时间" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.WarehouseCheck"
        SelectMethod="GetOneList" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript">
        isMultiple = false;
        var flag = 0;
        function ShowTab() {

        }
        function dblClk(data) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/MaterialCheck/WarehouseCheckReportDtl.aspx?CheckNo=" + $(data).find('td:eq(2)').html() + "&rnd=" + Math.random(), width: 1000, height: 500 });
        }
        /*选择仓库*/
        function selectWhCodeList() {
            flag = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }
<%--        /*选择物料*/
        function chooseMaterial() {
            flag = 3;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }--%>
        /*选择盘点单*/
        function selectCheckOrder() {
            flag = 1;
            $("#msg").html('');
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=200&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function getChooseValue(list) {
            if (flag == 1) {
                $("#<%=this.txtCheckNo.ClientID %>").val(list[0][0]);
                CheckNo = list[0][0];
            } if (flag == 2) {
                $("#<%=this.txtWarehouse.ClientID %>").val(list[0][2]);
            } if (flag == 3) {

            }
        }
    </script>
</asp:Content>
