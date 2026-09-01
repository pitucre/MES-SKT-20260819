<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="NCCodeList.aspx.cs" Inherits="SKT.LeanMES.Web.NCCode.NCCodeList"
    Title="NCCode List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%= Resources.lang.NCCode%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                不良代码类型
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtNCCodeGroup" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
             <td class="Label3">
                类别
            </td>
            <td class="Field3">
                <select name="selType" id="selType" runat="server">
                    <option value="">全部</option>
                    <option value="缺陷品">不良原因</option>
                    <option value="失败品">不良现象</option>
                    <option value="返修品">维修方法</option>
                </select>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="NCCode" HeaderText="<%$ Resources:lang,NCCode%>" HeaderStyle-Width="180px"
                SortExpression="NCCode" />
            <asp:BoundField DataField="NCCodeTypeName" HeaderText="不良代码类型" HeaderStyle-Width="120px"
                SortExpression="NCGroupName" />
            <asp:BoundField DataField="Category" HeaderText="<%$ Resources:lang,Category%>" HeaderStyle-Width="80px"
                SortExpression="Category" />
            <asp:BoundField DataField="DataType" HeaderText="<%$ Resources:lang,DataType%>" HeaderStyle-Width="120px"
                SortExpression="DataType" />
            <asp:BoundField DataField="Status" HeaderText="<%$ Resources:lang,Status%>" HeaderStyle-Width="80px"
                SortExpression="Status" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="Description" HeaderText="<%$ Resources:lang,Description%>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.NCCode.BLL.NCCode"
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
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/NCCode/NCCodeEdit.aspx?name=NCCode_NCCodeAdd&ID=-1";
            dialog({ title: "<%= Resources.lang.NCCodeAdd %>", src: openWinUrl, width: 600, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/NCCode/NCCodeEdit.aspx?name=NCCode_NCCodeEdit&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.NCCodeEdit %>", src: openWinUrl, width: 600, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/NCCode/NCCodeView.aspx?name=NCCode_NCCodeView&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.NCCodeView %>", src: openWinUrl, width: 600, height: 400 });
        }

        function UpdateList(NCCode) {
            $("#<%=this.txtCode.ClientID %>").val(NCCode);
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/NCCode/NCCodeEdit.aspx?name=NCCode_NCCodeEdit&ID=" + idStr + "&Action=Copy&rnd=" + Math.random();
            dialog({ title: "<%= Resources.lang.NCCodeEdit %>", src: openWinUrl, width: 600, height: 400 });
        }
        function Import() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/NCCode/NCCodeImport.aspx?name=NCCode_NCCodeImport";
            dialog({ title: "<%= Resources.Pages.NCCode_NCCodeImport %>", src: openWinUrl, width: 850, height: 450 });
        }
    </script>
</asp:Content>
