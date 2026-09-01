<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="LabelItemDocumentList.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.LabelItemDocumentList" ValidateRequest="false" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server" ViewStateMode="Enabled">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%= Resources.lang.Item %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItem" runat="server" CssClass="TextBox"></asp:TextBox><input type="button" id="btnSelectItem" onclick="openChoosePage(1);" class="ButtonBox" value="..." />
            </td>
            <td class="Label3">
                <%= Resources.lang.Station %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox"></asp:TextBox><input type="button" onclick="openChoosePage(8);" class="ButtonBox" value="..." />
            </td>
            <td class="Label3">
                <%= Resources.lang.RuleType %>
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlType" runat="server">
                </asp:DropDownList>
            </td>
        </tr>

    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, Item %>" />
            <asp:BoundField DataField="DocumentName" HeaderText="<%$ Resources:lang, Document %>" />
            <asp:BoundField DataField="TypeName" HeaderText="<%$ Resources:lang, RuleType %>" />
            <asp:BoundField DataField="Station" HeaderText="<%$ Resources:lang, Station %>" />
            <asp:BoundField DataField="Sequence" HeaderText="<%$ Resources:lang, Sequence %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Labels.BLL.LabelItemDocuments"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelItemDocumentEdit.aspx?name=Labels_ItemDocumentAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Labels_ItemDocumentAdd %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelItemDocumentEdit.aspx?name=Labels_ItemDocumentEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Labels_ItemDocumentEdit %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

//        function View() {
//            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelItemDocumentView.aspx?name=Labels_ItemDocumentView&ID=-1";
//            dialog({ title: "<%=Resources.Pages.Labels_ItemDocumentView %>", src: openWinUrl, width: 650, height: 300 });
//        }

        function Refresh() {
            document.forms[0].submit();
        }


        function openChoosePage(flags) {
            flag = flags;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&rnd=" + Math.random(), width: 750, height: 400 });
        }

        function getChooseValue(list) {
            if (flag == 1) {
                $("#<%= this.txtItem.ClientID %>").val(list[0][2]);
            }
            else if (flag == 8) {
                $("#<%= this.txtStation.ClientID %>").val(list[0][1]);
            }
            flag = -1;
        }
    </script>
</asp:Content>
