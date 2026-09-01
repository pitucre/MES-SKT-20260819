<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master"
    AutoEventWireup="true" CodeBehind="SupplierMaterialAnalysis.aspx.cs" Inherits="SKT.LeanMES.Web.Material.SupplierMaterialAnalysis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <%--<div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>--%>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">供应商名称<em>*</em>
            </td>
            <td class="Field2">
                <input type="hidden" value="-1" id="hdnVenID" />
                <input type="hidden" value="" id="hdnVendorCode" />
                <input type="text" value="" id="txtVendorName" disabled="disabled" isrequired="1" />
                <input type="button" value="..." class="ButtonBox" onclick="chooseVendor()" />
            </td>
            <td class="Label2">
                物料编码<em>*</em>
            </td>
            <td class="Field2">
                <input type="hidden" value="-1" id="hdnItemId" />
                <input type="text" id="txtItemName" class="TextBox" isrequired='1' disabled="disabled" value="" /><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." onclick="selectItem()" />
            </td>
        </tr>
        <tr>

            <td class="Label2" id="tdLotCode">
                <%=Resources.lang.LotSize %>
            </td>
            <td class="Field2">
                <input class="TextBox" id="lblLotCode" />
            </td>
            <td class="Label2">
                <%=Resources.lang.ProduceDate %><em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtProdDate" class="" IsRequired='1' disabled="disabled"
                    runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">DateCode(周数)
            </td>
            <td class="Field2">
                <input class="TextBox" id="textDateCode" isnumber='1' />
            </td>
            <td class="Label2">MPN
            </td>
            <td class="Field2">
                <input class="TextBox" id="textMPN" />
            </td>
        </tr>
        <tr>
            <td class="Label2">数量<em>*</em>
            </td>
            <td class="Field2">
                <input class="TextBox" id="txtQuantity" isnumber='1' />
            </td>
            <td class="Label2">打印机名称
            </td>
            <td class="Field2">
                <select id="selPrintersList" style=" width: 250px; ">
                </select>
                <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机列表</a>
            </td>
        </tr>
        <tr>
            <td class="Label2">条码示例：
            </td>
            <td class="Field2" colspan="3">
                <label id="lblExample" style="font-weight:bold"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">已确认条码：
            </td>
            <td class="Field2" colspan="3">
                <label id="lblAffirm" style="font-weight:bold"></label>
            </td>
        </tr>
       <tr>
            <td class="Label2">
                请扫描条码:
            </td>
            <td class="Field2" colspan="2">
                <input type="text" value="" id="txtGRN" style="width: 98%; height: 40px;font-weight:bold;font-size:14px;border:blue 1px solid" />
            </td>
           <td class="Field2">
                <input type="button" id="txtUdfSave" style="font-weight:bold;font-size:15px;" onclick="AffirmScan()" value="确认扫描"/>
            </td>
        </tr>
    </table>
    <!--打印状态的信息提示区域-->
    <div id="lblMessage" class="Tips" style="text-align: center">
        <div id="lblPt" class="Tips">
        </div>
    </div>
    <div class="ListTableTitle">
        <div style="left: 10px; top: 5px; line-height: 18px;">
            <span>物料条码列表</span><span>      已扫描条码数量:</span><span id="Sum">0</span>
        </div>
    </div>
    <table class="ListTable" width="100%" id="tblRecHistory">
        <thead>
            <tr class="ListTableHeader" style="text-align: center">
                <th>序号</th>
                <th>数量</th>
                <th>物料编码</th>
                <th>批次号码</th>
                <th>制造日期</th>
                <th>MPN</th>
                <th>供应商代码</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <tr id="trLast" class="ListTableOddRow">
                <td colspan="9" style="text-align: center;">暂无数据
                </td>
            </tr>
        </tbody>
    </table>
    <div id="activeinfo" class="active-info">
        <div id="activeinfoarea" class="active-info-area" >
        </div>
    </div>
    <style type="text/css">
        .active-info
        {
            padding-right: 10px;
            padding-top: 5px;
            padding-left: 1px;
        }

        .active-info-area
        {
            color: Red;
            background-color: #ebebe4;
            width: 100%;
            outline: none;
            border: 1px solid #d3d3d3;
            overflow:auto;
            font-size:12px;
            font-weight:normal;
            line-height:16px;
            padding:3px;
            height:410px;
        }
    </style>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script type="text/javascript">
        var arrGRN = [];//离线登记的GRN列表
        var labelItemId = -1; //打印产品
        var factoryCode = "";
        var itemAllQty = 0;
        var alreadyQty = 0; //已经打印数量
        var bigCartonQty = 0; //外包装最小包装数量
        var selItemCode = '';
        var strBarCode = '';
        //修复IQC打印时，GRN没有绑定IQC单号的BUG   BirongLiang 2017-4-13
        var selIqcOrder = '';
        var qtyReg = /^(0\.?\d{0,3}|[1-9]\d*\.?\d{0,3})/;//正整数校验正则
        $(function () {
            bindPrinters('selPrintersList');
            BindDatepicker();
            $("#activeinfoarea").css("height", $(window).height() - 445 + "px");
        });

        $(document).ready(function () {
            $("#txtVendorCode").focus();
            var $target = $("input");
            $target.bind('keydown', function (e) {
                var key = e.which;
                if (key == 13) {
                    e.preventDefault();
                    var nxtIdx = $target.index(this) + 1;
                    if ($target.eq(nxtIdx - 1).attr("id") == "txtDateCode") {
                        Save();
                    }
                    else if ($target.eq(nxtIdx - 1).attr("type") == "button") {
                        $target.eq(nxtIdx - 1).click();
                        $target.eq(nxtIdx).focus();
                    }
                    else {
                        $target.eq(nxtIdx).focus();
                    }
                }
            });
            $(".DateTimeBox1").datepicker({ minDate: 0, maxDate: "+1M +10D" });
            
         
            //GRN扫描事件
            $("#txtGRN").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    //获取供应商
                    var VendorCode = $.trim($("#hdnVendorCode").val());
                    if (VendorCode == "") {
                        alert("请先选择供应商！");
                        $("#txtGRN").val('').focus();
                        return;
                    }
                    ////获取物料
                    //var itemId = $.trim($("#hdnItemId").val());
                    //if (itemId == "" || itemId == "-1") {
                    //    alert("请先选择物料编码！");
                    //    $("#txtItemName").focus();
                    //    $("#txtGRN").val('').focus();
                    //    return;
                    //}
                    //获取条码
                    var grn = $.trim($("#txtGRN").val().replace(":", "").replace("'", ""));
                    if (grn == '') {
                        alert("请扫描条码！");
                        $("#txtGRN").val('').focus();
                        return false;
                    }
                    var GrnInfo = grn.split(VendorDelimiter);
                    //if (GrnInfo.length != ContentList.length) {
                    //    alert("条码格式不正确,请参考条码示例！");
                    //    $("#txtGRN").val('').focus();
                    //    return false;
                    //}

                    //循环条码信息
                    for (var i = 0; i < ContentList.length; i++) {
                        var Isign = ContentVal[i];
                        Isign = Isign - 1;
                        if (ContentList[i] == "物料标签") {
                            //判断条码是否已经扫描
                            if (existsGRN(GrnInfo[Isign])) {
                                alert("条码已扫描");
                                $("#txtGRN").val('').focus();
                                return false;
                            }
                            //判断条码是否在MES中已经存在
                            //验证GRN是否存在
                            
                            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.OfflineValidateGRN(GrnInfo[Isign]);
                            if (ajax.error != null) {
                                alert(ajax.error.Message);
                                $("#txtGRN").val('').focus();
                                return false;
                            }
                            if (ajax.value != null && ajax.value != "") {
                                alert(ajax.value);
                                $("#txtGRN").val('').focus();
                                return false;
                            }
                        } else if (ContentList[i] == "供应商") {
                            //判断条码供应商与选择的供应商是否一致
                            if (GrnInfo[Isign] != VendorCode) {
                                alert("条码供应商与选择的供应商不一致！");
                                $("#txtGRN").val('').focus();
                                return false;
                            }
                        }
                        else if (ContentList[i] == "物料编码") {
                            //判断条码的物料编码与选择的物料编码是否一致
                            //var StrItemName = $("#txtItemName").val();
                            //if (GrnInfo[Isign] != StrItemName) {
                            //    alert("条码的物料编码与选择的物料编码不一致！");
                            //    $("#txtGRN").val('').focus();
                            //    return false;
                            //}

                           
                            //验证物料编码是否存在
                            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.VerifyItemCode(GrnInfo[Isign]);
                            if (ajax.error != null) {
                                alert(ajax.error.Message);
                                $("#txtItemName").val('');
                                return false;
                            }
                            $("#hdnItemId").val(ajax.value);
                            $("#txtItemName").val(GrnInfo[Isign]);
                        }
                        else if (ContentList[i] == "数量") {
                            ////判断数量是否为空
                            //if (GrnInfo[i] == "") {
                            //    alert("数量不能为空！");
                            //    $("#txtGRN").val('').focus();
                            //    return false;
                            //}
                            ////判断数量格式是否正确
                            //if (!qtyReg.test(GrnInfo[i])) {
                            //    alert("数量格式不正确");
                            //    $("#txtGRN").val('').focus();
                            //    return false;
                            //}
                            var reg = /[a-z,A-Z]/g;//匹配任意字母
                            var Letter = GrnInfo[Isign];
                            if (GrnInfo[Isign].match(reg) != null) {
                                var Letter = GrnInfo[Isign].match(reg).toString();
                                Letter = Letter.replace(/,/g, "");
                                Letter = GrnInfo[Isign].replace(Letter, "");
                            }
                            $("#txtQuantity").val(Letter);
                        }
                        else if (ContentList[i] == "批次号码") {
                            if (GrnInfo[Isign] != "" && GrnInfo[Isign] != null) {
                                $("#lblLotCode").val(GrnInfo[Isign]);
                            }
                        }
                        else if (ContentList[i] == "制造日期") {
                            if (GrnInfo[Isign] != "" && GrnInfo[Isign] != null) {
                                $("#txtProdDate").val(GrnInfo[Isign]);
                                var weekofyear = (((new Date(GrnInfo[Isign])) - (new Date(new Date().getFullYear(), 0, 1))) / (24 * 60 * 60 * 7 * 1000) | 0) + 1;
                                $("#textDateCode").val(Math.abs(weekofyear));
                            }
                        }
                        else if (ContentList[i] == "MPN") {
                            if (GrnInfo[i] != "" && GrnInfo[Isign] != null) {
                                $("#textMPN").val(GrnInfo[Isign]);
                            }
                        }
                        
                    }
                    strBarCode = grn;
                }
            });
        });

        //确认扫描结果
        function AffirmScan() {
            var objGRN = {};//单个扫码的GRN对象，包括数量
            //objGRN.GRN = WLBQ;
            objGRN.ID = arrGRN.length+1;
            objGRN.GYS = $("#hdnVendorCode").val();
            objGRN.WLBM = $("#txtItemName").val();
            objGRN.PCHM = $("#lblLotCode").val();
            objGRN.ZZRQ = $("#txtProdDate").val();
            objGRN.MPN = $("#textMPN").val();
            objGRN.Qty = $("#txtQuantity").val();
            objGRN.SCZS = $("#textDateCode").val();
            arrGRN.push(objGRN);
            $("#lblAffirm").text(strBarCode);
            $("#txtGRN").val("").focus();
            Show();
        }
        function Show() {
            var data = "";
            $("#tblRecHistory tbody").html("");
            
            //将GRN数组拼接成HTML代码
            var html = bullderScanHtml();
            $("#tblRecHistory tbody").append(html);

            var grnSum = getScanGRNCount();
            $("#Sum").html(grnSum);
        }
        //将GRN数组拼接成HTML代码
        function bullderScanHtml() {
            var html = "";
            for (var i = 0; i < arrGRN.length; i++) {
                html += "<tr><td class='Field1' style='width:5%;text-align: center;'>" + (i + 1) + "</td>"
                    + "<td class='Field1' style='width:5%;text-align: center;'>" + arrGRN[i].Qty + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrGRN[i].WLBM + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrGRN[i].PCHM + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrGRN[i].ZZRQ + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrGRN[i].MPN + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'>" + arrGRN[i].GYS + "</td>"
                    + "<td class='Field1' style='width:10%;text-align: center;'><img title='删除' src='../Content/images/delete.gif' onclick=Delet('" + arrGRN[i].ID + "')></img></td></tr>";
            }
            return html;
        }
        //删除GRN
        function Delet(id) {
            var idx = -1;
            for (var i = 0; i < arrGRN.length; i++) {
                if (arrGRN[i].ID == id) {
                    idx = i;
                    break;
                }
            }
            if (idx > -1) {
                arrGRN.splice(idx, 1);
            }
            //重置列表
            var html = bullderScanHtml();
            $("#tblRecHistory tbody").html(html);
            var grnSum = getScanGRNCount();
            $("#Sum").html(grnSum);
        }
        //获取扫描GRN的总数量
        function getScanGRNCount() {
            var count = 0;
            for (var i = 0; i < arrGRN.length; i++) {
                count = parseFloat(count) + parseFloat(arrGRN[i].Qty);
            }
            return count;
        }

        var IsSupplierPeriod = 2;//供应商是否交期维护：1：需要 2：不需要 默认不需要
        function showIsSuppler() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfig(6);
            if (ajax.error == null) {
                var entity = $.parseJSON(ajax.value).data[0];
                IsSupplierPeriod = entity.ChoosePageId;
            }
        }
        //2017-10-17 胡芳 根据选择时间设置DateCode(周数)
        function BindDatepicker() {
            $(".DateTimeBox1").datepicker({
                showOn: "button",
                buttonImageOnly: true,
                showHms: _isHms,
                buttonText: "<%=Resources.Common.ChooseDate %>",
                onSelect: function () {
                    if (_isHms) {
                        var objme = $(this);
                        if (typeof (objme.attr("_isHms")) == "undefined") {
                            if (objme.val().length > 10) {
                                objme.css("width", "140px");
                            }
                        } else { objme.val(objme.val().substring(0, 10)); }
                    }
                    var time1 = $(".DateTimeBox1").val();
                    var weekofyear = (((new Date(time1)) - (new Date(new Date().getFullYear(), 0, 1))) / (24 * 60 * 60 * 7 * 1000) | 0) + 1;
                    $("#textDateCode").val(Math.abs(weekofyear));
                },
                gotoCurrent: true,
                changeMonth: true,
                changeYear: true
            });
        }
        //选择采购单号
        var printChoosePageId = 101;
        //选中供应商
        function chooseVendor() {
            if (arrGRN.length>0) {
                if (!window.confirm("是否清除上个供应商已扫描的物料信息？")) {
                    return false;
                }
                Empty();
            }
           dialog({
               title: "<%=Resources.Common.ChooseWindow %>",
               src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&CallBackFunc=setVendor&Multiple=false&rnd=" + Math.random(), width: 680, height: 350
            });
        }
        function setVendor(list) {
            GetOffLineLabel(list[0][1]);
            $("#hdnVenID").val(list[0][0]);
            $("#txtVendorName").val(list[0][2]);
            $("#hdnVendorCode").val(list[0][1]);
            $("#txtVendorName").attr("disabled", "disabled");
        }

        //选择产品
        function selectItem() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }

        function getChooseValue(list) {
            $("#txtItemName").val(list[0][2]);
            $("#hdnItemId").val(list[0][0]);
            $("#txtItemName").attr("disabled", "disabled");
        }

        //清空所有的数据
        function Empty(flag) {
            
            $("#txtItemName").val("");
            $("#hdnItemId").val(-1);
            $("#txtQuantity").val("");
            $("#textMPN").val("");
            $("#textDateCode").val("");
            $("#txtProdDate").val("");
            $("#lblLotCode").val("");
            $("#lblAffirm").text("");
            strBarCode = "";
            $("#tblRecHistory tbody").html("");
            arrGRN = [];
            $("#Sum").html(0);
        }

        var ContentList = []
        var ContentVal = []
        //根据供应商ID读取供应商配置
        function GetOffLineLabel(VendorCode) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetOffLineLabel(VendorCode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            if (entity != null && entity.length > 0) {
                VendorDelimiter = entity[0].Delimiter;
                ContentList = [];
                ContentVal = [];
                var StrHint = "";
                for (var i = 0; i < 10; i++) {
                    var Boolean = true;
                    for (var j = 0; j < entity.length; j++) {
                        if (entity[j].Paragraph == (i + 1)) {
                            ContentList.push(entity[j].DetailContent);
                            ContentVal.push(entity[j].Paragraph);
                            StrHint += entity[j].DetailContent + VendorDelimiter;
                            Boolean = false;
                            break;
                        }
                    }
                    if (Boolean) {
                        StrHint += "NA" + VendorDelimiter;
                    }
                }
                //StrHint = StrHint.substring(0, StrHint.length - 1);
                $("#lblExample").text(StrHint);
                
            } else {
                alert("该供应商还未设置标准离线标签配置，请先前往[仓库管理-仓库数据配置-离线标签配置列表]进行配置");
                ContentList = [];
                ContentVal = [];
                return false;
            }
            
        }

        
        function existsObj(Paragraph, List) {
            for (var i = 0; i < List.length; i++) {
                if (List[i].Paragraph == Paragraph) {
                    ContentList.push(entity[i].DetailContent);
                    ContentVal.push(entity[i].Paragraph);
                    StrHint += entity[i].DetailContent + VendorDelimiter;
                    return true;
                }
            }
            return false;
        }

        function Save() {
            labelItemId = $("#hdnItemId").val();
            var VendorCode = $("#hdnVendorCode").val();
            if (arrGRN.length <= 0) {
                alert("物料条码列表没有需要打印的GRN，请先扫描！");
                return false;
            }
            var list = [];
            for (var i = 0; i < arrGRN.length; i++) {
                var entity = {};
                entity.Qty = arrGRN[i].Qty;
                entity.LotCode = arrGRN[i].PCHM;
                entity.ProdDate = arrGRN[i].ZZRQ;
                entity.MPN = arrGRN[i].MPN;
                entity.DateCode = arrGRN[i].SCZS;
                list.push(entity);
            }


            if (!window.confirm("<%=Resources.Messages.ConfirmPrintTheseGRNs %>")) {
                return false;
            }
            //$("#lblMessage").html("正在生成GRN，请稍候...");
            showAreaMessge("供应商：" + $("#txtVendorName").val() + ",物料编码:" + $("#txtItemName").val() + "开始生成GRN，请稍候...", "messageGreen"); //messageRed,messageGreen
            setTimeout(function () {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SupplierMaterialPrint(list, parseInt(labelItemId), VendorCode);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    //$("#lblMessage").html(ajax.error.Message);
                    //$("#lblMessage").css("color", "red");
                    showAreaMessge(ajax.error.Message, "messageRed");
                    return false;
                }
                var arr = ajax.value;
                if (arr != null) {
                    //$("#lblMessage").html("<%=Resources.Messages.GenGrnFinishAndPrintInProcess %>");
                    setTimeout(function () {
                        try {
                            printGRN(arr);

                        }
                        catch (e) {
                            alert(e);
                            //$("#lblMessage").html(e);
                            showAreaMessge(e, "messageRed");
                        }
                    }, 100);
                }
            }, 100);
        }


        function printGRN(arr) {
            if (arr == null) {
                return false;
            }
            arr[0] = arr[0].substring(0, arr[0].lastIndexOf(","));
            arr[1] = arr[1].substring(0, arr[1].lastIndexOf(","));
            grnArr = arr[0].split(","); //物料条码
            //将GRN信息添加到SNInfo的SNInfo.SNList集合中
            SNInfo = {};
            SNInfo.SNList = grnArr;
            //根据打印方式决定 调用ZPL还是Lab打印
            usePrinGRNMethod();
            if (bigCartonQty != 0) {
                usePrintCartonMethod();
            }
            //打印完成刷新页面
            setTimeout(function () {
                //document.forms[0].submit();
                showAreaMessge("供应商：" + $("#txtVendorName").val() + ",物料编码:" + $("#txtItemName").val() + "打印完成", "messageGreen"); //messageRed,messageGreen
                Empty(2);
            }, 1000);
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelStationId = -1;    //工位Id
        var labelType = -3;          //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单)
        var labelSequence = 2;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径

        //获取物料条码文档模板基础信息
        function getGRNDocumentInfo() {
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

        //获取包装箱条码文档模板基础信息
        function getCartonDocumentInfo() {
            labelType = -4; //包装类型
            labelSequence = 3;

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

        //根据打印方式决定 调用ZPL还是Lab打印
        function usePrinGRNMethod() {
            getGRNDocumentInfo();
            mesLabLabelPrint(1);
        }

        function usePrintCartonMethod() {
            getCartonDocumentInfo();
            mesLabLabelPrint(2);
        }


        //codesoft打印  Lab模板方式
        function mesLabLabelPrint(printType) {
            //从已释放的标签信息集合中，获取SN序列号集合。
            var ShowInfo = "";
            if (printType == 1) {  //物料条码
                lableArr = SNInfo.SNList;
                ShowInfo = "条码生成,打印成功";
            }
            else if (printType == 2) {
                lableArr = SNInfo.CartonList;
                ShowInfo = "包装箱生成,打印成功";
            }
            var labelStr = "";
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
                        $("#lblMessage").html(e);
                        return false;
                    }
                }
                else {
                    printdata = [];
                    alert(ajaxLabContent.error.Message);
                    $("#lblMessage").html(ajaxLabContent.error.Message);
                    return false;
                }
            }
            if (printdata.length == 0)
                return;
            try {
                sendPrintContent(JSON.stringify(printdata), printName, 1, labelDocumentId);
            } catch (e) {
                alert(e);
                $("#lblMessage").html(e);
                return false;
            }
        }

        function toThousands(s) {
            if (/[^0-9\.]/.test(s)) return "不是数值类型";
            s = s.replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
            return s;
        }
        //生产虚拟采购订单
        function SaveVirtualPo() {
            var VenID = $("#hdnVenID").val();
            var VendorName = $("#txtVendorName").val();
            var VendorCode = $("#hdnVendorCode").val();
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/GenerateVirtualPo.aspx?name=GenerateVirtualPo&VenID=" + VenID + "&VendorName=" + VendorName + "&VendorCode=" + VendorCode;
            dialog({ title: "生产虚拟采购订单", src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth-100) });
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
            var html = "<span  style='font-size:13px;font-weight:normal;' class=" + styleClass + ">" + "[" + currentTime + "] " + information + "</span>" + '<br/>' + messageBox.html();
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