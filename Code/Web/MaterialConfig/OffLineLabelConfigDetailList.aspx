<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="OffLineLabelConfigDetailList.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialConfig.OffLineLabelConfigDetailList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" >
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="DetailContent" HeaderText="内容" SortExpression ="DetailContent" />
            <asp:BoundField DataField="Paragraph" HeaderText="段" SortExpression ="Paragraph" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy%>"
                SortExpression="CreateBy"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime%>"
                SortExpression="CreateDateTime" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy%>"
                SortExpression="ModifyBy"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$ Resources:lang,ModifyDateTime%>"
                SortExpression="ModifyTime" HeaderStyle-Width="140px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MaterialConfig.BLL.MaterialSupplierConfig"
        SelectMethod="GetOffLineLabelConfigDetailList" SelectCountMethod="GetCount">
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
        var LabelID = '<%=Request.QueryString["ID"]%>';

        $(function () {
            $("#searchField_content").remove();
        })
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialConfig/OffLineLabelConfigDetailEdit.aspx?name=OffLineLabelConfigDetailAdd&ID=-1&LabelID=" + LabelID;
            dialog({ title: "<%=Resources.Pages.OffLineLabelConfigAdd %>", src: openWinUrl, width: 500, height: 300 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialConfig/OffLineLabelConfigDetailEdit.aspx?name=OffLineLabelConfigDetailEdit&ID=" + idStr + "&LabelID=" + LabelID;
            dialog({ title: "<%=Resources.Pages.OffLineLabelConfigEdit %>", src: openWinUrl, width: 500, height: 300 });
        }
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

        function UpdateList() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>