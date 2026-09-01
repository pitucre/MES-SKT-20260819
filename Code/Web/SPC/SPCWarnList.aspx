<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="SPCWarnList.aspx.cs" Inherits="SKT.LeanMES.Web.SPC.SPCWarnList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                任务名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtTaskName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                报警时间
            </td>
            <td class="Field2">
                <asp:TextBox CssClass="DateTimeBox" ID="txtWarnBegin" runat="server" ></asp:TextBox> 至 <asp:TextBox CssClass="DateTimeBox" ID="txtWarnEnd" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="TaskName" HeaderText="任务名称" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="SPCWarnMsg" HeaderText="报警内容" HeaderStyle-Width="250px" />
            <asp:BoundField DataField="WarnTime" HeaderText="报警时间" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="Reson" HeaderText="原因分析" />
            <asp:BoundField DataField="DealDesc" HeaderText="处理内容" />
            <asp:BoundField DataField="DealBy" HeaderText="处理人" HeaderStyle-Width="60px" />
            <asp:TemplateField HeaderText="处理时间" HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("DealTime", "{0:yyyy-MM-dd HH:mm:ss}").ToString().Replace("9999-12-31 00:00:00", "")%>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SPC.BLL.SPCWarn"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
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

        /*
        function Add() {
        openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SPC/SPCWarnEdit.aspx?name=SPC_WarnAdd&ID=-1";
        dialog({ title: "", src: openWinUrl, width: 650, height: 400 });
        }*/

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SPC/SPCWarnEdit.aspx?name=SPC_WarnEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SPC_WarnEdit %>", src: openWinUrl, width: 600, height: 400 });
        }

        /*function Delete() {
        var idStr = getDeletingRecordIdString();
        if (idStr == "") return false;
        hdnOperate.val("delete");
        hdnIdString.val(idStr);
        document.forms[0].submit();
        }*/

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
