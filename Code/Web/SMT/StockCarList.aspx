<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StockCarList.aspx.cs" Inherits="SKT.LeanMES.Web.SMT.StockCarList" MasterPageFile="~/Masters/ListMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                备料车编码
            </td>
            <td class="Field1">
                <input type="text" id="txtTurnoverTypeName" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="StockCarNumber" HeaderText="备料车编码" HeaderStyle-Width="120px" SortExpression="StockCarNumber"/>
            <asp:BoundField DataField="StockTypeName" HeaderText="备料车类型" HeaderStyle-Width="80px" SortExpression="StockTypeName"/>
            <asp:BoundField DataField="StatusName" HeaderText="状态" HeaderStyle-Width="60px" SortExpression="StatusName"/>     
            <asp:BoundField DataField="MinQty" HeaderText="最小装载数量" HeaderStyle-Width="85px" SortExpression="MinQty"/>  
            <asp:BoundField DataField="MaxQty" HeaderText="最大装载数量" HeaderStyle-Width="85px" SortExpression="MaxQty"/>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px" SortExpression="CreateBy"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" SortExpression="CreateDateTime"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px" SortExpression="ModifyBy"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" SortExpression="ModifyDateTime"/>
            <asp:BoundField DataField="Remark" HeaderText="备注"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Turnover.BLL.StockCar"
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

        //增加 
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/StockCarEdit.aspx?name=StockCarAdd&Id=-1";
            dialog({ title: "<%= Resources.Pages.StockCarAdd %>", src: openWinUrl, width: 500, height: 350, resizeable: false });
        }

        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/StockCarEdit.aspx?name=StockCarEdit&Id=" + idStr;
            dialog({ title: "<%= Resources.Pages.StockCarEdit %>", src: openWinUrl, width: 500, height: 350, resizeable: false });
        }


        //刷新 
        function refresh() {
            document.forms[0].submit();
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            $(hdnOperate).val("Delete");
            $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(turnoverTypeName) {
            $("#<%=this.txtTurnoverTypeName.ClientID %>").val(turnoverTypeName);
            document.forms[0].submit();
        }
    </script>
</asp:Content>




