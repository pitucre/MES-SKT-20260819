<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExpiredDateList.aspx.cs"
    MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.Material.ExpiredDateList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">产品编码</td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">库位条码</td>
            <td class="Field3">
                <asp:TextBox ID="txtCBarCode" runat="server" class="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">仓库编码</td>
            <td class="Field3">
                <asp:TextBox ID="txtWarehouse" runat="server" class="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
        </tr>
        <tr>
            <td class="Label3">物料条码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtGRN" runat="server" class="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">供应商名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtVendorName" runat="server" class="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
            保质期剩余(天)
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtRemainingShelfLifeBegin" runat="server" style="width: 140px" onkeyup="limitNumRange(this,-maxRemainingShelfLife,maxRemainingShelfLife,false)" class="TextBox" />~
                <asp:TextBox ID="txtRemainingShelfLifeEnd" runat="server" style="width: 140px" onkeyup="limitNumRange(this,-maxRemainingShelfLife,maxRemainingShelfLife,false)" class="TextBox" />
            </td>
            <%--<td class="Label3">过期天数
            </td>
            <td class="Field3">
                <asp:TextBox ID="SurplusExpiredDate" runat="server" class="NumericBox50"></asp:TextBox>
            </td>--%>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="SerialNumber" HeaderText="物料条码" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="BalanceQty" HeaderText="重检数量"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CWhName" HeaderText="仓库编码"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CBarCode" HeaderText="库位编码"  HeaderStyle-Width="120px" />
            <asp:BoundField DataField="DateCode" HeaderText="生产日期" HeaderStyle-Width="80px"  />
            <asp:BoundField DataField="ExpiredDate" HeaderText="过期时间" HeaderStyle-Width="80px"  />
            <asp:BoundField DataField="RemainingShelfLife" HeaderText="保质期剩余(天)"  HeaderStyle-Width="80px" />
            <%--<asp:BoundField DataField="SurplusExpiredDate" HeaderText="过期天数(天)"  HeaderStyle-Width="80px" />--%>
            <asp:BoundField DataField="CheckNumber" HeaderText="重检次数" HeaderStyle-Width="50px"  />
            <asp:BoundField DataField="VendorName" HeaderText="供应商名称" HeaderStyle-Width="180px"  />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.Reinspection"
        SelectMethod="GetAllByList" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <%--<input type="hidden" id="hdnOperate" name="hdnOperate" value="" />--%>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var hdnOperate = $("#hdnOperate");
        var maxRemainingShelfLife = 10000 * 10000;
        $(function () {
            isMultiple = true;
        });
            //重检
        function Add() {
            if ($('input[name="chkSelect"]:checked').length <= 0) {
                alert("请选择GRN");
                return;
            }


            var strsql = "";
            var lastCWhName = "";//上一条仓库名称
            debugger;
            for (var i = 0; i < $('input[name="chkSelect"]:checked').length; i++) {
                var _tr = $('input[name="chkSelect"]:checked')[i];
                strsql += $(_tr).parent().parent().find("td:eq(1)").html() + ",";

                //add by zhi.li 20180713
                if (lastCWhName != $(_tr).parent().parent().find("td:eq(4)").html() && lastCWhName != "") {
                    alert("创建重检单勾选的GRN要在同一个仓库");
                    return false;
                }
                lastCWhName = $(_tr).parent().parent().find("td:eq(4)").html();
            }
            console.log(strsql);
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/ExpireDateEdit.aspx?type=insert&GRN=" + strsql;
            dialog({ title: mesLang("超期复检"), src: openWinUrl, width: 400, height: 250 });

        }
            function refresh() {
                document.forms[0].submit();
            }
            function ImportToExcel() {
                hdnOperate.val("exportExcel");
                document.forms[0].submit();
                hdnOperate.val("");
            }

            //限制文本框的数字输入范围
            function limitNumRange(input, min, max, isDecimal) {
                min = min || 0;
                max = max || 100;
                isDecimal = isDecimal || false;
                value = input.value || "";

                //是否支持负数	
                if (min < 0) {
                    //处理负数负号输入
                    if (value == "-") {
                        return;
                    }
                    value = value.replace(/^0\d+/g, '0');
                    value = value.replace(/^-0\d+/g, '-0');
                }
                else {
                    value = value.replace(/-/g, '');
                    value = value.replace(/^0\d+/g, '0');
                }
                //是否支持小数
                if (isDecimal) {
                    //处理小数点开始
                    value = value.replace(/^\..*/g, '');
                    value = value.replace(/^-\..*/g, '-');
                    //处理小数点后的尾数0
                    if (value.indexOf(".") > -1) {
                        value = value.replace(/0+$\./g, '');
                    }
                }
                else {
                    value = value.replace(/\./g, '');
                }
                //移除非数字
                value = value.replace(/[^\d-.]/g, '');
                //处理负号
                if (min < 0) {
                    //移除非起始的负号
                    value = value.replace(/^-/g, "$#$").replace(/-/g, "").replace("$#$", "-")
                }
                //处理小数点
                if (isDecimal) {
                    //移除多余的小数点
                    value = value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".")
                }
                input.value = value;
                //限制范围
                if (!input.value) return;
                var num = parseInt(input.value);
                if (!isNaN(num)) {
                    if (num < min) {
                        input.value = min;
                    }
                    if (num > max) {
                        num = max;
                        input.value = max;
                    }
                }
            }
    </script>
</asp:Content>
