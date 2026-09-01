<%@ Page Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true" CodeBehind="MaterialBurnView.aspx.cs" Inherits="SKT.LeanMES.Web.Product.MaterialBurnView" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content2" ContentPlaceHolderID="EditContent" runat="Server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="GridviewContent" runat="server">
    <div class="tb_c" style="min-height: 385px; overflow: auto;">
        <div>
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label2">软件名称</td>
                    <td class="Field2">
                        <asp:Literal ID="ltrSoftName" runat="server"></asp:Literal>
                    </td>
                    <td class="Label2">测试仪器</td>
                    <td class="Field2">
                        <asp:Literal ID="ltrTestMachine" runat="server"></asp:Literal>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">适用客户</td>
                    <td class="Field2">
                        <asp:Literal ID="ltrCustomer" runat="server"></asp:Literal>
                    </td>
                    <td class="Label2">软件作者 </td>
                    <td class="Field2">
                        <asp:Literal ID="ltrSoftCreator" runat="server"></asp:Literal>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">接收日期</td>
                    <td class="Field2">
                        <asp:Literal ID="ltrReceiveDate" runat="server"></asp:Literal>
                    </td>
                    <td class="Label2">更新内容</td>
                    <td class="Field2">
                        <asp:Literal ID="ltrUpdateContent" runat="server"></asp:Literal>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">烧录软件名</td>
                    <td class="Field2" colspan="3">
                        <asp:Literal ID="ltrSoftPath" runat="server"></asp:Literal>

                    </td>
                </tr>
                <tr>
                    <td class="Label2">检验码</td>
                    <td class="Field2" colspan="3">
                        <asp:Literal ID="ltrVerifyCode" runat="server"></asp:Literal>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">下载目录</td>
                    <td class="Field2" colspan="3">
                        <asp:Literal ID="ltrDownloadDir" runat="server"></asp:Literal>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="Label2">描述</td>
                    <td class="Field2" colspan="3">
                        <asp:Literal ID="ltrRemark" runat="server"></asp:Literal>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">关联产品
                    </td>
                    <td colspan="3" class="Field2">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataSourceID="ObjectDataSource1">
                            <Columns>
                                <asp:BoundField DataField="ItemCode" HeaderText="物料编码" />
                                <asp:BoundField DataField="ItemName" HeaderText="物料描述" />
                            </Columns>
                        </asp:GridView>
                        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
                            MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Molding.BLL.MaterialBurnMember"
                            SelectMethod="GetAll" SelectCountMethod="GetCount">
                            <SelectParameters>
                                <asp:Parameter Name="searchSettings" Type="Object" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script>
        $(function () {
            var tbObj = $(".ListTable");
            var length = tbObj.find("tr:not(.ListTableEmptyDataRow)").length;
            if (length == 0) {
                tbObj.hide();
            } else {
                tbObj.find("tr th:nth-child(1)").hide();
                tbObj.find("tr td:nth-child(1)").hide();
            }
        });
    </script>
</asp:Content>
