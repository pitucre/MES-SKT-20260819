<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="PopedomInStationList.aspx.cs" Inherits="SKT.LeanMES.Web.ClientConfig.PopedomInStationList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server"  ViewStateMode="Enabled">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3"><%= Resources.lang.StationType %></td>
            <td class="Field3">
                <asp:TextBox ID="txtStationTypeName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3"><%= Resources.lang.Station %></td>
            <td class="Field3">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3"><%= Resources.lang.TemplateName %></td>
            <td class="Field3">
                <asp:TextBox ID="txtTemplateName" runat="server" CssClass="TextBox"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectTemp"
                        class="ButtonBox" value="..." title="Select" onclick="selectNewTemplate();" />
                <asp:HiddenField ID="hdnNewTemplate" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="StationTypeName" HeaderText="<%$ Resources:lang, StationType %>" />
            <asp:BoundField DataField="StationName" HeaderText="<%$ Resources:lang, Station %>" />
            <asp:BoundField DataField="PopedomName" HeaderText="<%$ Resources:lang, TemplateName %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.ClientConfig.BLL.PopedomInStation" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ClientConfig/PopedomInStationEdit.aspx?name=Client_PopedomStationAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Client_PopedomStationAdd %>", src: openWinUrl, width: 750, height: 400 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ClientConfig/PopedomInStationView.aspx?name=Client_PopedomStationView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Client_PopedomStationEdit %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ClientConfig/PopedomInStationEdit.aspx?name=Client_PopedomStationEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Client_PopedomStationEdit %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ClientConfig/PopedomInStationEdit.aspx?name=Client_PopedomStationCopy&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Client_PopedomStationCopy %>", src: openWinUrl, width: 600, height: 400 });
        }

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

         function selectNewTemplate() {
            flag = 12;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=121&CallBackFunc=setTemplate&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function setTemplate(list) {
            $("#hdnNewTemplate").val(list[0][1]);
            $("#txtTemplateName").val(list[0][2]);
        }
    </script>
</asp:Content>