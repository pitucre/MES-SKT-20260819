<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TurnoverGroupList.aspx.cs"
    Inherits="SKT.LeanMES.Web.Turnover.TurnoverGroupList" MasterPageFile="~/Masters/ListMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%=Resources.lang.TurnoverGroupName%>
            </td>
            <td class="Field4">
                <input type="text" id="txtTurnoverGroupName" class="TextBox" runat="server" />
            </td>
             <td class="Label3">
                <%=Resources.lang.ItemCode%>
            </td>
            <td class="Field4">
                <input type="text" id="txtItemCode" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="TurnoverGroupName" HeaderText="<%$ Resources:lang,TurnoverGroupName %>"
                HeaderStyle-Width="120px" SortExpression="TurnoverGroupName" />
            <asp:BoundField DataField="TurnoverTypeName" HeaderText="<%$ Resources:lang,TurnoverTypeName %>"
                HeaderStyle-Width="120px" SortExpression="TurnoverTypeName" />
            <asp:BoundField DataField="MinQty" HeaderText="<%$ Resources:lang,MinStowQty %>"
                HeaderStyle-Width="90px" />
            <asp:BoundField DataField="MaxQty" HeaderText="<%$ Resources:lang,MaxStowQty %>"
                HeaderStyle-Width="90px" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang,ItemsName %>"
                SortExpression="ItemName" />
              <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang,ItemCode %>"
                SortExpression="ItemName" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Turnover.BLL.TurnoverGroup"
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

        //增加 
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Turnover/TurnoverGroupEdit.aspx?name=Turnover_TurnoverGroupAdd&Id=-1";
            dialog({ title: "<%= Resources.Pages.Turnover_TurnoverGroupAdd %>", src: openWinUrl, width: 750, height: 420, resizeable: true });
        }

        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Turnover/TurnoverGroupEdit.aspx?name=Turnover_TurnoverGroupEdit&Id=" + idStr;
            dialog({ title: "<%= Resources.Pages.Turnover_TurnoverGroupEdit %>", src: openWinUrl, width: 750, height: 420, resizeable: true });
        }

        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Turnover/TurnoverGroupView.aspx?name=Turnover_TurnoverGroupView&Id=" + idStr;
            dialog({ title: "<%= Resources.Pages.Turnover_TurnoverGroupView %>", src: openWinUrl, width: 750, height: 420, resizeable: true });
        }

        //刷新 
        function refresh() {
            document.forms[0].submit();
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            $(hdnOperate).val("Delete");
            $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }

        //周转工具条码注册
        function Register() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Turnover/TurnoverRegister.aspx?name=Turnover_TurnoverRegister&Id=" + idStr;
            dialog({ title: "<%= Resources.Pages.Turnover_TurnoverRegister %>", src: openWinUrl, width: 760, height: 500, resizeable: false });
        }


        function UpdateList(txtTurnoverGroupName) {
            $("#<%=this.txtTurnoverGroupName.ClientID %>").val(txtTurnoverGroupName);
            document.forms[0].submit();
        }


        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Turnover/TurnoverGroupEdit.aspx?name=Turnover_TurnoverGroupCopy&Id=" + idStr + "&Action=Copy&rnd=" + Math.random();
            dialog({ title: "<%= Resources.Pages.Turnover_TurnoverGroupCopy %>", src: openWinUrl, width: 750, height: 420, resizeable: true });
        }
    </script>
</asp:Content>
