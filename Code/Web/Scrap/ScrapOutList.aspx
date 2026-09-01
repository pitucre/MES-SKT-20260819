<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="ScrapOutList.aspx.cs" Inherits="SKT.LeanMES.Web.Scrap.ScrapOutList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">报废单号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtScrapNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>

            <td class="Label3">报废时间
            </td>
            <td class="Field3">
                <input type="text" id="txtDateF" class="DateTimeBox" runat="server" readonly="readonly" />
                -
                    <input type="text" id="txtDateT" class="DateTimeBox" runat="server" readonly="readonly" />
            </td>
            <td class="Label3">回写ERP报废单号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtErpCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">报废人
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtCreateBy" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">创建时间
            </td>
            <td class="Field3">
                <input type="text" id="txtCreateDateF" class="DateTimeBox" runat="server" readonly="readonly" />
                -
                    <input type="text" id="txtCreateDateT" class="DateTimeBox" runat="server" readonly="readonly" />
            </td>
            <td class="Label3">物料编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>

        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <div id="divList" style="overflow: auto;">
        <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
            <Columns>
                <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                <asp:BoundField DataField="ScrapDateTime" HeaderText="报废时间" SortExpression="ScrapDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                <asp:BoundField DataField="ScrapNo" HeaderText="报废单号" SortExpression="ScrapNo" />
                <asp:BoundField DataField="ErpCode" HeaderText="回写ERP报废单号" SortExpression="ErpCode" />
                <asp:BoundField DataField="WhName" HeaderText="仓库" ItemStyle-Wrap="false" />
                <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="ItemCode" />
                <asp:BoundField DataField="ItemName" HeaderText="物料名称" ItemStyle-Wrap="false" />
                <asp:BoundField DataField="ScrapQty" HeaderText="报废数量" SortExpression="ScrapQty" />
                <asp:BoundField DataField="CName" HeaderText="报废人" ItemStyle-Wrap="false" />
                <asp:BoundField DataField="ReceiveUser" HeaderText="确认接收人" />
                <asp:BoundField DataField="ReceiveData" HeaderText="确认接收时间" SortExpression="ReceiveData" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
            MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Scrap.BLL.ScrapStorage"
            SelectMethod="GetAllScrapStorageList" SelectCountMethod="GetCount">
            <SelectParameters>
                <asp:Parameter Name="searchSettings" Type="Object" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function Refresh() {
            document.forms[0].submit();
        }

        //导出
        function Import() {
            hdnOperate.val("exportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        function View() {
            var idStr = getOneRecordId();
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 2 改为 ScrapDateTime
            // 9 改为 CName
            var scrapDateTime = getOneRecordCellTextByFiled("ScrapDateTime");
            var cName = getOneRecordCellTextByFiled("CName");
            if (idStr == "") return;
            dialog({ title: mesLang("查看详细"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Scrap/ScrapOutView.aspx?name=ScrapStorageView&ScrapId=" + idStr + "&ScrapDateTime=" + scrapDateTime + "&CName=" + cName + "&rnd=" + Math.random(), width: 850, height: 300 });

        }
        //确认接收
        function ScrapSure() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            if (!window.confirm("是否确认接收？")) {
                return "";
            }

            var scrapId = idStr;
            var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapStorage.ScrapOutListReceive(scrapId, userId);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("接收成功");
            document.forms[0].submit();
        }

    </script>
</asp:Content>
