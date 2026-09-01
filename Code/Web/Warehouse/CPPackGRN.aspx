<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="CPPackGRN.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.CPPackGRN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <!--打印插件未安装的提示区域-->
    <div id="noprtplg" class="Tips">
    </div>
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1" style="font-size: 22px; font-weight: bold;">成品包装箱条码:
            </td>
            <td class="Field1" align="center"  style="font-size: 22px; font-weight: bold;">
                <span id="GrnPackingSN" style="font-size: 22px; font-weight: bold;"></span>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.SN %><em>*</em>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtGRN" class="TextBox" style="width: 250px; height: 25px; text-transform: uppercase; font-size: 16px; font-weight: bold;" />
                <input type="hidden" value="" id="hdnVendorCode" />
                <input class="TextBox" id="hidtxt" style="display: none;" />
            </td>
        </tr>
         <tr>
         <td class="Label1">
            是否打印
         </td>
         <td class="Field1">
                <asp:CheckBox ID="IsCheckPrint" runat="server" ClientIDMode="Static" />
           
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
                <th>成品编码
                </th>
                <th>成品名称
                </th>
                <th>供应商名称
                </th>
                <th>批次号
                </th>
            </tr>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="7" style="text-align: center;">
                    <span>暂无数据</span>
                </td>
            </tr>
        </table>
    </div>
    <div class="clear5">
    </div>
    <div id="lblPt" class="Tips">
    </div>
    <div id="packingItemList">
        <table class="ListTable" width="100%" >
            
            <tr class="ListTableHeader">
                <th align="left" colspan="7">
                  成品包装箱条码&nbsp;&nbsp;<span id="CartonSN"></span>    <span>总数量</span> <span id="PackQty">0</span>
                </th>
            </tr>
            <tr class="ListTableEvenRow">
                <td align="left" colspan="7">
                    <%=Resources.lang.PackedGRN %><span id="packedItemQty">0</span>
                </td>
            </tr>

            <tr class="ListTableHeader">
                <th>
                  序号
                </th>
                <th>产品条码
                </th>
                <th>产品编码
                </th>
                <th>产品名称
                </th>
                <th>工单号
                </th>
                <th>数量
                </th>
                   <th>操作
   </th>
</tr>
           <tbody id="packingItemListTbl">

           </tbody>
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
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 700, height: 350 });
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
            //回车包装
            $("#txtGRN").keydown(function (event) {
                var e = event || window.event
                if (e && e.keyCode == 13) {
                    if ($.trim($("#txtGRN").val()) != "") {
                        PackGRN();
                    }
                    else {
                        alert("请先扫描成品条码");
                        $("#txtGRN").focus();
                        $("#txtGRN").select();
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
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ValidateGRN(txtGRN, hdnCartonSN, vendorCode, firstGrn);
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
                $("#txtGRN").focus();
                $("#msg").css("color", "red");
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
                $("#msg").html("成功打开旧包装，您可以继续往该包装箱内包装成品！");
                $("#msg").css("color", "green");
                GrnCount = GrnCount + 1;
                firstGrn = $.trim($("#txtGRN").val());
                return false;
            }
            firstGrn = $.trim($("#txtGRN").val());
        }
        //获取供应商信息
        function getvendorCode(grn) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitInfoByGRN(grn);
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            var data = ajax.value;
            if (data != null) {
                $("#txtVendorCode").val(data.VendorCode);
                vendorCode = data.VendorCode;
                $("#hdnVendorCode").val(data.VendorCode);
                if (vendorCode == null || vendorCode == "" || vendorCode == undefined) {
                    $("#msg").html("成品条码无效！");
                    $("#msg").css("color", "red");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }
                return true;
            }
            else {
                $("#msg").html("成品条码无效！");
                $("#msg").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            return false;
        }


        //包装GRN
        function PackGRN() {

            $("#msg").html("");
            $("#msg").css("color", "red");
            $(".StrongFont").removeClass("StrongFont");
            var txtGRN = $.trim($("#txtGRN").val());
            var hdnCartonSN = $.trim($("#hdnCartonSN").val());
           
            if (txtGRN == "") {
                alert("请扫SN条码！");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            if (firstGrn == "") {
                firstGrn = $.trim($("#txtGRN").val());
            }
            var info = {SN: txtGRN, PackSN: hdnCartonSN };

            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCheckCPIsBox", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var jsonInfo = JSON.parse(ajax.value).data[0];
      
            if (jsonInfo.IsBox) {
                if (!window.confirm("该条码【" + txtGRN + "】已存在包装【" + jsonInfo.ContainerSN + "】，是否解除包装!")) {
                    return false;
                }
            }

            info = { SN: txtGRN, FirstSN: firstGrn, PackSN: hdnCartonSN,     UserId: userId, };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspValidateSN", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = JSON.parse(ajax.value);
            var boxInfo = list.data[0];
            $("#PackQty").text(boxInfo.PackQty);
          
            setCartonSN(boxInfo.ContainerSN);

            for (var i = 0; i < list.data.length; i++) {
                appendPackItem(list.data[i]);
            }

            $("#txtGRN").val("").focus();
            $("#txtGRN").select();
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
                $("#msg").html("成功打开旧包装，您可以继续往该包装箱内包装成品！");
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
        function appendPackItem(data) {
            var isCZ = true;
            $("#packingItemListTbl tr").each(function (obj, i) {

                if ($(this).find("td:eq(1)").text() == data.SN)
                {
                    isCZ = false;
                }    ;
            });
            if(isCZ){
                $(".StrongFont").removeClass("StrongFont");
                var rows = $("#packingItemListTbl tr").length;
                if (rows % 2 == 0) {
                    $("<tr class='ListTableOddRow StrongFont'><td width='3%'>" + (rows + 1) + "</td><td>" + data.SN + "</td><td>" + data.ItemCode + "</td><td>" + data.ItemName + "</td><td>" + data.OrderNo + "</td><td>" + data.BatchQty + "</td><td><a href='#' onclick ='Clear(this,\"" + data.SN +"\")'>移除</a></td></tr>").appendTo($("#packingItemListTbl"));
                }
                else {
                    $("<tr class='ListTableEvenRow StrongFont'><td width='3%'>" + (rows + 1) + "</td><td>" + data.SN + "</td><td>" + data.ItemCode + "</td><td>" + data.ItemName + "</td><td>" + data.OrderNo + "</td><td>" + data.BatchQty + "</td><td><a href='#' onclick ='Clear(this,\"" + data.SN +"\")'>移除</a></td></tr>").appendTo($("#packingItemListTbl"));
                }
                    $("#packedItemQty").html((parseInt($("#packedItemQty").html()) + 1).toString());
            }
        }

        function Clear(obj,sn) {
            if (confirm("确认移除吗?")) {
                var info = { SN: sn, UserId: userId };
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspUnSNPack", JSON.stringify(info));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                $(obj).parent().parent().remove();
                $("#PackQty").text($("#PackQty").text()-1);

            }
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
            var grncount = $("#packingItemListTbl tr").length;
            if (grncount == 0) {
                alert("<%=Resources.Messages.CartonCannotBeClosed %>");
                return false;
            }
         
            if (confirm(String.format("<%=Resources.Messages.ConfirmCloseCarton %>", txtCartonSN.toString(), grncount.toString()))) {
                var snAttr = "";
                $("#packingItemListTbl tr").each(function (obj, i) {
                    if (snAttr != '') {
                        snAttr +=","
                    }
                    snAttr += $(this).find("td:eq(1)").text();
                });
               
                var info = { ContainerSN: txtCartonSN, SNAttr: snAttr, UserId: userId };

                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSaveCpPack", JSON.stringify(info));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var jsonInfo = JSON.parse(ajax.value).data[0];
                labelItemId = jsonInfo.ItemId;
                $("#packingItemListTbl tr").remove()
                $("#CartonSN").html("<span style='color:green;'>" + txtCartonSN + "[<%=Resources.lang.CartonIsClosed %>]</span>");
                $("#GrnPackingSN").html("");
                $("#hdnCartonSN").val("");
                $("#PackQty").text("");
                $("#txtGRN").val("");
                $("#txtGRN").focus();
                firstGrn = "";
                clearInfo();
                //$("#msg").html("正在打印...");
                //$("#msg").css("color", "green");

                
                if ($("#<%=this.IsCheckPrint.ClientID%>").prop("checked")) {
                    showAreaMessge("包装完成,开始打印包装箱，请稍候...", "messageGreen"); //messageRed,messageGreen
                    printCartonLabel(txtCartonSN);
                } else {
                    showAreaMessge("包装完成!", "messageGreen"); //messageRed,messageGreen
                }

               

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
            ////获取包装箱成品信息
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitInfoByGRN(grn);
            //if (ajax.error != null) {
            //    alert(ajax.error.Message);
            //    return false;
            //}
            //var entity = ajax.value;
            //labelItemId = entity.PartId

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
        var labelType = -4;          //标签类型  (1.成品条码 2：包装条码)
        var labelSequence = 8;      //标签序号
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
            var labelStr = "";
            var ShowInfo = "包装箱生成,打印成功";
            var printdata = [];
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
            } catch (e) {
                alert(e);
                //$("#lblMessage").html(e);
                showAreaMessge(e, "messageRed");
                return false;
            }
            ibs = 3;
            setTimeout(function () {
                //$("#lblMessage").html('条码打印完成!');
                showAreaMessge( "打印完成", "messageGreen"); //messageRed,messageGreen
            }, 300);
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

