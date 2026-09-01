<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master" CodeBehind="MenuButtonList.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.MenuButtonList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="SearchContent" runat="Server" ViewStateMode="Enabled">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">系统
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlsystem" AutoPostBack="true" OnSelectedIndexChanged="ddlsystem_SelectedIndexChanged"></asp:DropDownList>
            </td>
            <td class="Label2">模块
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlmodule" AutoPostBack="true" OnSelectedIndexChanged="ddlmodule_SelectedIndexChanged"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">地址
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtUrl" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
            </td>
            <td class="Field2">
               
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1"
        OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="module" HeaderText="模块" />
            <asp:BoundField DataField="name" HeaderText="菜单" />
            <asp:BoundField DataField="popedom" HeaderText="权限编号" />
            <asp:BoundField DataField="url" HeaderText="菜单地址" />
            <asp:BoundField DataField="flag" HeaderText=""  Visible="false"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.CustomMenu.BLL.MenuBottonConfig"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript">

        function Edit() {
            var idStr = getOneRecordId();
            if (!idStr)
                return false;
            if ($(".ListTable  input[type='checkbox']:checked").parent().next().text() == "是") {
                alert("主键不能编辑！");
                return false;
            }
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/MenuButtonEdit.aspx?name=MenuButtonEdit&popedom=" + $(".ListTable tr").eq(selectedRowIndex).find("td").eq(3).text() + "&module=" + $("#<%=ddlmodule.ClientID%>").val() + "&page=" + idStr;
            dialog({ title: "编辑菜单按钮", src: openWinUrl, width: 800, height: 400 });
        }

        function View() {
            Edit();
        }
        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

