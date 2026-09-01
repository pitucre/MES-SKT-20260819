<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="SteelItemList.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelItemList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ItemName%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="btnItemName" class="ButtonBox" value="..." title="选择产品"
                    onclick="selectItemName();" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" />
            </td>
            <td class="Label2">
                <%= Resources.lang.SteelMeshName%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSteelName" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="btnSteelName" class="ButtonBox" value="..." title="选择钢网"
                    onclick="selectSteelName();" />
                <asp:HiddenField ID="hdfSteelId" runat="server" Value="-1" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="SteelName" HeaderText="<%$ Resources:lang, SteelMeshName %>" />
            <asp:BoundField DataField="SteelCode" HeaderText="<%$ Resources:lang, SteelMeshCode %>" />
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemName %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SteelItem.BLL.SteelItem"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        var temp = 0;
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelMeshEdit.aspx?name=SteelItemAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.SteelItemAdd %>", src: openWinUrl, width: 600, height: 330 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelItemEdit.aspx?name=SteelItemEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SteelItemEdit %>", src: openWinUrl, width: 600, height: 330 });
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelItemEdit.aspx?name=SteelItemView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.SteelItemView %>", src: openWinUrl, width: 600, height: 330 });
        }
        function Refresh() {
            document.forms[0].submit();
        }
        function UpdateList(namestr) {
            $("#<%=this.txtItemName.ClientID %>").val(namestr);
            document.forms[0].submit();
        }
        function selectItemName() {
            temp = 0;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
        }
        function selectSteelName() {
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=48&Multiple=false&rnd=" + Math.random(), width: 500, height: 380 });
        }
        function getChooseValue(list) {
            if (temp == 0) {
                $("#<%=this.txtItemName.ClientID %>").val(list[0][1] + "|" + list[0][2]);
                $("#<%=this.hdnItemId.ClientID %>").val(list[0][2]);
            }
            else if (temp == 1) {
                $("#<%=this.txtSteelName.ClientID %>").val(list[0][1] + "|" + list[0][2]);
                $("#<%=this.hdfSteelId.ClientID %>").val(list[0][2]);
            }
            else { }
        } 
    </script>
</asp:Content>
