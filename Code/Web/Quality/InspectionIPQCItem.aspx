<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="InspectionIPQCItem.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionIPQCItem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table id="tabTmplContent1" class="EditeContentTable" style="width: 100%;">
        <tr>
            <td class="Label1">
                检验结果
            </td>
            <td class="Field1">
                <label style="color: Red">
                    <input id='cbFormOK' type="checkbox" onchange='FinalResult(this)' checked="checked" />合格</label>&nbsp;&nbsp;
                <label style="color: Red">
                    <input id='cbFormNG' type="checkbox" onchange='FinalResult(this)' />不合格</label>
            </td>
        </tr>
        <tr id="trNc" style="display: none;">
            <td class="Label1">
                不良代码
            </td>
            <td class="Field1">
                <select id="selNe">
                </select>
            </td>
        </tr>
        <tr id="idGrn">
            <td class="Label1">
                扫描条码
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtProductSN" class="TextBox" style="width: 250px;
                    height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
            </td>
        </tr>
    </table>
    <br />
    <table id="tbGrnInfo" class="EditeContentTable" style="width: 100%;">
        <tr>
            <td class='Label1' style='text-align: center; width: 12%'>
                时间段
            </td>
            <td class='Label1' style='text-align: center; width: 12%'>
                产品序列号
            </td>
            <td class='Label1' style='text-align: center; width: 12%'>
                工单
            </td>
            <td class='Label1' style='text-align: center; width: 12%'>
                产品编码
            </td>
            <td class='Label1' style='text-align: center; width: 7%'>
                是否合格
            </td>
            <td class='Label1' style='text-align: center; width: 20%'>
                不良检验项目
            </td>
            <td class='Label1' style='text-align: center; width: 7%'>
                操作
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var TempId = '<%=Request.QueryString["TempId"] %>';
        var InsId = '<%=Request.QueryString["InsId"] %>';
        var ShiftType = '<%=Request.QueryString["ShiftType"] %>';//白班或晚班
        var InspectionTemplateId = '<%=Request.QueryString["InspectionTemplateId"] %>';
        var List = [];
        var isGrn = 1;
        $(function () {
            $("#txtProductSN").focus();
            $("#txtProductSN").select();
            /*扫描条码*/
            $("#txtProductSN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($("#txtProductSN").val()) != "") {
                        showDelList();
                        return false;
                    } else {
                        alert("请先扫描条码");
                        $("#txtProductSN").focus();
                        $("#txtProductSN").select();
                        return false;
                    }
                }
            });
            if (InspectionTemplateId > -1) {
                GetNc(TempId);
            }
            else {
                GetIPQCTempNc(TempId);
            }
            getProductSNInfo();
        });

        function FinalResult(t) {
            var cb = $(t).attr('id') == "cbFormOK" ? "cbFormNG" : "cbFormOK";
            $("#" + cb).removeAttr('checked');
            if (cb == "cbFormOK") {
                $("#trNc").show();
            }
            else {
                $("#trNc").hide();
            }
        }

        function GetNc(ParentTempId) {
            var entity = {};
            entity.ParentTempId = ParentTempId;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsGetTemplateItemByParent", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var value = $.parseJSON(ajax.value).data;

            for (var j = 0; j < value.length; j++) {
                $("#selNe").append("<option value='" + value[j].InspectionItemId + "'>" + value[j].InspectionItemName + "</option>");
            }
        }
        function GetIPQCTempNc(ProdIPQCTempId) {
            var entity = {};
            entity.ProdIPQCTempId = ProdIPQCTempId;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsGetProdIPQCTempItem", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var value = $.parseJSON(ajax.value).data;

            for (var j = 0; j < value.length; j++) {
                $("#selNe").append("<option value='" + value[j].ProdIPQCTempId + "'>" + value[j].InspectionItemName + "</option>");
            }
        }
        function getProductSNInfo() {
            var entity = {};
            entity.TempId = TempId;
            entity.InsId = InsId;
            entity.TempType = InspectionTemplateId;
            
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsGetIPQCItemByTemp", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtProductSN").focus();
                $("#txtProductSN").select();
                return;
            }

            var en = $.parseJSON(ajax.value).data;

            //加载信息
            List = en;
            $.grep(List, function (o, j) {
                AddDtl(o);
            });
        }

        //删除行
        function deleteRow(ProductSN, t) {
            var index = -1;
            $.grep(List, function (o, j) {
                if (o.ProductSN == ProductSN) {
                    index = j;
                }
            });
            $(t).parent().parent().remove();
            List.splice(index, 1);
        }

        //根据产品条码取得信息
        function showDelList() {
            var SN = $.trim($("#txtProductSN").val());
            var entity = {};
            entity.SN = SN;
            entity.InsId = InsId;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsGetIPQCItemBySN", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtProductSN").focus();
                $("#txtProductSN").select();
            }
            else {
                var en = $.parseJSON(ajax.value).data[0];
                //是否合格
                if ($("#cbFormOK").is(':checked')) {
                    en.InspectionResult = 1;
                    en.NcCode = '';
                    en.NcName = '';
                }
                else {
                    en.InspectionResult = 0;
                    en.NcCode = $("#selNe").val();
                    en.NcName = $("#selNe").find("option:selected").text();
                }
                en.ShiftValue = getShiftType();
                //添加
                var index = -1;
                $.grep(List, function (o, j) {
                    if (o.ProductSN === SN) {
                        index = j;
                    }
                });
                if (index === -1) {
                    AddDtl(en);
                    List.push(en);
                }
                $("#txtProductSN").val("");
            }
        }

        function AddDtl(e) {
            var tr = "<tr>" +
                        "<td class='Field1' style='text-align: center; width: 14%'>" + getDate(e.ShiftValue) + "</td>" +
                        "<td class='Field1' style='text-align: center; width: 14%'>" + e.ProductSN + "</td>" +
                        "<td class='Field1' style='text-align: center; width: 14%'>" + e.OrderNO + "</td>" +
                        "<td class='Field1' style='text-align: center; width: 14%'>" + e.ItemCode + "</td>";
            if (e.InspectionResult == "1") {
                tr += "<td class='Field1' style='text-align: center; width: 10%'>合格</td>";
            }
            else {
                tr += "<td class='Field1' style='text-align: center; width: 10%'>不合格</td>";
            }
            tr += "<td class='Field1' style='text-align: center; width: 25%'>" + e.NcName + "</td>" +
                        "<td class='Field1' style='text-align:center; width: 7%'>" +
                            "<span style='font-size:15px; color:Red' onclick= 'deleteRow( " +
                            e.ProductSN + ", $(this));' >移除</span>" + "</td></tr>";
            $('#tbGrnInfo').append(tr);
        }

        //保存
        function Save() {
            var ShiftValue = getShiftType();
            if (ShiftValue == 0) {
                alert("当前时间不在该检验单时间范围内");
                return;
            }

            var index = 1;
            var ShiftValue = 0;
            $.grep(List, function (o, j) {
                if (j == 0) {
                    ShiftValue = o.ShiftValue;
                }
                else {
                    if (o.ShiftValue === ShiftValue) {
                        index++;
                    }
                    else {
                        index = 1;
                    }
                }
            });
            if (index > 5) {
                alert("每个时间段扫描数量不能大于5");
                return;
            }

            var entity = {};
            entity.ProductIPQCId = parseInt(InsId);
            entity.TempId = parseInt(TempId);
            entity.userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.ShiftValue = parseInt(ShiftValue);
            entity.TempType = InspectionTemplateId;
            entity.tbDtl = JSON.stringify(List);
            
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSaveProductIPQCSN", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("保存成功");
            parent.Refresh();
        }
        //获取当前班别时间段
        function getShiftType() {
            var result = 0;
            if (ShiftType == "白班") {
                if (setTime("08:30", "09:59")) {
                    result = 1;
                }
                else if (setTime("10:00", "11:59")) {
                    result = 2;
                }
                else if (setTime("12:00", "15:14")) {
                    result = 3;
                }
                else if (setTime("15:15", "17:44")) {
                    result = 4;
                }
                else if (setTime("17:45", "20:30")) {
                    result = 5;
                }
            }
            else {
                if (setTime("20:30", "21:59")) {
                    result = 1;
                }
                else if (setTime("22:00", "23:59")) {
                    result = 2;
                }
                else if (setTime("00:00", "03:14")) {
                    result = 3;
                }
                else if (setTime("03:15", "05:44")) {
                    result = 4;
                }
                else if (setTime("05:45", "08:29")) {
                    result = 5;
                }
            }
            return result;
        }
        //判断当前时间是否属于某一个时间段
        function setTime(beginTime, endTime) {
            var strb = beginTime.split(":");
            if (strb.length != 2)
            { return false; }
            var stre = endTime.split(":");
            if (stre.length != 2) {
                return false;
            }
            var b = new Date();
            var e = new Date();
            var n = new Date();
            b.setHours(strb[0]);
            b.setMinutes(strb[1]);
            e.setHours(stre[0]);
            e.setMinutes(stre[1]);
            if (n.getTime() - b.getTime() > 0 && n.getTime() - e.getTime() < 0) {
                return true;
            }
            else {
                return false;
            }
        }
        //获取当前班别时间段
        function getDate(value) {
            var result = 0;
            if (ShiftType == "白班") {
                if (value == 1) {
                    result = "08:30-09:59";
                }
                else if (value == 2) {
                    result = "10:00-11:59";
                }
                else if (value == 3) {
                    result = "12:00-15:14";
                }
                else if (value == 4) {
                    result = "15:15-17:44";
                }
                else if (value == 5) {
                    result = "17:45-20:30";
                }
            }
            else {
                if (value == 1) {
                    result = "20:30-21:59";
                }
                else if (value == 2) {
                    result = "22:00-23:59";
                }
                else if (value == 3) {
                    result = "00:00-03:14";
                }
                else if (value == 4) {
                    result = "03:15-05:44";
                }
                else if (value == 5) {
                    result = "05:45-08:29";
                }
            }
            return result;
        }
    </script>
</asp:Content>
