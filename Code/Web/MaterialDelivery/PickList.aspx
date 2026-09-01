<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="PickList.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialDelivery.PickList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server"> 
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.PickCode%>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtPick" class="TextBox" style="width: 250px; height: 25px;"
                    runat="server" />
                <input type="button" id="btnPick" class="ButtonBox" value="..." title="" style="height: 27px;"
                    onclick="PrintPick();" />
                <asp:HiddenField ID="hdfPick" Value="0" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="PickCode" HeaderText="<%$ Resources:lang, PickCode %>" />
            <asp:BoundField DataField="LineName" HeaderText="<%$ Resources:lang, LineName %>" />
            <asp:BoundField DataField="OrderNO" HeaderText="<%$ Resources:lang, OrderNO %>" />
            <asp:BoundField DataField="Qty" HeaderText="<%$ Resources:lang, Qty %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MaterialDelivery.BLL.PickMaterial"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        /*选择分捡单*/
        function PrintPick() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=53&Multiple=false&rnd=" + Math.random(), width: 400, height: 300 });
        }
        function getChooseValue(list) {
            $("#<%=this.txtPick.ClientID %>").val(list[0][1]);
            $("#<%=this.hdfPick.ClientID %>").val(list[0][0]);
        }
        function Print() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明,菜单已无此页面
            // 1 改为 PickCode
            var formNo = getOneRecordCellTextByFiled("PickCode");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialDelivery/PickPrint.aspx?formNo=" + formNo + "&ID=" + idStr;
            window.open(openWinUrl, "打印", 'height=980, width=1080');
        }
    </script>
</asp:Content>
