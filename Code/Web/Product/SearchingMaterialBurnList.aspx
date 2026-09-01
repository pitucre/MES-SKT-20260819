<%@ Page Language="C#"  MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="SearchingMaterialBurnList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.SearchingMaterialBurnList" %>


<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                产品编码
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtItem" runat="server" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnSelectItem" onclick="openChoosePage(1);" class="ButtonBox"
                    value="..." />
            </td>
            <td class="Label3">
                物料编码
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtMItem" runat="server" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnSelectMItem" onclick="openChoosePage(816);" class="ButtonBox"
                    value="..." />
            </td>
            <td class="Label3">
                软件名称
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtSoftName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="false" ClientIDMode="Static">
        <Columns>
            <asp:BoundField DataField="SoftName" HeaderText="软件名称" />
            <asp:BoundField DataField="TestMachine" HeaderText="测试仪器" />
            <asp:BoundField DataField="Customer" HeaderText="适用客户" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" />
            <asp:BoundField DataField="MItemCode" HeaderText="物料编码" />
            <asp:BoundField DataField="MItemName" HeaderText="物料名称" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Molding.BLL.MaterialBurn"
        SelectMethod="GetMaterialBurnInfoDetail" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = true;
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        var flags = 0;
        function openChoosePage(flag) {
            flags = flag;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flag + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function getChooseValue(list) {
            if (flags == 1) {
                $("#<%= this.txtItem.ClientID %>").val(list[0][2]);
            }if (flags == 816) {
                $("#<%= this.txtMItem.ClientID %>").val(list[0][2]);
            }
            flags = 0;
        }

        function ImportToExcel() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
    </script>
</asp:Content>

