<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="DeletedPckList.aspx.cs" Inherits="SKT.LeanMES.Web.Material.DeletedPckList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.PickingListNO%>
            </td>
            <td class="Field1">
                <input type="text" id="txtPckpd" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="PkdPK" HeaderText="<%$Resources:lang,PickingListNO %>" />
            <asp:BoundField DataField="PkdWoNbr" HeaderText="<%$Resources:lang,WONumber %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$Resources:lang,DeleteDatetime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.MaterialUnit"
        SelectMethod="GetDeletePckList" SelectCountMethod="GetDeletePckListCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        function ReUse() {
            var idStr = getRecordIdString();
            if (idStr == "") {
                return false;
            }
            if (confirm("<%=Resources.Messages.ConfirmReUser %>")) {
                $("#hdnIdString").val(idStr);
                $("#hdnOperate").val("ReUse");
                document.forms[0].submit();
            }
        }

        $(document).ready(function () {
            if ('<%=Request.Form["hdnOperate"] %>' == "") {
                $("#hdnOperate").val("search");
                $("#<%=this.txtPckpd.ClientID %>").val("*");
                document.forms[0].submit();
            }
        });
    </script>
</asp:Content>
