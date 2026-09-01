<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="OrderSchedulList.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.OrderSchedulList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%=Resources.lang.OrderNumber %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.ItemCode %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.ItemName %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.Status %>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="" Text="所有"> </asp:ListItem>
                    <asp:ListItem Value="待确认" Text="待确认"> </asp:ListItem>
                    <asp:ListItem Value="队列中" Text="队列中"> </asp:ListItem>
                    <asp:ListItem Value="待生产" Text="待生产"> </asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="False" OnRowDataBound="GridView1_RowDataBound" >
        <Columns>
           
            <asp:BoundField DataField="OrderNo" HeaderText="工单号" />
            <asp:BoundField DataField="SchedulNum" HeaderText="排产数" />
            <asp:BoundField DataField="Status" HeaderText="状态" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" />
            <asp:TemplateField HeaderText="是否SMT"  ItemStyle-Width="90px"  >
                <ItemTemplate >
                    <%#Eval("IsSmt").ToString() == "True" ? "是" : "否"%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ProductionFace" HeaderText="生产面别" />
            <asp:BoundField DataField="Priority" HeaderText="优先级" />
            <asp:TemplateField HeaderText="工单计划开始时间"  ItemStyle-Width="130px"  >
                <ItemTemplate >
                    <%#Eval("PlannedStartTime").ToString() == "9999/12/31 0:00:00" ? "" : Eval("PlannedStartTime","{0:yyyy-MM-dd}").ToString()%>
                </ItemTemplate>
            </asp:TemplateField>
          
  
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="True" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Plan.BLL.SchedulOrderDal"
        SelectMethod="GetAllList" SelectCountMethod="GetCount">
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
        function Confirm() {
            var idStr = getRecordIdString();
            if (idStr == "") return false;

            if (!window.confirm("确认添加工单到排产队列吗？")) {
                return false;
            }
            var ajax = SKT.LeanMES.Web.Plan.OrderSchedulList.ConfirmOrderSchedul(idStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
             alert("<%=Resources.Messages.OperationSuccess %>");
            document.forms[0].submit();
        }

        function Cancel() {
            var idStr = getRecordIdString();
            if (idStr == "") return false;

            if (!window.confirm("确认取消工单排产吗？")) {
                return false;
            }

            var ajax = SKT.LeanMES.Web.Plan.OrderSchedulList.CancelOrderSchedul(idStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
             alert("<%=Resources.Messages.OperationSuccess %>");
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }

    </script>
</asp:Content>
