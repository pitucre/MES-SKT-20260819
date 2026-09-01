<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="WarehouseCheck.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialCheck.WarehouseCheck" %>

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
        </table>
    </div>
    <div class="clear5">
    </div>
    <div class="divBottom" style="width: 100%; overflow: auto;">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">扫描GRN
                </td>
                <td class="Field2">
                    <input type="text" id="txtGRN" class="TextBox" style="width: 370px" />
                </td>
            </tr>
            <tr>
                <td class="Label2">输入盘点数量
                </td>
                <td class="Field2">
                    <input type="text" id="txtQty" class="TextBox" isnumber='1' style="width: 370px" />
                </td>
            </tr>
            <tr>
                <td class="Label2">实际库位条码
                </td>
                <td class="Field2">
                    <input type="text" id="txtRealBarCode" class="TextBox" style="width: 370px" placeholder="与清单库位不一致时扫描实际库位，将自动移库" />
                </td>
            </tr>
            <tr>
                <td class="Label2">备注</td>
                <td class="Field2">
                    <textarea style="width: 370px" class="TextArea" id="txtRemark"></textarea>
            </tr>
        </table>
    </div>
    <div id="msg" style="text-align: center; font-size: 18px">
    </div>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            盘点单明细
        </div>
        <div style="position: absolute; right: 200px; top: 5px; width: 50px; height: 20px; line-height: 18px;">
            已初盘
        </div>
        <div style="position: absolute; right: 100px; top: 5px; width: 100px; height: 15px; line-height: 18px; background-color: gray;">
        </div>
    </div>
    <div class="EditeContentTable" id="infotab" width="100%">
        <table class="ListTable" width="100%" id="tbBuyOrderDetail" style="line-height: 28px; display: none">
            <tr class="ListTableHeader">
                <th>行号
                </th>
                <th>仓库
                </th>
                <th>库位条码
                </th>
                <th>GRN
                </th>
                <th>物料编码
                </th>
                <th>物料名称
                </th>
                <th>物料规格
                </th>
                <th>帐面数量
                </th>
                <th>初盘数量
                </th>
                <th>初盘人
                </th>
                <th>初盘时间
                </th>
            </tr>
        </table>
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        var CheckListNo = "";//盘点单
        var OrderList = []; //盘点单细项列表
        var CheckListDetail = [];
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        $("#txtGRN").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                $("#msg").html('');
                var grn = $.trim($("#txtGRN").val());               
                var balanceQty = 0;                                 //GRN可用数量
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
                    $("#txtGRN").val("");
                    $("#txtGRN").focus();
                    return false;
                }

                if (ajax.value.PFlag>-1&&ajax.value.PSN) {
                    alert("包装过的物料请扫描包装条码【" + ajax.value.PSN + "】");
                    $("#txtGRN").val("").focus();
                    return false;
                }
                grn = ajax.value.GRN;
                balanceQty = ajax.value.StockQty;

                //校验GRN是否已经盘点
                var ajaxCheck = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.ScanCancelCheck(CheckListNo, grn, 1);
                if (ajaxCheck.value == 1) {
                    if (confirm("条码【" + grn + "】已经扫描，是否撤销扫描")) {
                        if (ajax.value.Flag != -1) {
                            //直接进行盘点撤销
                            var ajaxRollBack = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.ScanRollback(CheckListNo, grn, userName, 1);
                            if (ajaxRollBack.error != null) {
                                alert(ajaxRollBack.error.Message);
                                return false;
                            }
                            //showOrderDelList()
                            //获取包装箱物料信息
                            var ajaxGrn = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetPackedItemList(grn);
                            if (ajaxGrn.error != null) {
                                alert(ajaxGrn.error.Message);
                                return false;
                            }
                            var listGrn = ajaxGrn.value;
                            //更新盘点数量
                            if (listGrn && listGrn.length > 0) {
                                $.each(listGrn, function (i, o) {
                                    $('#tbBuyOrderDetail tr[grn="' + o.SerialNumber + '"]').css("background-color", "#F8F8F8");
                                    $("input[id='FirstQty" + o.SerialNumber + "']").val(o.BalanceQty);
                                });
                            }
                            $("#txtQty").attr("disabled", true);
                            $("#msg").html(grn + "撤销成功").css("color", "#0000FF");
                            $("#txtGRN").val("");
                            $("#txtQty").val("");
                            $("#txtGRN").focus().select();
                        }
                        else {
                            //直接进行盘点撤销
                            var ajaxRollBack = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.ScanRollback(CheckListNo, grn, userName, 1);
                            $('#tbBuyOrderDetail tr[grn="' + grn + '"]').css("background-color", "#F8F8F8");
                            $("#msg").html(grn + "撤销成功").css("color", "#0000FF");
                            $("#txtGRN").focus().select();
                            $("#txtGRN").val("");
                            $("#txtQty").val("");
                            $("#txtQty").attr("disabled", false);
                        }
                        showOrderDelList();
                        return;
                    }                    
                }
               
                //如果是包装箱
                if (ajax.value.Flag != -1) {
                    //直接进行盘点
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.Scan(CheckListNo, grn, 0, userName, 1);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    //获取包装箱物料信息
                    var ajaxGrn = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetPackedItemList(grn);
                    if (ajaxGrn.error != null) {
                        alert(ajaxGrn.error.Message);
                        return false;
                    }
                    var listGrn = ajaxGrn.value;
                    //更新盘点数量
                    if (listGrn && listGrn.length >0) {
                        $.each(listGrn, function (i,o) {
                            $('#tbBuyOrderDetail tr[grn="' + o.SerialNumber + '"]').css("backgroundColor", "gray");
                            $("input[id='FirstQty" + o.SerialNumber + "']").val(o.BalanceQty);
                        });
                    }
                    $("#txtQty").val(balanceQty);
                    $("#txtQty").attr("disabled", true);
                    $("#msg").html(grn + "扫描成功").css("color", "#0000FF");
                    $("#txtGRN").focus().select();
                    showOrderDelList();
                } else {
                    var flag = false;
                    var $trs = $("#tbBuyOrderDetail tbody tr");
                    $trs.each(function (i) {
                        if ($(this).find("td:eq(3)").html() == grn) {
                            flag = true;
                            return false;
                        }
                    });
                    if (!flag) {
                        alert("GRN不在差异清单中");
                        $("#txtGRN").focus().select();
                        return false;
                    }
                    $("#txtQty").val(balanceQty);
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
            var grn = $.trim($("#txtGRN").val());
            var realBarCode = $.trim($("#txtRealBarCode").val());
            //与清单库位不一致时，先自动移库到实际库位
            if (realBarCode != "") {
                var checkBarCode = "";
                $('#tbBuyOrderDetail tr[grn="' + grn + '"]').each(function () {
                    checkBarCode = $.trim($(this).find("td:eq(2)").text());
                });
                if (checkBarCode != "" && checkBarCode != realBarCode) {
                    var ajaxMove = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.MoveMaterial(realBarCode, grn);
                    if (ajaxMove.error != null) {
                        alert(ajaxMove.error.Message);
                        return false;
                    }
                    //更新清单中的库位条码
                    $('#tbBuyOrderDetail tr[grn="' + grn + '"]').find("td:eq(2)").text(realBarCode);
                    $("#msg").html(grn + "已自动移库到库位【" + realBarCode + "】").css("color", "#FF0000");
                }
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.Scan(CheckListNo, grn,parseFloat($.trim($("#txtQty").val())), userName, 1);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            //扫描成功后，更改对应的已初盘数据
            $('#tbBuyOrderDetail tr[grn="' + grn + '"]').css("backgroundColor", "gray");
            //更新初盘数量
            $("input[id='FirstQty" + grn + "']").val($.trim($("#txtQty").val()));
            $("#msg").html(grn + "扫描成功").css("color", "#0000FF");
            $("#txtGRN").val("");
            $("#txtQty").val("");
            $("#txtRealBarCode").val("");
            $("#txtGRN").focus().select();
            showOrderDelList();
        }
        function View() {
            if (CheckListNo == "" || CheckListNo == null || typeof (CheckListNo) == 'undefined') {
                alert("请选择盘点单");
                return false;
            }
            dialog({ title: "盘点差异记录", src: "WarehouseCheckDifferenceList.aspx?checkNo=" + CheckListNo, width: 800, height: 600 });
        }
        function selectCheckOrder() {
            $("#msg").html('');
            $("#tbBuyOrderDetail tr:gt(0)").remove();
            var searchCondition = " CheckOrderStatus =2 "; // "审核完成"; 
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=200&PageCondition= " + searchCondition + "&Multiple=false&CallBackFunc=setCheckCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setCheckCode(list) {
            console.log(list)
            $("#txtCheckNo").val(list[0][1] + "|" + list[0][2]);
            CheckListNo = list[0][1];
            $("#txtRemark").val(list[0][5])
            $("#txtGRN").focus();
            //显示盘点单明细信息
            showOrderDelList();
        }

        //显示盘点单明细
        function showOrderDelList() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.GetCheckOrderDetail(CheckListNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var data = $.parseJSON(ajax.value).data;
            if (data.length <= 0) {
                alert("未找到明细数据！");
                return false;
            }
            //添加盘点单明细列表
            OrderList = [];
            CheckListDetail = [];
            $.grep(data, function (e, i) {
                OrderList.push(e);
            });
            GetOrderDelList();
            $("#tbBuyOrderDetail tbody tr").each(function () {
                var a = $(this).children();//获取每一行
                var fistBy = a[9].innerText;//取得第10列的值 行号
                if (fistBy  != "") {
                    $(this).css("backgroundColor", "gray");
                }
            });
        }
        function GetOrderDelList() {
            if (OrderList != null && OrderList.length > 0) {
                $("#tbBuyOrderDetail").show();
                $("#tbBuyOrderDetail").find(".ListTableEvenRow").remove();
                $("#tbBuyOrderDetail").find(".ListTableOddRow").remove();
                $("#trNewInfo").remove();
                var tableList = document.getElementById("tbBuyOrderDetail");
                var row, cel
                for (var i = 0; i < OrderList.length; i++) {

                    row = tableList.insertRow(i + 1);
                    row.className = i % 2 == 0 ? "ListTableEvenRow" : "ListTableOddRow";

                    row.setAttribute("grn", OrderList[i].SN);
                    var firstBy = OrderList[i].FirstBy;
                    CheckListDetail.push({ "GRN": OrderList[i].SN, "NowQty": OrderList[i].StockQty });

                    cel = row.insertCell(0);
                    cel.innerHTML = i + 1;

                    cel = row.insertCell(1);
                    cel.innerHTML = OrderList[i].Warehouse;

                    cel = row.insertCell(2);
                    cel.innerHTML = OrderList[i].WhBarcode;

                    cel = row.insertCell(3);
                    cel.innerHTML = OrderList[i].SN;

                    cel = row.insertCell(4);
                    cel.innerHTML = OrderList[i].ItemCode;

                    cel = row.insertCell(5);
                    cel.innerHTML = OrderList[i].ItemName;

                    cel = row.insertCell(6);
                    cel.innerHTML = OrderList[i].ItemSpec;

                    cel = row.insertCell(7);
                    cel.innerHTML = parseFloat(OrderList[i].BalanceQty);

                    //初盘数量 if没有初盘人，表示第一次初盘，数量显示GRN数量，else带出初盘数量

                    //if (firstBy == "") {
                    //    OrderList[i].StockQty = OrderList[i].BalanceQty;
                    //    cel = row.insertCell(8);
                    //    cel.innerHTML = "<input type='text' class='stockQty' style='width: 60%'  onchange = isPositiveNum(this," + i + ") id='FirstQty" + OrderList[i].SN + "'  value='" +parseFloat( OrderList[i].StockQty) + "' />";
                    //}
                    //else {
                        //OrderList[i].StockQty = OrderList[i].StockQty;
                        cel = row.insertCell(8);
                        cel.innerHTML = "<input type='text' class='stockQty' style='width: 60%'  onchange = isPositiveNum(this," + i + ") id='FirstQty" + OrderList[i].SN + "'  value='" +parseFloat( OrderList[i].StockQty) + "' />";
                    //}
                    cel = row.insertCell(9);
                    cel.innerHTML = firstBy;

                    //初盘时间：if没有初盘人说明没有初盘时间 else 
                    if (firstBy == "") {
                        cel = row.insertCell(10);
                        cel.innerHTML = "";
                    }
                    else {
                        cel = row.insertCell(10);
                        cel.innerHTML = OrderList[i].FirstTime;
                    }
                   
                }
            }
            else {
                $("#tbBuyOrderDetail tr:gt(0)").remove();
                $("#tbBuyOrderDetail tr:eq(0)").after('<tr class="ListTableOddRow"><td colspan="12" align="center"><font color="red">暂无数据</font></td></tr>');
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

        //初盘批量完成
        function Save() {
            var Remark = $("#txtRemark").val();
            if (CheckListNo == "" || CheckListNo == null) {
                alert("请选择对应的盘点单");
                return false;
            }
            if (confirm("是否完成初盘?")) {
                for (var i = 0; i < $("#tbBuyOrderDetail tr").length - 1; i++) {
                    var stockQty = $($("#tbBuyOrderDetail tr:gt(0)")[i]).find("input[class='stockQty']").val();
                    if (stockQty == "") {
                        stockQty = 0;
                    }
                    CheckListDetail[i].NowQty = stockQty;
                }
                var entity = {};
                entity.CheckOrder = CheckListNo;
                entity.UpdateBy = userName;
                entity.Flag = 3; //初盘
                entity.Remark = Remark;
                entity.TbDtl = JSON.stringify(CheckListDetail);
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.SaveCheckOrder(JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert('<%=Resources.Messages.SaveSuccess %>');
                refresh();
            }
        }

        /*刷新页面*/
        function refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
