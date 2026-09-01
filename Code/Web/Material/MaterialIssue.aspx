<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialIssue.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialIssue" %>

<asp:Content ID="Content2" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr class="Label1">
            <td align="left">
                <span class="information16"></span>请选择要发料的工单
            </td>
            <td align="right">
                <span class="informationlink"></span><a href="#" onclick="openSplitMaterial();">分料截料</a>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                领料单<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtReuestOrder" class="TextBox" style="width: 250px;
                    height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                <input type="button" id="Button1" class="ButtonBox" value="..." style="height: 27px;
                    font-weight: bold; text-transform: uppercase;" onclick="selectPickingList()" />
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div style="text-align: center;" class="Tips" id="msg">
    </div>
     <%--overflow:scroll;暂时不用滚动条--%>
    <div style="width: 49%; float: left; height:320px;" id="leftApplication">
        <table class="ListTable" width="100%" id="tblRecHistory" style="margin-top: 5px;">
            <tr class="ListTableHeader">
                <th>
                    序号
                </th>
                <th>
                    物料编码
                </th>
                <th>
                    物料描述
                </th>
                <th>
                    申请数量
                </th>
                <th>
                    已发数量
                </th>
                <th>
                    是否先进先出
                </th>
                <th>
                    先进先出推荐
                </th>
            </tr>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="7" style="text-align: center;">
                    暂无数据
                </td>
            </tr>
        </table>
    </div>
    <div style="width: 49%; height: 400px; float: right" id="rightRequest">
        <table style="width: 100%;" class="EditeContentTable">
            <tr>
                <td colspan="2" align="center" style="font-size: larger; font-weight: bolder">
                    <div class="clear5">
                    </div>
                    发料信息
                </td>
            </tr>
            <tr>
                <td class="Label1">
                    发料到
                </td>
                <td class="Field1">
                    <select id="selLocation" style="width: 100px;">
                        <option value="2" selected="selected">产线</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="Label1">
                    扫描GRN条码
                </td>
                <td class="Field1">
                    <input type="text" id="txtGRN" class="TextBox" style="width: 70%; font-size: 16px;
                        font-weight: bold; text-transform: uppercase;" />
                    <input type="button" id="scanSN" class="ButtonBox" value="..." style="font-weight: bold;
                        text-transform: uppercase;" />
                </td>
            </tr>
        </table>
        <div style="text-align: center; margin-top: 1px;" class="Tips" id="showGrn">
        </div>
        <iframe id="iframeGrnList" name="iframeGrnList" style="width: 100%; margin: auto 0px;
            height: 100%" frameborder="0" marginwidth="0" marginheight="0"></iframe>
    </div>
    <script type="text/javascript">
        var requestOrder = 0; //领料单号
        var itemStr = ""; //存储领料单对应的ItemId
        var grnStr = ""; //存储扫描的Grn
        var itemAllQty = 0; //领料单总数量
        var requtestQty = 0;   //已发数量
        var flage = 0; //为true可取消先进先出推荐
        $(function () {
            $("#txtReuestOrder").focus();
            //扫描工单
            $("#txtReuestOrder").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    setPickingList($("#txtReuestOrder").val());
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
            if (grnStr.indexOf(grn) >= 0) {
                $("#showGrn").html("该条码已经扫描完成，不能重复扫描!");
                $("#showGrn").css("color", "red");
                return false;
            }
            //获取GRN返回的itemid
            var ajaxItem = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetItemIdByGrn(grn);
            if (ajaxItem.error == null) {
                var listItem = ajaxItem.value[0];
                if ($("#chktd" + listItem.PartId).is(":checked")) {
                    flage = 0;
                }
                else {
                    flage = 1;
                }

            }
            //校验GRN
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.CheckSendMaterial(itemStr, grn, flage, grnStr);
            if (ajax.error != null) {
                $("#showGrn").html(ajax.error.Message);
                $("#showGrn").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            else {
                var list = ajax.value[0];
                var ctrl = $("#td" + list.PartId);
                /*判断扫描数量总和不能大于申请数量*/
                var appCount = $("#qty" + list.PartId).text(); //申请数量
                var requestCount = $("#td" + list.PartId).text(); //发料数量
                if (parseFloat(parseFloat(ctrl.text()) + list.BalanceQty) > parseFloat(appCount)) {
                    $("#showGrn").html("发料数量不能大于申请数量!");
                    $("#showGrn").css("color", "red");
                    $("#txtGRN").val("");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }
                ctrl.text(parseFloat(ctrl.text()) + list.BalanceQty);
                requtestQty += list.BalanceQty;
                grnStr += grn + ',';
                $("#showGrn").html("扫描完成!");
                $("#showGrn").css("color", "green");
                $("#txtGRN").val("");
                $("#txtGRN").focus();
                $("#txtGRN").select();
            }
        }
        //选择工单
        function selectPickingList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=66&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function getChooseValue(list) {
            requestOrder = list[0][0];
            $("#txtReuestOrder").val(list[0][1]);
            setPickingList($("#txtReuestOrder").val());
        }
        function setPickingList(forNumber) {
            clearWaitGrnTable();
            if (forNumber != "") {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.sendMaterialInfo(forNumber);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                else {
                    var list = ajax.value;
                    var r = "";
                    if (list == null || list.length == 0) {
                        r += "<tr class='ListTableEmptyDataRow'><td colspan='7' ><%=Resources.Messages.NoPickingLine %></td></tr>";
                        $(r).appendTo($("#tblRecHistory"));
                        return false;
                    }
                    if (requestOrder == 0) {
                        requestOrder = list[0].MaterialRequestId;
                    }
                    var itemDesc = "";
                    for (var i = 0; i < list.length; i++) {
                        itemStr += list[i].ItemId + ',';
                        itemAllQty += list[i].RequestQty;
                        itemDesc = list[i].ItemDesc.split(":")[0];
                        r += "<tr class='ListTableOddRow'><td></td>";
                        r += "<td>" + list[i].ItemCode + "</td>";
                        r += "<td>" + itemDesc + "</td>";
                        r += "<td id='qty" + list[i].ItemId + "'>" + list[i].RequestQty + "</td><td  id='td" + list[i].ItemId + "'>" + list[i].ResponseQty + "</td>";
                        r += "<td align='center'><input name='chkSelect' type='checkbox' id ='chktd" + list[i].ItemId + "'  checked ='true' onclick='selectStartSN(this)' /><input type='hidden' value='" + list[i].ItemId + "' style='display:none'/></td>";
                        r += "<td align='center'><a href='#' onclick ='SearchRule(this)'>先进先出</a><input type='hidden' value='" + list[i].ItemId + "' style='display:none'/></td>";
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
                }
            }
        }
        var itemId = -1; //获取选中的ItemId
        function SearchRule(obj) {
            var $obj = $(obj);
            itemId = $obj.next().val();
            $("#iframeGrnList").attr("src","");
            $("#iframeGrnList").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialGrnShow.aspx?ID=" + itemId + "");
        }
        /* 清空指定table中数据 */
        function clearWaitGrnTable() {
            if ($("#tblRecHistory tr").length > 1) {
                $("#tblRecHistory tr:not(:first)").remove();
            }
            $("#iframeGrnList").attr("src", "");
            $("#showGrn").html("");
            itemStr = ""; //存储领料单对应的ItemId
            grnStr = ""; //存储扫描的Grn
            itemAllQty = 0; //领料单总数量
            requtestQty = 0;   //已发数量
        }
        //发料
        function Save() {
            /*选择的是线别仓还是产线*/
            var selLocation = $("#selLocation").val();
            if (requestOrder == 0) {
                alert("请选择领料单!");
                return false;
            }
            if (parseFloat(itemAllQty) == "0") {
                alert("申请数量为0,不能发料!");
                return false;
            }
            if (parseFloat(requtestQty) == "0") {
                alert("发料数量为0,不能发料!");
                return false;
            }
            if (parseFloat(itemAllQty) != parseFloat(requtestQty)) {
                alert("发料数量没有达到申请数量，不能发料");
                return false;
            }
            if (confirm('确定该领料单发料?')) {
                var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SaveSendMaterial(requestOrder, selLocation, grnStr, userName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                else {
                    /*清空数据*/
                    if ($("#tblRecHistory tr").length > 1) {
                        $("#tblRecHistory tr:not(:first)").remove();
                    }
                    alert("发料成功!");
                    $("#iframeGrnList").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialGrnShow.aspx?ID=-1");
                    clearWaitGrnTable();
                    $("#txtReuestOrder").val("");
                    requestOrder = 0;
                    var str = "<tr id='trNewInfo' class='ListTableOddRow'><td colspan='9' style='text-align:center;'>暂无数据</td></tr>";
                    $(str).appendTo($("#tblRecHistory"));
                }
            }
        }
        function openSplitMaterial() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialSplit.aspx?name=Material_MaterialSplit";
            dialog({ title: "分料截料", src: openWinUrl, width: 750, height: 420 });
        }
        //判断是否需要执行先进先出
        function selectStartSN(obj) {
            var $obj = $(obj);
            var itemId = $obj.next().val();
            var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
            // var popedom = 30110301; //取消先进先出
            var popedom = 30110601;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClient.IsPermission(userId, popedom);
            if (ajax.value == true) {
                //可以取消先进先出推荐，不进行判断
                flage = 1;
            }
            else {
                //不可以取消先进先出推荐，需要进行判断
                flage = 0
                $obj.attr("checked", "checked");
                alert("您没有取消先进先出的权限！");
            }
        }
    </script>
</asp:Content>
