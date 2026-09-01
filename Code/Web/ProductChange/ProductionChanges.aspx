<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="ProductionChanges.aspx.cs" Inherits="SKT.LeanMES.Web.ProductChange.ProductionChanges" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips" style="height: 24px; line-height: 24px;">
        <span>请选择生产工单</span>
    </div>
    <table class="EditeContentTable" id="tbSearchContent" width="100%">
        <tr>
            <td class="Label2">序列号
            </td>
            <td class="Field2">
                <input type="text" id="txtSerialNumber" class="TextBox" /><input type="button" id="btnTurnNo"
                    class="ButtonBox" style="width: 45px; line-height: 20px;" value="查询" title="查询-序列号"
                    onclick="selectTurnNo();" />
            </td>
            <td class="Label2">生产工单
            </td>
            <td class="Field2">
                <input type="text" id="txtFormNo" class="TextBox" readonly="readonly" /><input type="button" id="btnFormNo"
                    class="ButtonBox" value="..." title="Select" onclick="selectFormNo(1);" />
                <asp:HiddenField ID="hdnWoId" runat="server" Value="" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">包装箱号/栈板号
            </td>
            <td class="Field2">
                <input type="text" id="txtPackNo" class="TextBox" /><input type="button" id="Button2" class="ButtonBox" style="width: 45px; line-height: 20px;"
                    value="查询" title="查询-包装箱号/栈板号" onclick="getSNInfoByPackSN()" />
            </td>

            <td class="Label2">进入时间
            </td>
            <td class="Field2">
                <div style="float: left; margin-right: 5px;">
                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="DateTimeBox" ReadOnly="true"
                        IsRequired='1'></asp:TextBox>
                    -
                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="DateTimeBox" ReadOnly="true"
                        IsRequired='1'></asp:TextBox>
                </div>
                &nbsp;<input type="button" id="Button1" class="ButtonBox" style="width: 45px; border-left-width: 1px; border-top-left-radius: 4px; border-bottom-left-radius: 4px; line-height: 20px;"
                    value="查询" title="Search" onclick="selectDate();" />
            </td>

        </tr>
        <tr>

            <td class="Label2"></td>
            <td class="Field2"></td>
            <td class="Label2">工位
            </td>
            <td class="Field2">
                <select id="GetRouterStaionId">
                    <option value="-1">暂无</option>
                </select>
            </td>
        </tr>
    </table>
    <div class="infoTips" style="height: 24px; line-height: 24px;">
        <%=Resources.Messages.WithAsteriskIsRequired %><span>请选择下面的条件进行变更</span>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">新生产工单
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtNewFormNo" runat="server" ReadOnly="true" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnNewFormNo" class="ButtonBox" value="..." title="Select"
                    onclick="selectFormNo(2);" />
                <asp:HiddenField ID="hdnNewWoId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">新产品编码
            </td>
            <td class="Field2">
                <asp:Label ID="lblNewProduct" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">新工艺路线<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRouter" runat="server" IsRequired="1" ReadOnly="true" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnRouter" class="ButtonBox" value="..." title="Select" onclick="selectRouter();" />
                <asp:HiddenField ID="hdnRouterID" runat="server" Value="-1" ClientIDMode="Static" />
                <input type="checkbox" id="chkIsUnAss" /><span>组装打散</span>&nbsp;<input type="checkbox" id="chkIsUnCustomerSN" /><span>客户条码打散</span>
                &nbsp;<input type="checkbox" id="chkIsUnAgeing" /><span>老化打散</span>
            </td>
            <td class="Label2">起始工序<em>*</em>
            </td>
            <td class="Field2">
                <select id="ddlStation">
                    <option value="-1">暂无</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="Label2">备注
            </td>
            <td class="Field2" colspan="3">
                <input id="remark" style="width: 420px; height: 30px; border-radius: 3px; border: 1px solid #ccc;" />
            </td>
        </tr>
    </table>
    <div id="divShowFail" style="width: 100%; height: 265px; overflow-x: hidden; overflow-y: auto; display: block; word-break: break-all; word-wrap: break-word;">
        <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
            class="ListTable">
            <tr class="ListTableHeader">
                <th scope="col" style="width: 2%;">
                    <input type="checkbox" name="chkAll" id="chkAll" onclick="checkAllNew(this.checked);" />
                </th>
                <th scope="col" style="width: 3%;">序号
                </th>
                <th scope="col">序列号
                </th>
                <th scope="col" style="width: 10%;">工单号码
                </th>
                <th scope="col" style="width: 15%;">产品编码
                </th>
                <th scope="col" style="width: 8%;">当前工序
                </th>
                <th scope="col" style="width: 20%;">进入时间
                </th>
                <th scope="col" style="width: 20%;">离开时间
                </th>
            </tr>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="8" style="text-align: center;"><span>暂无数据</span>
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        var chooseFlag = 0;
        var SearchStyle = 0;
        var SearchCondition = "";
        var isFirstSearch = 0; //是否第一次查询
        var saveFirstSN = ""; //保存第一次扫描的SN
        var selectStationId = -1;
        var flag = 0; //1、SN 2、工单

        $(document).ready(function () {
            $("#<%=this.txtStartDate.ClientID %>").val(GetDateStr(-30));
            $("#<%=this.txtEndDate.ClientID %>").val(GetDateStr(0));


            
            $("#txtSerialNumber").bind('input propertychange', function () {
                $(this).val($(this).val().trim());

            });
            $("#txtPackNo").bind('input propertychange', function () {
                $(this).val($(this).val().trim());

            });

            $("#txtSerialNumber").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($("#txtSerialNumber").val() == "") {
                        alert("序列号不能为空");
                        $("#txtSerialNumber").focus()
                        return;
                    }
                    getProcessFormByTurnDataId($("#txtSerialNumber").val(), 1);
                    return false;
                }
            });

            $("#txtFormNo").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;

                if (curKey == 13) {
                    if ($("#txtFormNo").val() == "") {
                        alert("工单号不能为空!");
                    }
                    getProcessFormByTurnDataId($("#txtFormNo").val(), 2);
                    return false;
                }
            });

            $("#txtPackNo").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;

                if (curKey == 13) {
                    getSNInfoByPackSN();
                    return false;
                }
            });

            //下拉框查询根据工序查询
            $("#GetRouterStaionId").bind("change", function () {
                selectStationId = $("#GetRouterStaionId").val();
                //根据工位查询
                var orderSN = $("#txtFormNo").val();
                showProductSNInfo(orderSN, 2, "", selectStationId);
            });
        });

        function selectDate() {
            selectStationId = $("#GetRouterStaionId").val();
            if (flag == 2) {
                //根据工位查询
                var orderSN = $("#txtFormNo").val();
                showProductSNInfo(orderSN, 2, "", selectStationId);
            }
        }

        /**
        *   根据包装号查询SN信息
        **/
        function getSNInfoByPackSN() {
            var packNo = $.trim($("#txtPackNo").val());
            if (packNo == "") {
                alert("包装箱号/栈板号不能为空!");
                $("#txtPackNo").focus();
                return false;
            }
            showProductSNInfo(packNo, 3, "", -1);
            $("#txtPackNo").val('').focus();
        }

        /**
        *保存产品变更信息
        **/
        function Save() {
            var idStr = getSelectedValuesNew();
            if (idStr == "") {
                alert("请选择记录!");
                return false;
            }
          
            //获取流程单id
            var orderId = $("#<%=this.hdnNewWoId.ClientID %>").val();
            var itemId = -1;
            var routerId = $("#<%=this.hdnRouterID.ClientID %>").val();
            var stationId = $("#ddlStation").val(); //
            var chkIsUnAss = $("#chkIsUnAss").prop("checked") == true ? 1 : 0;
            var chkIsUnCustomerSN = $("#chkIsUnCustomerSN").prop("checked") == true ? 1 : 0;
            var chkIsUnAgeing = $("#chkIsUnAgeing").prop("checked") == true ? 1 : 0;//Zhuchenglong 2017-11-07 添加老化打散功能
            var remark = $("#remark").val();
            if (orderId == -1 && routerId == -1 && stationId == -1) {
                alert("请选择需要变更的条件!");
                return false;
            }
            var startProcedure = $('#ddlStation').val();
            if (-1 == startProcedure) {
                alert('请选择起始工序');
                $('#ddlStation').focus();
                return;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.SaveProductionChange(routerId, stationId, idStr, chkIsUnAss, chkIsUnCustomerSN, chkIsUnAgeing, remark, orderId, itemId);
            if (ajax.error == null) {
                //移除相关的数据
                alert("数据保存成功!");
                $(':checkbox[name=chkSelect]').each(function () {
                    if ($(this).attr('checked')) {
                        $(this).closest('tr').remove();
                    }
                });
            }
            else {
                alert(ajax.error.Message);
                return false;
            }
            $(".ListTable :checkbox").attr("checked", false);
            clearSaveAfter(1);
            clearTable();
            $("#remark").val("");
            $("#txtSerialNumber").focus();
        }

     <%--   function showProductSNInfo(SearchString, flage, saveFirstSN, selectStationId) {
            var startDate = $("#<%=this.txtStartDate.ClientID %>").val();
            var endDate = $("#<%=this.txtEndDate.ClientID %>").val();
            //加载显示序列号信息
            var ajaxTurn = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetTurnNoInfoBySearch(SearchString, flage, saveFirstSN, selectStationId, startDate.todate(), endDate.todate());
            if (ajaxTurn.error == null) {
                var list = ajaxTurn.value;
                //每一次重新加载，把之前的数据都清空
                if (flage == 2 || flage == 3) {
                    clearTable();
                    isFirstSearch = 0;
                }
                else if (flage == 1 && isFirstSearch == 0) {
                    clearTable();
                    isFirstSearch = isFirstSearch + 1;
                    saveFirstSN = SearchString; //保存第一次SN
                }
                //for (var i = 0; i < list.length; i++) {
                //    addDetail(list[i]);
                //}
                //优化产品变更：

                $("#trNewInfo").remove();
                var html = "";
                for (var i = 0; i < list.length; i++) {
                    html += "<tr  class='ListTableOddRow'><td><input type=\"checkbox\"  class =\"checkSelect\"  name=\"chkSelect\" value=\"" + list[i].SerialNumber + "\"  /></td>"
                    html += "<td>" + (i + 1) + "</td><td>" + list[i].SerialNumber + "</td><td>" + list[i].OrderNo + "</td><td>" + list[i].ItemCode + "</td><td>" + list[i].Station + "</td>";
                    html += "<td>" + list[i].CreateTime.toLocaleDateString() + " " + list[i].CreateTime.toLocaleTimeString() + "</td>";
                    html += "<td>" + list[i].LastUpdate.toLocaleDateString() + " " + list[i].LastUpdate.toLocaleTimeString() + "</td></tr>";

                }
                //document.getElementById("tblExpand").innerHTML = html;
                $("#tblExpand").append(html);
            } else {
                alert(ajaxTurn.error.Message);
                isFirstSearch = isFirstSearch + 1;
                return false;
            }
        }--%>
        /*1.序列号*/
        function selectTurnNo() {
            if ($("#txtSerialNumber").val() == "") {
                alert("序列号不能为空");
                return;
            }

            clearSaveAfter();

            getProcessFormByTurnDataId($("#txtSerialNumber").val(), 1); //通过序列号找到对应的序列号信息


        }

        /*2.工单列表*/
        function selectFormNo(flage) {
            if (flage == 1) {
                chooseFlag = 2;
                SearchCondition = " Status in (1) ";
            }
            else if (flage == 2) {
                chooseFlag = 3;
                SearchCondition = " Status in (1) ";
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&SearchCondition=" + SearchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 420 });
        }

        //产品列表
        function selectItem() {
            chooseFlag = 4;
            SearchCondition = ""; //"  ItemType in (2,3) ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&SearchCondition=" + SearchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 420 });
        }

        //路由列表
        function selectRouter() {
            chooseFlag = 5;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=22&Multiple=false&rnd=" + Math.random(), width: 650, height: 420 });
        }


        function clearSaveAfter(isSsve) {
            var orderId = $("#<%=this.hdnNewWoId.ClientID %>").val();
            var routerId = $("#<%=this.hdnRouterID.ClientID %>").val();

            if (isSsve == 1) {
                $("#<%=this.txtNewFormNo.ClientID %>").val("");
                $("#<%=this.hdnNewWoId.ClientID %>").val("-1");
                $("#chkIsUnCustomerSN").prop("checked", false);
                $("#chkIsUnAss").prop("checked", false);
                $("#lblNewProduct").text('');
                $("#ddlStation").empty().append("<option value='-1'>暂无</option>");
            }
            if (orderId == -1 || isSsve == 1) {
                $("#<%=this.hdnRouterID.ClientID %>").val("-1");
                $("#<%=this.txtRouter.ClientID %>").val('');
            }
            $("#txtFormNo").val('');
            $("#<%=this.hdnWoId.ClientID %>").val(-1);
            $("#GetRouterStaionId").empty().append("<option value='-1'>暂无</option>");
        }

        function getStationByRouterName(RouterName, selectName) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetStationByRouterName(RouterName);

            if (ajax.error == null) {
                var list = ajax.value;
                //每一次重新加载，把之前的数据都清空
                $("#" + selectName + "").find("option").remove();
                if (list[0] == null) {
                    $("#" + selectName + "").append("<option value='-1'>暂无</option>");
                } else {

                    $("#" + selectName + "").append("<option value='-1'>--全部--</option><option value='-10'>开始</option>");
                    for (var i = 0; i < list.length; i++) {
                        $("#" + selectName + "").append("<option value=" + list[i].StationId + ">" + list[i].Station + "</option>");
                    }
                    if (selectName != "ddlStation") {
                        $("#" + selectName + "").append("<option value='-20'>结束</option>");
                    }
                }
            } else {
                //$("#" + selectName + "").append("<option value='-1'>暂无</option>");
            }
        }

        function clearTurnDataInfo() {
            clearTable();
        }

        var orderReturnRouterName = "";
        function getProcessFormByTurnDataId(SearchString, flage) {
            //扫描序号时查询是否存在重复的序号。
            var isExsit = false;
            var orderId = $("#<%=this.hdnNewWoId.ClientID %>").val();
            var routerId = $("#<%=this.hdnRouterID.ClientID %>").val();

            if (flage == 1 && isFirstSearch != 0) {
                $("#tblExpand tbody tr").find("td:eq(2)").each(
                function (index, item) {
                    if (SearchString == $(this).text()) {
                        isExsit = true;
                        return;
                    }
                });
            }
            if (isExsit) {
                alert("扫描的序列号已在列表中存在！");
                $("#txtSerialNumber").val("").focus();
                return false;
            }
            flag = flage;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetProcessFormBySearch(SearchString, flage);
            if (ajax.error == null) {
                var list = ajax.value;
                if (list != null) {
                    //找到对应的路由
                    if (orderId == -1 && routerId == -1) {
                        orderReturnRouterName = list.RouterName;
                        $("#<%=this.txtRouter.ClientID %>").val(list.RouterName);
                        $("#<%=this.hdnRouterID.ClientID %>").val(list.RouterId);
                        getStationByRouterName(list.RouterName, "ddlStation");
                    }
                }
                else {
                    clearTurnDataInfo();
                }
            }
            else {
                alert(ajax.error.Message);
                $("#txtSerialNumber").val("").focus();
                //clearTurnDataInfo();
                return false;
            }
            //加载显示序列号信息
            showProductSNInfo(SearchString, flage, saveFirstSN, selectStationId);
            $("#txtSerialNumber").val("").focus();

        }

        //绑定选择类型值
        function getChooseValue(list) {
            if (chooseFlag == 2) {
                clearSaveAfter();
                $("#txtFormNo").val(list[0][1]);
                if (list[0][0] != "-1") {
                    $("#<%=this.hdnWoId.ClientID %>").val(list[0][0]);
                    getProcessFormByTurnDataId(list[0][1], 2); //通过工单号找到对应的信息
                    /*add  by  weixia on 2016.4.8 根据工单带出工位信息*/
                    getStationByRouterName(orderReturnRouterName, "GetRouterStaionId");

                }
                /**/
            }
            if (chooseFlag == 3) {
                $("#<%=this.txtNewFormNo.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnNewWoId.ClientID %>").val(list[0][0]);
                //根据工单号带出对应的产品，路由，工序信息

                if (list[0][0] != "-1") {
                    getRouterByOrderId(list[0][0]);
                }
            }
            if (chooseFlag == 4) {
                $("#<%=this.lblNewProduct.ClientID %>").text(list[0][1]);
            }
            if (chooseFlag == 5) {
                $("#<%=this.txtRouter.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnRouterID.ClientID %>").val(list[0][0]);
                getStationByRouterName(list[0][1], "ddlStation");
            }
        }

        function getRouterByOrderId(orderId) {
            var ajaxOrder = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.GetInfo(orderId);
            if (ajaxOrder.error == null) {
                var orderEntity = ajaxOrder.value;
                $("#<%=this.lblNewProduct.ClientID %>").text(orderEntity.ItemCode);
                $("#<%=this.txtRouter.ClientID %>").val(orderEntity.RouterName);
                $("#<%=this.hdnRouterID.ClientID %>").val(orderEntity.RouterId);
                getStationByRouterName(orderEntity.RouterName, "ddlStation");
            } else {
                alert(ajaxOrder.error.Message);
                return false;
            }
        }

        var tab = document.getElementById("tblExpand");

        function addDetail(entity) {
            if (entity == null) {
                $("#trNewInfo").innerHTML = "暂无数据!";
            }
            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"checkbox\"  class =\"checkSelect\"  name=\"chkSelect\" value=\"" + entity.SerialNumber + "\"  />"; //添加全新按钮

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = (rowNewIdx);

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.SerialNumber;

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.OrderNo;

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ItemCode;

            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.Station;

            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.CreateTime.toLocaleDateString() + " " + entity.CreateTime.toLocaleTimeString();

            cell = row.insertCell(7);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.LastUpdate.toLocaleDateString() + " " + entity.LastUpdate.toLocaleTimeString();
        }

        /*全选*/
        function checkAllNew(checked) {
            if (checked) {
                $(".ListTable :checkbox").attr("checked", true);
            }
            else {
                $(".ListTable :checkbox").attr("checked", false);
                var $row = $(".ListTable :checkbox").parent().parent();
                for (var i = 1; i < $row.length; i++) {
                    $($row[i]).removeClass("ListTableSelectedRow");
                    $($row[i]).addClass(($row[i].rowIndex % 2 == 1) ? "ListTableOddRow" : "ListTableEvenRow");
                }
            }
        }

        function clearTable() {
            $("#tblExpand tr:not(:first)").each(function () {
                $(this).remove();
            });
            var leftStr = "<tr id='trNewInfo' class='ListTableOddRow'><td colspan='8' style='text-align:center;'>暂无数据</td></tr>";
            $(leftStr).appendTo($("#tblExpand"));
            ChangeListData = [];
        }

        //强制变更
        function ForceChange() {
            var idStr = getSelectedValuesNew();
            if (idStr == "") {
                alert("请选择记录!");
                return false;
            }
            //获取流程单id
            var stationId = $("#ddlStation").val(); //变更工序
            if (stationId == -1) {
                alert("请选择需要变更的条件!");
                return false;
            }
            var startProcedure = $('#ddlStation').val();
            if (-1 == startProcedure) {
                alert('请选择起始工序');
                $('#ddlStation').focus();
                return;
            }
            var chkIsUnAss = $("#chkIsUnAss").prop("checked") == true ? 1 : 0;
            var chkIsUnCustomerSN = $("#chkIsUnCustomerSN").prop("checked") == true ? 1 : 0;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.SaveForceChange(idStr, stationId, chkIsUnAss, chkIsUnCustomerSN);
            if (ajax.error == null) {
                //移除相关的数据
                alert("数据保存成功!");
                $(':checkbox[name=chkSelect]').each(function () {
                    if ($(this).attr('checked')) {
                        $(this).closest('tr').remove();
                    }
                });
            }
            else {
                alert(ajax.error.Message);
                return false;
            }
            $(".ListTable :checkbox").attr("checked", false);
            clearSaveAfter(1);
            clearTable();
            $("#txtSerialNumber").focus();
        }
    </script>
    <script type="text/javascript">
        <%--   var maxpages = 1;
        function ScrollLoadData(SearchString, flage, saveFirstSN, selectStationId) {
            $("#divShowFail").scroll(function () {
                var clientHeight = $("#tblExpand").height();
                var scrollTop = $("#divShowFail").scrollTop();
                if (scrollTop >= clientHeight * 0.9) {
                    var pageNum = parseInt($("tr[pages]:last").attr("pages"));
                    showProductSNInfo(SearchString, flage, saveFirstSN, selectStationId, pageNum, false);
                }
            });
        }
        function showProductSNInfo(SearchString, flage, saveFirstSN, selectStationId, pageNum, isFirst) {
            if (pageNum == undefined || pageNum == null) {
                pageNum = 0;
            }
            pageNum = parseInt(pageNum);
            if (pageNum >= maxpages) {
                $("#divShowFail").unbind("scroll");
                return;
            }
            var ajaxIsfirst = (isFirst == undefined || isFirst == null || isFirst == true);
            if (ajaxIsfirst) {
                ScrollLoadData(SearchString, flage, saveFirstSN, selectStationId);
            }
            $("#remark").val(pageNum + 1);
            var startDate = $("#<%=this.txtStartDate.ClientID %>").val();
            var endDate = $("#<%=this.txtEndDate.ClientID %>").val();
            //加载显示序列号信息
            var ajaxTurn = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetTurnNoInfoBySearchJson(SearchString, flage, saveFirstSN, selectStationId, startDate.todate(), endDate.todate(), (pageNum + 1), 200);
            if (ajaxTurn.error == null) {

                if ((flage == 2 || flage == 3) && ajaxIsfirst) {
                    clearTable();
                    isFirstSearch = 0;
                }
                else if (flage == 1 && isFirstSearch == 0 && ajaxIsfirst) {
                    clearTable();
                    isFirstSearch = isFirstSearch + 1;
                    saveFirstSN = SearchString; //保存第一次SN
                }
                $("#trNewInfo").remove();
                var list = strJson2Object(ajaxTurn.value);
                maxpages = (list.datacount / 2000) + (list.datacount % 200 > 0 ? 1 : 0);
                list = list.data;
                var html = "";
                var num = 0;
                for (var i = 0; i < list.length; i++) {
                    html += "<tr  class='ListTableOddRow' pages='" + (pageNum + 1) + "'><td><input type=\"checkbox\"  class =\"checkSelect\"  name=\"chkSelect\" value=\"" + list[i].SerialNumber + "\"  /></td>"
                    html += "<td>" + ((pageNum * 200) + i + 1) + "</td><td>" + list[i].SerialNumber + "</td><td>" + list[i].OrderNo + "</td><td>" + list[i].ItemCode + "</td><td>" + list[i].Station + "</td>";
                    html += "<td>" + new Date(list[i].CreateTime).toLocaleDateString() + " " + new Date(list[i].CreateTime).toLocaleTimeString() + "</td>";
                    html += "<td>" + new Date(list[i].LastUpdate).toLocaleDateString() + " " + new Date(list[i].LastUpdate).toLocaleTimeString() + "</td></tr>";
                }
                $("#tblExpand").append(html);
            }
            else {
                alert(ajaxTurn.error.Message);
                isFirstSearch = isFirstSearch + 1;
                return false;
            }
        }--%>
        var listData = [];
        var ChangeListData = [];
        var ShowIndex = 0;
        var MaxCount = 0;
        function showProductSNInfo(SearchString, flage, saveFirstSN, selectStationId) {
            var startDate = $("#<%=this.txtStartDate.ClientID %>").val();
            var endDate = $("#<%=this.txtEndDate.ClientID %>").val();
            //加载显示序列号信息
            var ajaxTurn = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetTurnNoInfoBySearch(SearchString, flage, saveFirstSN, selectStationId, startDate.todate(), endDate.todate());
            if (ajaxTurn.error == null) {
                //每一次重新加载，把之前的数据都清空
                if (flage == 2 || flage == 3) {
                    clearTable();
                    isFirstSearch = 0;
                }
                else if (flage == 1 && isFirstSearch == 0) {
                    clearTable();
                    isFirstSearch = isFirstSearch + 1;
                    saveFirstSN = SearchString; //保存第一次SN
                }

                listData = ajaxTurn.value;
                var turnLen = listData.length;
                for (var i = 0; i < turnLen; i++) {
                    ChangeListData.push(listData[i]);
                }
                ShowIndex = 0;
                MaxCount = ajaxTurn.value.length

                //优化产品变更：
                $("#trNewInfo").remove();
                ScrollLoadData();
            } else {
                alert(ajaxTurn.error.Message);
                isFirstSearch = isFirstSearch + 1;
                return false;
            }
        }
        function ScrollLoadData() {
            ShowData();
            $("#divShowFail").scroll(function () {
                var clientHeight = $("#tblExpand").height();
                var scrollTop = $("#divShowFail").scrollTop();
                if (scrollTop >= clientHeight * 0.9) {
                    if (MaxCount >= ShowIndex) {
                        ShowData();
                    } else {
                        $("#divShowFail").unbind("scroll");
                    }
                }
            });
        }
        function ShowData() {
            var html = "";
            for (var i = 0; i < 200; i++) {
                if (ShowIndex >= MaxCount) {
                    $("#divShowFail").unbind("scroll");
                    break;
                }
                html += "<tr  class='ListTableOddRow'><td><input type=\"checkbox\"  class =\"checkSelect\"  name=\"chkSelect\" value=\"" + listData[ShowIndex].SerialNumber + "\"  onclick='isSelectAll()' /></td>"
                html += "<td>" + (1 + i) + "</td><td>" + listData[ShowIndex].SerialNumber + "</td><td>" + listData[ShowIndex].OrderNo + "</td><td>" + listData[ShowIndex].ItemCode + "</td><td>" + listData[ShowIndex].Station + "</td>";
                html += "<td>" + listData[ShowIndex].CreateTime.toLocaleDateString() + " " + listData[ShowIndex].CreateTime.toLocaleTimeString() + "</td>";
                html += "<td>" + listData[ShowIndex].LastUpdate.toLocaleDateString() + " " + listData[ShowIndex].LastUpdate.toLocaleTimeString() + "</td></tr>";
                ShowIndex++;
                $("#Remark").val(ShowIndex);
            }
            $("#tblExpand").append(html);
        }
        /*得到选中记录的值*/
        function getSelectedValuesNew() {
            var selValues = "";

            if (document.getElementById("chkAll").checked && ChangeListData != null) {
                var ChangeCount = ChangeListData.length;

                selValues = ChangeListData[0].SerialNumber;
                for (var i = 1; i < ChangeCount; i++) {
                    selValues += "," + ChangeListData[i].SerialNumber;
                }
            } else {
                var checkboxs = document.getElementsByName("chkSelect");
                var checkboxCount = checkboxs.length;
                for (var i = 0; i < checkboxCount; i++) {
                    if (checkboxs[i].checked) {
                        if (selValues != "") {
                            selValues += ",";
                        }
                        selValues += checkboxs[i].value;
                    }
                }
            }
            return selValues;
        }

        function isSelectAll() {
            if ($("#chkAll").prop("checked") && ChangeListData != null) {
                var checkedCount = $("input[type='checkbox'][name='chkSelect']:checked").length;
                if (checkedCount != ChangeListData.length) {
                    $("#chkAll").prop("checked", false);
                    return false;
                }
            }
        }
    </script>
</asp:Content>
