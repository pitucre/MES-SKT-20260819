<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditHeadMaster.master" CodeBehind="MaterialReplacement.aspx.cs" Inherits="SKT.LeanMES.Web.Client.MaterialReplacement" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">不良位置
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtNCPosition" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">物料编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input type="button" id="btnChooseItem" runat="server" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(1);" />
                <%--<asp:HiddenField ID="hidItemId" runat="server" ClientIDMode="Static" />--%>
            </td>
            <td class="Field3">
                <input type="button" id="searchSubmit" value="<%=Resources.lang.Search %>" onclick="doSearch()"
                    class="SearchButton" title="<%=Resources.lang.Search %>" />
            </td>
        </tr>
    </table>
</asp:Content>


<%--列表模块--%>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <div class="ListTableHeader">
        物料列表
    </div>
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemName %>" />
            <asp:BoundField DataField="ItemSpec" HeaderText="<%$ Resources:lang, ItemModel %>" />
            <asp:BoundField DataField="UsePosition" HeaderText="不良位置" ItemStyle-CssClass="nc-position" />
            <asp:BoundField DataField="Qty" HeaderText="用量" DataFormatString="{0:#.##}" />
            <asp:BoundField DataField="SerialNumber" ItemStyle-CssClass="item-bom-grn" HeaderText="<%$ Resources:lang, GRN %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Product.BLL.ItemBomChild"
        SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div class="ListTableHeader" style="padding: 7px 0px 2px">
        物料更换
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">物料条码
            </td>
            <td class="Field3" colspan="3">
                <asp:Label ID="lblItemBarcode" runat="server" nc-position="" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3">更换后的物料条码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtChangeItemBarcode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">数量
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtChangeItemBarcodeQty" runat="server" CssClass="TextBox" Text="1" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="center" style="padding: 5px 0px; border: 0px;">
                <input type="button" id="btnOpen" value=" 保 存 " onclick="Save()">
            </td>
        </tr>
    </table>
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField ID="hidNcDataId" runat="server" ClientIDMode="Static" />
    <script type="text/javascript">

        isMultiple = false;
        var hdnIdString = $("#hdnIdString");

        $(function () {
            //移除列表中的‘复选框’
            $(".ListTable tr th:first").html("");

            //不良代码回车事件
            $("#txtNCPosition").bind("keypress", function (event) {
                if (event.keyCode == "13") {
                    //带出物料编码
                    var val = $.trim($(this).val());
                    if (val == "") {
                        return;
                    }
                    var entity = {};
                    entity.UsePosition = val;
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.GetItemBomListByPosition(entity);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return;
                    }
                    else {
                        var list = ajax.value;
                        if (list != null && list.length > 0) {
                            $("#txtItemCode").val(list[0].ItemCode);
                        }
                    }
                }
            });

            //物料编码回车事件
            $("#txtItemCode").bind("keypress", function (event) {
                if (event.keyCode == "13") {
                    doSearch();
                }
            });

            //列表行点击、双击事件
            $(".ListTable tr").bind("click dblclick", function () {
                var grn = "";
                var ncPosition = "";
                var chks = $(".ListTable tr").find("input[type='checkbox']:checked");
                if (chks != null && chks.length > 0) {
                    grn = chks.first().parent().siblings(".item-bom-grn").html();
                    ncPosition=chks.first().parent().siblings(".nc-position").html();
                }
                $("#lblItemBarcode").html(grn).attr("nc-position",ncPosition);
            });

            //更换后的物料条码回车事件
            $("#txtChangeItemBarcode").bind("keypress", function (event) {
                if (event.keyCode == "13") {
                    //var itemCode = $.trim($("#txtItemCode").val());
                    //if (itemCode == "") {
                    //    alert("物料编码不能为空");
                    //    $("#txtItemCode").focus();
                    //    return;
                    //} else {
                    $("#txtChangeItemBarcodeQty").focus();
                    //}
                }
            });

        });

        function openChoosePage(pageId) {
            var condition = "";
            dialog({
                title: "<%= Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                pageId +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&rnd=" +
                Math.random(),
                width: 650,
                height: 350
            });
        }

        function doSearch() {
            document.forms[0].submit();
        }

        //获取选中的数据
        function getChooseValue(list) {
            //$("#hidItemId").val(list[0][0]);
        
            $("#txtItemCode").val(list[0][2]);
        }

        //保存
        function Save() {
            //var itemCode = $.trim($("#txtItemCode").val());
            var grn = $("#lblItemBarcode").html();
            var ncPosition = $("#lblItemBarcode").attr("nc-position");
            var replaseGRN = $.trim($("#txtChangeItemBarcode").val());
            var qty = $.trim($("#txtChangeItemBarcodeQty").val());
            var ncDataId = $.trim($("#hidNcDataId").val());
            if (ncDataId == "") {
                alert("未获取到不良信息");
                return;
            }
            if (qty == "") {
                alert("数量不能为空");
                $("#txtChangeItemBarcodeQty").focus();
                return;
            }
            if (!isGreaterThanZero(qty) || parseFloat(qty) == 0) {
                alert("请输入正数，小数部分最多允许输入3位小数");
                $("#txtChangeItemBarcodeQty").focus();
                return;
            }
            //if (ncPosition == "") {
            //    alert("不良位置不能为空");
            //    $("#txtNCPosition").focus();
            //    return;
            //}
            //if (itemCode == "") {
            //    alert("物料编码不能为空");
            //    $("#txtItemCode").focus();
            //    return;
            //}
            if (grn == "") {
                alert("请选择GRN");
                return;
            }
            if (replaseGRN == "") {
                alert("更换后的物料条码不能为空");
                $("#txtChangeItemBarcode").focus();
                return;
            }
            if (replaseGRN == grn) {
                alert("物料条码不能等于更换后的物料条码");
                $("#txtChangeItemBarcode").focus();
                return;
            }

            var entity = {};
            entity.NcDataId = ncDataId;
            entity.NcPosition = ncPosition;
            entity.ItemCode = "";
            entity.GRN = grn;
            entity.ReplaceGRN = replaseGRN;
            entity.Qty = qty;
            entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRepair.MaterialReplace(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("物料更换成功");
            $(".ListTable tr").find("input[type='checkbox']:checked").removeAttr("checked");//取消选中
            $("#lblItemBarcode").html("");
            $("#txtChangeItemBarcode").val("");
            $("#txtChangeItemBarcodeQty").val("1");
        }

        //验证是否为大于0的数字（小数部分最多允许输入6位）
        function isGreaterThanZero(val) {
            var reg = /^[0-9]+(.[0-9]{1,6})?$/;
            return reg.test(val);
        }


    </script>
</asp:Content>
