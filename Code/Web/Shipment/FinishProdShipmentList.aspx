<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="FinishProdShipmentList.aspx.cs" Inherits="SKT.LeanMES.Web.Shipment.FinishProdShipmentList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                出货单
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtShipmentNo" runat="server"></asp:TextBox>
            </td>
            <td class="Label2">
                计划出货时间
            </td>
            <td class="Field2">
                从<asp:TextBox ID="txtCreateDateTimeStart" runat="server" CssClass="DateTimeBox"></asp:TextBox>
                到
                <asp:TextBox ID="txtCreateDateTimeEnd" runat="server" CssClass="DateTimeBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="false"
        ClientIDMode="Static">
        <Columns>
            <asp:BoundField DataField="Code" HeaderText="出货单据号" />
            <asp:BoundField DataField="SOCode" HeaderText="销售出货单" />
            <asp:BoundField DataField="PlanQty" HeaderText="计划出货数量" />
            <asp:BoundField DataField="OutStorageQty" HeaderText="已出货数量" />
            <asp:BoundField DataField="ShipDate" HeaderText="计划出货时间" />
            <asp:BoundField DataField="WhCode" HeaderText="仓库编码" />
            <asp:BoundField DataField="VenCode" HeaderText="供应商编码" />
            <asp:BoundField DataField="CusCode" HeaderText="客户编码" />
            <asp:BoundField DataField="PersonCode" HeaderText="业务员编码" />
            <asp:BoundField DataField="ChkPerson" HeaderText="检验员" />
            <asp:BoundField DataField="Wherson" HeaderText="仓库员" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Shipment.BLL.ShipmentRecord"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ckbMultipleSelected").parent().hide();
        })
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Shipment/FinishProdShipmentDetail.aspx?name=Production_FinishProdShipMentDetail&ID=" + idStr;
            dialog({ title: "查看出货明细", src: openWinUrl, width: 900, height: 400 });
        }
         
      
    </script>
</asp:Content>
