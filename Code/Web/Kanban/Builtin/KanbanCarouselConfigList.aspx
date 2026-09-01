<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="KanbanCarouselConfigList.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.KanbanCarouselConfigList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">轮播看板名</td>
            <td class="Field1">
                <asp:TextBox ID="txtCarouselName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="CarouselName" HeaderText="轮播看板名" />
            <asp:BoundField DataField="CarouselTime" HeaderText="轮播时间（秒）" />
            <asp:BoundField DataField="Remark" HeaderText="描述" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Kanban.BLL.KanBanCarouselConfig" SelectMethod="GetAll" SelectCountMethod="GetCount">
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

        //打开看板
        function Open() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/Builtin/KanbanCarouselConfigOpen.aspx?carouselConfigId=" + idStr;
            window.open(openWinUrl);
        }

        //新增
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/Builtin/KanbanCarouselConfigEdit.aspx?name=KanbanCarouselConfigAdd&carouselConfigId=-1";
            dialog({ title: "新增看板轮播配置", src: openWinUrl, width: 800, height: 400 });
        }

        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/Builtin/KanbanCarouselConfigEdit.aspx?name=KanbanCarouselConfigEdit&carouselConfigId=" + idStr;
            dialog({ title: "编辑看板轮播配置", src: openWinUrl, width: 800, height: 400 });
        }

        //查看
        function View() {
           var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/Builtin/KanbanCarouselConfigView.aspx?name=KanbanCarouselConfigView&carouselConfigId=" + idStr;
            dialog({ title: "查看看板轮播配置", src: openWinUrl, width: 800, height: 400 });
        }

        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;

            var entity =
            {
                CarouselConfigIds: idStr
            };

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.KanBanCarouselConfigDelete(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("删除成功!");

            doRefresh();
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
