<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="BarCodeScopeSetList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.BarCodeScopeSetList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                工单号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox"  ClientIDMode="Static"></asp:TextBox>
                <input type="button" id="bnOper" class="ButtonBox" onclick="openChoosePage()" value="..." />
            </td>
            <td class="Label2">
                订单号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCustomerOrder" runat="server" CssClass="TextBox"  ClientIDMode="Static"></asp:TextBox>
            </td>          
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="NumberType" HeaderText="号码类型" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="OrderNo" HeaderText="工单号" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CustomerOrder" HeaderText="订单号" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="Prefix" HeaderText="条码前缀" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="Suffix" HeaderText="条码后缀" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="SerialBegin" HeaderText="起始流水号" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="SerialEnd" HeaderText="结束流水号" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="SerialLength" HeaderText="流水号长度" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="Qty" HeaderText="数量" HeaderStyle-Width="50px" />
            <asp:BoundField DataField="NumberBegin" HeaderText="完整起始号码" HeaderStyle-Width="280px" />
            <asp:BoundField DataField="NumberEnd" HeaderText="完整结束号码" HeaderStyle-Width="280px" />
            <asp:BoundField DataField="SpecialStr" HeaderText="特殊字符" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="Increase" HeaderText="递增量" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="Fixed" HeaderText="固定码" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="IsMain" HeaderText="是否主条码" HeaderStyle-Width="100px" />
<%--            <asp:BoundField DataField="CreateBy" HeaderText="建立人" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="建立时间" HeaderStyle-Width="140px" />--%>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ModifyTime" HeaderText="修改时间" HeaderStyle-Width="140px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ProdUnit.BLL.BarCodeScope"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/BarCodeScopeSetEdit.aspx?name=BarCodeScopeSetAdd&ID=-1";
            dialog({ title: "<%=Resources.lang.AddBarcodeRangeSettings%>", src: openWinUrl, width: 850, height: 500 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            var OrderNo = "";
            for (var i = 0; i < $("input[name='chkSelect']").length; i++) {
                var $_input = $($("input[name='chkSelect']")[i]);
                if ($_input.val() == idStr) {
                    OrderNo = $_input.parent().parent().find("td:eq(2)").html();
                }
            }

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/BarCodeScopeSetEdit.aspx?name=BarCodeScopeSetMacEdit&ID=" + idStr + "&OrderNo=" + OrderNo;
            dialog({ title: "<%=Resources.lang.EditBarcodeRangeSettings%>", src: openWinUrl, width: 850, height: 500 });
        }
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function openChoosePage(flags) {
            var condition = "";
            dialog({ title: "选择窗口", src: "../Framework/ChoosePage.aspx?PageId=44&Multiple=false&SearchCondition=" + condition + "&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
            $("#txtOrderNo").val(list[0][1]);
        }
    </script>
</asp:Content>
