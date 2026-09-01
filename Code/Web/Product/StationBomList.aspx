<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="StationBomList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.StationBomList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                BOM名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemBomName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">
                <%=Resources.lang.ItemCode %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">
                 <%=Resources.lang.Revision%>
            </td>
            <td class="Field3">
               <asp:TextBox ID="txtVersion" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%=Resources.lang.CurrentRevision %>
            </td>
            <td class="Field3">
                 <asp:DropDownList ID="ddlIsCurrentVer" runat="server">  
                <asp:ListItem Value="-1" Text="All"></asp:ListItem>               
                <asp:ListItem Value="1" Text="<%$ Resources:lang,Yes %>"></asp:ListItem>
                <asp:ListItem Value="0" Text="<%$ Resources:lang,No %>"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">
                <%=Resources.lang.Status %>
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlStatus" runat="server">  
                 <asp:ListItem Value="-1" Text="All"></asp:ListItem>                
                <asp:ListItem Value="1" Text="<%$ Resources:lang,InUse %>"></asp:ListItem>
                <asp:ListItem Value="0" Text="<%$ Resources:lang,OutOfService %>"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">
                来源
            </td>
            <td class="Field3">
                 <asp:DropDownList ID="ddlIsMESadd" runat="server">
                    <asp:ListItem Value="-1" Text="All"> </asp:ListItem>
                    <asp:ListItem Value="1" Text="ERP Down"> </asp:ListItem>
                    <asp:ListItem Value="2" Text="MES Import"> </asp:ListItem>
                    <asp:ListItem Value="3" Text="<%$ Resources:lang,MESCreation %>"> </asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="BomName" HeaderText="BOM名称" SortExpression="BomName" />
            <asp:BoundField DataField="Version" HeaderText="<%$ Resources:lang, Revision %>"
                HeaderStyle-Width="60px" SortExpression="Version" />
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>"
                SortExpression="ItemCode" />          
            <asp:BoundField DataField="Description" HeaderText="BOM描述" />
            <asp:TemplateField HeaderText="<%$ Resources:lang, Status %>" HeaderStyle-Width="80px"
                SortExpression="State">
                <ItemTemplate>
                    <%#Eval("State").ToString() == "0" ? Resources.lang.OutOfService :Resources.lang.InUse%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:lang, CurrentRevision %>" HeaderStyle-Width="80px"
                SortExpression="IsCurrentVer">
                <ItemTemplate>
                    <%#Eval("IsCurrentVer").ToString().ToLower() == "true"?Resources.lang.Yes:Resources.lang.No %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Source" HeaderText="来源" HeaderStyle-Width="60px" SortExpression="Source" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Product.BLL.StationBom"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">

        isMultiple = false;
        var openWinUrl = "";
        
        var hdnIdString = $("#hdnIdString");
    
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/StationBomView.aspx?name=Product_StationBomView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Product_StationBomView %>", src: openWinUrl, width: 1000, height: 500 });
        } 

    </script>
</asp:Content>
