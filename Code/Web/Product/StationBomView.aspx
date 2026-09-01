<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true" CodeBehind="StationBomView.aspx.cs" Inherits="SKT.LeanMES.Web.Product.StationBomView" %>
<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">   
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.ItemCode %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemCode" runat="server"  ></asp:Label>                
            </td>
            <td class="Label2">
                <%=Resources.lang.ItemsName %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemName" runat="server" Text="" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Revision%>
            </td>
            <td class="Field2">
               <asp:Label ID="lblVersion" runat="server"  ></asp:Label> (<asp:Label ID="lblIsCurrentRev" runat="server"  ></asp:Label>)   
            </td>
            <td class="Label2">
                <%=Resources.lang.Status %>
            </td>
            <td class="Field2">
             <asp:Label ID="lblStatus" runat="server"  ></asp:Label>                    
            </td>
        </tr>
        <tr>
            <td class="Label2">            
                <%=Resources.lang.Description %>
            </td>
            <td class="Field2" colspan="3">
                 <asp:Label ID="lblBomDesc" runat="server"  ></asp:Label>    
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <div class="ListTableTitle">
        <%=Resources.lang.MaterialList%>&nbsp;<span id="bomCompList"></span></div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <%--<asp:BoundField DataField="ItemLevel" HeaderText="阶次" />--%>
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" />
            <asp:BoundField DataField="ItemName" HeaderText="物料描述" />
            <asp:BoundField DataField="Station" HeaderText="工序" />
            <asp:BoundField DataField="Units" HeaderText="单位" />
            <asp:BoundField DataField="Qty" HeaderText="单位用量" />
            <asp:BoundField DataField="UsePosition" HeaderText="使用位置" />           
            <asp:TemplateField HeaderText="是否虚拟件" >
                <ItemTemplate>
                    <%#Eval("IsFictitious").ToString().ToLower() == "true" ? "是" : "否"%>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Product.BLL.StationBom"
        SelectMethod="GetBomChildAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript">
        isMultiple = false;

        $().ready(function () {

            $(".ListTable").find("input[type='checkbox']").parent().hide();
        });
    </script>
</asp:Content>