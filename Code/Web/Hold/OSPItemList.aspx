<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="OSPItemList.aspx.cs" Inherits="SKT.LeanMES.Web.Hold.OSPItemList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">产品编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server"></asp:TextBox>
            </td>
            <td class="Label2">产品名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemName" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" ItemStyle-Width="150px" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" ItemStyle-Width="200px" />
            <asp:BoundField DataField="ItemSpec" HeaderText="产品规格" ItemStyle-Width="200px" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" ItemStyle-Width="100px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" ItemStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.OSP"
        SelectMethod="GetOSPItem" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" runat="server" clientidmode="Static"/>
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");


         function Add() {
             openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Hold/OSPItemEdit.aspx?name=OSPItemAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.OSPItemAdd%>", src: openWinUrl, width: 880, height: 550 });
         }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Hold/OSPItemEdit.aspx?name=OSPItemEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.OSPItemEdit%>", src: openWinUrl, width: 880, height: 550 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();           
        }
    </script>
</asp:Content>
