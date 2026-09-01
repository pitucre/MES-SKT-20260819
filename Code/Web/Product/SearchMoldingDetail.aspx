<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="SearchMoldingDetail.aspx.cs" Inherits="SKT.LeanMES.Web.Product.SearchMoldingDetail" %>

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
                加工前物料编码
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtItem2" runat="server" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnSelectItem2" onclick="openChoosePage(2);" class="ButtonBox"
                    value="..." />
            </td>
            <td class="Label3">
                加工后物料编码
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtItem3" runat="server" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnSelectItem3" onclick="openChoosePage(3);" class="ButtonBox"
                    value="..." />
            </td>
        </tr>
        <tr>
            <td class="Label3">
                生产工单
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtWorkOrder" runat="server" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnWO" onclick="openChoosePage(44);" class="ButtonBox"
                    value="..." />
            </td>
            <td class="Label3">
                工位
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnStation" onclick="openChoosePage(8);" class="ButtonBox"
                    value="..." />
            </td>
            <td class="Label3">
                操作员
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                加工日期从
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtBeginTime" runat="server"  CssClass="DateTimeBox" options="{showHms:'false'}"></asp:TextBox>
            </td>
            <td class="Label3">
                至
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtEndTime" runat="server" CssClass="DateTimeBox" options="{showHms:'false'}"></asp:TextBox>
            </td>
            <td class="Label3"></td>
            <td class="Field3"></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="false" ClientIDMode="Static">
        <Columns>
            <asp:BoundField DataField="ProcessNo" HeaderText="序号"
                SortExpression="ProcessNo" />
            <asp:BoundField DataField="OrderNO" HeaderText="<%$ Resources:lang,ShopOrder %>"
                SortExpression="OrderNO" />
            <asp:BoundField DataField="ProdItemCode" HeaderText="产品编码"
                SortExpression="ProdItemCode" />
            <asp:BoundField DataField="UseGRN" HeaderText="Grn"
                SortExpression="UseGRN" />
             <asp:BoundField DataField="CreateTime" HeaderText="加工日期"
                SortExpression="CreateTime" />
            <asp:BoundField DataField="Group" HeaderText="班组" />
            <asp:BoundField DataField="Station" HeaderText="工位"
                SortExpression="Station" />
                <asp:BoundField DataField="TargetItemCode" HeaderText="物料编码"
                SortExpression="TargetItemCode" />
            <asp:BoundField DataField="LotCode" HeaderText="批次号"
                SortExpression="LotCode" />
            <asp:BoundField DataField="SourceItemCode" HeaderText="加工前物料编码"
                SortExpression="SourceItemCode" />
          <%--  <asp:BoundField DataField="UseQty" HeaderText="合格数量"
                SortExpression="UseQty" />--%>
              <asp:TemplateField HeaderText="合格数量"  SortExpression="UseQty">
                <ItemTemplate>
                    <%#Eval("UseQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="EquipmentNo" HeaderText="设备编码"
                SortExpression="EquipmentNo" />
            <asp:BoundField DataField="Weight" HeaderText="重量"
                SortExpression="Weight"    />
            <asp:BoundField DataField="Location" HeaderText="库位"
                SortExpression="Location" />
            <asp:BoundField DataField="Remark" HeaderText="描述"
                SortExpression="Remark"    />
            <asp:BoundField DataField="CName" HeaderText="操作员"
                SortExpression="CName" />
             <asp:BoundField DataField="MoldingType" HeaderText="类型"
                SortExpression="MoldingType" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Molding.BLL.MaterialMolding"
        SelectMethod="GetMoldingDetail" SelectCountMethod="GetCount">
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
            if (flag == 2 || flag == 3) {
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
            else if (flags == 3) {
                $("#<%= this.txtItem3.ClientID %>").val(list[0][2]);
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
