<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialUnitListSuply.aspx.cs" Inherits="SKT.LeanMES.Web.SuplyMaterial.MaterialUnitListSuply" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server" ViewStateMode="Enabled">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                物料条码
            </td>
            <td class="Field3">
                <input type="text" id="txtSerialNumber" class="TextBox" runat="server" clientidmode="Static" />
            </td>
            <td class="Label3">
                批次号
            </td>
            <td class="Field3">
                <input type="text" id="txtLotCode" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
                物料编码/名称/规格
            </td>
            <td class="Field3">
                <input type="text" id="txtItem" class="TextBox" runat="server" />
            </td>
        </tr>
        
        <tr>
            <td class="Label3">
                创建人
            </td>
            <td class="Field3">
                <input type="text" id="txtCreateBy" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
                采购单号
            </td>
            <td class="Field3">
                <input type="text" id="txtPOorder" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
                <%=Resources.lang.Status%>
            </td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="ddlMaterialStatus">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                供应商
            </td>
            <td class="Field3">
                <input type="text" id="txtVendorName" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
                送货单号
            </td>
            <td class="Field3">
                <input type="text" id="DeliveryOrder" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
                生成物料条码时间
            </td>
            <td class="Field3" colspan="3">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" />
                  <img title="点击清除日期" id="timeClear" style="margin-bottom:-5px;  cursor: pointer;" onclick="clearDataTime();" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==">
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <asp:BoundField DataField="POorder" HeaderText="采购单号" SortExpression="POorder" HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="DeliveryOrder" HeaderText="送货单号" SortExpression="POorder" HeaderStyle-Width="150px"/>
            <asp:BoundField DataField="SerialNumber" HeaderText="物料条码" SortExpression="SerialNumber" HeaderStyle-Width="130px"/>
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="ItemCode" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="ItemName" HeaderText="物料名称" SortExpression="ItemName" HeaderStyle-Width="170px"/>
            <asp:BoundField DataField="ItemSpec" HeaderText="物料规格" SortExpression="ItemSpec" HeaderStyle-Width="240px"/>
            <asp:BoundField DataField="LotCode" HeaderText="批次号" SortExpression="LotCode" HeaderStyle-Width="100px"/>
            <asp:TemplateField HeaderText="总数量" SortExpression="Quantity"  HeaderStyle-Width="100px">
                <ItemTemplate>
                     <%#Eval("Quantity","{0:G0}").ToString().IndexOf("E")>-1?Eval("Quantity","{0:G}").ToString():Eval("Quantity","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="剩余数量" SortExpression="BalanceQty"  HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("BalanceQty","{0:G0}").ToString().IndexOf("E")>-1?Eval("BalanceQty","{0:G}").ToString():Eval("BalanceQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="VendorName" HeaderText="供应商" SortExpression="VendorName" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="Statusname" HeaderText="当前状态" HeaderStyle-Width="70px"/>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="生成物料条码时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"
                SortExpression="CreateDateTime" HeaderStyle-Width="140px" />
            

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.MaterialUnit"
        SelectMethod="GetMaterialInfoAllSuply" SelectCountMethod="GetCount">
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
            gridCellsChangeNo = true;
            $(".DateTimeBox").datepicker({
                showOn: "both",
                buttonImageOnly: true,
                buttonText: "<%=Resources.lang.ChooseDate %>"
            });
        });
        /*生成GRN条码*/
        function GenerateGRN() {
            dialog({ title: "<%= Resources.Pages.Material_GenerateGRN %>", src: "GenerateGRNSuply.aspx?name=Material_GenerateGRNSuply&rnd=" + Math.random(), width: 625, height: 300, onClosed: "updatelist" });
        }

        function getCheckedValue(a) {
            var b = "", c = $("input[name='chkSelect']:checked");
            return c.length == 0 ? false : c.length > 1 ? false : b = c[0].parentElement.parentElement.cells[GetGridCellsChangNo(a)].innerText, b;
        }

        /*刷新页面*/
        function refresh() {
            document.forms[0].submit();
        }

        /*打印GRN条码*/
        function Print() {
            var cellStr = getRecordCellTextsByFiled("SerialNumber");
            if (cellStr == "") {
                return false;
            }
            dialog({ title: "<%= Resources.Pages.Material_RePrintGRNSuply %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/ReprintGRN.aspx?name=Material_RePrintGRNSuply&GRN=" + cellStr + "&rnd=" + Math.random(), width: 600, height: 270 });
        }
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SuplyMaterial/MaterialUnitEditSuply.aspx?ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Material_MaterialInfo %>", src: openWinUrl, width: 750, height: 400 });
        }
        function View() {
            Edit();
        }
        function EditQuantity() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/GRNModify.aspx?ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Material_IQCFormView %>", src: openWinUrl, width: 350, height: 200 });
        }


        /*删除*/
        function Delete() {         
            var idStr = getRecordIdString();
            if (idStr == "") return;
            if (!window.confirm(ConfirmDelete)) {
                return false;
            }
            var ajaxDelete = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.DeleteGRN(idStr, 1);
            if (ajaxDelete.error != null) {
                alert(ajaxDelete.error.Message);
                return false;
            }

            alert("<%= Resources.Messages.DeleteSuccess %>");
            document.forms[0].submit();
        }

        //报废
        function Scrap() {
            var idStr = getRecordIdString();
            if (idStr == "") return;
            if (confirm('确定报废?')) {

                var ajaxDelete = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.FailGRNByVenCode(idStr);
                if (ajaxDelete.error != null) {
                    alert(ajaxDelete.error.Message);
                    return false;
                }
                alert("报废成功！");
                document.forms[0].submit();
            }
        }
        function Export()
        {
            hdnOperate.val("exportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
    </script>
</asp:Content>
