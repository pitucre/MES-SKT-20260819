<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="IQCConfirmList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.IQCConfirmList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">

                <select id="selOrderType">
                    <option value="1"><%=Resources.lang.DeliverNo%></option>
                    <option value="2"><%=Resources.lang.PONO%></option>
                    <option value="3"><%=Resources.lang.IQCFormNO%></option>
                </select>
                <asp:HiddenField ID="hdOrderType" runat="server" />
            </td>
            <td class="Field3">
                <input type="text" id="txtOrderNo" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
                <%=Resources.lang.VendorCode%>
            </td>
            <td class="Field3">
                <input type="text" id="txtVendorCode" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
                <%=Resources.lang.HandoverTime%>
            </td>
            <td class="Field3">
                <asp:TextBox CssClass="DateTimeBox" ID="txtTimeStart" Style="width: 76px;" runat="server"></asp:TextBox>
                -
                <asp:TextBox CssClass="DateTimeBox" ID="txtTimeEnd" Style="width: 76px;" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%=Resources.lang.MaterialCode%>
            </td>
            <td class="Field3">
                <input type="text" id="ItemCode" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
                <%=Resources.lang.HandoverStatus%>
            </td>
            <td class="Field3">
                <select id="Status">
                    <option value="-1">所有</option>
                   <%-- <option value="1">待检验</option>
                    <option value="2">已检验</option>
                    <option value="3">已退货</option>--%>
                    <option value="4">已交接</option>
                    <option value="5">已入库</option>
                </select>

                <asp:HiddenField ID="hfStatus" runat="server" Value="-1" />
            </td>
            <td class="Label3">
                <%=Resources.lang.CheckDateTime%>
            </td>
            <td class="Field3">
                <asp:TextBox CssClass="DateTimeBox" ID="txtCheckDateStart" Style="width: 76px;" runat="server"></asp:TextBox>
                -
                <asp:TextBox CssClass="DateTimeBox" ID="txtCheckDateEnd" Style="width: 76px;" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">订单号
            </td>
            <td class="Field3">
                <input type="text" id="txtSOCode" class="TextBox" runat="server" />
            </td>
            <td class="Label3">校验结果</td>
            <td class="Field3">
                <select name="selInspectionResult" id="selInspectionResult" class="selInspectionResult" runat="server">
                    <option value="" selected="selected">请选择</option>
                    <option value="0">不合格</option>
                    <option value="1">合格</option>
                </select>
            </td>
            <td class="Label3">IQC判定结果方式</td>
            <td class="Field3">
                <select name="selIQCResult" id="selIQCResult" runat="server">
                    <option value="" selected="selected">请选择</option>
                    <%--<option value="-3">待处理</option>--%>
	                <%--<option value="2">批量退货</option>--%>
	                <option value="3">特采</option>
	                <option value="4">挑选</option>
                </select>  
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" Style="table-layout: fixed; word-wrap: break-word; word-break: break-all">
        <Columns>
            <asp:BoundField DataField="交接时间" HeaderText="交接时间" SortExpression="交接时间" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="IQC检验单" HeaderText="IQC检验单" SortExpression="IQC检验单" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="检验日期" HeaderText="检验时间" SortExpression="检验日期" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="送货单" HeaderText="送货单" SortExpression="送货单" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="送货时间" HeaderText="送货时间" SortExpression="送货时间" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="采购单" HeaderText="采购单" SortExpression="采购单" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="订单号" HeaderText="订单号" SortExpression="订单号" HeaderStyle-Width="150px" />
            <asp:BoundField DataField="物料编号" HeaderText="物料编号" SortExpression="物料编号" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="物料名称" HeaderText="物料名称" SortExpression="物料名称" HeaderStyle-Width="180px" />
            <asp:BoundField DataField="物料规格" HeaderText="物料规格" SortExpression="物料规格" HeaderStyle-Width="320px" />
            <asp:BoundField DataField="供应商代码" HeaderText="供应商代码" SortExpression="供应商代码" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="供应商名称" HeaderText="供应商名称" HeaderStyle-Width="180px" />
            
            <asp:TemplateField HeaderText="收料数量" SortExpression="收料数量"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("收料数量","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="合格数量" SortExpression="合格数量"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("合格数量","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="不合格数量" SortExpression="不合格数量"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("不合格数量","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
           
            <asp:BoundField DataField="检验结果" HeaderText="检验结果" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="处理方式" HeaderText="IQC判定结果方式" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="紧急情况" HeaderText="紧急情况" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="交接人" HeaderText="交接人" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="是否条码管控" HeaderText="是否条码管控" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="交接状态" HeaderText="交接状态" HeaderStyle-Width="80px" />

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.AjaxCommon.DBService"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        $(function () {
            var orderTypeId = $("#<%=this.hdOrderType.ClientID %>").val();
            if (orderTypeId == "") {
                orderTypeId = "1";
            }
            $("#selOrderType").val(orderTypeId);
            $("#selOrderType").bind("change", function () {
                $("#<%=this.hdOrderType.ClientID %>").val($(this).val());
            })

            $("#Status").val($("#<%=this.hfStatus.ClientID %>").val());

            $("#Status").bind("click", function () {
                $("#<%=this.hfStatus.ClientID %>").val($(this).val());
            });
            gridCellsChangeNo = true;

        })

    </script>
</asp:Content>
