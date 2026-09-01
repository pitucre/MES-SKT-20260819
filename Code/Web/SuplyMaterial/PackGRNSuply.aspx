<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="PackGRNSuply.aspx.cs" Inherits="SKT.LeanMES.Web.SuplyMaterial.PackGRNSuply" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <!--打印插件未安装的提示区域-->
    <div id="noprtplg" class="Tips">
    </div>
    <div class="infoTips">
       <em>*</em> <span>为必填项</span>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label" align="center" colspan="2" style="font-size: 22px; font-weight: bold;">
                <%=Resources.lang.GRNCartonSN%>:<span id="GrnPackingSN" style="font-size: 22px; font-weight: bold;"></span>
            </td>
        </tr>
        <tr id="showSupplierList" style="display: none">
            <td class="Label1">选择供应商<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" id="txtVendorCode" class="TextBox" disabled="disabled" value="" /><input
                    type="button" id="btnSelectSupplier" class="ButtonBox" value="..." onclick="selectSupplier()" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.GRN %><em>*</em>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtGRN" class="TextBox" style="width: 250px; height: 25px; text-transform: uppercase; font-size: 16px; font-weight: bold;" />
                <input type="hidden" value="" id="hdnVendorCode" />
                <input class="TextBox" id="hidtxt" style="display: none;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">打印机名称
            </td>
            <td class="Field2" colspan="1">
                <select id="selPrintersList" style="width: 250px;">
                </select>
                <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机列表</a>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div style="text-align: center; color: Red;">
        <span id="msg"></span>
    </div>
    <!--打印状态的信息提示区域-->
    <div id="lblMessage" class="Tips" style="text-align: center">
    </div>
    <div id="divPackScanCode">
        <table class="ListTable" width="100%" id="tabPackScanCode">
            <tr class="ListTableHeader">
                <th>
                    <input type="checkbox" value="-1" />
                </th>
                <th>未关闭的包装箱号
                </th>
                <th>物料编码
                </th>
                <th>物料名称
                </th>
                <th>供应商名称
                </th>
                <th>批次号
                </th>
            </tr>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="7" style="text-align: center;"><span>暂无数据</span>
                </td>
            </tr>
        </table>
    </div>
    <div class="clear5">
    </div>
    <div id="lblPt" class="Tips">
    </div>
    <div id="packingItemList">
        <table class="ListTable" width="100%" id="packingItemListTbl">
            <tr class="ListTableHeader">
                <th align="left" colspan="2">
                    <%=Resources.lang.GRNCartonSN%>&nbsp;&nbsp;<span id="CartonSN"></span>    <span>总数量</span> <span id="PackQty">0</span>
                </th>
            </tr>
            <tr class="ListTableEvenRow">
                <td align="left" colspan="2">
                    <%=Resources.lang.PackedGRN %><span id="packedItemQty">0</span>
                </td>
            </tr>
        </table>
    </div>
    <input type="hidden" value="" id="hdnCartonSN" />
    <div id="activeinfo" class="active-info">
        <div id="activeinfoarea" class="active-info-area"></div>
        <%--<textarea id="activeinfoarea" class="active-info-area" readonly>
        </textarea>--%>
    </div>
    <style type="text/css">
        .active-info {
            padding-right: 10px;
            padding-top: 5px;
            padding-left: 1px;
        }

        .active-info-area {
            color: Red;
            background-color: #ebebe4;
            width: 100%;
            outline: none;
            border: 1px solid #d3d3d3;
            overflow: auto;
            font-size: 12px;
            font-weight: normal;
            line-height: 16px;
            padding: 3px;
            height: 410px;
        }

        .messageRed {
            display: inline-block;
            text-align: left;
            color: Red;
            font-weight: normal;
            font-size: 14px;
        }

        .messageGreen {
            display: inline-block;
            text-align: left;
            color: Green;
            font-weight: normal;
            font-size: 14px;
        }
    </style>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        var vendorCode = "";
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var userId = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>';
        var num = 0; //取消次数
        var GrnCount = 0;
        var OneGrn = "";
        var firstGrn = "";
        $(function () {
            $("#divPackScanCode").hide();
            bindPrinters('selPrintersList');
            $("#activeinfoarea").css("height", $(window).height() - 313 + "px");
        });


        function selectSupplier() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 612, height: 300 });
        }

        function getChooseValue(list) {
            $("#txtVendorCode").val(list[0][1]);
            vendorCode = list[0][1];
            $("#hdnVendorCode").val(vendorCode);
            firstGrn = "";
            $("#GrnPackingSN").html("");
            $("#hdnCartonSN").val("");
            $("#txtGRN").val("");
            $("#PackQty").text("0");
            $("#txtGRN").focus();
            $("#CartonSN").html("");
            $("#packingItemListTbl tr:gt(1)").remove();
            $("#packedItemQty").html("0");
            $("#msg").html("");
            GrnCount = 0;
        }

        $(document).ready(function () {
            //通过用户获取对应的供应商
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetVenCodeByUserId(userId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            vendorCode = ajax.value.VendorCode;
            if (vendorCode == "") {
                $("#showSupplierList").show();
            }
            $("#hdnVendorCode").val(vendorCode);

            //回车包装
            $("#txtGRN").keydown(function (event) {
                var e = event || window.event
                if (e && e.keyCode == 13) {
                    if ($.trim($("#txtGRN").val()) != "") {
                        //回车只显示GRN信息   
                        //PackGRN();

                        //if (GrnCount == 0) {
                        //    OneGrn = $.trim($("#txtGRN").val());
                        //    //判断Grn
                        //    if (!GrnFirstValidate(OneGrn)) {
                        //        return false;
                        //    }
                        //    GrnCount = GrnCount + 1;
                        //    $("#msg").html("物料条码【" + OneGrn + "】扫描成功！但【单个物料条码不需要包装操作】，请继续扫描物料条码进行包装操作！");
                        //    $("#msg").css("color", "green");
                        //    $("#txtGRN").focus();
                        //    $("#txtGRN").select();
                        //    return false;
                        //}
                        //else if (GrnCount == 1) {
                        //    var grnTwo = $.trim($("#txtGRN").val());
                        //    //判断Grn
                        //    if (!GrnFirstValidate(grnTwo)) {
                        //        return false;
                        //    }
                        //    PackGRNFirst(OneGrn);//写入第一条码
                        //    //回车只显示GRN信息 
                        //    PackGRNFirst(grnTwo);//写入第二个条码
                        //}
                        //else {
                        //回车只显示GRN信息 
                        PackGRN();

                        //}
                    }
                    else {
                        alert("请先扫描GRN条码");
                        return false;
                    }
                }
            });

            $(".ListTableOddRow,.ListTableEvenRow,.ListTableSelectedRow").live({
                mouseenter: function () {
                    $(this).addClass("ListTableHoverRow");
                },
                mouseleave: function () {
                    $(this).removeClass("ListTableHoverRow");
                },
                click: function () {
                    $(".ListTableSelectedRow").not($(this)).removeClass("ListTableSelectedRow");
                    $(this).toggleClass("ListTableSelectedRow");
                }
            });
        });

        //包装GRN
        function PackGRNFirst(txtGRN) {
            $("#msg").html("");
            $(".StrongFont").removeClass("StrongFont");
            var hdnCartonSN = $.trim($("#hdnCartonSN").val());
            vendorCode = $("#hdnVendorCode").val();
            if (vendorCode == "") {
                $("#msg").html("请选择供应商!");
                $("#msg").css("color", "red");
                //alert("请选择供应商!");
                return false;
            }
            //验证包装的GRN条码是否合法
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ValidateGRN(txtGRN, hdnCartonSN, vendorCode);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                highListCurrentItem(txtGRN);
                return false;
            }
            var messageStr = ajax.value;
            vendorCode = messageStr[2];
            $("#PackQty").text(messageStr[3]);
            $("#hdnVendorCode").val(vendorCode);
            //有错误信息
            if (messageStr[0] == -1) {
                $("#msg").html(messageStr[1]);
                $("#msg").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }

            //数据库中没有未关闭的包装箱，系统生成新carton箱条码并成功包装GRN
            if (messageStr[0] == 0) {
                setCartonSN(messageStr[1]);
                setPackInfo(txtGRN);
                appendPackItem(txtGRN);
                GrnCount = GrnCount + 1;
                return false;
            }
            //系统中还有未关闭的包装箱可使用，是否使用未关闭的包装箱？\n点击【确定】重新生成新的包装箱，点击【取消】打开未关闭的包装箱
            if (messageStr[0] == 1) {
                $("#txtGRN").focus();
                $("#txtGRN").select();
                if (vendorCode == "") {
                    $("#msg").html("获取供应商编码失败！");
                    $("#msg").css("color", "red");
                    return false;
                }
                //不检测是否有未关闭的包装箱，每重新扫描一次，都打开新箱
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GenerateNewCartonSNAndPack(txtGRN, 1);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                var returnCartonSN = ajax.value;
                setCartonSN(returnCartonSN);
                setPackInfo(txtGRN);
                appendPackItem(txtGRN);
                GrnCount = GrnCount + 1;
            }
            //大包装箱
            if (messageStr[0] == 2) {
                var str = messageStr[1].split("|");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                if (vendorCode != str[1]) {
                    $("#msg").html("<%=Resources.Messages.GrnNotMatchVendorCode %>");
                    $("#msg").css("color", "red");
                    return false;
                }
                setCartonSN(str[0]);
                getPackedItemList(str[0]);
                $("#msg").html("成功打开旧包装，您可以继续往该包装箱内包装物料！");
                $("#msg").css("color", "green");
                GrnCount = GrnCount + 1;
                return false;
            }
        }

        //包装GRN
        function PackGRN() {
            if ($.trim($("#txtGRN").val()) == "") {
                alert("请先扫描GRN条码");
                return false;
            }
            $("#msg").html("");
            $("#msg").css("color", "red");
            $(".StrongFont").removeClass("StrongFont");
            var txtGRN = $.trim($("#txtGRN").val());
            var hdnCartonSN = $.trim($("#hdnCartonSN").val());
            vendorCode = $("#hdnVendorCode").val();
            if (txtGRN == "") {
                alert("请扫GRN条码！");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            if (vendorCode == "") {
                alert("请选择供应商!");
                return false;
            }
            if (firstGrn == "") {
                firstGrn = $.trim($("#txtGRN").val());
            }

            //验证包装的GRN条码是否合法
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ValidateGRN(txtGRN, hdnCartonSN, vendorCode, firstGrn);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                highListCurrentItem(txtGRN);
                return false;
            }
            //验证GRN状态是否在送货单
            var ajaxCK = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ValidateGRNOnWay(txtGRN);
            if (ajaxCK.error == null && ajaxCK.value) {
                $("#msg").html("该物料条码已在供应商已产生送货单！");
                $("#msg").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }

            var messageStr = ajax.value;
            vendorCode = messageStr[2];
            $("#PackQty").text(messageStr[3]);
            $("#hdnVendorCode").val(vendorCode);
            //有错误信息
            if (messageStr[0] == -1) {
                $("#msg").html(messageStr[1]);
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }

            //数据库中没有未关闭的包装箱，系统生成新carton箱条码并成功包装GRN
            if (messageStr[0] == 0) {
                setCartonSN(messageStr[1]);
                setPackInfo(txtGRN);
                appendPackItem(txtGRN);
                GrnCount = GrnCount + 1;
                return false;
            }
            //系统中还有未关闭的包装箱可使用，是否使用未关闭的包装箱？\n点击【确定】重新生成新的包装箱，点击【取消】打开未关闭的包装箱
            if (messageStr[0] == 1) {
                $("#txtGRN").focus();
                $("#txtGRN").select();
                if (vendorCode == "") {
                    $("#msg").html("获取供应商编码失败！");
                    $("#msg").css("color", "red");
                    return false;
                }
                //不检测是否有未关闭的包装箱，每重新扫描一次，都打开新箱
                //if (confirm("<%=Resources.Messages.ConfirmToNewCartonSN %>")) {
                //update by peter on 2016-5-12 生成新的包装箱号
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GenerateNewCartonSNAndPack(txtGRN, 1);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                var returnCartonSN = ajax.value;
                setCartonSN(returnCartonSN);
                setPackInfo(txtGRN);
                appendPackItem(txtGRN);
                GrnCount = GrnCount + 1;
                //}
                //else {
                //    //点击【取消】打开未关闭的包装箱(获取原包装箱号) update by peter on 2016-5-12
                //    //显示未关闭的包装箱列表
                //    num += 1;
                //    $("#divPackScanCode").show();
                //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetOldCartonGRNList(txtGRN);
                //    if (ajax.error != null) {
                //        $("#msg").html(ajax.error.Message);
                //        $("#msg").css("color", "red");
                //        return false;
                //    }
                //    var strHtml = "";
                //    var oldCartonSN = "";
                //    var list = ajax.value;
                //    $("#trNewInfo").remove();
                //    if (num == 1) {
                //        for (var i = 0; i < list.length; i++) {
                //            strHtml += "<tr class='ListTableOddRow'>";
                //            strHtml += "<td><input name='chkSelect' align='center' type='checkbox' value='" + list[i].SerialNumber + "'/></td>";
                //            strHtml += "<td>" + list[i].SerialNumber + "</td>";
                //            strHtml += "<td>" + list[i].ItemCode + "</td>";
                //            strHtml += "<td>" + list[i].ItemName + "</td>";
                //            strHtml += "<td>" + list[i].VendorName + "</td>";
                //            strHtml += "<td>" + list[i].LotCode + "</td>";
                //            strHtml += "</tr>";
                //        }
                //        $(strHtml).appendTo($("#tabPackScanCode"));
                //    }
                //    //获取选中的值
                //    $("input[name='chkSelect']").click(function () {
                //        if (this.checked) {
                //            $("#tabPackScanCode tr").each(function () {
                //                if ($($(this).find("td")[0]).find("input[name='chkSelect']").is(":checked")) {
                //                    oldCartonSN += $($(this).find("td")[1]).html();
                //                }
                //            });
                //            //包装扫描的GRN
                //            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetOldCartonGRN(txtGRN, vendorCode, oldCartonSN);
                //            if (ajax.error != null) {
                //                $("#msg").html(ajax.error.Message);
                //                $("#msg").css("color", "red");
                //                return false;
                //            }
                //            setCartonSN(oldCartonSN);
                //            setPackInfo(txtGRN);
                //            getPackedItemList(oldCartonSN);
                //        }
                //    });
                //}
            }
            //大包装箱
            if (messageStr[0] == 2) {
                var str = messageStr[1].split("|");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                if (vendorCode != str[1]) {
                    $("#msg").html("<%=Resources.Messages.GrnNotMatchVendorCode %>");
                    $("#msg").css("color", "red");
                    return false;
                }
                setCartonSN(str[0]);
                getPackedItemList(str[0]);
                $("#msg").html("成功打开旧包装，您可以继续往该包装箱内包装物料！");
                $("#msg").css("color", "green");
                GrnCount = GrnCount + 1;
                return false;
            }
        }

        //判断Grn是否合法
        function GrnFirstValidate(grn) {
            //验证包装的GRN条码是否合法
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplier.FirstValidateGRN(grn, $.trim($("#hdnCartonSN").val()), $("#hdnVendorCode").val());
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            var messageStr1 = ajax.value;
            //有错误信息
            if (messageStr1[0] == -1) {
                $("#msg").html(messageStr1[1]);
                $("#msg").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            //大包装箱
            if (messageStr1[0] == 2 && GrnCount == 0) {
                $("#PackQty").text(messageStr1[3]);
                var str = messageStr1[1].split("|");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                if (vendorCode != str[1]) {
                    $("#msg").html("<%=Resources.Messages.GrnNotMatchVendorCode %>");
                    $("#msg").css("color", "red");
                    return false;
                }
                setCartonSN(str[0]);
                getPackedItemList(str[0]);
                $("#msg").html("成功打开旧包装，您可以继续往该包装箱内包装物料！");
                $("#msg").css("color", "green");
                GrnCount = GrnCount + 1;
                return false;
            }
            return true;
        }


        /*得到选中记录的值*/
        function getSelectedValues() {
            var selValues = "";
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
            return selValues;
        }
        function highListCurrentItem(txtGRN) {
            $("#packingItemListTbl tr").each(function () {
                if ($(this).children("td:eq(1)").html() == txtGRN) {
                    $(this).addClass("StrongFont");
                }
            });
        }
        //赋值
        function setCartonSN(cartonsn) {
            $("#GrnPackingSN").html(cartonsn);
            $("#hdnCartonSN").val(cartonsn);
            $("#CartonSN").html(cartonsn);
        }
        //设置完成包装信息
        function setPackInfo(info) {
            var msg = "" + GrnCount == 2 ? "[" + OneGrn + "]" + "[" + info + "]<%=Resources.Messages.PackingSuccessful %>" : "[" + info + "]<%=Resources.Messages.PackingSuccessful %>";
            $("#msg").html(msg);
            $("#msg").css("color", "green");
            $("#txtGRN").val("");
            $("#txtGRN").focus();
            $("#txtGRN").select();
            $("#divPackScanCode").hide();
        }
        //包装成功显示列表
        function appendPackItem(grn) {
            $(".StrongFont").removeClass("StrongFont");
            var rows = $("#packingItemListTbl tr").length - 2;
            if (rows % 2 == 0) {
                $("<tr class='ListTableOddRow StrongFont'><td width='3%'>" + (rows + 1) + "</td><td>" + grn + "</td></tr>").appendTo($("#packingItemListTbl"));
            }
            else {
                $("<tr class='ListTableEvenRow StrongFont'><td width='3%'>" + (rows + 1) + "</td><td>" + grn + "</td></tr>").appendTo($("#packingItemListTbl"));
            }
            $("#packedItemQty").html((parseInt($("#packedItemQty").html()) + 1).toString());
        }

        function getPackedItemList(cartonsn) {
            $(".StrongFont").removeClass("StrongFont");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetPackedItemList(cartonsn);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var list = ajax.value;
            var l = "";
            var rows = $("#packingItemListTbl tr").length - 2;
            var scaningGRN = $.trim($("#txtGRN").val());
            for (var i = 0; i < list.length; i++) {
                if ((rows + i) % 2 == 0) {
                    if (list[i].SerialNumber == scaningGRN) {
                        l += "<tr class='ListTableOddRow StrongFont'><td width='3%'>" + (rows + i + 1) + "</td><td>" + list[i].SerialNumber + "</td></tr>";
                    }
                    else {
                        l += "<tr class='ListTableOddRow'><td width='3%'>" + (rows + i + 1) + "</td><td>" + list[i].SerialNumber + "</td></tr>";
                    }
                }
                else {
                    if (list[i].SerialNumber == scaningGRN) {
                        l += "<tr class='ListTableEvenRow StrongFont'><td width='3%'>" + (rows + i + 1) + "</td><td>" + list[i].SerialNumber + "</td></tr>";
                    }
                    else {
                        l += "<tr class='ListTableEvenRow'><td width='3%'>" + (rows + i + 1) + "</td><td>" + list[i].SerialNumber + "</td></tr>";
                    }
                }
            }
            $(l).appendTo($("#packingItemListTbl"));
            $("#packedItemQty").html(list.length.toString());
        }

        //完成包装箱
        function ClosePack() {
            var txtCartonSN = $("#hdnCartonSN").val();
            if (txtCartonSN == "") {
                alert("<%=Resources.Messages.NoCartonToClose %>");
                return false;
            }
            var grncount = $("#packingItemListTbl tr").length - 2;
            if (grncount == 0) {
                alert("<%=Resources.Messages.CartonCannotBeClosed %>");
                return false;
            }
            //if (grncount == 1) {
            //    alert("单个物料条码不需要包装操作！");
            //    return false;
            //}

            if (confirm(String.format("<%=Resources.Messages.ConfirmCloseCarton %>", txtCartonSN.toString(), grncount.toString()))) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ClosePack(txtCartonSN);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                $("#CartonSN").html("<span style='color:green;'>" + txtCartonSN + "[<%=Resources.lang.CartonIsClosed %>]</span>");
                $("#GrnPackingSN").html("");
                $("#hdnCartonSN").val("");
                $("#txtGRN").val("");
                $("#PackQty").text("");
                $("#txtGRN").focus();

                //$("#msg").html("正在打印...");
                //$("#msg").css("color", "green");
                showAreaMessge("供应商:" + $("#hdnVendorCode").val() + "开始生成包装箱，请稍候...", "messageGreen"); //messageRed,messageGreen

                var ajax11 = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetPackedItemList(txtCartonSN);
                if (ajax11.error != null) {
                    alert(ajax11.error.Message);
                    return false;
                }

                var list11 = ajax11.value;
                for (var i = 0; i < list11.length; i++) {
                    showAreaMessge("物料条码:" + list11[i].SerialNumber, "messageGreen");
                }
                printCartonLabel(txtCartonSN);

            }
        }
        function clearInfo() {
            $("#txtVendorCode").val("");
            $("#lblVendorName").text("");
            $("#GrnPackingSN").html("");
            $("#hdnCartonSN").val("");
            $("#txtGRN").val("");
            $("#PackQty").text("0");
            $("#txtGRN").focus();
            $("#CartonSN").html("");
            $("#packingItemListTbl tr:gt(1)").remove();
            $("#packedItemQty").html("0");
            $("#msg").html("");
            GrnCount = 0;
        }

        //打印包装箱
        function printCartonLabel(grn) {
            //获取包装箱物料信息
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitInfoByGRN(grn);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            labelItemId = entity.PartId

            //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
            SNInfo = {};
            SNInfo.SNList = [];
            SNInfo.SNList.push(grn);
            if (SNInfo.SNList.length == 0) return false;

            //根据打印方式决定 调用ZPL还是Lab打印
            getDocumentInfo();
            mesLabLabelPrint();

            setTimeout(function () {
                //document.forms[0].submit()
                clearInfo()
            }, 1000);
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = '<%=Request.QueryString["ItemID"] %>';    //ItemId
        var labelProdOrderId = '<%=Request.QueryString["OrderID"] %>';
        var labelStationId = -1;    //工位Id
        var labelType = -14;          //标签类型  (1.物料条码 2：包装条码)
        var labelSequence = 3;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径



        //获取文档模板基础信息
        function getDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId; //Label文档Id
                lableTypeQty = entity.PlateQty;           //连板数量
                //获取打印机名称值
                printName = $("#selPrintersList").val();
                labelPrintWayId = entity.PrintWayId;      //打印方式 78=Lab  79=ZPL
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return false;
            }
        }


        //codesoft打印  Lab模板方式
        function mesLabLabelPrint() {
            //从已释放的标签信息集合中，获取SN序列号集合。
            lableArr = SNInfo.SNList;
            var ShowInfo = "包装箱生成,打印成功";
            var labelStr = "";
            var printdata = [];
            /*循环GRN*/
            for (var i = 0; i < lableArr.length;) {
                //连片数
                if (lableTypeQty == 1) {
                    labelStr = lableArr[i];
                }
                else {
                    //每次重置一下
                    labelStr = "";
                    for (var j = 0; j < lableTypeQty; j++) {
                        if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {
                        }
                        else {
                            //根据联板数，拼接SN字符串。 
                            labelStr += lableArr[i + j] + ",";
                        }
                    }
                }
                showAreaMessge(lableArr[i] + ShowInfo, "messageGreen");
                i = i + lableTypeQty; //连片的递增
                //获取标签模板中的标签值 集合
                var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, -1);
                if (ajaxLabContent.error == null) {
                    try {
                        var list = ajaxLabContent.value;
                        if (list.length > 0) {
                            var page = { LabelContent: [] };
                            for (var k = 0; k < list.length; k++) {
                                page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                            }
                            printdata.push(page);
                        }
                    } catch (e) {
                        printdata = [];
                        alert(e);
                        //$("#lblMessage").html(e);
                        showAreaMessge(e, "messageRed"); //messageRed,messageGreen

                        return false;
                    }
                }
                else {
                    printdata = [];
                    alert(ajaxLabContent.error.Message);
                    //$("#lblMessage").html(ajaxLabContent.error.Message);
                    showAreaMessge(ajaxLabContent.error.Message, "messageRed");
                    return false;
                }
            }
            if (printdata.length == 0)
                return;
            try {
                sendPrintContent(JSON.stringify(printdata), printName, 1, labelDocumentId);
                $("#lblMessage").html("");
                showAreaMessge("供应商：" + $("#hdnVendorCode").val() + "打印完成", "messageGreen"); //messageRed,messageGreen
            } catch (e) {
                alert(e);
                //$("#lblMessage").html(e);
                showAreaMessge(e, "messageRed");
                return false;
            }
        }

        //#region 设置消息提示框样式
        /*
        * 设置消息提示框样式
        */
        function showAreaMessge(information, styleClass) {
            var currentTime = getDateTime();
            var messageBox = $("#activeinfoarea");
            var rows = 100;

            messageBox.find("span").eq(rows - 2).nextAll().remove(); //显示50条扫描记录        
            var html = "<span  class=" + styleClass + ">" + "[" + currentTime + "] " + information + "</span>" + '<br/>' + messageBox.html();
            messageBox.empty();
            messageBox.append(html);
        }
        /**
        *获取当前时间
        */
        function getDateTime() {
            var now = new Date();
            var year = now.getFullYear();
            var month = now.getMonth() + 1;
            var date = now.getDate();
            var hour = now.getHours();
            var min = now.getMinutes();
            var sec = now.getSeconds();
            var day = now.getDay();

            month = (month < 10) ? '0' + month.toString() : month.toString();
            date = (date < 10) ? '0' + date.toString() : date.toString();
            hour = (hour < 10) ? '0' + hour.toString() : hour.toString();
            min = (min < 10) ? '0' + min.toString() : min.toString();
            sec = (sec < 10) ? '0' + sec.toString() : sec.toString();
            return year.toString() + '年' + month.toString() + '月' + date.toString() + "日  " + hour.toString() + ":" + min.toString() + ":" + sec.toString();
        }

        function isIE() { //ie?
            if (!!window.ActiveXObject || "ActiveXObject" in window)
                return true;
            else
                return false;
        }
        //#endregion
    </script>
</asp:Content>
