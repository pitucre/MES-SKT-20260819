<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShopOrderChangeHistory.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ShopOrderChangeHistory" MasterPageFile="~/Masters/ListMaster.master" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>     
            <td class="Label1"><%=Resources.lang.ShopOrder %></td>       
            <td class="Field1" >
                <asp:TextBox ID="txtOrderNo" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
     
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="false" OnRowDataBound="GridView1_OnRowDataBound" ClientIDMode="Static">
        <Columns>
            <asp:BoundField DataField="Rowno" HeaderText="项次" />
            <asp:BoundField DataField="BusType" HeaderText="<%$ Resources:lang,OrderType %>" />
            <asp:BoundField DataField="MDeptName" HeaderText="<%$ Resources:lang,DepartmentName %>" />
            <asp:BoundField DataField="MDate" HeaderText="<%$ Resources:lang,CreateDateTime %>" />
            <asp:BoundField DataField="PlanBeginDate" HeaderText="<%$ Resources:lang,Planned_Start_Time %>" />
            <asp:BoundField DataField="PlanEndTime" HeaderText="<%$ Resources:lang,Planned_Completed_Date %>" />
            <asp:BoundField DataField="ComUnitCode" HeaderText="<%$ Resources:lang,PartUnit %>" />
            <asp:BoundField DataField="Qty" HeaderText="<%$ Resources:lang,Qty %>" />
            <asp:BoundField DataField="QualifiedInQty" HeaderText="入库数量" />
            <asp:BoundField DataField="Memo" HeaderText="<%$ Resources:lang,Remark %>" />
            <asp:BoundField DataField="MOStatus" HeaderText="<%$ Resources:lang,Status %>" />
            <asp:BoundField DataField="ChangePerson" HeaderText="<%$ Resources:lang,ChangePerson %>" />
            <asp:BoundField DataField="ChangeDate" HeaderText="<%$ Resources:lang,ChangeDate %>" />
            <asp:BoundField DataField="ChangeRemark" HeaderText="<%$ Resources:lang,ChangeDescription %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Order.BLL.MO_Change"
        SelectMethod="GetChangeHistoryAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#ckbMultipleSelected").parent().hide();
        })
    </script>

</asp:Content>
