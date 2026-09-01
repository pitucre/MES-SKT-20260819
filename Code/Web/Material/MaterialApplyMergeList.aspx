<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="MaterialApplyMergeList.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialApplyMergeList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                母领料单
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMergeApplyNo" runat="server" CssClass="TextBox"  ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">
                子领料单
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtApplyNo" runat="server" CssClass="TextBox"  ClientIDMode="Static"></asp:TextBox>
            </td>          
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="MergeApplyNo" HeaderText="母领料单号码" HeaderStyle-Width="220px" />
            <asp:BoundField DataField="RowId" HeaderText="序号" HeaderStyle-Width="40px" />
            <asp:BoundField DataField="ApplyNo" HeaderText="领料单号码"  />
            <asp:BoundField DataField="Statue" HeaderText="状态" />
            <asp:BoundField DataField="CreateBy" HeaderText="建立人"  />
            <asp:BoundField DataField="CreateDateTime" SortExpression="CreateDateTime" HeaderText="建立时间"  />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.Apply"
        SelectMethod="GetMergeApplyAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js" type="text/javascript"></script>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function AddMerge() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialApplyMergeEdit.aspx?name=MaterialApplyMergeAdd&ID=-1";
            dialog({ title: mesLang("合并领料单"), src: openWinUrl, width: 700, height: 400 });
        }

        
        function CancelMerge() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            debugger
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 1 改为 MergeApplyNo
            // 4 改为 Statue
            var MergeApplyNo = getOneRecordCellTextByFiled("MergeApplyNo");
            var Statue = getOneRecordCellTextByFiled("Statue");
            if (Statue != "待备料") {
                alert("该状态不允许取消合并！");
                return false;
            }
            if (window.confirm("是否要取消母单[" + MergeApplyNo+"]合并？")) {
                hdnOperate.val("delete");
                hdnIdString.val(idStr);
                document.forms[0].submit();
            }
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function openChoosePage(flags) {
            var condition = "";
            dialog({ title: mesLang("选择窗口"), src: "../Framework/ChoosePage.aspx?PageId=44&Multiple=false&SearchCondition=" + condition + "&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
            $("#txtOrderNo").val(list[0][1]);
        }
    </script>
</asp:Content>
