<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master"
    CodeBehind="CpPrepare.aspx.cs" Inherits="SKT.LeanMES.Web.Material.CpPrepare" %>

<asp:Content ID="Content2" ContentPlaceHolderID="viewcontent" runat="server">
    <style>
        .focuMrl { /*background: #80fff9 !important;*/ background: yellow; }

        .bg-green { background: green; }
    </style>
    <table width="100%" class="EditeContentTable">

        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label1">领料单<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtReuestOrder" class="TextBox" style="width: 250px; height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" /><input type="button" id="Button1" class="ButtonBox" value="..." style="height: 27px; font-weight: bold; text-transform: uppercase;"
                    onclick="selectPickingList()" />
            </td>
        </tr>
        <tr>
            <td class="Label1">生产投料单
            </td>
            <td class="Field1">
                <label id="woNo">
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
                <th>物料名称
                </th>
                <th>领料申请数量
                </th>
                <th>已备数量
                </th>
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
                        <span>备料信息</span>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="Label1">扫描类型
                </td>
                <td class="Field1">
                    <input id="rdSN" type="radio" class="radio" name="sacntype" value="1" />
                    <span>SN</span>
                    <input id="rdXDSN" type="radio" class="radio" name="sacntype" value="2" />
                    <span>客户SN</span>
                    <input id="rdCon" type="radio" class="radio" name="sacntype" value="3" checked />
                    <span>卡通箱</span>
                    <input id="rdPl" type="radio" class="radio" name="sacntype" value="4" />
                    <span>栈板</span>
                </td>
            </tr>
            <tr id="grntr">
                <td class="Label1">扫描条码
                </td>
                <td class="Field1">
                    <input type="text" id="txtGRN" class="TextBox" style="width: 70%; font-size: 16px; text-transform: uppercase;" />
                </td>
            </tr>
        </table>
        <div style="text-align: center; margin-top: 1px;" class="Tips" id="showGrn">
        </div>
    </div>
    <asp:HiddenField ID="hdFIFO" runat="server" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        var requestOrder = 0; //领料单号
        var itemStr = ""; //存储领料单对应的ItemId
        var grnStr = ""; //存储扫描的Grn
        var itemAllQty = 0; //领料单总数量
        var requtestQty = 0;   //备料数量
        var flage = 0; //为true可取消先进先出推荐
        var requestId = 0;
        var selItemId = "";

        var ItemList = [];
        $(function () {
            //增加自定义备料地点选择   BirongLiang  2017-5-11
            initLocSel();
            $("#txtReuestOrder").focus();
            //扫描领料单
            $("#txtReuestOrder").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($("#txtReuestOrder").val()) != "") {
                        requestOrder = $.trim($("#txtReuestOrder").val());
                        //setPickingList($("#txtReuestOrder").val());
                        //2017-3-17 通过领料单获取待选列表
                        var getList = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetApplyInfo(requestOrder);
                        var dataList = JSON.parse(getList.value);
                        if (dataList.data.length * 1 > 1) {
                            selectPickingList(" and ApplyNo='" + requestOrder + "'");
                        } else {
                            requestId = dataList.data[0].ApplyId;
                            $("#txtReuestOrder").val(requestOrder);
                            $("#woNo").html(dataList.data[0].MOCode);
                            setPickingList(requestId);
                        }

                    }
                }
            });
            /*扫描物料条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    SendMaterial();
                }
            });
            $("#scanSN").bind("click", function () {
                SendMaterial();
            });

            //input 事件焦点设定
            $('input').click(function () {
                this.blur();
                this.focus();
            });

            $("#leftApplication").height($(window).height() - 130);
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
        })
        //扫描GRN
        function SendMaterial() {
            $("#showGrn").html("");
            if ($.trim($("#txtGRN").val()) == "") {
                $("#showGrn").html("物料条码不能为空!");
                $("#showGrn").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            if (requestOrder == 0) {
                $("#showGrn").html("请先选择对应的领料单!");
                $("#showGrn").css("color", "red");
                $("#txtReuestOrder").focus();
                $("#txtReuestOrder").select();
                return false;
            }
            var grn = $.trim($("#txtGRN").val());


            var scanType = $("input[type='radio']:checked").val();
            //校验GRN
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.CheckCPrepareBySN(scanType, grn);
            if (ajax.error != null) {
                $("#showGrn").html(ajax.error.Message);
                $("#showGrn").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            var data = ajax.value;
            //条码是否匹配领料单
            if ($.inArray(data[0].ItemId, ItemList) == -1) {
                alert("条码不在领料单中");
                return false;
            }
            for (var i = 0; i < data.length; i++) {
                if (grnStr.indexOf(data[i].GRN) >= 0) {
                    $("#showGrn").html("该条码已经扫描完成，不能重复扫描!");
                    $("#showGrn").css("color", "red");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }
            }
            var SNQty = 0;//扫描的条码总数
            for (var i = 0; i < data.length; i++) {
                if (grnStr == "") {
                    grnStr += data[i].GRN;
                } else {
                    grnStr += ',' + data[i].GRN;
                }
                SNQty += parseFloat(data[i].BalanceQty);
            }

            var hasqty = parseInt($("#td" + data[0].ItemId).html());
            var needqty = parseInt($("#qty" + data[0].ItemId).html());
            //if ((hasqty + data.length) > needqty)
            if ((hasqty + SNQty) > needqty) {
                $("#msg").html("扫描数量不能大于需求数量!");
                $("#msg").css("color", "red");
                $("#txtGRN").val();
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }

            //$("#td" + data[0].ItemId).html(parseInt($("#td" + data[0].ItemId).html()) + data.length);
            $("#td" + data[0].ItemId).html(parseInt($("#td" + data[0].ItemId).html()) + SNQty);
            var $tr = $("#td" + data[0].ItemId).parent();
            $tr.fadeOut(500).fadeIn(500).css("background-color", "#7CFC00");
            $("#tblRecHistory tbody:gt(0)").prepend($tr);//置顶
            $("#txtGRN").val("");
            $("#txtGRN").focus();
            $("#txtGRN").select();
        }
        //选择领料单
        function selectPickingList(condition) {
            var searchCondition = " Statue in(0, 4) ";
            var plusCondition = typeof condition == 'undefined' ? "" : condition;
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=83&PageCondition="
                    + escape(searchCondition + plusCondition) + "&Multiple=false&CallBackFunc=getChooseValue&rnd=" + Math.random(), width: 700, height: 380
            });
        }
        function getChooseValue(list) {
            requestOrder = list[0][1]; //领料单号
            requestId = list[0][0];
            $("#txtReuestOrder").val(list[0][1]);
            $("#woNo").text(list[0][2]);
            setPickingList(list[0][0]);  //改为用ApplyID，应对一张applyNO有多个工单的情况  2017-3-16 BirongLiang
        }
        //根据投料单获取物料信息
        function setPickingList(applyID) {
            clearWaitGrnTable();
            if (applyID != "" && applyID != "") {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetApplyDtlList($.trim(applyID));
                ItemList = [];
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                else {
                    var list = ajax.value;
                    var r = "";
                    if (list == null || list.length == 0) {
                        r += "<tr class='ListTableEmptyDataRow'><td colspan='7' >此工单暂无数据</td></tr>";
                        $(r).appendTo($("#tblRecHistory"));
                        return false;
                    }
                    for (var i = 0; i < list.length; i++) {
                        requestId = list[0].ApplyId;
                        itemStr += list[i].ItemId + ',';
                        itemAllQty += list[i].ApplyQty; //领料单申请数量
                        if (i % 2 == 0) {
                            r += "<tr class='ListTableOddRow'><td></td>";
                        }
                        else {
                            r += "<tr class='ListTableEvenRow'><td></td>";
                        }
                        r += "<td>" + list[i].ItemCode + "(" + list[i].ItemName + ")" + "</td>";
                        r += "<td id='qty" + list[i].ItemId + "'>" + list[i].ApplyQty + "</td><td  id='td" + list[i].ItemId + "'>" + list[i].StockQty + "</td>";
                        r += "</tr>";
                        ItemList.push(list[i].ItemId);
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
                }
            }
        }
        var itemId = -1; //获取选中的ItemId
        /* 清空指定table中数据 */
        function clearWaitGrnTable() {
            if ($("#tblRecHistory tr").length > 1) {
                $("#tblRecHistory tr:not(:first)").remove();
            }
            $("#showGrn").html("");

            itemStr = ""; //存储领料单对应的ItemId
            grnStr = ""; //存储扫描的Grn
            itemAllQty = 0; //领料单总申请数量
            requtestQty = 0;   //本次备料数量
        }
        var whList = [];
        function Save() {
            /*选择的是线别仓还是产线*/
            var selLocation = $("#selLocation").val();
            var locDesc = $("#selLocation").find("option:selected").text();

            if (requestOrder == 0) {
                alert("请选择领料单!");
                return false;
            }
            //if (parseFloat(itemAllQty) == "0") {
            //    alert("申请数量为0,不能备料!");
            //    return false;
            //}
            //if (parseFloat(requtestQty) == "0") {
            //    alert("备料数量为0,不能备料!");
            //    return false;
            //}
            if (grnStr.length <= 0) {
                alert("备料数量为0,不能备料!");
                return false;
            }
            if (confirm('是否确定该领料单备料?')) {
                var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
                //校验数据是否重复

                var isCF = false;
                $("#tblRecHistory tr:not(:first)").each(function () {

                    var hasqty = 0;
                    var needqty = 0;
                    if ($(this).children("td:eq(2)").html() != undefined)
                        needqty = parseInt($(this).children("td:eq(2)").html());
                    if ( $(this).children("td:eq(3)").html() != undefined)
                        hasqty = parseInt($(this).children("td:eq(3)").html());
                  
                    if (hasqty != 0 && needqty != 0) {
                        if (hasqty > needqty) {
                            isCF = true;
                        }
                    }

                });
                if (isCF) {
                    $("#msg").html("备料数据中存在扫描数量大于需求数量!");
                    $("#msg").css("color", "red");
                    $("#txtGRN").val();
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }

                var materialStorageNo = ""; //备料单号
                var ajaxNo = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetMaterialStorageNo(-10);
                if (ajaxNo.error != null) {
                    alert(ajaxNo.error.Message);
                    return;
                } else {
                    if (ajaxNo.value == "") {
                        alert("备料单号获取失败");
                        return;
                    }
                    materialStorageNo = ajaxNo.value;
                }

                var entity = {};
                entity.RequestId = requestId;
                entity.userName = userName;
                entity.tbDtl = JSON.stringify(whList);

                var model = [];
                var arr = grnStr.split(",");
                for (var i = 0; i < arr.length; i++) {
                    var arrVal = {};
                    arrVal.VAL = arr[i];
                    model.push(arrVal);
                }
                //requestId:领料申请单ID,selLocation:线别仓还是产线,grnStr:GRN集合,entity 无GRN项 备料列表
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.SavePrepareBySN(requestId, JSON.stringify(model), userName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                    //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.SaveMaterialPrepare(materialStorageNo, requestId, selLocation, locDesc, grnStr, userName, JSON.stringify(entity));
                    //if (ajax.error != null) {
                    //    alert(ajax.error.Message);
                    //    return false;
                    //}
                else {
                    /*清空数据*/
                    if ($("#tblRecHistory tr").length > 1) {
                        $("#tblRecHistory tr:not(:first)").remove();
                    }
                    alert("备料成功!");
                    clearWaitGrnTable();
                    $("#txtReuestOrder").val("");
                    $("#woNo").html("");

                    requestOrder = 0;
                    var str = "<tr id='trNewInfo' class='ListTableOddRow'><td colspan='7' style='text-align:center;'>暂无数据</td></tr>";
                    $(str).appendTo($("#tblRecHistory"));
                }
            }
        }
        //分料截料
        //        function openSplitMaterial() {
        //            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialSplit.aspx?name=Material_MaterialSplit";
        //            dialog({ title: "分料截料", src: openWinUrl, width: 750, height: 400 });
        //        }
        //物料选择框事件
        function issueselect(obj) {
            var $obj = $(obj);
            if ($obj.attr("checked") != "checked") {
                //取消选择
                selItemId = "";
                show1();
                return;
            }
            $(".checkboxIssue").each(function () {
                if (this != obj) {
                    $(this).attr("checked", false);
                }
            });
            var itemId = $obj.next().val();
            if ($("#chktd" + itemId).is(':checked')) {
                //有条码
                show1();
            }
            else {
                //无条码
                selItemId = $obj.next().val(); //选择的物料ID
                show2();
            }
            $("#showGrn").html("");
        }
        //GRN条码
        function show1() {
            $("#grntr").show();
            $("#whtr").hide();
            $("#whtrnum").hide();
        }
        //仓库条码
        function show2() {
            $("#whtrnum").show();
            $("#whtr").show();
            $("#txtWHouseNum").val("");
            $("#grntr").hide();
        }

        function initLocSel() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetPrepareLoc();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var dataList = JSON.parse(ajax.value).data;
            var strHtml = '';
            for (var i = 0; i < dataList.length; i++) {
                strHtml += '<option value="' + dataList[i].RID + '">' + dataList[i].PrepareDesc + '</option>';
            }
            $("#selLocation").append(strHtml);

        }
    </script>
</asp:Content>
