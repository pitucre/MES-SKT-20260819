<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master"
    AutoEventWireup="true" CodeBehind="ItemBomView.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemBomView" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
<div class="Tips" id="NotAllowModify" runat="server"></div>
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
    <div class="ListTableTitle">
        <%=Resources.lang.MaterialList%>&nbsp;<span id="bomCompList"></span></div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <%--<asp:BoundField DataField="ItemLevel" HeaderText="阶次" />--%>
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" />
            <asp:BoundField DataField="ItemName" HeaderText="物料描述" />
            <asp:BoundField DataField="Units" HeaderText="单位" />
         <%--   <asp:BoundField DataField="Qty" HeaderText="单位用量" />--%>
            <asp:TemplateField HeaderText="单位用量" SortExpression="Qty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("Qty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="UsePosition" HeaderText="使用位置" />
            <asp:TemplateField HeaderText="是否虚拟件">
                <ItemTemplate>
                    <%#Eval("IsFictitious").ToString().ToLower() == "true" ? "是" : "否"%>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Product.BLL.ItemBomChild"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
 <script type="text/javascript">
     function Edit() {
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemBomEdit.aspx?name=Product_BomEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
         location.href = openWinUrl;
     }
    </script>
</asp:Content>
