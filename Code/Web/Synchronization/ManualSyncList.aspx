<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="ManualSyncList.aspx.cs" Inherits="SKT.LeanMES.Web.Synchronization.ManualSyncList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server" ViewStateMode="Enabled">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                类型
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlSyncType" runat="server" >
                   
                </asp:DropDownList>  
            </td>
            <td class="Label2">
                内容
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSyncContent" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="SyncType" HeaderText="类型" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="SyncContent" HeaderText="内容" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateBy" HeaderText="建立人" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="建立时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="DisposeDateTime" HeaderText="处理时间" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="DisposeState" HeaderText="是否处理" HeaderStyle-Width="120px" />
             <asp:BoundField DataField="ModifyBy" HeaderText="修改人"
                SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间"
                SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Synchronization.BLL.Synchronization"
        SelectMethod="GetManualSyncAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script type="text/javascript">
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Synchronization/ManualSyncEdit.aspx?name=ManualSyncEdit&ID=-1";
            dialog({ title: "新增手动同步", src: openWinUrl, width: 750, height: 400 });
        }
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Synchronization/ManualSyncEdit.aspx?name=ManualSyncEdit&ID=" + idStr;
            dialog({ title: "编辑手动同步", src: openWinUrl, width: 750, height: 400 });
        }
        function Refresh() {
            document.forms[0].submit();
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
