<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="CustomerOrderList.aspx.cs" Inherits="SKT.LeanMES.Web.Customer.CustomerOrderList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3"><%=Resources.lang.OrderNumber %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtCustomerOrder" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">产品编码
            </td>
            <td class="Field3">
                <input type="hidden" value="-1" id="hdnItemId" />
                <input type="text" id="txtItemCode" class="TextBox" value="" runat="server" clientidmode="Static" /><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." onclick="selectItem()" />
            </td>
            <td class="Label3">客户名称
            </td>
            <td class="Field3" width="165px">
                <asp:TextBox ID="txtCustomer" runat="server" CssClass="TextBox" Text="" ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectCustomer" class="ButtonBox" value="..." title="选择客户"
                    onclick="selectCustomer();" />
                <asp:HiddenField ID="hdnCustomerId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label3">状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlOpenDataStatus" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="">All</asp:ListItem>
                    <asp:ListItem Value="9" Text="<%$ Resources:lang, NotClosed %>"></asp:ListItem>
                    <asp:ListItem Value="10" Text="<%$ Resources:lang, BeenClosed %>"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">来源
            </td>
            <td class="Field3" colspan="3">
                <asp:DropDownList ID="ddlIsMesAdd" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="">All</asp:ListItem>
                    <asp:ListItem Value="1">MES</asp:ListItem>
                    <asp:ListItem Value="0">ERP</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Style="table-layout: fixed; word-wrap: break-word; word-break: break-all" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="CustomerOrder" HeaderText="订单号" HeaderStyle-Width="160px" />
            <asp:BoundField DataField="OrderDateTime" HeaderText="单据日期" DataFormatString="{0:yyyy-MM-dd}" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="CustomerCode" HeaderText="客户编码" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="CustomerName" HeaderText="客户名称" HeaderStyle-Width="180px" />
            <asp:TemplateField HeaderText="来源" HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("IsMesAdd").ToString()=="0"?"ERP":"MES" %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="OpenDataStatusName" HeaderText="状态" HeaderStyle-Width="100px" />
            <%-- <asp:BoundField DataField="CustomerOrder_LOT" HeaderText="订单行号" />--%>
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" />
            <%--            <asp:BoundField DataField="ItemSpec" HeaderText="产品规格"/>--%>
            <%--            <asp:BoundField DataField="Qty" HeaderText="数量"/>--%>
            <asp:BoundField DataField="OrderRem" HeaderText="备注" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="150px" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Customer.BLL.Project"
        SelectMethod="GetCustomerOrderAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Customer/CustomerOrderEdit.aspx?name=CustomerOrderAdd&ID=-1";
            dialog({ title:"<%=Resources.lang.AddOrder%>", src: openWinUrl, width: 1000, height: 500 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Customer/CustomerOrderEdit.aspx?name=CustomerOrderEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.lang.EditOrder%>", src: openWinUrl, width: 1000, height: 500 });
        }
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Customer/CustomerOrderEdit.aspx?name=CustomerOrderEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.lang.EditOrder%>", src: openWinUrl, width: 1000, height: 500 });
        }
        //删除订单信息
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function selectCustomer() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&CallBackFunc=setCustomer&Multiple=false&rnd=" + Math.random(), width: 680, height: 350
            });
        }

        function setCustomer(list) {
           
            $("#<%=this.txtCustomer.ClientID %>").val(list[0][3]);
            $("#<%=this.hdnCustomerId.ClientID %>").val(list[0][0]);
        }

        //选择产品
        function selectItem() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }

        function getChooseValue(list) {
            $("#txtItemCode").val(list[0][2]);
            $("#hdnItemId").val(list[0][0]);
        }
    </script>
</asp:Content>
