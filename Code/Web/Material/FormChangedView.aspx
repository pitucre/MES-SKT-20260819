<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true" CodeBehind="FormChangedView.aspx.cs" Inherits="SKT.LeanMES.Web.Material.FormChangedView" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">单号
            </td>
            <td class="Field2">
                <asp:Label ID="txtFormChangeNo" runat="server"></asp:Label>
            </td>
            <td class="Label2">单据类型
            </td>
            <td class="Field2">
                <asp:Label ID="txtDocumentType" runat="server"></asp:Label>
            </td>
        </tr>

        <tr>
            <td class="Label2">仓库编码
            </td>
            <td class="Field2">
                <asp:Label ID="txtWarehouseCode" runat="server"></asp:Label>
            </td>
            <td class="Label2">仓库名称
            </td>
            <td class="Field2">
                <asp:Label ID="txtWarehouseName" runat="server"></asp:Label>
            </td>
        </tr>

    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <div class="ListTableTitle">
        转换单明细
    </div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
        <Columns>

            <asp:BoundField DataField="RowNo" HeaderText="行号" SortExpression="RowNo" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ChangeType" HeaderText="转换类别" SortExpression="ChangeType" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="MaterialCode" HeaderText="料号" SortExpression="MaterialCode" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="MaterialName" HeaderText="品名" SortExpression="MaterialName" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="StorageType" HeaderText="存储类型" SortExpression="StorageType" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
            <asp:TemplateField HeaderText="数量" SortExpression="Quantity" HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("Quantity","{0:G0}").ToString().IndexOf("E")>-1?Eval("Quantity","{0:G}").ToString():Eval("Quantity","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="成本数量" SortExpression="CostQuantity" HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("CostQuantity","{0:G0}").ToString().IndexOf("E")>-1?Eval("CostQuantity","{0:G}").ToString():Eval("CostQuantity","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Unit" HeaderText="单位" SortExpression="Unit" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CostUnit" HeaderText="成本单位" SortExpression="CostUnit" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
                  <asp:BoundField DataField="Cost" HeaderText="成本" SortExpression="Cost" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" DataFormatString="{0:N2}"/>
            <asp:BoundField DataField="UnitPrice" HeaderText="单价" SortExpression="UnitPrice" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" DataFormatString="{0:N2}"/>
            <asp:BoundField DataField="StorageLocation" HeaderText="存储地点" SortExpression="StorageLocation" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="WarehouseLocation" HeaderText="库位" SortExpression="WarehouseLocation" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="SpecificationModel" HeaderText="规格型号" SortExpression="SpecificationModel" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="FactoryCode" HeaderText="工厂代码" SortExpression="FactoryCode" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.AjaxCommon.DBService"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>
