<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="ScrapOut.aspx.cs" Inherits="SKT.LeanMES.Web.Scrap.ScrapOut" %>

<asp:Content ID="Content2" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">报废单号<em>*</em>
            </td>
            <td class="Field3">
                <input type="text" value="" id="txtReuestOrder" class="TextBox" style="width: 250px; height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                <input type="button" id="Button1" class="ButtonBox" value="..." style="height: 27px; font-weight: bold; text-transform: uppercase;"
                    onclick="selectPickingList()" />
            </td>

            <td class="Label5">仓库
            </td>
            <td class="Field5">
                <label id="WhName">
                </label>
            </td>
        </tr>

    </table>
    <div class="clear5">
    </div>
    <div style="text-align: center;" class="Tips" id="msg">
    </div>
    <div style="width: 49%; overflow: auto; float: left" id="leftApplication">
        <table class="ListTable" width="100%" id="tblRecHistory">
            <tr class="ListTableHeader">
                <th>序号
                </th>
                 <th>物料编码
                </th>
                <th>物料名称
                </th>
                <th>报废数量
                </th>
                <th>已报废数量
                </th>
               <%-- <th>是否有条码
                </th>--%>
                <%--<th style="width: 50px;">先进先出
                </th>--%>
               <%-- <th>无GRN报废
                </th>--%>
            </tr>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="7" style="text-align: center;"><span>暂无数据</span>
                </td>
            </tr>
        </table>
    </div>
    <div style="width: 49%; float: right" id="rightRequest">
        <table style="width: 100%;" class="EditeContentTable">
            <tr>
                <td colspan="2">
                    <div class="ListTableTitle" style="border: 0px;">
                        <span>报废出库扫描</span>
                    </div>
                </td>
            </tr>
            <%--<tr id="grntr3">
                <td class="Label1">仓库库位条码
                </td>
                <td class="Field1">
                    <input type="text" id="txtGoalPos" class="TextBox" style="width: 70%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                </td>
            </tr>--%>

            <tr id="grntr">
                <td class="Label1">扫描GRN条码
                </td>
                <td class="Field1">
                    <input type="text" id="txtGRN" class="TextBox" style="width: 70%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                    <input type="text" id="txtPosCode" class="TextBox" style="width: 70%; font-size: 16px; font-weight: bold; text-transform: uppercase; display: none;" />
                </td>
            </tr>
    
         <%--   <tr id="whtr3" style="display: none">
                <td class="Label1">仓库库位条码
                </td>
                <td class="Field1">
                    <input type="text" id="txtWHouse" class="TextBox" style="width: 70%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                </td>
            </tr>--%>

            <tr id="trLocCode" style="display: none">
                <td class="Label1">批次号
                </td>
                <td class="Field1">
                    <input type="text" id="txtLotCode" class="TextBox" style="width: 70%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                </td>
            </tr>
            <tr id="whtrnum" style="display: none">
                <td class="Label1">输入报废数量
                </td>
                <td class="Field1">
                    <input type="text" id="txtWHouseNum" class="TextBox" style="width: 70%; font-size: 16px; font-weight: bold; text-transform: uppercase;"  />
                </td>
            </tr>
        </table>
        <div style="text-align: center; margin-top: 1px;" class="Tips" id="showGrn">
        </div>
        <%--<div style="width: 100%; overflow: auto; float: left" id="divGrnList">
            <table class="ListTable" width="100%" id="tableGrnList">
                <tr class="ListTableHeader">
                    <th>GRN条码
                    </th>
                    <th>数量
                    </th>
                    <th>批次号
                    </th>
                    <th>库位
                    </th>

                    <th>入库日期
                    </th>
                    <th>生产日期
                    </th>
                </tr>
                <tr id="tr1" class="ListTableOddRow">
                    <td colspan="6" style="text-align: center;">暂无数据
                    </td>
                </tr>
            </table>
        </div>--%>
    </div>

    <script type="text/javascript">
        var requestOrder = 0; //报废单号
        var whName = 0; //仓库
        var grnStr = ""; //存储扫描的Grn
        var itemAllQty = 0; //领料单总数量
        var requtestQty = 0;   //报废数量
        var flage = 0; //为true可取消先进先出推荐
        var requestId = 0;
        var scrapDtlId = "";
        var WhList = []; //无GRN报废的信息
        var GrnList = []; //有GRN报废信息
        $(function () {
            $("#txtReuestOrder").focus();
            //扫描报废单
            $("#txtReuestOrder").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($("#txtReuestOrder").val()) != "") {
                        requestOrder = $.trim($("#txtReuestOrder").val());
                        setPickingList($.trim($("#txtReuestOrder").val()));
                    }
                }
            });
            /*扫描仓库库位条码*/
            //$("#txtGoalPos").keydown(function () {
            //    var curKey = 0, e = e || window.event;
            //    curKey = e.keyCode || e.which || e.charCode;
            //    if (curKey == 13) {
            //        //验证库位条码是否正确
            //        if (!changeBarCode($.trim($("#txtGoalPos").val()), whName)) {
            //            $("#txtGoalPos").val("");
            //            $("#txtGoalPos").focus();
            //            $("#txtGoalPos").select();
            //            return false;
            //        }
            //        else {
            //            var e = {}, conList = [];
            //            e.name = "cBarCode";
            //            e.value = $.trim($("#txtGoalPos").val());
            //            conList.push(e);

            //            $("#txtGRN").focus();

            //            $("#showGrn").html("调入货位扫描成功");
            //            $("#showGrn").css("color", "green");
            //        }
            //    }
            //});
            /*扫描物料条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    GetPosCode(); //带出库位条码
                }
            });
            /*有GRN报废，扫描库位*/
            $("#txtPosCode").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    SendMaterial();
                }
            });
            /*输入发料数量*/
            $("#txtWHouseNum").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    SendMaterialGRN(false);
                }
            });
            /*批次号*/
            $("#txtLotCode").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#txtWHouseNum").focus();
                }
            });
            /*无GRN报废，扫描调出货位*/
            //$("#txtWHouse").keydown(function () {
            //    var curKey = 0, e = e || window.event;
            //    curKey = e.keyCode || e.which || e.charCode;
            //    if (curKey == 13) {
            //        WhEnter();
            //    }
            //});

            $("#leftApplication").height($(window).height() - 130);
            $("#divGrnList").height($(window).height() - 230);
        });
        function enterToTab()
        { }

        $("form").submit(function (e) {
            if (e && e.preventDefault) {
                e.preventDefault();
            }
            else {
                window.event.returnValue = false;
            }
            return false;
        });
        //验证库位
        function changeBarCode(wh, whName) {
            if (whName == 0) {
                alert("请先选择报废单号!");
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetBarCode2(wh, whName);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var en = $.parseJSON(ajax.value);
            if (!en.BarCode) {
                $("#showGrn").html(whName + "不存在仓库库位条码【" + wh + "】！");
                $("#showGrn").css("color", "red");
                return false;
            }
            else {
                return true;
            }
        }
        //扫描GRN带出库位信息
        function GetPosCode() {
            if (requestOrder == 0) {
                $("#showGrn").html("请先选择对应的报废单!");
                $("#showGrn").css("color", "red");
                $("#txtReuestOrder").focus();
                $("#txtReuestOrder").select();
                return false;
            }
            //if (scrapDtlId == "") {
            //    $("#showGrn").html("请先选择对应的物料明细!");
            //    $("#showGrn").css("color", "red");
            //    return false;
            //}
            //if ($.trim($("#txtGoalPos").val()) == "") {
            //    $("#showGrn").html("调入库位条码不能为空!");
            //    $("#showGrn").css("color", "red");
            //    $("#txtGoalPos").focus();
            //    $("#txtGoalPos").select();
            //    return false;
            //}
            if ($.trim($("#txtGRN").val()) == "") {
                $("#showGrn").html("物料条码不能为空!");
                $("#showGrn").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            var grn = $.trim($("#txtGRN").val());
            if (grnStr.indexOf(grn) >= 0) {
                $("#showGrn").html("该条码已经扫描完成，不能重复扫描!");
                $("#showGrn").css("color", "red");
                return false;
            }
            //校验GRN

           // var scrapDtlId2 = scrapDtlId; //报废单明细ID
            var grn = $.trim($("#txtGRN").val());
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapApply.GetScrapPosCodeByGrn(scrapDtlId2, grn);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapApply.GetScrapPosCodeByGrn(grn);
            if (ajax.error != null) {
                $("#showGrn").html(ajax.error.Message);
                $("#showGrn").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            var list = $.parseJSON(ajax.value);
            $("#txtPosCode").val(list.data[0].BarCode);

            //扫描GRN获取对应的报废明细ID
            if ($("#tblRecHistory tr").length > 1) {
                for (var i = 1; i < $("#tblRecHistory tr").length ; i++) {
                    if ($("#tblRecHistory tr")[i].cells['1'].innerHTML == list.data[0].ItemCode) {
                        scrapDtlId = $("#tblRecHistory tr")[i].cells['1'].id;
                        break;
                    }
                }
            }
            if (scrapDtlId == "") {
                $("#showGrn").html("扫描的GRN不属于报废明细的物料！");
                $("#showGrn").css("color", "red");
                $("#txtPosCode").val("");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }

            SendMaterial()
        }
        //GRN和库位报废
        function SendMaterial() {
            //验证库位条码是否正确
            if ($("#txtPosCode").val() != "") {
                if (!changeBarCode($.trim($("#txtPosCode").val()), whName)) {
                    //$("#showGrn").html("扫描失败，该GRN条码的库位条码不存在或已被删除");
                    $("#showGrn").css("color", "red");
                    $("#txtPosCode").val("");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }
            }
            //验证调入货位是否正确
            //if (!changeBarCode($.trim($("#txtGoalPos").val()), whName)) {
            //    $("#txtGoalPos").val("");
            //    $("#txtGoalPos").focus();
            //    $("#txtGoalPos").select();
            //    return false;
            //}

            //校验GRN
            var scrapId = requestId; //报废单ID
            var grn = $.trim($("#txtGRN").val());
            var grnStr1 = grnStr;
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName %>";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapApply.CheckScrapGrnPosCode(scrapId, grn, grnStr1, userName);

            if (ajax.error != null) {
                $("#showGrn").html(ajax.error.Message);
                $("#showGrn").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            var list = $.parseJSON(ajax.value).data;
            //if (list[0].Flage == 0) {
            //    if (!confirm("您没有遵循先进先出原则，是否确认操作？")) {
            //        $("#txtGRN").focus();
            //        $("#txtGRN").select();
            //        $("#txtGRN").val("");
            //        $("#txtPosCode").val("");
            //        return false;
            //    }
            //}
            //获取GRN或包装箱数量
            var sumQty = 0;
            for (var i = 0; i < list.length; i++) {
                sumQty = parseFloat(sumQty) + parseFloat(list[i].BalanceQty);
            }
            /*判断扫描数量总和不能大于申请数量*/
            var appCount = $("#qty" + scrapDtlId).text(); //申请数量
            var requestCount = $("#td" + scrapDtlId).text(); //已报废数量

            //需要检验数量

            if (parseFloat(parseFloat(requestCount) + parseFloat(sumQty)) > parseFloat(appCount)) {
                $("#showGrn").html("报废数量不能大于申请数量!");
                $("#showGrn").css("color", "red");
                $("#txtGRN").val("");
                $("#txtPosCode").val("");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }

            requtestQty += sumQty; //本次报废数量
            for (var i = 0; i < list.length; i++) {
                //扫描包装箱时，判断包装箱里面的GRN是否已经扫描
                if (grnStr.indexOf(list[i].SerialNumber) >= 0) {

                }
                else {
                    //更新已报废数量
                    var ctrl = $("#td" + scrapDtlId);
                    //ctrl.text((parseFloat(ctrl.text()) + parseFloat(list[i].BalanceQty)).toFixed(6));
                    ctrl.text(parseFloat(parseFloat(ctrl.text()) + parseFloat(list[i].BalanceQty)));
                    grnStr += list[i].SerialNumber + ',';
                    GrnList.push({ ScrapDtlId: scrapDtlId, Grn: list[i].SerialNumber, BarCode: $.trim($("#txtPosCode").val()) });
                    //$("#chktd" + scrapDtlId).attr("checked", true);
                }
            }
            //SearchRule("", scrapDtlId); //刷新先进先出列表
            $("#showGrn").html("【" + grn + "】GRN扫描完成!");
            $("#showGrn").css("color", "green");
            $("#txtGRN").val("");
            $("#txtPosCode").val("");
            $("#txtGRN").focus();
            $("#txtGRN").select();
        }
        //选择报废单
        function selectPickingList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=804&Multiple=false&CallBackFunc=getChooseValue&rnd=" + Math.random(), width: 600, height: 380 });
        }
        function getChooseValue(list) {
            requestId = list[0][0];
            requestOrder = list[0][1]; //报废单号
            whName = list[0][2]; //仓库

            $("#txtReuestOrder").val(list[0][1]);
            $("#WhName").text(list[0][2]);

            setPickingList(list[0][1]);
        }
        //根据报废单获取物料信息
        function setPickingList(forNumber) {
            clearWaitGrnTable();
            if (forNumber != "") {

                var scrapNo = forNumber;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapApply.GetScrapItemByNo(scrapNo);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                else {
                    var list = $.parseJSON(ajax.value).data;
                    var r = "";
                    if (list == null || list.length == 0) {
                        r += "<tr class='ListTableEmptyDataRow'><td colspan='7' >此报废单暂无数据</td></tr>";
                        $(r).appendTo($("#tblRecHistory"));
                        return false;
                    }
                     
                    $("#WhName").text(list[0]["CWhName"]);
                    whName = list[0]["CWhName"];
                    for (var i = 0; i < list.length; i++) {
                        requestId = list[0].ScrapId;
                        itemAllQty += list[i].ApplyQty; //报废单申请数量          
                        if (i % 2 == 0) {
                            r += "<tr class='ListTableOddRow'><td></td>";
                        }
                        else {
                            r += "<tr class='ListTableEvenRow'><td></td>";
                        }
                        r += "<td class='ItemName' id='" + list[i].ScrapDtlId + "'>" + list[i].ItemCode + "</td>";
                        r += "<td>" + list[i].ItemName + "</td>";
                        //r += "<td>" + list[i].ItemCode + "(" + list[i].ItemName + ")" + "</td>";
                        r += "<td class='ApplyQty' id='qty" + list[i].ScrapDtlId + "'>" + list[i].ApplyQty + "</td><td class='ScrapQty'  id='td" + list[i].ScrapDtlId + "'>" + list[i].StockQty + "</td>";
                        //if (list[i].IsGrn == 1) {
                        //    //有条码
                        //    r += "<td align='center'><input type='checkbox' disabled='disabled' id ='chktd" + list[i].ScrapDtlId + "'  checked ='true'/><input type='hidden' value='" + list[i].ScrapDtlId + "' style='display:none'/></td>";
                        //}
                        //else {
                        //    //无条码
                        //    r += "<td align='center'><input type='checkbox' disabled='disabled' id ='chktd" + list[i].ScrapDtlId + "' /><input type='hidden' value='" + list[i].ScrapDtlId + "' style='display:none'/></td>";
                        //}
                        //r += "<td align='center'><a href='#' name='alist' onclick ='SearchRule(this," + list[i].ScrapDtlId + ")'>先进先出</a></td>";
                        //r += "<td align='center'><input type='checkbox' class='checkboxIssue' onclick='issueselect(this)'/><input type='hidden' value='" + list[i].ScrapDtlId + "' style='display:none'/></td>"
                        r += "</tr>";
                    }
                    if ($("#tblRecHistory tr").length == 1) {
                        $("#tblRecHistory tr:eq(0)").after(r);
                    }
                    else {
                        $("#tblRecHistory tr:eq(1)").before(r);
                    }
                    var j = 0;
                    $("#tblRecHistory tr").each(function () {
                        $(this).children("td:eq(0)").html(j.toString());
                        j++;
                    });
                    //$("#txtGoalPos").focus();
                }
            }
        }
        //var itemId = -1; //获取选中的ItemId
        ////先进先出列表显示
        //function SearchRule(obj, dtlId) {
        //    $("#showGrn").html("");
        //    $("#txtWHouseNum").val("");
        //    //$("#txtWHouse").val("");
        //    $("#txtGRN").val("");
        //    $("#txtPosCode").val("");
        //    //清空先进先出列表
        //    if ($("#tableGrnList tr").length > 1) {
        //        $("#tableGrnList tr:not(:first)").remove();
        //    }
        //    var itemId = -1; //获取选中的ItemId
        //    if (obj != "") {
        //        scrapDtlId = dtlId;
        //        var $obj = $(obj);
        //        $("[name='alist']").css("color", "blue");
        //        $("table").find("tr").css('background-color', '	#FFFFFF');
        //        $(obj).css("color", "red");
        //        $(obj).parent().parent().css('background-color', '#00FFFF');
        //    }

        //    var scrapDtlId1 = dtlId;
        //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapApply.GetScrapGRN(scrapDtlId1);
        //    if (ajax.error != null) {
        //        alert(ajax.error.Message);
        //        return false;
        //    }
        //    var en = $.parseJSON(ajax.value);
        //    var GrnList = en.data;
        //    var r = "";
        //    if (GrnList == null || GrnList.length == 0) {
        //        r += "<tr class='ListTableEmptyDataRow'><td colspan='6' >暂无数据</td></tr>";
        //        $(r).appendTo($("#tableGrnList"));
        //        show1();
        //        return false;
        //    }
        //    for (var i = 0; i < GrnList.length; i++) {
        //        if (grnStr.indexOf(GrnList[i].GRN) >= 0) {
        //        }
        //        else {
        //            //判断是否为F开头的仓库
        //            var cBarCode = GrnList[i].cBarCode; //库位
        //            if (cBarCode.length > 1) {
        //                if (cBarCode.substr(0, 1).toUpperCase() == 'F') {
        //                    r += "<tr  style='background-color:Red;'>";
        //                }
        //                else {
        //                    r += "<tr class='ListTableEvenRow'>";
        //                }
        //            }
        //            else {
        //                r += "<tr class='ListTableEvenRow'>";
        //            }

        //            var dateCode = "";
        //            var storageDate = "";
        //            if (GrnList[i].DateCode.split(" ")[0] == "1900/1/1") {
        //                dateCode = "";
        //            }
        //            else {
        //                dateCode = GrnList[i].DateCode.split(" ")[0];
        //            }

        //            if (GrnList[i].StorageDate.split(" ")[0] == "1900/1/1") {
        //                storageDate = "";
        //            }
        //            else {
        //                storageDate = GrnList[i].StorageDate.split(" ")[0];
        //            }

        //            r += "<td>" + GrnList[i].GRN + "</td><td>" + GrnList[i].StorageQty + "</td><td>" + GrnList[i].LotCode + "</td><td>" + GrnList[i].cBarCode + "</td><td>" + storageDate + "</td><td>" + dateCode + "</td>";
        //            r += "</tr>";
        //        }
        //    }
        //    $("#tableGrnList tr:eq(0)").after(r);
        //    $(".checkboxIssue").each(function () {
        //        if (this != obj) {
        //            $(this).attr("checked", false);
        //        }
        //    });
        //    show1();
        //    //GetScrapSaleWarehouse(1);
        //}
        /* 清空指定table中数据 */
        function clearWaitGrnTable() {
            //清空物料明细数据
            if ($("#tblRecHistory tr").length > 1) {
                $("#tblRecHistory tr:not(:first)").remove();
            }
            //清空先进先出列表
            if ($("#tableGrnList tr").length > 1) {
                $("#tableGrnList tr:not(:first)").remove();
            }
            $("#showGrn").html("");
            WhList = []; //清空无GRN报废的信息
            GrnList = []; //清空有GRN报废的信息
            grnStr = ""; //存储扫描的Grn
            itemAllQty = 0; //领料单总申请数量
            requtestQty = 0;   //本次报废数量
            $("#txtWHouseNum").val("");
            $("#txtLotCode").val("");
           // $("#txtWHouse").val("");
            $("#txtWHouse").val("");

            $("#txtGRN").val("");
            $("#txtPosCode").val("");
            //$("#txtGoalPos").val("");
            scrapDtlId = "";
            $("#msg").html("");
        }
        //扫描仓库库位条码
        //function WhEnter() {
        //    if (requestOrder == "") {
        //        $("#showGrn").html("请先选择对应的报废单");
        //        $("#showGrn").css("color", "red");
        //        $("#txtReuestOrder").focus();
        //        $("#txtReuestOrder").select();
        //        return false;
        //    }
   
        //    if ($.trim($("#txtWHouse").val()) == "") {
        //        $("#showGrn").html("仓库库位条码不可为空!");
        //        $("#showGrn").css("color", "red");
        //        $("#txtWHouse").focus();
        //        return false;
        //    }
        //    //检验库位条码是否正确
        //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetBarCode($.trim($("#txtWHouse").val()));
        //    if (ajax.error != null) {
        //        alert(ajax.error.Message);
        //        return;
        //    }
        //    var en = $.parseJSON(ajax.value);
        //    if (!en.BarCode) {
        //        $("#showGrn").html("仓库库位条码不存在!");
        //        $("#showGrn").css("color", "red");
        //        $("#txtWHouse").focus();
        //        $("#txtWHouse").val("");
        //        return;
        //    }
        //    else {
        //        $("#showGrn").html("仓库库位条码扫描成功!");
        //        $("#showGrn").css("color", "green");
        //    }
        //}
        //输入报废数量
        function SendMaterialGRN() {
            if (requestOrder == "") {
                $("#showGrn").html("请先选择对应的报废单");
                $("#showGrn").css("color", "red");
                $("#txtReuestOrder").focus();
                $("#txtReuestOrder").select();
                return false;
            }
   
           // var txtWHouse = $.trim($("#txtWHouse").val()); //仓库库位条码
            var txtWHouseNum = $.trim($("#txtWHouseNum").val()); //数量
            var txtLotCode = $.trim($("#txtLotCode").val()); //批次号

            if (scrapDtlId == "") {
                $("#showGrn").html("无GRN发料，需要选择对应的物料!");
                $("#showGrn").css("color", "red");
                return false;
            }
     
            //if (txtWHouse == "") {
            //    $("#showGrn").html("仓库库位条码不可为空");
            //    $("#showGrn").css("color", "red");
            //    $("#txtWHouse").focus();
            //    return false;
            //}
            if (txtLotCode == "") {
                $("#showGrn").html("批次号不可为空");
                $("#showGrn").css("color", "red");
                $("#txtLotCode").focus();
                return false;
            }



            //验证仓库库位条码是否正确
            //if (!changeBarCode($.trim($("#txtWHouse").val()), whName)) {
            //    $("#txtWHouse").val("");
            //    $("#txtWHouse").focus();
            //    $("#txtWHouse").select();
            //    return false;
            //}

            var type = "^[0-9]*[1-9][0-9]*$";
            var re = new RegExp(type);

            if ($.trim(txtWHouseNum) == "") {
                $("#showGrn").html("报废数量不可为空");
                $("#showGrn").css("color", "red");
                $("#txtWHouseNum").focus();
                return false;
            }
            if (isNaN(txtWHouseNum) || txtWHouseNum<0) {
                $("#txtWHouseNum").focus();
                $("#showGrn").html("请输入大于0的数字!");
                return false;
            }
            var ctrl = $("#td" + scrapDtlId);
            /*判断扫描数量总和不能大于申请数量*/
            var appCount = $("#qty" + scrapDtlId).text(); //申请数量
            var requestCount = $("#td" + scrapDtlId).text(); //已报废数量

            //需要检验数量

            if (parseFloat(parseFloat(requestCount) + parseFloat(txtWHouseNum)) > parseFloat(appCount)) {
                $("#txtWHouseNum").focus();
                $("#showGrn").html("报废数量不能大于申请数量!");
                $("#showGrn").css("color", "red");
                return false;
            }

            requtestQty += parseFloat(txtWHouseNum);
            ctrl.text(parseFloat(ctrl.text()) + parseFloat(txtWHouseNum)); //更新已报废数量
            WhList.push({ ScrapDtlId: scrapDtlId, WHouse: '', WHouseOut: '', WHouseNum: txtWHouseNum, LotCode: txtLotCode });
            //WhList.push({ ScrapDtlId: scrapDtlId , WHouseNum: txtWHouseNum, LotCode: txtLotCode });
            $("#showGrn").html("扫描完成!");
            $("#showGrn").css("color", "green");
            $("#txtWHouseNum").val("");
            $("#txtWHouseNum").focus();
            $("#txtWHouseNum").select();
        }
        function Save() {
            if (requestOrder == 0) {
                alert("请先选择报废单号!");
                return false;
            }
            if (parseFloat(itemAllQty) == "0" ) {
                alert("申请数量为0,不能报废!");
                return false;
            }
            if (parseFloat(requtestQty) == "0") {
                alert("本次报废数量为0,不能报废!");
                return false;
            }

            /*报废数量等于已报废数量才能保存*/
            var SaveFlag = true;
            $("#tblRecHistory tr:not(.ListTableHeader)").each(function () {
                var itemCode = $(this).find("td.ItemName").text(); //物料编码
                var applyQty = parseFloat($(this).find("td.ApplyQty").text()); //申请数量
                var stockQty = parseFloat($(this).find("td.ScrapQty").text()); //已报废数量
                if (applyQty != 0 ) {
                    if (applyQty != stockQty) {
                        alert("物料【" + itemCode + "】报废数量必须等于申请数量才能保存!");
                        SaveFlag = false;
                        return false;
                    }
                }
            });

            if (!SaveFlag) {
                return false;
            }

            if (confirm('是否确定报废?')) {
                //保存记录
                var entity = {};
                entity.ScrapId = requestId;
                entity.UserName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
                entity.EmployeeCName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName %>";
                entity.GrnList = JSON.stringify(GrnList);
                entity.WhList = JSON.stringify(WhList);
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxScrapApply.SaveScrap(JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                } else {
                    alert("报废成功");
                }
                clearWaitGrnTable();
                setPickingList($.trim($("#txtReuestOrder").val())); //根据领料单号重新刷新页面
            }
        }
        //物料选择框事件
        function issueselect(obj) {
            var $obj = $(obj);
            if ($obj.attr("checked") != "checked") {
                //取消选择
                scrapDtlId = "";
                show1();
                // GetScrapSaleWarehouse(1);
                return;
            }
            $(".checkboxIssue").each(function () {
                if (this != obj) {
                    $(this).attr("checked", false);
                }
            });
            //勾选了以后就是无GRN入库
            scrapDtlId = $obj.next().val(); //选择的报废单明细ID
            show2();
            $("[name='alist']").css("color", "blue");
            $("#showGrn").html("");
        }

        //GRN条码
        function show1() {
            $("#grntr").show();
            $("#grntr2").show();
            $("#grntr3").show();
            $("#whtr").hide();
            $("#whtr2").hide();
            $("#whtr3").hide();
            $("#whtrnum").hide();
            $("#trLocCode").hide();
            $("#divGrnList").show(); //先进先出列表
            //$("#txtGoalPos").focus();
            //$("#txtGoalPos").select();
        }
        //仓库条码
        function show2() {
            $("#whtrnum").show();
            $("#trLocCode").show();
            $("#whtr").show();
            $("#whtr2").show();
            $("#whtr3").show();
            $("#txtWHouseNum").val("");
            $("#txtLotCode").val("");
            $("#grntr").hide();
            $("#grntr2").hide();
            $("#grntr3").hide();
            $("#divGrnList").hide(); //隐藏先进先出列表
            //$("#txtWHouse").focus();
            //$("#txtWHouse").select();
        }
    </script>

</asp:Content>
