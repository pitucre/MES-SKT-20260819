<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReinspectionHistory.aspx.cs"
    MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.Material.ReinspectionHistory" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">重检单号
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtCheckNo"></asp:TextBox>
            </td>
            <td class="Label3">产品编码
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtItemName"></asp:TextBox>
            </td>
            <td class="Label3">检验结果
            </td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="dllStatus">
                    <asp:ListItem Value="-1">全部</asp:ListItem>
                    <asp:ListItem Value="1">合格</asp:ListItem>
                    <asp:ListItem Value="0">不合格</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label3">检验人
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtCheckUserName"></asp:TextBox>
            </td>
            <td class="Label3">供应商名称
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtVendorName"></asp:TextBox>
            </td>
            <td class="Label3"></td>
            <td class="Field3"></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="ReinspectionNo" HeaderText="重检单号" />
            <asp:BoundField DataField="SerialNumber" HeaderText="物料条码" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="Quantity" HeaderText="重检数量" />
            <asp:BoundField DataField="CWhCode" HeaderText="仓库编码" />
            <asp:BoundField DataField="CBarCode" HeaderText="库位条码" />
            <asp:BoundField DataField="CheckResultName" HeaderText="检验结果" />
            <asp:BoundField DataField="UserName" HeaderText="检验人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="重检时间" />
            <asp:BoundField DataField="CheckNumber" HeaderText="重检次数" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderText="修改时间" />
            <asp:BoundField DataField="VendorName" HeaderText="供应商名称" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.Reinspection"
        SelectMethod="GetReinspections" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <%--<input type="hidden" id="hdnOperate" name="hdnOperate" value="" />--%>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <%-- layer不居中，需要引用jquery-3.1.0--%>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script type="text/javascript">
        var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var hdnOperate = $("#hdnOperate");
        $(function () {
            isMultiple = true;
        });

        function View() {
            var idStr = getRecordIdString();
            if (idStr == "") return false;
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/ExpireDateEdit.aspx?type=update&GRN=" + idStr;
            dialog({ title: mesLang("结果变更"), src: openWinUrl, width: 400, height: 250 });
        }
        function refresh() {
            document.forms[0].submit();
        }
        function ImportToExcel() {
            hdnOperate.val("exportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
    </script>
</asp:Content>
