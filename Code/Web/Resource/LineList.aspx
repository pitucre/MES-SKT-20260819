<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="LineList.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.LineList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">线别
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">线别编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtLineCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">线别设备类型
            </td>
            <td class="Field3">
                <asp:TextBox ID="machineline" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="LineName" HeaderText="<%$Resources:lang,Line %>" HeaderStyle-Width="150px"
                SortExpression="LineName" />
            <asp:BoundField DataField="LineCode" HeaderText="线别编码" HeaderStyle-Width="100px"
                SortExpression="LineCode" />
            <asp:BoundField DataField="LineMachineRelation" HeaderText="<%$Resources:lang,EquipmentLineDisplayName %>" />
            <asp:BoundField DataField="WorkShopName" HeaderText="<%$Resources:lang,WorkShopName %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="LineDescription" HeaderText="<%$Resources:lang,Description %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Resource.BLL.Line"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/LineEdit.aspx?name=Resource_LineAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Resource_LineAdd %>", src: openWinUrl, width: 650, height: 400 });
        }

        /*编辑*/
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/LineEdit.aspx?name=Resource_LineEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Resource_LineEdit %>", src: openWinUrl, width: 700, height: 420 });
        }

        /*删除*/
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        /*查看*/
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/LineView.aspx?name=Resource_LineView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Resource_LineView %>", src: openWinUrl, width: 650, height: 400 });
        }

        /*更新列表*/
        function UpdateList(namestr) {
            $("#<%=this.txtLineName.ClientID %>").val(namestr);
            document.forms[0].submit();
        }

        /*复制*/
        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/LineEdit.aspx?name=Resource_LineEdit&ID=" + idStr + "&Action=Copy&rnd=" + Math.random();
            dialog({ title: "<%=Resources.Buttons.COM_Copy %><%=Resources.lang.Line %>", src: openWinUrl, width: 700, height: 420 });
        }
    </script>
</asp:Content>
