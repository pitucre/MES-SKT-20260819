<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="SupplierDeliveryList.aspx.cs" Inherits="SKT.LeanMES.Web.SuplyMaterial.SupplierDeliveryList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">采购单号</td>
            <td class="Field2">
                <asp:TextBox ID="txtpOCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">物料编码/名称/规格</td>
            <td class="Field2">
                <asp:TextBox ID="txtItem" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">供应商编码/名称</td>
            <td class="Field2">
                <asp:TextBox ID="txtSuplier" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">交货状态</td>
            <td class="Field2">
                <asp:DropDownList ID="ddlUnpaid" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="未完成" Selected="True">未完成</asp:ListItem>
                    <asp:ListItem Value="已完成">已完成</asp:ListItem>
                </asp:DropDownList>  
            </td>
        </tr>
        <tr>
            <td class="Label2">交货日期</td>
            <td class="Field2" colspan="3">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server"  readonly="readonly" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server"  readonly="readonly"/>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server" >
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"  DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound" style="table-layout:fixed;word-wrap:break-word;word-break:break-all"> 
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="POCode" HeaderText="采购单号"   HeaderStyle-Width="180px" />
            <asp:BoundField DataField="AutoId" HeaderText="采购单行号"   HeaderStyle-Width="180px" />
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ItemName" HeaderText="物料名称" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ItemDescription" HeaderText="物料规格" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="SuplierCode" HeaderText="供应商代码" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="VendorName" HeaderText="供应商名称" HeaderStyle-Width="180px" />
            <asp:BoundField DataField="ItemQty" HeaderText="物料数量" HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="FinishQty" HeaderText="已交数量" HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="UnpaidQyt" HeaderText="未交数量" HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="UnpaidStatus" HeaderText="交货状态" HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="PlanDateTime" HeaderText="交货日期" DataFormatString="{0:yyyy-MM-dd}"   HeaderStyle-Width="100px" />
             <asp:BoundField DataField="ConfirmDateTime" HeaderText="确认交期"
                HeaderStyle-Width="80px"   DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="DeliveryManCName" HeaderText="交货人"  HeaderStyle-Width="60px"/>
            <asp:BoundField DataField="ModifyByCName" HeaderText="确认人"
              HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="确认时间"
              DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"  HeaderStyle-Width="150px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Supplier.BLL.SupplierDelivery" SelectMethod="GetSupplierDeliveryList" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            window.parent.openTab(this, "供应商交期维护", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/SuplyMaterial/SupplierDelivery.aspx?name=SupplierDelivery", Date.parse(new Date()), "<%=SKT.LeanMES.Web.WebHelper.ImageRoot %>icon/eqpttype.png");
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
//            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SuplyMaterial/SupplierDeliveryEdit.aspx?name=SupplierDeliveryEdit&ID=" + idStr;
//            dialog({ title: "编辑供应商交期", src: openWinUrl, width: 1000, height: 600 });
            window.parent.openTab(this, "编辑供应商交期", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/SuplyMaterial/SupplierDeliveryEdit.aspx?name=SupplierDeliveryEdit&ID=" + idStr, Date.parse(new Date()), "<%=SKT.LeanMES.Web.WebHelper.ImageRoot %>icon/eqpttype.png");
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        //导出
        function Import() {
            hdnOperate.val("exportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>


