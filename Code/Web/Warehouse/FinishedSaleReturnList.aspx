<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="FinishedSaleReturnList.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.FinishedSaleReturnList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label3">销退单号</td>
            <td class="Field3">
                <asp:TextBox CssClass="TextBox" runat="server" ID="SaleReturnNo"></asp:TextBox>
            </td>
            <td class="Label3">客户编码</td>
            <td class="Field3">
                <asp:TextBox ID="CustomerCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" onclick="openChoosePage(10)" value="..." />
            </td>
            <td class="Label3">产品编码</td>
            <td class="Field3">
                <asp:TextBox ID="ItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" onclick="openChoosePage(1)" value="..." />
            </td>
        </tr>
        <tr>
            <td class="Label3">备货单号</td>
            <td class="Field3">
                <asp:TextBox CssClass="TextBox" runat="server" ID="DNCode"></asp:TextBox>
            </td>
            <td class="Label3">销售订单号</td>
            <td class="Field3">
                <asp:TextBox CssClass="TextBox" runat="server" ID="SaleOrderNo" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">仓库编码</td>
            <td class="Field3">
                <asp:TextBox ID="CWhCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" onclick="openChoosePage(14)" value="..." />
            </td>
        </tr>
        <tr>
            <td class="Label3">状态</td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="Status" ClientIDMode="Static">
                    <asp:ListItem Value="" Selected="True">请选择</asp:ListItem>
                    <asp:ListItem Value="0">待退货</asp:ListItem>
                    <asp:ListItem Value="1">退货中</asp:ListItem>
                    <asp:ListItem Value="2">已完成</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3"></td>
            <td class="Field3"></td>
            <td class="Label3"></td>
            <td class="Field3"></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" Style="table-layout: fixed; word-wrap: break-word; word-break: break-all"  OnRowDataBound="GridView1_RowDataBound">
    <Columns>
        <%-- To Do --%>

        <asp:BoundField DataField="SaleReturnNo" HeaderText="销退单号" SortExpression="SaleReturnNo" ItemStyle-CssClass="SaleReturnNo" />
        <asp:BoundField DataField="SaleReturnRowId" HeaderText="销退单行号" SortExpression="SaleReturnRowId" ItemStyle-CssClass="SaleReturnRowId" />
        <asp:BoundField DataField="CustomerCode" HeaderText="客户编码" SortExpression="CustomerCode" />
        <asp:BoundField DataField="CustomerName" HeaderText="客户名称" SortExpression="CustomerName" />
        <asp:BoundField DataField="DNCode" HeaderText="备货单号" SortExpression="DNCode" />
        <asp:BoundField DataField="DNRowId" HeaderText="备货单行号" SortExpression="DNRowId" />
        <asp:BoundField DataField="SaleOrderNo" HeaderText="销售订单号" SortExpression="SaleOrderNo" />
        <asp:BoundField DataField="SaleOrderItem" HeaderText="销售订单行号" SortExpression="SaleOrderItem" />
        <asp:BoundField DataField="ItemCode" HeaderText="产品编码" SortExpression="ItemCode" />
        <asp:BoundField DataField="ItemName" HeaderText="产品名称" SortExpression="ItemName" />
        <%--<asp:BoundField DataField="CustomerOrderNo" HeaderText="客户订单号" SortExpression="CustomerOrderNo" />
        <asp:BoundField DataField="CustomerOrderItem" HeaderText="客户订单行号" SortExpression="CustomerOrderItem" />--%>
        <asp:BoundField DataField="CWhCode" HeaderText="仓库编码" SortExpression="CWhCode" />
        <asp:BoundField DataField="CWhName" HeaderText="仓库名称" SortExpression="CWhName" />
        <asp:BoundField DataField="SaleReturnQty" HeaderText="退货数量" SortExpression="SaleReturnQty" ItemStyle-CssClass="number" />
        <asp:BoundField DataField="CurrentReturnQty" HeaderText="已退货数量" SortExpression="CurrentReturnQty" ItemStyle-CssClass="number" />
        <asp:BoundField DataField="StatusName" HeaderText="状态" SortExpression="StatusName" />
           <asp:BoundField DataField="Remark" HeaderText="备注" SortExpression="StatusName" />
        <asp:BoundField DataField="ModifyBy" HeaderText="修改人" SortExpression="ModifyBy" />
        <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" SortExpression="ModifyDateTime" />
        <%--<asp:BoundField DataField="SaleReturnId" HeaderText="退货主表ID" SortExpression="SaleReturnId"  ItemStyle-CssClass="SaleReturnId" Visible="false"/>--%>
    </Columns>
</asp:GridView>
<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
    StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
    TypeName="SKT.LeanMES.SaleReturn.BLL.SaleReturn" SelectMethod="GetSaleReturnDtlList" SelectCountMethod="GetCount">
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
        var flag = -1;

        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr === "") return false;
            var saleReturnNo = getTextByClass("SaleReturnNo");
            var saleReturnRowId = getTextByClass("SaleReturnRowId");

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/FinishedSaleReturnView.aspx?name=FinishedSaleReturnView&SaleReturnNo=" + saleReturnNo + "&SaleReturnRowId=" + saleReturnRowId;
            dialog({ title: "退货条码", src: openWinUrl, width: 860, height: 500 });
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function openChoosePage(flags) {
            var condition = "";
            flag = flags;
            dialog({ title: "选择窗口", src: "../Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&SearchCondition=" + condition + "&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function getChooseValue(list) {
            if (flag == 1) {	//选择产品编码
                $("#ItemCode").val(list[0][2]);
            }
            else if (flag == 10) {	//选择客户
                $("#CustomerCode").val(list[0][2]);
            }
            else if (flag == 14) {	//选择仓库
                $("#CWhCode").val(list[0][1]);
            }
            flag = -1;
        }

        //导出到EXCEL
        function Export() {
            hdnOperate.val("exportexcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        //xiang.yan 2024-07-08 新增退货单
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/SaleReturnEdit.aspx?name=StockOrderAdd&SaleReturnId=-1";
            dialog({ title: mesLang("新增退货单信息"), src: openWinUrl, width: 750, height: 400 });
        }

        //xiang.yan 2024-07-08 编辑退货单
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //var saleReturnId = getTextByClass("SaleReturnId");
            //alert(saleReturnId);
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/SaleReturnEdit.aspx?name=StockOrderEdit&SaleReturnId=" + idStr;
            dialog({ title: mesLang("编辑退货单信息"), src: openWinUrl, width: 750, height: 400 });
        }

        //xiang.yan 2024-07-08 删除备货单
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        //物料条码打印
        function Print() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            var StatusName = getRecordCellTextsByFiled('StatusName');
            if (StatusName == "已完成") {
                alert("只能打印未完成、退货中单据条码!");
                return;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/FinishedSaleReturnListPrintGRN.aspx?name=FinishedSaleReturnListPrintGRN&SaleReturnDtlId=" + idStr;
            dialog({ title: mesLang("物料条码打印"), src: openWinUrl, width: 1500, height: 700 });
        }

        //品质判定
        function JudgeQuality() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/FinishedSaleReturnListJudgeQuality.aspx?name=FinishedSaleReturnJudgeQuality&SaleReturnDtlId=" + idStr;
            dialog({ title: mesLang("品质判定"), src: openWinUrl, width: 1000, height: 500 });            
        }

    </script>
</asp:Content>
