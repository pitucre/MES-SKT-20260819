<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="WarehouseCheckReplay.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialCheck.WarehouseCheckReplay" %>

<%@ MasterType VirtualPath="~/Masters/ViewMaster.master" %>
<asp:Content ID="Content3" ContentPlaceHolderID="viewcontent" runat="Server">
    <style>
        #divProductSummaryInfo {
            font-size: 14px;
        }
    </style>
    <div>
        <%--查询模块--%>
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">
                    <%= Resources.lang.WarehouseCheckList %>
                </td>
                <td class="Field2">
                    <input type="hidden" value="" id="hdnDN" />
                    <input type="text" id="txtCheckNo" class="TextBox" disabled="disabled" style="width: 370px" />
                    <input type="button" id="Button1" class="ButtonBox" value="..." onclick="selectCheckOrder()" />
                </td>
            </tr>
            <tr>
                <td class="Label2">扫描GRN</td>
                <td class="Field2">
                    <input type="text" id="txtGRN" class="TextBox" style="width: 370px" /></td>
            </tr>
            <tr>
                <td class="Label2">输入复盘数量
                </td>
                <td class="Field2">
                    <input type="text" id="txtQty" class="TextBox" isnumber='1' style="width: 370px" />
                </td>
            </tr>
            <tr>
                <td class="Label2">备注</td>
                <td class="Field2">
                    <textarea style="width: 370px" class="TextArea" id="txtRemark"></textarea>
                </td>
            </tr>
        </table>
    </div>
    <div id="msg" style="text-align: center; font-size: 18px">
    </div>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            差异清单
        </div>
        <div style="position: absolute; right: 200px; top: 5px; width: 50px; height: 20px; line-height: 18px;">
            已复盘
        </div>
        <div style="position: absolute; right: 100px; top: 5px; width: 100px; height: 15px; line-height: 18px; background-color: gray;">
        </div>
    </div>
    <div>
        <div class="EditeContentTable" id="infotab" width="100%">
        </div>
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        var CheckListNo;//盘点单
        var checkOrderId = -1;
        var OrderDetailList = []; //盘点单明细
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        $(function () {
            //动态绑定
            $(document).on("keydown", "input[name='qty']", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if (isPositiveNum(this, 1)) {
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.Scan(CheckListNo, $.trim($("#txtGRN").val()), $("input[name='qty']:focus").val(), userName, 2);
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            return false;
                        }
                        $("#txtGRN").focus().select();
                        CheckDifferenceList(CheckListNo);
                    }
                }
            });
        });
        $("#txtGRN").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                $("#msg").html('');
                var grn = $.trim($("#txtGRN").val());
                if (CheckListNo == "" || CheckListNo == null) {
                    alert("请选择盘点单");
                    return false;
                }
                if (!grn) {
                    alert("请扫描物料条码/包装箱");
                    return false;
                }
                //校验GRN
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.GetMaInfo(grn);
                if (ajax.value == null) {
                    alert("无效的GRN");
                    $("txtGRN").val("");
                    $("txtGRN").focus();
                    return false;
                }
                if (ajax.value.PFlag > -1 && ajax.value.PSN) {
                    alert("包装过的物料请扫描包装条码【" + ajax.value.PSN + "】");
                    $("txtGRN").val("");
                    $("txtGRN").focus();
                    return false;
                }
                grn = ajax.value.GRN;
                balanceQty = ajax.value.StockQty;

                //校验GRN是否已经盘点
                var ajaxCheck = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.ScanCancelCheck(CheckListNo, grn, 2);
                if (ajaxCheck.value == 1) {
                    if (confirm("条码【" + grn + "】已经扫描，是否撤销扫描")) {
                        if (ajax.value.Flag != -1) {
                            //直接进行盘点撤销
                            var ajaxRollBack = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.ScanRollback(CheckListNo, grn, userName, 2);
                            if (ajaxRollBack.error != null) {
                                alert(ajaxRollBack.error.Message);
                                return false;
                            }
                            //showOrderDelList()
                            //获取包装箱物料信息
                            var ajaxGrn = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.GetCheckOrderDetailInfoByPackageSN(grn, checkOrderId);
                            if (ajaxGrn.error != null) {
                                alert(ajaxGrn.error.Message);
                                return false;
                            }
                            var listGrn = ajaxGrn.value;
                            //更新盘点数量
                            var totalQty = 0;
                            if (listGrn && listGrn.length > 0) {
                                $.each(listGrn, function (i, o) {
                                    $('#tbBuyOrderDetail tr[grn="' + o.GRN + '"]').css("background-color", "#F8F8F8");
                                    var qty = o.FirstBy ? o.StockQty : o.BalanceQty;
                                    totalQty += qty;
                                    $("input[id='RepeatQty" + o.GRN + "']").val(qty);
                                });
                            }

                            $("#txtQty").val(totalQty);
                            $("#msg").html(grn + "撤销成功").css("color", "#0000FF");
                            $("#txtGRN").focus().select();
                            $("#txtQty").attr("disabled", true);
                        }
                        else {
                            //直接进行盘点撤销
                            var ajaxRollBack = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.ScanRollback(CheckListNo, grn, userName, 2);
                            $('#tbBuyOrderDetail tr[grn="' + grn + '"]').css("background-color", "#F8F8F8");
                            $("#txtQty").val(balanceQty);
                            $("#msg").html(grn + "撤销成功").css("color", "#0000FF");
                            $("#txtGRN").focus().select();
                            $("#txtQty").attr("disabled", false);
                        }
                        CheckDifferenceList(CheckListNo);
                        return;
                    }
                }

                //如果是包装箱
                if (ajax.value.Flag != -1) {
                    //直接进行盘点
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.Scan(CheckListNo, grn, 0, userName, 2);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    //获取包装箱物料信息
                    var ajaxGrn = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.GetCheckOrderDetailInfoByPackageSN(grn, checkOrderId);
                    if (ajaxGrn.error != null) {
                        alert(ajaxGrn.error.Message);
                        return false;
                    }
                    var listGrn = ajaxGrn.value;
                    var totalQty = 0;
                    //更新盘点数量
                    if (listGrn && listGrn.length > 0) {
                        $.each(listGrn, function (i, o) {
                            $('#tbBuyOrderDetail tr[grn="' + o.GRN + '"]').css("backgroundColor", "gray");
                            var qty = o.FirstBy ? o.StockQty : o.BalanceQty;
                            totalQty += qty;
                            $("input[id='RepeatQty" + o.GRN + "']").val(qty);
                        });
                    }
                    $("#txtQty").val(totalQty);
                    $("#txtQty").attr("disabled", true);
                    $("#msg").html(grn + "扫描成功").css("color", "#0000FF");
                    $("#txtGRN").focus().select();
                    CheckDifferenceList(CheckListNo);
                } else {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.GetCheckOrderDetailInfo(grn, checkOrderId);
                    if (ajax.value == null) {
                        alert("GRN错误或不在盘点单中");
                        $("txtGRN").focus();
                        return false;
                    }
                    var entity = ajax.value;
                    $("#txtQty").val(entity.FirstBy ? entity.StockQty : entity.BalanceQty);
                    $("#txtQty").attr("disabled", false);
                    $("#txtQty").focus().select();
                    
                }
            }
        });

        $("#txtQty").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                $("#msg").html('');
                if (CheckListNo == "" || CheckListNo == null) {
                    alert("请选择盘点单");
                    return false;
                }
                if (isPositiveNum(this, 1)) {
                    if ($("#txtGRN").val() != "" && $("#txtQty").val() != "") {
                        Check();
                        $("#txtGRN").focus().select();
                    }
                }
            }
        });

        function Check() {
            if (CheckListNo == "" || CheckListNo == null || typeof (CheckListNo) == 'undefined') {
                alert("请选择盘点单");
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.Scan(CheckListNo, $.trim($("#txtGRN").val()), parseFloat($.trim($("#txtQty").val())), userName, 2);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            //扫描成功后，更改对应的已初盘数据
            var grn = $.trim($("#txtGRN").val());
            for (var i = 0; i < $("#infotab tbody tr").length; i++) {
                if (grn == $($("#infotab tbody tr")[i]).find("td:eq(3)").html()) {
                    $($("#infotab tr:gt(0)")[i]).css("backgroundColor", "gray");
                }
            }
            //更新复盘数量
            $("input[id='RepeatQty" + grn + "']").val($.trim($("#txtQty").val()));
            $("#msg").html(grn + "扫描成功").css("color", "#0000FF");
            $("#txtGRN").val("");
            $("#txtQty").val("");
            $("#txtGRN").focus().select();
            CheckDifferenceList(CheckListNo);
        }

        function selectCheckOrder() {
            var searchCondition = " CheckOrderStatus =3"; // "Status=1"; 
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=200&PageCondition= " + searchCondition + "&Multiple=false&CallBackFunc=setCheckCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setCheckCode(list) {
            $("#txtCheckNo").val(list[0][1] + "|" + list[0][2]);
            CheckListNo = list[0][1];
            checkOrderId = list[0][0];
            OrderDetailList = [];
            $("#txtRemark").val(list[0][5])
            CheckDifferenceList(CheckListNo);
            $("#txtGRN").focus();
        }
        function CheckDifferenceList(CheckListNo) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.CheckDifferenceList(CheckListNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
            }
            var htmlstr = "<table width='100% ' class='ListTable' id='tbBuyOrderDetail'><thead><tr class='ListTableHeader'>"
                + "<th>行号</th><th>仓库</th><th>库位条码</th><th>GRN</th><th>物料编码</th><th>物料名称</th><th>物料规格</th>"
                + " <th>帐面数量</th><th>初盘数量</th><th>初盘人</th><th>初盘时间</th>"
                + " <th>盈亏</th><th>复盘数量</th></tr></thead>";
            var list = ajax.value;
            for (var i = 0; i < list.length; i++) {
                var value = parseFloat((list[i].StockQty - list[i].BalanceQty).toFixed(6));
                var RepeatBy = list[i].RepeatBy;
                var FirstBy = list[i].FirstBy;
                var repeatQty = "";
                //if (RepeatBy != "") {
                    repeatQty = list[i].NowQty;
                //} else {
                //    if (list[i].FirstBy != "") {
                //        repeatQty = list[i].StockQty;
                //    }
                    
                //}
                //获取盘点单明细信息
                OrderDetailList.push({ "GRN": list[i].GRN, "NowQty": repeatQty });

                if (i % 2 == 0) {
                    if (RepeatBy != "") {
                        htmlstr += "<tr class='ListTableEvenRow' style='background-color:gray' grn='" + list[i].GRN + "'>";
                    }
                    else {
                        htmlstr += "<tr class='ListTableEvenRow' grn='" + list[i].GRN + "' >";
                    }
                }
                else {
                    if (RepeatBy != "") {
                        htmlstr += "<tr class='ListTableOddRow' grn='" + list[i].GRN + "' style='background-color:gray'>";
                    } else {
                        htmlstr += "<tr class='ListTableOddRow' grn='" + list[i].GRN + "'>";
                    }
                }

                htmlstr += "<td>" + (i + 1) + "</td>"
                       + "<td>" + list[i].Warehouse + "</td>"
                       + "<td>" + list[i].BarCode + "</td>"
                       + "<td>" + list[i].GRN + "</td>"
                       + "<td>" + list[i].ItemCode + "</td>"
                       + "<td>" + list[i].ItemName + "</td>"
                       + "<td>" + list[i].ItemSpec + "</td>"
                       + "<td>" + list[i].BalanceQty + "</td>"
                       //+ (list[i].FirstBy == "" ? "<td></td>" : "<td>" + list[i].StockQty + "</td>")
                       + "<td>" + list[i].StockQty + "</td>"
                       + "<td>" + list[i].FirstBy + "</td>"
                       + "<td>" + list[i].FirstTime + "</td>"
                       + (value == 0 ? "<td >" + value + "</td>" : value > 0 ? "<td style='background:#7FFF00'>" + value + "</td>" : "<td style='background:red'>" + value + "</td>")
                     //  + (value >= 0 ? "<td style='background:#7FFF00'>" + value + "</td>" : "<td style='background:red'>" + value + "</td>")
                       + "<td><input id='RepeatQty" + list[i].GRN + "' disabled='disabled' onchange = isPositiveNum(this," + i + ") type='text' name='qty' class='TextBox'  value='" + repeatQty + "'/></td>"

                + "</tr>";
            }
            $("#infotab").html(htmlstr + "</table>");
        }
        //完成复盘
        function Finish() {
            if (CheckListNo == "" || CheckListNo == null) {
                alert("请选择盘点单");
                return false;
            }
            var Remark = $("#txtRemark").val();
            if (confirm("是否完成复盘?")) {
                for (var i = 0; i < $("#infotab tbody tr").length; i++) {
                    var stockQty = $($("#infotab tr:gt(0)")[i]).find("input").val();
                    if (stockQty == "") {
                        stockQty = 0;
                    }
                    OrderDetailList[i].NowQty = stockQty;
                }
                var entity = {};
                entity.CheckOrder = CheckListNo;
                entity.UpdateBy = userName;
                entity.Flag = 1; //复盘
                entity.Remark = Remark;
                entity.TbDtl = JSON.stringify(OrderDetailList);
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.SaveCheckOrder(JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert("盘点完成");
                window.location.reload();
            }
        }
        function isPositiveNum(obj, i) {//是否为正整数
            var s = $(obj).val();
            var re = /^[+-]?(0|([1-9]\d*))(\.\d+)?$/g;
            if (!re.test(s)) {
                alert("请输入正确数字格式！");
                $(obj).val(0);
                $(obj).focus();
                return false;
            } else {
                return true;
            }
        }
    </script>
</asp:Content>
