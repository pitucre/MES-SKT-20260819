<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReturnToSupplierList.aspx.cs"
    MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.Material.ReturnToSupplierList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">退料单</td>
            <td class="Field3">
                <asp:TextBox ID="txtReturnToWarehouseNO" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">采购单号</td>
            <td class="Field3">
                <asp:TextBox ID="txtErpSrc" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">物料编码</td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">供应商代码</td>
            <td class="Field3">
                <asp:TextBox ID="txtVenCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">退料人</td>
            <td class="Field3">
                <asp:TextBox ID="txtCreater" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">退料日期</td>
            <td class="Field3">
                <asp:TextBox ID="txtReturnDateFr" runat="server" ClientIDMode="Static" CssClass=" DateTimeBox"></asp:TextBox>
                --
                <asp:TextBox ID="txtReturnDateTo" runat="server" ClientIDMode="Static" CssClass="DateTimeBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">完成状态</td>
            <td class="Field3" colspan="5">
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Selected="True" Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="0">未完成</asp:ListItem>
                    <asp:ListItem Value="2">退料中</asp:ListItem>
                    <asp:ListItem Value="1">已完成</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ReturnOrder" HeaderText="退料单" SortExpression="ReturnOrder" />
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="ItemCode" />
            <asp:BoundField DataField="ItemName" HeaderText="物料名称" SortExpression="ItemName" />
            <%--<asp:BoundField DataField="ProdOrderNo" HeaderText="工单" SortExpression="ProdOrderNo" />--%>
            <%--            <asp:BoundField DataField="DepartName" HeaderText="退料部门" SortExpression="DepartName" />--%>
            
            <asp:TemplateField HeaderText="需退数量" SortExpression="ReturnQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("ReturnQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="已退数量" SortExpression="ReceiveQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("ReceiveQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>

     
            <asp:BoundField DataField="FinishStatus" HeaderText="完成状态" SortExpression="FinishStatus" ItemStyle-CssClass="finish-status" />
            <asp:BoundField DataField="VendorName" HeaderText="供应商" SortExpression="VendorName" />
            <asp:BoundField DataField="SourceBillNo" HeaderText="ERP来源单(采购单号)" SortExpression="SourceBillNo" />
            <asp:BoundField DataField="AutoID" HeaderText="行号" SortExpression="AutoID" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateTime" />
            <asp:BoundField DataField="UpdateBy" HeaderText="修改人" SortExpression="UpdateBy" />
            <asp:BoundField DataField="UpdateTime" HeaderText="修改时间" SortExpression="UpdateTime" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Material.BLL.Material" SelectMethod="GetReturnToVendorAll" SelectCountMethod="GetCount">
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
        $(function () {
            $("#txtReturnDateFr").attr("readonly", "readonly");
            $("#txtReturnDateTo").attr("readonly", "readonly");
            gridCellsChangeNo = true;
        })
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/ReturnToSupplierEdit.aspx?name=ReturnToSupplierAdd&Id=-1";
            dialog({ title: mesLang("新增"), src: openWinUrl, width: 900, height: 600 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/ReturnToSupplierEdit.aspx?name=ReturnToSupplierEdit&Id=" + idStr;
            dialog({ title: mesLang("编辑"), src: openWinUrl, width: 900, height: 600 });
        }

        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function View() {
            var idStr = getOneRecordId();
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 2 改为 ItemCode
            var itemcode = getOneRecordCellTextByFiled("ItemCode");
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/ReturnToSupplierDtl.aspx?ID=" + idStr + "&ItemCode=" + itemcode;
            dialog({ title: mesLang("查看"), src: openWinUrl, width: 900, height: 500 });
        }

        function Cancel() {
            //xiang.yan 2024-4-28  列取值由索引改为列明,功能已去除
            // 7>6 改为 FinishStatus
            var resultState = getOneRecordCellTextByFiled("FinishStatus");
            if (resultState !== "未完成") {
                alert("只有未完成的退料单可以取消操作!");
                return false;
            }
            //xiang.yan 2024-4-28  列取值由索引改为列明,功能已去除
            // 1 改为 ReturnOrder
            var idStr = getOneRecordCellTextByFiled("ReturnOrder");
            if (idStr == "") return false;

            hdnOperate.val("Cancel");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
