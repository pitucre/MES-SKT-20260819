<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BomUpdateCompare.aspx.cs" Inherits="SKT.LeanMES.Web.Schedule.BomUpdateCompare" MasterPageFile="~/Masters/ListMaster.master" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="false" OnRowDataBound="GridView1_OnRowDataBound" ClientIDMode="Static">
        <Columns>
            <asp:BoundField DataField="State" HeaderText="<%$ Resources:lang,ChangeDescription %>" />
            <asp:BoundField DataField="MoCode" HeaderText="<%$ Resources:lang,ShopOrder %>" />
            <asp:BoundField DataField="Rowno" HeaderText="项次" />
<%--        <asp:BoundField DataField="BusType" HeaderText="<%$ Resources:lang,OrderType %>" />
            <asp:BoundField DataField="MDeptName" HeaderText="<%$ Resources:lang,DepartmentName %>" />--%>
            <asp:BoundField DataField="InvCode" HeaderText="物料编码" />
            <asp:BoundField DataField="WhCode" HeaderText="仓库编码" />
            <asp:BoundField DataField="VouchCode" HeaderText="货位编码" />
            <asp:BoundField DataField="ComUnitCode" HeaderText="<%$ Resources:lang,PartUnit %>" />
            <asp:BoundField DataField="Qty" HeaderText="<%$ Resources:lang,Qty %>" />
            <asp:BoundField DataField="RequisitionIssQty" HeaderText="申请已领数量" />
            <asp:BoundField DataField="IssQty" HeaderText="已领数量" />
            <asp:BoundField DataField="CompScrap" HeaderText="损耗率" />
            <asp:BoundField DataField="Batch" HeaderText="批号" />
<%--            <asp:BoundField DataField="RSortSeq" HeaderText="工段号" />
            <asp:BoundField DataField="SortSeq" HeaderText="工序号" />
            <asp:BoundField DataField="WorkSeq" HeaderText="工作序号" />--%>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Schedule.BLL.ERP_MOBOM_Change"
        SelectMethod="GetChangeDetailAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>

<script type="text/javascript" >
    var orderNO = '<%= Request.QueryString["orderNO"] == null ? "***" : Request.QueryString["orderNO"].ToString()%>'
    var pubufts = '<%= Request.QueryString["pubufts"] == null ? "***" : Request.QueryString["pubufts"].ToString()%>'
    var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"

    //BOM确认变更
    function ConfirmUpdate() {

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.BomConfirmChange(orderNO, pubufts, user)
        if (ajax.error != null) {
            alert(ajax.error.Message)
            return false;
        }

        alert("变更成功！");

        parent.window.UpdateList("");
    }

    $(document).ready(function () {
            $("#searchBtns").hide();
            $("#ckbMultipleSelected").parent().hide();
    })
</script>

</asp:Content>
