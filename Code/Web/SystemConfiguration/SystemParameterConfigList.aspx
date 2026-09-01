<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemParameterConfigList.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.SystemParameterConfigList" MasterPageFile="~/Masters/ListMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">表名
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTableName" runat="server" CssClass="TextBox" Width="150" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="TabaleName" HeaderText="表名" />            
            <asp:BoundField DataField="Modifier" HeaderText="<%$ Resources:lang,ModifyBy %>" />
            <asp:TemplateField HeaderText="<%$ Resources:lang,ModifyDateTime %>">
                <ItemTemplate>
                    <%#Eval("ModifyDate", "{0:yyyy-MM-dd HH:mm:ss}").ToString().Replace("0001-01-01 00:00:00", "")%>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Lookup.BLL.LookupDef"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript">
        isMultiple = false;

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }
            var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/SystemParameterConfigEdit.aspx?name=SystemParameterConfigEdit&TableName=" + idStr;
            dialog({ title: "<%=Resources.Pages.SystemParameterConfigEdit %>", src: url, width: 800, height: 500 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }
            var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/SystemParameterConfigView.aspx?name=SystemParameterConfigView&TableName=" + idStr;
            dialog({ title: "<%=Resources.Pages.SystemParameterConfigView %>", src: url, width: 800, height: 500 });
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
