<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="BarCodeScopeDtlList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.BarCodeScopeDtlList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server" ViewStateMode="Enabled">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                工单号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox"  ClientIDMode="Static"></asp:TextBox>
                <input type="button" id="bnOper" class="ButtonBox" onclick="openChoosePage()" value="..." />
            </td>
            <td class="Label2">
                号码类型
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlNumberType" runat="server" ClientIDMode="Static" isrequired="1">
                    
                </asp:DropDownList>  
            </td>  
                   
        </tr>
        <tr>
            <td class="Label2">
                状态
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlStatus" runat="server" ClientIDMode="Static" isrequired="1">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="已使用">已使用</asp:ListItem>
                    <asp:ListItem Value="未使用">未使用</asp:ListItem>
                </asp:DropDownList>  
            </td> 
            <td class="Label2">
                条码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSerialNumber" runat="server" CssClass="TextBox"  ClientIDMode="Static"></asp:TextBox>
            </td> 
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="NumberID" HeaderText="序号" HeaderStyle-Width="40px" />
            <asp:BoundField DataField="NumberType" HeaderText="号码类型" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="OrderNo" HeaderText="工单号" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="SerialNumber" HeaderText="条码" HeaderStyle-Width="180px" />
            <asp:BoundField DataField="Status" HeaderText="状态" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateBy" HeaderText="建立人" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="建立时间" HeaderStyle-Width="120px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ProdUnit.BLL.BarCodeScope"
        SelectMethod="GetSerialNumberAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        function openChoosePage(flags) {
            var condition = "";
            dialog({ title: "选择窗口", src: "../Framework/ChoosePage.aspx?PageId=44&Multiple=false&SearchCondition=" + condition + "&rnd=" + Math.random(), width: 680, height: 300 });
        }
        function getChooseValue(list) {
            $("#txtOrderNo").val(list[0][1]);
        }
    </script>
</asp:Content>