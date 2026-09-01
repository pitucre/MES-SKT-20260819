<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AllMaterialHistoryList.aspx.cs" 
    MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.Material.AllMaterialHistoryList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server" ViewStateMode="Enabled">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                物料条码
            </td>
            <td class="Field2">
                <input type="text" id="txtSerialNumber" class="TextBox" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                操作类型
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlMaterialStatus">
                </asp:DropDownList>
            </td>
        </tr>
 
        <tr>
            <td class="Label2">
                物料编码
            </td>
            <td class="Field2">
                <input type="text" id="txtItemCode" class="TextBox" runat="server" />
            </td>
            <td class="Label2">
                关联单号
            </td>
            <td class="Field2">
                <input type="text" id="txtActionOrder" class="TextBox" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                操作时间
            </td>
            <td class="Field2">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" />
            </td>

        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>       
            <asp:BoundField DataField="SerialNumber" HeaderText="物料条码" SortExpression="SerialNumber" />
            <asp:BoundField DataField="OperateOrder" HeaderText="关联单号" SortExpression="OperateOrder" />
            <asp:BoundField DataField="ActionType" HeaderText="操作类型" SortExpression="ActionType" />
            <asp:BoundField DataField="ActionDesc" HeaderText="描述" SortExpression="ActionDesc" />
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="ItemCode" />
            <asp:BoundField DataField="ItemName" HeaderText="物料名称" SortExpression="ItemName" />
            <asp:TemplateField HeaderText="数量" SortExpression="Quantity" >
                <ItemTemplate>
                    <%#Eval("Quantity","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>   
            <asp:BoundField DataField="CreateBy" HeaderText="操作人" SortExpression="CreateBy" /> 
             <asp:BoundField DataField="CreateDateTime" HeaderText="操作时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"
                SortExpression="CreateDateTime"  HeaderStyle-Width="140px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.MaterialUnit"
        SelectMethod="GetHistoryActionInfoAll" SelectCountMethod="GetCount">
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
            $(".DateTimeBox").datepicker({
                showOn: "both",
                buttonImageOnly: true,
                buttonText: "<%=Resources.lang.ChooseDate %>"
            });

            if ('<%=Request.Form["selStatus"] %>' != null && '<%=Request.Form["selStatus"] %>' != "") {
                $("#selStatus").val('<%=Request.Form["selStatus"] %>');
            }
            $(document).ready(function () {
                if ($("#txtSerialNumber").val()!=="") {
                    $("#txtSerialNumber").select();
                }
            })
        });
        /*生成GRN条码*/
        function GenerateGRN() {
            dialog({ title: "<%= Resources.Pages.Material_GenerateGRN %>", src: "GenerateGRN.aspx?name=Material_GenerateGRN&rnd=" + Math.random(), width: 625, height: 300, onClosed: "updatelist" });
        }

        function getCheckedValue(a) {
            var b = "", c = $("input[name='chkSelect']:checked");
            return c.length == 0 ? false : c.length > 1 ? false : b = c[0].parentElement.parentElement.cells[a].innerText, b;
        }

        /*刷新页面*/
        function refresh() {
            document.forms[0].submit();
        }
        /*打印GRN条码*/
        function Print() {
            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值,按钮事件已取消
            // 1 改为 SerialNumber
            var cellStr = getRecordCellTextsByFiled("SerialNumber"); 
            if (cellStr == "") {
                return false;
            }
            dialog({ title: "<%= Resources.Pages.Material_ReprintGRN %>", src: "ReprintGRN.aspx?name=Material_ReprintGRN&GRN=" + cellStr + "&rnd=" + Math.random(), width: 450, height: 200 });
        }
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialUnitEdit.aspx?ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Material_MaterialInfo %>", src: openWinUrl, width: 750, height: 400 });
        }
        function View() {
            //Edit();
        }
        function EditQuantity() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //增加状态验证2017-3-17
            //xiang.yan 2024-4-26  列取值由索引改为列明,功能已去除
            // 14列已不存在不做修改
            var resultState = getOneRecordCellText(14);
            if (resultState == '前置加工' || resultState == '开拉' || resultState == '手插'
                || resultState == '物料暂收' || resultState == '用完' || resultState == '报废'
                || resultState == '在供应商已生成送货单') {
                alert('不能修改此状态的物料数量');
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/GRNModify.aspx?ID=" + idStr;
            dialog({ title: "修改GRN可用数量", src: openWinUrl, width: 400, height: 250 });
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
    </script>
    <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
        type="text/javascript" charset="GBK"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
        type="text/javascript"></script>
</asp:Content>
