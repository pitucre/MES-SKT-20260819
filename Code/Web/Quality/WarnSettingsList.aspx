<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="WarnSettingsList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.WarnSettingsList" Title="WarnSettings List Page" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">产品</td>
            <td class="Field1">
                <asp:TextBox ID="txtProduct" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" 
        onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="ItemName" HeaderText="产品" />
            <asp:BoundField DataField="LineName" HeaderText="线别" />
            <asp:BoundField DataField="StationName" HeaderText="操作工位" />
            <asp:BoundField DataField="WarnType" HeaderText="预警类型" />
            <asp:BoundField DataField="WarnLevel" HeaderText="预警级别" />
            <asp:BoundField DataField="Yield" HeaderText="良品率(%)" />
            <asp:BoundField DataField="ReciveUsers" HeaderText="通知接收人" />
            <asp:BoundField DataField="Contents" HeaderText="备注" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Quality.BLL.WarnSettings" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/WarnSettingsEdit.aspx?name=WarnSettings_YieldAdd&ID=-1";
            dialog({ title: "新增产品率预警", src: openWinUrl, width: 500, height: 350});
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/WarnSettingsEdit.aspx?name=WarnSettings_YieldEdit&ID=" + idStr;
            dialog({ title: "编辑产品率预警", src: openWinUrl, width: 500, height: 350 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/WarnSettingsView.aspx?name=WarnSettings_YieldView&ID=" + idStr;
            dialog({ title: "查看产品率预警", src: openWinUrl, width: 500, height: 350 });
        }

        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList() {
            document.forms[0].submit();
        }  
    </script>
</asp:Content>

