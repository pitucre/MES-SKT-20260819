<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="ESOPFastView.aspx.cs" Inherits="SKT.LeanMES.Web.ESOP.ESOPFastView" Title="Parts List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <script src="../Content/js/jquery.media.js" type="text/javascript"></script>
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">产品编码/名称</td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">ESOP工序</td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtESOPStationName" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">ESOP名称</td>
            <td class="Field3">
                <asp:TextBox ID="txtESOPName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ESOPName" HeaderText="ESOP名称" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" />
            <asp:BoundField DataField="StationName" HeaderText="ESOP工序" />
            <%--<asp:BoundField DataField="ESOPFileName" HeaderText="文件名称" />--%>
            <asp:TemplateField HeaderText="文件名称" ItemStyle-Wrap="false" HeaderStyle-Width="120">
                <ItemTemplate>
                    <a href='javascript:void(0)' class="down-load" onclick="showPic(this)"><%#Eval("ESOPFileName")%></a>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.ESOP.BLL.ESOPFile" SelectMethod="GetAllFastViewList" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        //预览图片
        function showPic(obj) {
            var fileName = $(obj).text();
            var picUrl = GetFilePath("", fileName.replaceAll(/%20/g, '_').replaceAll(' ', '_'));
            var n = 0;
            if (picUrl.indexOf('.') > 0) {
                var n = picUrl.lastIndexOf(".");
            }
            var imgArr = ['png', 'jpg', 'jpeg', 'bmp', 'gif'];
            var ext = picUrl.substring(n + 1);
            if (imgArr.indexOf(ext.toLowerCase()) !== -1) {
                window.open(picUrl);

            } else {
                window.open(picUrl);
            }
        }

        //导出Excel
        function saveExcel() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
            hdnIdString.val("");
        }
    </script>
</asp:Content>

