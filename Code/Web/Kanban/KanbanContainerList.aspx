<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="KanbanContainerList.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.KanbanContainerList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
<%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                容器名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtTemplName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
               
            </td>
            <td class="Field2" id="tdSelType">
                <%--<SKTControl:ReportDDL runat="server" ID="ddlReport" ClientIDMode="Static"></SKTControl:ReportDDL>--%>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <asp:BoundField DataField="ContainerName" HeaderText="容器名称" HeaderStyle-Width="180px"
                SortExpression="ContainerName" />
            <asp:BoundField DataField="LayoutType" HeaderText="类型信息" HeaderStyle-Width="180px"/>
            <asp:BoundField DataField="Remark" HeaderText="描述/备注信息" HeaderStyle-Width="180px" />
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人"/>
            <asp:BoundField DataField="ModifyTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd  HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Kanban.BLL.Master"
        SelectMethod="GetAllContainer" SelectCountMethod="GetCount">
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
        var w = $(window).width() - 100;
        var h = $(window).height() - 50;
        $(document).ready(function() {
 
        });
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/KanbanContainerEdit.aspx?name=Kanban_ContainerAdd&ID=-1";
            //dialog({ title: "新增容器", src: openWinUrl, width: w, height: h });
            window.parent.openLeftMenu(this, "新增容器", openWinUrl, 'addContainer');
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") { return false; }

            var wins = $(window.parent);
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/KanbanContainerEdit.aspx?name=Kanban_ContainerEdit&ID=" + idStr;
            //dialog({ title: "编辑容器", src: openWinUrl, width: w, height: h });
            window.parent.openLeftMenu(this, "编辑容器", openWinUrl, 'editContainer');
        }

//        function View() {
//            Edit();
//        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") { return false; }

            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(templName) {
            document.forms[0].submit();
        }
        function AddType() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/ContainerTypeEdit.aspx?name=ContainerTypeAdd&ID=-1";
            window.parent.openLeftMenu(this, "新增看板布局类型", openWinUrl, '-1');

        }
 
    </script>
</asp:Content>





