<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="TransfersStorageList.aspx.cs" Inherits="SKT.LeanMES.Web.Transfers.TransfersStorageList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">调拨单号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtTransfersNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">来源单号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtSourceNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">物料编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">调拨类型
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlType" runat="server">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="0">无单据调拨</asp:ListItem>
                    <asp:ListItem Value="1">委外调拨</asp:ListItem>
                    <asp:ListItem Value="3">超期不良调拨</asp:ListItem>
                    <asp:ListItem Value="2">无单调拨出库</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">回写ERP调拨单号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtErpCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">创建时间
            </td>
            <td class="Field3">
                <input type="text" id="txtCreateDateF" class="DateTimeBox" runat="server" readonly="readonly" />
                -
                    <input type="text" id="txtCreateDateT" class="DateTimeBox" runat="server" readonly="readonly" />
            </td>

        </tr>
        <tr>
            <td class="Label3">调拨人
            </td>
            <td class="Field3" colspan="5">
                <asp:TextBox ID="txtCreateBy" runat="server" CssClass="TextBox"></asp:TextBox>

            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <div id="divList" style="overflow: auto;">
        <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
            <Columns>
                <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                <asp:BoundField DataField="TransfersTypeName" HeaderText="调拨类型" SortExpression="TransfersType" />
                <asp:BoundField DataField="TransfersNo" HeaderText="调拨单号" SortExpression="TransfersNo" />
                <asp:BoundField DataField="SourceNo" HeaderText="来源单号" SortExpression="SourceNo" />
                <asp:BoundField DataField="ErpCode" HeaderText="回写ERP调拨单号" SortExpression="ErpCode" />
                <asp:BoundField DataField="OutWhName" HeaderText="调出仓位" ItemStyle-Wrap="false" />
                <asp:BoundField DataField="InWhName" HeaderText="调入仓位" ItemStyle-Wrap="false" />
                <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="ItemCode" />
                <asp:BoundField DataField="ItemName" HeaderText="物料名称" ItemStyle-Wrap="false" />
                <asp:TemplateField HeaderText="需求数量" SortExpression="ApplyQty"  HeaderStyle-Width="100px">
                    <ItemTemplate>
                        <%#Eval("ApplyQty","{0:G0}").ToString() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="调拨数量" SortExpression="FinishQty"  HeaderStyle-Width="100px">
                    <ItemTemplate>
                        <%#Eval("FinishQty","{0:G0}").ToString() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="CName" HeaderText="调拨人" ItemStyle-Wrap="false" />
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
            MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.AjaxCommon.DBService"
            SelectMethod="GetAll" SelectCountMethod="GetCount">
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
            if (idStr == "") return;
            dialog({ title: mesLang("查看详细"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Transfers/TransfersStorageView.aspx?name=TransfersStorageView&TransfersDtlId=" + idStr + "&rnd=" + Math.random(), width: 850, height: 300 });

        }
        //确认接收
        function TransfersStorageSure() {
            //xiang.yan 2024-4-28  列取值由索引改为列明,功能已去除
            // 13>12 改为 CName 已经没有13列用12列替代
            var confirmMan = getOneRecordCellTextByFiled("CName");
            if ($.trim(confirmMan) !== "") {
                alert("记录已经确认，不能重复确认！");
                return;
            }

            var idStr = getOneRecordId();
            if (idStr == "") return false;
            if (!window.confirm("是否确认接收？")) {
                return "";
            }
          
            var entity = {};
            entity.TransfersId = idStr;
            entity.UserId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsTransfersStorageListReceive", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("接收成功");
            document.forms[0].submit();
        }

    </script>
</asp:Content>
