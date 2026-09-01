<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="PartInOutStockRecordList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.PartInOutStockRecordList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
 <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
         <tr>
             <td class="Label2"><%= Resources.lang.PartCode%></td>
             <td class="Field2">
                 <asp:TextBox ID="txtPartCode" runat="server" CssClass="TextBox"></asp:TextBox>
             </td>
             <td class="Label2"><%= Resources.lang.PartName%></td>
             <td class="Field2">
                 <asp:TextBox ID="txtPartName" runat="server" CssClass="TextBox"></asp:TextBox>
             </td>
             
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.OperationTime%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtStartTime" runat="server"  CssClass="DateTimeBox"></asp:TextBox> ~   <asp:TextBox ID="txtEndTime"  runat="server"  CssClass="DateTimeBox"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.SQLType%>
            </td>
            <td class="Field2" rowspan="3">
                <asp:DropDownList ID="ddOutType" ClientIDMode="Static" runat="server" Width="100" >
                    <asp:ListItem Value="" >请选择</asp:ListItem>
                    <asp:ListItem Value="新增入库" >新增入库</asp:ListItem>
                    <asp:ListItem Value="产线入库" >产线入库</asp:ListItem>
                    <asp:ListItem Value="使用出库" >使用出库</asp:ListItem>
                    <asp:ListItem Value="报废出库" >报废出库</asp:ListItem>
                </asp:DropDownList>
            </td>
            
        </tr>
    </table> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="PartCode" HeaderText="<%$ Resources:lang, PartCode %>" />
            <asp:BoundField DataField="PartName" HeaderText="<%$ Resources:lang, PartName %>" />
            <asp:BoundField DataField="OperationType" HeaderText="<%$ Resources:lang, SQLType %>" />
            <asp:BoundField DataField="Qty" HeaderText="数量" /> 
            <asp:BoundField DataField="Remark" HeaderText="备注" HeaderStyle-Width="200" /> 
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,Operator %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, OperationTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
          
            
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Equipment.BLL.Part" SelectMethod="GetAllInOutStockList" SelectCountMethod="GetCount">
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

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/PartInOutStockRecordView.aspx?name=EquimentPartView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.PartView %>", src: openWinUrl, width: 600, height: 280 });
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>