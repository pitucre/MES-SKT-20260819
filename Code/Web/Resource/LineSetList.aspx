<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="LineSetList.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.LineSetList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">日期
            </td>
            <td class="Field3">              
                <asp:TextBox ID="txtLineSetDate" runat="server" CssClass="DateTimeBox"></asp:TextBox>
            </td>
            <td class="Label3">线别
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">班制
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtShiftName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server"><asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:TemplateField HeaderText="日期" >
                <ItemTemplate>
                    <%# Convert.ToDateTime(Eval("LineSetDate").ToString()).ToString("yyyy-MM-dd") %>
                </ItemTemplate>
            </asp:TemplateField>             
            <asp:BoundField DataField="LineName" HeaderText="<%$Resources:lang,Line %>" HeaderStyle-Width="200px"   />
            <asp:BoundField DataField="ShiftName" HeaderText="班制" />
            <asp:BoundField DataField="CName" HeaderText="负责人" />
            <asp:BoundField DataField="StandardHuman" HeaderText="标准人数" />
            <asp:BoundField DataField="ActualHuman" HeaderText="实到人数" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Resource.BLL.LineSet"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
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
        /*新增*/
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/LineSetEdit.aspx?name=Resource_LineSetAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Resource_LineSetAdd %>", src: openWinUrl, width: 750, height: 400 });
        }

        /*编辑*/
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/LineSetEdit.aspx?name=Resource_LineSetEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Resource_LineSetEdit %>", src: openWinUrl, width: 750, height: 400 });
        }

        /*删除*/
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
    </script>
</asp:Content>