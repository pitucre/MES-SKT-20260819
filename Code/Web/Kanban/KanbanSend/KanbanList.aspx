<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master" CodeBehind="KanbanList.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.KanbanManage.KanbanList" ValidateRequest="false" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">看板名称</td>
            <td class="Field1">
                <asp:TextBox ID="txtKanbName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="KanbanName" HeaderText="看板名称" />
            <asp:BoundField DataField="LinkUrl" HeaderText="网址" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="UpdateBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="UpdateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Kanban.BLL.Tag" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/KanbanSend/KanbanEdit.aspx?name=Kanban_TagSendAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Kanban_TagSendAdd %>", src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/KanbanSend/KanbanEdit.aspx?name=Kanban_TagSendEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Kanban_TagSendEdit %>", src: openWinUrl, width: 600, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>'
            if (idStr == "") return false;
            var tagEntity = SKT.LeanMES.Web.AjaxServices.AjaxKanbanManage.Delete(idStr, userName);
            if (tagEntity.error != null) {
                alert(tagEntity.error.Message);
                return false;
            } else {
                alert("删除成功!");
            }
            document.forms[0].submit();
        }

        function View() {
            var idStr = getOneRecordId();
            var url = "";
            //通过id找到url
            var tagEntity = SKT.LeanMES.Web.AjaxServices.AjaxKanbanManage.GetInfo(idStr);
            if (tagEntity.error != null) {
                return false;
            }
            else {
                var entity = tagEntity.value;
                url = entity.LinkUrl;
            }
            window.open(url);
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>


