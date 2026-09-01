<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialDeliverList.aspx.cs"
    MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.Material.MaterialDeliverList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">送货单号
            </td>
            <td class="Field3">
                <input type="text" id="txtReveivedNO" class="TextBox" runat="server" />
            </td>
            <td class="Label3" name="supplier">
                供应商名称
            </td>
            <td class="Field3" name="supplier">
                <input type="text" id="txtVendorName" class="TextBox" runat="server"  />
            </td>
            <td class="Label3">采购单号
            </td>
            <td class="Field3">
                <input type="text" id="txtPoCode" class="TextBox" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label3">物料编码
            </td>
            <td class="Field3">
                <input type="text" id="txtItemCope" class="TextBox" runat="server" />
            </td>
            <td class="Label3">送货日期
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtDateTime" runat="server" CssClass="DateTimeBox"></asp:TextBox>
                ~<asp:TextBox ID="txtDateEnd" runat="server" CssClass="DateTimeBox"></asp:TextBox>
            </td>
            <td class="Label3">状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Text="全部" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="草稿" Value="0"></asp:ListItem>
                    <asp:ListItem Text="送出" Value="1"></asp:ListItem>
                    <asp:ListItem Text="收货" Value="2"></asp:ListItem>
                    <asp:ListItem Text="报废" Value="3"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="POCode" HeaderText="采购单号" />
            <asp:BoundField DataField="DeliverNo" HeaderText="送货单号" />
            <asp:BoundField DataField="VendorName" HeaderText="供应商名称" />
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" />
            <asp:BoundField DataField="ItemName" HeaderText="物料名称" />
           <%-- <asp:BoundField DataField="SentQty" HeaderText="送货数量"/>--%>
            <asp:TemplateField HeaderText="送货数量">
                <ItemTemplate>
                  <%#Eval("SentQty","{0:G0}").ToString().IndexOf("E")>-1?Eval("SentQty","{0:G}").ToString():Eval("SentQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="DeliStateText" HeaderText="状态" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="CreateBy" HeaderText="建单人" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="送出日期" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.Deliver"
        SelectMethod="GetList" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <%--<input type="hidden" id="hdnOperate" name="hdnOperate" value="" />--%>
    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">

        $(function () {
            $(document).ready(function () {
                $("#ckbMultipleSelected").parent().hide();
            });

            if ("<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserType%>" != "-1") {
                $("td[name='supplier']").hide();
            }
        });
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function RePrint() {
            var idStr = getRecordIdString();
            if (idStr == "") {
                return false;
            }
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 7 改为 DeliStateText
            var status = getOneRecordCellTextByFiled("DeliStateText");
            if (status != "送出" && status != "收货") {
                alert("您选择的信息状态非【送出/收货】状态！");
                return false;
            }
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/MaterialDeliFormPrint.aspx?name=Material_DeliveryFormPrint&ID=" + idStr);
        }

        //取消送货       
        function RevocationDeliver() {
            var isScanGRN = false;
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 2 改为 DeliverNo
            var deliverNo = getOneRecordCellTextByFiled("DeliverNo");
            if (deliverNo == "") {
                return false;
            }
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 7 改为 DeliStateText
            if (getOneRecordCellTextByFiled("DeliStateText") != "送出") {
                alert("您选择的信息状态非【送出】状态！");
                return false;
            }

            if (!confirm("确认取消送货单[" + deliverNo + "]所有送货信息？")) {
                return false;
            }

            //检验送货单是否已存在扫描GRN记录且不存在确认收料记录
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDelivery.CheckDeliverNoIsScanGRN(deliverNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            isScanGRN = ajax.value;

            if (isScanGRN) {
                if (!confirm("已有扫描收料记录，是否需要取消？")) {
                    return false;
                }
            }
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            //送货单号
            ajax = SKT.LeanMES.Web.AjaxServices.AjaxDelivery.RevocationDeliverNo(deliverNo, userName);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("取消送货成功！");
            document.forms[0].submit();
        }

        //导出PDF
        function PdfPrint() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            hdnOperate.val("PdfPrint");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
    </script>
</asp:Content>
