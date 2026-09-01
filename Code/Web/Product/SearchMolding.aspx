<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="SearchMolding.aspx.cs" Inherits="SKT.LeanMES.Web.Product.SearchMolding" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                产品编码
            </td>
            <td class="Field2">
                 <asp:TextBox ID="txtItem" runat="server" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnSelectItem" onclick="openChoosePage(1);" class="ButtonBox"
                    value="..." />
            </td>
            <td class="Label2">
                加工后编码
            </td>
            <td class="Field2">
                 <asp:TextBox ID="txtItem2" runat="server" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnSelectItem2" onclick="openChoosePage(2);" class="ButtonBox"
                    value="..." />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                生产工单
            </td>
            <td class="Field2">
                 <asp:TextBox ID="txtWorkOrder" runat="server" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnWO" onclick="openChoosePage(44);" class="ButtonBox"
                    value="..." />
            </td>
            <td class="Label2">
                工位
            </td>
            <td class="Field2">
                 <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnStation" onclick="openChoosePage(8);" class="ButtonBox"
                    value="..." />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                加工日期从
            </td>
            <td class="Field2">
                 <asp:TextBox ID="txtBeginTime" runat="server"  CssClass="DateTimeBox" options="{showHms:'false'}"></asp:TextBox>
            </td>
            <td class="Label2">
                至
            </td>
            <td class="Field2">
                 <asp:TextBox ID="txtEndTime" runat="server" CssClass="DateTimeBox" options="{showHms:'false'}"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="false" ClientIDMode="Static">
        <Columns>
            <asp:BoundField DataField="RowIndex" HeaderText="序号"
                SortExpression="RowIndex" />
            <asp:BoundField DataField="OrderNO" HeaderText="<%$ Resources:lang,ShopOrder %>"
                SortExpression="OrderNO" />
            <asp:BoundField DataField="SourceItemCode" HeaderText="产品编码"
                SortExpression="SourceItemCode" />
            <asp:BoundField DataField="Station" HeaderText="工位"
                SortExpression="Station" />
                <asp:BoundField DataField="TargetItemCode" HeaderText="加工后物料编码"
                SortExpression="TargetItemCode" />
            <asp:BoundField DataField="TargetItemSpec" HeaderText="物料规格"
                SortExpression="TargetItemSpec" />
            <asp:BoundField DataField="TargetItemName" HeaderText="物料名称"
                SortExpression="TargetItemName" />
            <asp:BoundField DataField="Qty_to_Build" HeaderText="工单数量"
                SortExpression="Qty_to_Build" />
         <%--   <asp:BoundField DataField="MustWorkQty" HeaderText="应加工数量"
                SortExpression="MustWorkQty" />--%>
             <asp:TemplateField HeaderText="应加工数量"  SortExpression="MustWorkQty">
                <ItemTemplate>
                    <%#Eval("MustWorkQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
     <%--       <asp:BoundField DataField="AlreadyQty" HeaderText="已生产数量"
                SortExpression="AlreadyQty"    />--%>
              <asp:TemplateField HeaderText="已生产数量"  SortExpression="AlreadyQty">
                <ItemTemplate>
                    <%#Eval("AlreadyQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
        <%--    <asp:BoundField DataField="NeedWorkQty" HeaderText="未加工数量"
                SortExpression="NeedWorkQty" />--%>
            <asp:TemplateField HeaderText="未加工数量"  SortExpression="NeedWorkQty">
                <ItemTemplate>
                    <%#Eval("NeedWorkQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Molding.BLL.MaterialMolding"
        SelectMethod="GetWOMolding" SelectCountMethod="GetCount">
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
            if (flag == 2) {
                flag = 1;
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flag + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function getChooseValue(list) {
            if (flags == 1) {
                $("#<%= this.txtItem.ClientID %>").val(list[0][2]);
            }
            else if (flags == 2) {
                $("#<%= this.txtItem2.ClientID %>").val(list[0][2]);
            }
            else if (flags == 8) {
                $("#<%= this.txtStation.ClientID %>").val(list[0][1]);
            }
            else if (flags == 44) {
                $("#<%= this.txtWorkOrder.ClientID %>").val(list[0][1]);
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
