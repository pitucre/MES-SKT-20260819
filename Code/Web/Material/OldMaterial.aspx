<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="OldMaterial.aspx.cs" Inherits="SKT.LeanMES.Web.Material.OldMaterial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <style type="text/css">
        .tabs-oldmaterial {
            width: 99.7%;
            height: 30px;
            margin-left: 2px;
        }

            .tabs-oldmaterial div {
                width: 120px;
                height: 20px;
                line-height: 20px;
            }

        .tabs-oldmaterialContent {
        }

            .tabs-oldmaterialContent div {
                padding: 2px;
            }

            .tabs-oldmaterialContent input[type=text] {
                float: left;
                display: inline;
            }

            .tabs-oldmaterialContent label {
                float: left;
                display: inline;
                line-height: 18px;
            }

        .CartonGrnListTitle {
            line-height: 18px;
            position: relative;
        }

        .currentrow {
            font-weight: bold;
        }

        .CartonGrnListTitle .title {
            left: 5px;
            top: 0px;
            position: absolute;
        }

        .CartonGrnListTitle .button {
            right: 5px;
            top: 0px;
            position: absolute;
            border: 0px;
            background: transparent;
        }

        #lblMessage {
            word-wrap: break-word;
            overflow: hidden;
        }
    </style>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <div id="noprtplg" class="Tips">
    </div>

    <div class="clear5">
    </div>
    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="打印历史物料标签">打印历史物料标签 </li>
            <%--<li class="" title="包装历史物料">包装历史物料 </li>--%>
        </ul>
        <!--历史物料打印标签-->
        <div id="infoTabContent-1" class="tb_c tb_content">
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label2">选择物料<em>*</em>
                    </td>
                    <td class="Field2">
                        <input type="hidden" value="-1" id="hdnItemId" />
                        <input type="hidden" value="" id="hdnItemCode" />
                        <input type="text" value="" isrequired="1" id="lbItemCode" disabled="disabled" /><input type="button" value="..." class="ButtonBox"
                            onclick="chooseMaterial()" />
                    </td>
                    <td class="Label2">
                        <%=Resources.lang.MaterialName %>
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblItemName" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">选择供应商<em>*</em>
                    </td>
                    <td class="Field2">
                        <input type="hidden" value="" id="hdnVendorCode" />
                        <input type="text" value="" id="txtVendorCode" isrequired="1" /><input type="button" value="..."
                            class="ButtonBox" onclick="chooseVendor(1)" />
                    </td>
                    <td class="Label2">供应商名称
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblVendorName" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">打印物料数量<em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:HiddenField ID="hdnPOLineGrnQty" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnPOQty" runat="server" Value="0" />
                        <input type="text" id="txtGRNQty" class="TextBox" isrequired="1" value="" onkeyup="if(isNaN(value))execCommand('undo')"
                            onafterpaste="if(isNaN(value))execCommand('undo')" />
                    </td>
                    <td class="Label2">
                        <%=Resources.lang.MinPackageQty%><em>*</em>
                    </td>
                    <td class="Field2">
                        <input type="text" id="txtQty" class="TextBox" isrequired="1" value="" onkeyup="if(isNaN(value))execCommand('undo')"
                            onafterpaste="if(isNaN(value))execCommand('undo')" />
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.LotSize %><em>*</em>
                    </td>
                    <td class="Field2">
                        <input type="text" id="txtLotCode" class="TextBox" isrequired="1" />
                        <%--<asp:Label runat="server" ID="lblLotCode"></asp:Label>--%>
                    </td>
                    <td class="Label2">
                        <%=Resources.lang.ProduceDate %><em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtProdDate" ReadOnly="true" class="DateTimeBox1" runat="server" ClientIDMode="Static" IsRequired="1" />
                    </td>
                </tr>
                <tr>
                    <td class="Label2">DateCode(周数)
                    </td>
                    <td class="Field2">
                        <input class="TextBox" id="textDateCode" isnumber='1' type="number" min="1" onblur="if(value <0 ){value = '1'}" />
                    </td>
                    <td class="Label2">MPN
                    </td>
                    <td class="Field2">
                        <input class="TextBox" id="textMPN" />
                    </td>
                </tr>
                <tr>
                    <td class="Label2">打印机名称<em>*</em>
                    </td>
                    <td class="Field2">
                        <select id="selPrintersList" style="width: 250px;">
                        </select>
                        <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机列表</a>
                    </td>
                    <td class="Label2">入库日期<em>*</em></td>
                    <td class="Field2">
                        <asp:TextBox ID="txtStorageDate" class="DateTimeBox1" runat="server" ClientIDMode="Static" IsRequired="1" />
                    </td>
                </tr>
                <tr>
                    <td id="lblWhCode" class="Label2">仓库<em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtWhCode" runat="server" IsRequired="1" CssClass="TextBox" ClientIDMode="Static"
                            ReadOnly="true"></asp:TextBox><input id="button1" class="ButtonBox" type="button" onclick="selectWhCodeList()"
                                value="..." title="选择仓库" />
                        <asp:HiddenField ID="hdnWhCode" runat="server" Value="" ClientIDMode="Static" />
                    </td>
                    <td id="lblCbarCode" class="Label2">库位<em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtCbarCode" runat="server" IsRequired="1" CssClass="TextBox" ClientIDMode="Static"
                            ReadOnly="true"></asp:TextBox><input id="button2" class="ButtonBox" type="button" onclick="selectWhBarCodeList()"
                                value="..." title="选择库位" />
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.Remark%>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" ClientIDMode="Static"
                            TextMode="MultiLine" Width="41%"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <div class="clear5">
            </div>
            <%--            <div style="text-align: center;">
                <input type="button" value="打印历史物料" onclick="PrintOldMaterialLabel()" />
                </div>--%>
        </div>
        <!--/历史物料打印标签-->

    </div>

    <div id="lblMessage" class="Tips" style="text-align: center">
        <div id="lblPt" class="Tips">
        </div>
    </div>
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
    <asp:HiddenField runat="server" ID="hdnLabelContent" Value="" />
    <asp:HiddenField runat="server" ID="hdnLabelCartonContent" Value="" />
    <asp:HiddenField runat="server" ID="hdnLabelCnt" Value="" />

    <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
        type="text/javascript" charset="GBK"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
        type="text/javascript"></script>
    <script type="text/javascript">

        var lableDocumentId = 0;
        var IsRequierdWh = true;    //是否仓库、库位必填

        $(function () {
            //是否启用历史物料打印到产线
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfigByConfigType("24");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                var entity = ajax.value;
                if (entity && entity.ConfigResult == "1") { //启用
                    IsRequierdWh = false;
                    $("#lblWhCode em:first").hide();
                    $("#lblCbarCode em:first").hide();
                    $("#<%=this.txtWhCode.ClientID %>").removeAttr("IsRequired");
                    $("#<%=this.txtCbarCode.ClientID %>").removeAttr("IsRequired");
                }
            }

            bindPrinters('selPrintersList');
            /*包装物料时输入物料序列号回车后进行包装*/
            $("#txtGrn").enterKey("packGrn");
            $("#txtVendorCode").enterKey("getVendorInfo");
            $("#lbItemCode").enterKey("getItemInfo");
            $("#txtVendorCode2").enterKey("getVendorInfo2");
            //获取批次号
            getLotCode();

            //获取本地计算机打印机名字列表方法
            //lblprintLabel = document.getElementById("printLabel");
            //lblprintLabel.GetLocalPrintersList();
            //绑定计算机列表值


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
            BindDatepicker();
            $("#txtStorageDate").val(GetDateStr(0));
            $("#activeinfoarea").css("height", $(window).height() - 406 + "px");
        });
        //2017-10-17 胡芳 根据选择时间设置DateCode(周数)
        function BindDatepicker() {
            $(".DateTimeBox1").datepicker({
                showOn: "button",
                buttonImageOnly: true,
                showHms: _isHms,
                maxDate: 0,
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
        /*选择物料*/
        function chooseMaterial() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        /*选择供应商*/
        function chooseVendor(i) {
            if (i == 1) {
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&CallBackFunc=setVendor&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
            }
            else {
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&CallBackFunc=setVendor2&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
            }
        }

        /*获取物料信息*/
        function getChooseValue(list) {
            console.log(list);
            $("#hdnItemId").val(list[0][0]);
            $("#hdnItemCode").val(list[0][2]);
            $("#lbItemCode").val(list[0][2]);
            //$("#txtQty").val(parseInt(list[0][4]));
            $("#<%=this.lblItemName.ClientID %>").text(list[0][1]);
            setTimeout(function () {
                $("#txtVendorCode").focus();
            }, 10);
        }

        /*获取供应商信息*/
        function setVendor(list) {
            $("#hdnVendorCode").val(list[0][1]);
            $("#txtVendorCode").val(list[0][1]);
            $("#<%=this.lblVendorName.ClientID %>").text(list[0][2]);
            setTimeout(function () {
                $("#txtGRNQty").focus();
            }, 10);
        }

        /*获取供应商信息 包装历史物料*/
        function setVendor2(list) {
            $("#hdnVendorCode2").val(list[0][1]);
            $("#txtVendorCode2").val(list[0][1]);
            $("#lblVendorName2").html(list[0][2]);
            setTimeout(function () {
                $("#txtGrn").focus();
            }, 10);
        }
        var list;
        var grnArr;
        var txtNoQty = 0; //送货数量/最小包装数量的余数
        var txtPrintQty = 0; //本次打印数量(送货数量/最小包装数量)

        /*生成并打印历史物料标签*/
        function PrintOldMaterialLabel() {
            if (!SubmitValidation()) {
                return false;
            }
            var itemId = $("#hdnItemId").val();
            var vendorCode = $("#hdnVendorCode").val();
            var printMaterialQty = $("#txtGRNQty").val().replace(/,/g, "");
            var minQty = $("#txtQty").val().replace(/,/g, "");
            var lotCode = $("#txtLotCode").val();
            var productDate = $("#<%=this.txtProdDate.ClientID %>").val();
            var remark = $("#txtRemark").val();
            var str = "";
            var moveCount = 0;

            var errorStr = "";

            /*物料，打印数量，最小包装数量，批次号为必填项*/
            if (itemId == -1) {
                errorStr += "请选择一种物料来打印标签\n";
            }

            if ($.trim(printMaterialQty) == "" || parseFloat(printMaterialQty) <= 0) {
                errorStr += "请输入要打印标签的物料数量，打印标签的数量不能为空且须大于零\n";
            }

            if ($.trim(minQty) == "" || parseFloat(minQty) <= 0) {
                errorStr += "请输入物料最小包装数量，最小包装数量不能为空且须大于零，且不能大于打印标签的物料数量\n";
            }

            if (lotCode == "") {
                errorStr += "批次号不能为空\n";
            }

            /*显示错误提示*/
            if ($.trim(errorStr) != "") {
                alert(errorStr);
                return false;
            }
            if (IsRequierdWh) {
                //校验货位产品唯一
                if (!verifyProductOnly("", $("#hdnItemCode").val(), $("#txtCbarCode").val())) return false;
            }

            if (vendorCode == "") {
                vendorCode = "-1";
            }
            if (!window.confirm("<%=Resources.Messages.ConfirmPrintTheseGRNs %>")) {
                return false;
            }
            /*生成物料标签*/
            showAreaMessge("物料编码:" + $("#lbItemCode").val() + "开始生成GRN，请稍候...", "messageGreen"); //messageRed,messageGreen
            // $("#lblMessage").html("正在生成历史物料标签条码，请稍后...");

            txtPrintQty = parseInt(printMaterialQty / minQty); //生成GRN数量
            txtNoQty = (printMaterialQty % minQty); //尾数

            var entity = {};
            entity.ItemId = parseInt(itemId);
            entity.VendorCode = vendorCode;
            entity.GRNQty = parseFloat(txtPrintQty); //打印数量
            entity.MinQty = parseFloat(minQty); //最小包装数量
            entity.SurplusQty = txtNoQty; //尾数数量
            entity.DateCode = productDate; //生产日期
            entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.CWhCode = $("#hdnWhCode").val(); //仓库编码
            entity.CBarCode = $("#txtCbarCode").val(); //库位条码
            entity.LotCodes = $("#txtLotCode").val();

            entity.WeekCode = $("#textDateCode").val();//DateCode
            entity.MPN = $("#textMPN").val();//MPN
            entity.StorageDate = $("#txtStorageDate").val(); //入库日期
            entity.Remark = remark; //备注
            <%--entity.LotCodes = $("#<%=this.lblLotCode.ClientID %>").text();--%>//Modify By ZhiMan.Yuan 2017-3-6,修改打印历史物料条码时，未调用页面生成的批次 而使用存储过程再次生成批次号的问题。
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.ExecuteSpc("uspGenerateOldMaterialSN", JSON.stringify(entity));

            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GenerateOldMaterialGRN(parseInt(itemId), vendorCode, parseFloat(txtPrintQty), parseFloat(minQty), txtNoQty, lotCode, productDate);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                showAreaMessge(ajax.error.Message, "messageRed");
                return false;
            }
            var arr = $.parseJSON(ajax.value).data; //Modify By Alen 2017-03-05 data1 -> data;
            if (arr != null) {
                try {
                    printGRN(arr);
                }
                catch (e) {
                    alert(e);
                    showAreaMessge(e, "messageRed");
                }
            }
        }


        var grnArr;
        var itemInfo;
        var vendorSort;
        var __txtQty = 0;
        var __txtLeft = 0;
        function printGRN(arr) {
            if (arr[0].GRNString == null) { //BirongLiang 2017-1-16
                return false;
            }

            arr[0].GRNString = arr[0].GRNString.substring(0, arr[0].GRNString.lastIndexOf(","));
            grnArr = arr[0].GRNString.split(",");      // GRN
            itemInfo = arr[0].ItemInfo.split(",");    // arr[0] itemcode,itemName  
            vendorSort = arr[0].VendorSort.split(",");  // 供应商

            //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
            getDocumentInfo();
            if (labelDocumentId == -1) {
                return false;
            }
            //将GRN信息添加到SNInfo的SNInfo.SNList集合中
            SNInfo = {};
            SNInfo.SNList = grnArr;
            SNInfo.ItemInfo = itemInfo;
            SNInfo.VendorSort = vendorSort;

            //根据打印方式决定 调用ZPL还是Lab打印
            mesLabLabelPrint();


            ibs = 3;

            var dd = $("#<%=this.lblItemName.ClientID %>").text();
            var ss = $("#txtWhCode").val();
            var aa = $("#txtGRNQty").val();
            var cc = $("#<%=this.lblVendorName.ClientID %>").text();

            showAreaMessge("物料编码:" + $("#lbItemCode").val() + "打印完成", "messageGreen"); //messageRed,messageGreen

            $("#lblMessage").html();
            Empty();
            //强制杀死进程
            //labelPrintingPlugin.KillProcess("lppa.exe");
            //打印完成刷新页面
            //setTimeout(function () {
            //    document.forms[0].submit();
            //}, 2000);
            //var sn = SNInfo.SNList;
            //sn.sort(function (a, b) {
            //    if (a > b) {
            //        return -1;
            //    }
            //    if (a == b) {
            //        return 0;
            //    }
            //    else {
            //        return 1;
            //    }
            //});
            //$("#lblPt").html(sn.slice(0, 50));

        }

        //清空所有的数据
        function Empty() {
            //$("#hdnItemId").val(-1);
            //$("#hdnVendorCode").val("");
            $("#txtGRNQty").val("");
            $("#txtQty").val("");
           <%-- $("#txtLotCode").val("");
            $("#<%=this.txtProdDate.ClientID %>").val("");
            $("#txtRemark").val("");--%>
            //$("#hdnWhCode").val(""); //仓库编码
            //$("#txtCbarCode").val(""); //库位条码
         /*   $("#txtLotCode").val("");*/
            /*$("#txtWhCode").val("");*/
           /* $("#textDateCode").val("");//DateCode*/
            //$("#textMPN").val("");//MPN
            //$("#txtStorageDate").val(GetDateStr(0));
            //重新获取批次号
            getLotCode();
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1;    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = '<%=Request.QueryString["ItemID"] %>';    //ItemId
        var labelProdOrderId = '<%=Request.QueryString["OrderID"] %>';
        var labelStationId = -1;    //工位Id
        var labelType = -3;          //标签类型  (-3.GRN)
        var labelSequence = 2;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径

        /*打印机插件未引用成功的消息内容*/
        NoPrinterPlugin = "<%=Resources.Messages.NoPrinterPlugin %>";
        var NoPrinterPluginLab = "Lab打印插件加载失败！请先安装打印插件！";
        //打印插件对象
        var labelPrintingPlugin;


        //获取文档模板基础信息
        function getDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo($("#hdnItemId").val(), labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId; //Label文档Id
                lableTypeQty = entity.PlateQty;           //连板数量
                //printName = entity.PrinterName;         //打印机名称
                //获取打印机名称值
                printName = $("#selPrintersList").val();
                labelPrintWayId = entity.PrintWayId;      //打印方式 78=Lab  79=ZPL
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
            }
            else {
                alert(ajax.error.Message);
                showAreaMessge(ajax.error.Message, "messageRed");
                // $("#lblMessage").html(ajax.error.Message);
                return false;
            }
            //初始化打印插件
            //            InityPrintingPlugin();
        }



        //codesoft打印  Lab模板方式
        function mesLabLabelPrint() {
            //从已释放的标签信息集合中，获取SN序列号集合。
            lableArr = SNInfo.SNList;
            var labelStr = "";
            var printdata = [];
            for (var i = 0; i < lableArr.length; i++) {
                labelStr = labelStr + lableArr[i] + ",";
                showAreaMessge(lableArr[i] + "条码生成成功", "messageGreen");
            }
            //获取标签模板中的标签值 集合
            var entity = {};
            entity.LabelDocumentId = labelDocumentId;
            entity.SN = labelStr;
            entity.StationId = -1;
            entity.ResId = -1;
            entity.LineId = -1;
            entity.ItemId = $("#hdnItemId").val();
            entity.WOId = -1;
            var ajaxLabContent = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetLabelContentForLabPrintBatch", JSON.stringify(entity));
            if (ajaxLabContent.error == null) {
                try {
                    var list = JSON.parse(ajaxLabContent.value).data;
                    if (list.length > 0) {
                        for (var i = 0; i < lableArr.length; i++) {
                            var page = { LabelContent: [] };
                            for (var k = 0; k < list.length; k++) {
                                if (list[k].SN == lableArr[i]) {
                                    page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                                }
                            }
                            printdata.push(page);
                        }
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
                showAreaMessge(ajaxLabContent.error.Message, "messageRed");
                // $("#lblMessage").html(ajaxLabContent.error.Message);
                return false;
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

        /********************************************标签打印 结束   （zhibin.Chen 2016-03-11 整理）************************************************/


        /*包装历史物料*/
        function packGrn() {
            $("#lblMessage").html("");
            var txtGrn = $.trim($("#txtGrn").val());
            var cartonSN = $("#hdnCartonSN").val();
            var vendorCode = $.trim($("#hdnVendorCode2").val());

            if (txtGrn == "") {
                return false;
            }
            var flag = false;
            $("#CartonGrnListTable tr").each(function () {
                if ($(this).children("td:eq(0)").html() == txtGrn) {
                    $("#lblMessage").html("该物料序列号已包装在当前包装箱内了。");
                    flag = true;
                    return false;
                }
            });
            if (flag) {
                $("#txtGrn").val("");
                $("#txtGrn").focus();
                setTimeout(function () { $("#lblMessage").html("") }, 3000);
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.PackOldMaterial(txtGrn, cartonSN, vendorCode);
            if (ajax.error != null) {
                $("#lblMessage").html(ajax.error.Message);
                $("#lblMessage").css("color", "red");
                $("#txtGrn").val("");
                $("#txtGrn").focus();
                setTimeout(function () { $("#lblMessage").html("") }, 3000);
                return false;
            }

            var list = ajax.value;
            if (list != null && list.length > 0) {
                /*移除旧的当前行样式*/
                $("#CartonGrnListTable tr").removeClass("currentrow");
                /*将包装到该包装箱的物料序列显示在列表中*/
                var listhtml = "";
                for (var j = 0; j < list.length; j++) {
                    if (j % 2 == 0) {
                        listhtml += "<tr class='ListTableOddRow'><td>" + list[j].SerialNumber + "</td><td>" + list[j].ItemName + "</td><td>" + list[j].VendorCode + "-" + list[j].VendorName + "</td><td>" + list[j].PackTime + "</td></tr>";
                    }
                    else {
                        listhtml += "<tr class='ListTableEvenRow'><td>" + list[j].SerialNumber + "</td><td>" + list[j].ItemName + "</td><td>" + list[j].VendorCode + "-" + list[j].VendorName + "</td><td>" + list[j].PackTime + "</td></tr>";
                    }
                }

                $("#CartonGrnListTable tr:eq(0)").after(listhtml);
                $("#txtGrn").val("");
                if (cartonSN == "") {
                    $("#hdnCartonSN").val(list[0].CartonSN);
                    $("#lblCartonSN").text(list[0].CartonSN);
                    $("#lblCartonSN2").html(list[0].CartonSN);
                    $("#txtVendorCode2").val(list[0].VendorCode);
                    $("#lblVendorName2").html(list[0].VendorName);
                    $("#hdnVendorCode2").val(list[0].VendorCode);
                }

                $(".ListTableOddRow").removeClass("ListTableOddRow");
                $(".ListTableEvenRow").removeClass("ListTableEvenRow");
                /*设置列表样式*/
                $("#CartonGrnListTable tr:gt(0)").each(function (i) {
                    if (i % 2 == 0) {
                        $(this).addClass("ListTableOddRow");
                    }
                    else {
                        $(this).addClass("ListTableEvenRow");
                    }
                });
            }
        }

        /*关闭包装箱并打印包装箱标签*/
        function closeCarton() {
            if (!checkPrintPlugin($("#noprtplg"))) {
                return false;
            }

            var cartonSN = $("#hdnCartonSN").val();
            if (cartonSN == "") {
                alert("页面上无包装箱可关闭");
                return false;
            }

            if (!confirm("是否确定要关闭当前包装箱？")) {
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ClosePack(cartonSN);
            if (ajax.error != null) {
                $("#lblMessage").html(ajax.error.Message);
                $("#lblMessage").css("color", "red");
                return false;
            }

            /*获取包装信息打印标签*/
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitCartonInfo(cartonSN);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var entity = ajax.value;

            //物料编号
            var itemCode = entity[0];
            //厂商编码
            var vendorCode = entity[1];
            //周数
            var theWeek = entity[3];
            //数量
            var printCount = entity[2];

            //是否是大箱
            var isCnt = false;
            if (entity[4].toLowerCase() == "yes") {
                isCnt = true;
            }

            var vendorLot = itemCode.toString() + ((itemCode == "") ? "" : "+") + vendorCode.toString() + ((vendorCode == "") ? "" : "+") + theWeek.toString() + "+" + printCount.toString().replace(".000", "");

            var zplContent = "";
            if (isCnt) {
                zplContent = $("#<%=this.hdnLabelCnt.ClientID %>").val();
            }
            else {
                zplContent = $("#<%=this.hdnLabelCartonContent.ClientID %>").val();
            }

            zplContent = zplContent.replace(new RegExp("%VendorLot%", "gm"), vendorLot);
            zplContent = zplContent.replace(new RegExp("%ID%", "gm"), cartonSN.toString());

            //doPrintGrn(document.getElementById("labelPrintingPlugin"), zplContent);

            $("#hdnCartonSN").val("");
            $("#lblCartonSN").text("");
            $("#lblCartonSN2").html("");
            $("#txtGrn").val("");
            $("#txtGrn").focus();
            $("#CartonGrnListTable tr:gt(0)").remove();
        }

        /*打印标签*/
        //var labelPrintingPlugin;
        var i = 0;
        var moveCount = 0;
        var yearweek = '<%=DateTime.Now.Year.ToString().Substring(2, 2) + SKT.LeanMES.Web.AppCode.Utility.DateTimeUtility.GetWeekOfYear(DateTime.Now).ToString() %>';
        var minQty = 0;
        var grnSerialNumber = "";
        var vendorLot = "";
        function initPrint(list) {
            if (!checkPrintPlugin($("#noprtplg"))) {
                return false;
            }

            //labelPrintingPlugin = document.getElementById("labelPrintingPlugin");
            i = 0;
        }

        //codesoft打印
        function codePrint() {
            var itemId = $("#hdnItemId").val();
            var documentId = "";
            var labelStr = "";
            //var itemId = 1;
            var stationId = -1;
            var type = -3;
            var sequence = 2;
            var printParaCount = 0;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(itemId, stationId, type, sequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                documentId = entity.LabelDocumentId;
                lableTypeQty = entity.PlateQty;
                printName = entity.PrinterName;
                ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetTempCount(documentId);
                if (ajax.error == null) {
                    printParaCount = ajax.value;
                }
            }
            else {
                alert(ajax.error.Message);
                return false;
            }
            for (var j = 0; j < grnArr.length; j++) {
                labelStr += grnArr[j].SerialNumber + ",";
            }
            //var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnZplContent(documentId, labelStr, -1, -1, -1, itemId, -1);
            var labelJsonData = "";
            var labelContent = "";
            var tempatePath = "";  //打印路径
            var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelPrintContent(documentId, labelStr, -1, -1, -1, itemId, -1);


            if (ajaxLabContent.error == null) {
                //接收打印的lab标签  
                try {
                    if (ajaxLabContent.error == null) {
                        var list = ajaxLabContent.value;
                        if (list.length > 0) {
                            tempatePath = list[0].TemplatePath; //可自定义打印路径 eg:D:\\GRN\\GrnLabel.Lab
                            //tempatePath = "D:\\GRN\\ItemGRN.Lab";

                            //  tempatePath = "D:\\GRN\\GRN.Lab";
                            var iCount = list.length;
                            var tFalg = 1;
                            for (var i = 0; i < iCount; i++) {
                                tFalg = ((i + 1) % (printParaCount));
                                tFalg = (tFalg == 0 ? printParaCount : tFalg);
                                labelContent += '{name:"value' + tFalg + '",value:"' + list[i].LabelValue + '"}' + ",";
                                if ((i + 1) % printParaCount == 0 || (i + 1) == iCount) {

                                    labelContent = labelContent.substring(0, labelContent.length - 1);
                                    labelJsonData = "[{LabelContent:[" + labelContent + "]}]";
                                    // alert(labelJsonData);
                                    printLabel(tempatePath, labelJsonData, printName, 'zpl');

                                    labelContent = "";
                                }
                            }
                        }
                    }
                    else {
                        alert(ajaxLabContent.error.Message);
                        return false;
                    }
                } catch (e) {
                    alert(e);
                    return false;
                }
            }
        }
        //        /*打印label*/
        //        function printLabel() {
        //            var lblContainer = $("#lblContainer").text();
        //            var OrderId = $("#OrderId").val();
        //            var zpl = "";
        //            /*执行*/
        //            var ajaxResult = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnZplContent(lableDocumentId, lblContainer, -1, -1, -1, PartID, OrderId);
        //            if (ajaxResult.error == null) {
        //                //接收打印的ZPL标签  
        //                zpl = ajaxResult.value;
        //                printerDemo.DoPrint(zpl, printName);
        //                /*插入打印记录*/
        //                var printRecodeEntity = {};
        //                printRecodeEntity.RecordId = -1;
        //                printRecodeEntity.ActionType = 1;
        //                printRecodeEntity.PrintType = -1;
        //                printRecodeEntity.PrintKey = lblContainer;
        //                printRecodeEntity.StationId = -1;
        //                printRecodeEntity.ResourceId = -1;
        //                var ajaxPrintRecodes = SKT.LeanMES.Web.AjaxServices.AjaxPrint.RecodePrint(printRecodeEntity); ;
        //                if (ajaxPrintRecodes.error != null) {
        //                    alert(ajaxPrintRecodes.error.Message);
        //                    return false;
        //                }
        //            } else {
        //                alert(ajaxResult.error.Message);
        //                return false;
        //            }
        //        }

        /*根据物料名或物料编号获取物料信息*/
        function getItemInfo() {
            console.log(11111);
            if ($.trim($("#lbItemCode").val()) == "") return false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetProItemInfo($.trim($("#lbItemCode").val()));

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var entity = $.parseJSON(ajax.value);
            console.log(entity);
            if (entity == null || entity.ItemID == null) {
                alert("请输入正确的物料编码");
                $("#lbItemCode").val("");
                return false;
            }
            setItemInfo(entity)
        }

        /*根据供应商代码或名称获取供应商信息*/
        function getVendorInfo() {
            if ($.trim($("#txtVendorCode").val()) == "") {
                $("#txtGRNQty").focus();
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetVendorInfo($("#txtVendorCode").val());
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;

            if (entity == null) {
                alert("请输入正确的供应商代码或名称");
                $("#txtVendorCode").val("");
                return false;
            }
            setVendorInfo(entity)
        }

        /*根据供应商代码或名称获取供应商信息 历史物料包装*/
        function getVendorInfo2() {
            var _pack_vendor_code = $.trim($("#txtVendorCode2").val());
            var _pack_vendor_code1 = $.trim($("#hdnVendorCode2").val());

            if (_pack_vendor_code == "") {
                $("#txtGrn").focus();
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetVendorInfo(_pack_vendor_code);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;

            if (entity == null) {
                alert("请输入正确的供应商代码或名称");
                $("#txtVendorCode2").val("");
                return false;
            }
            setVendorInfo2(entity)
        }

        /*设置物料信息*/
        function setItemInfo(entity) {
            $("#hdnItemId").val(entity.ItemID);
            $("#hdnItemCode").val(entity.ItemCode);
            $("#lbItemCode").val(entity.ItemCode);
            $("#<%=this.lblItemName.ClientID %>").text(entity.ItemName);

            $("#txtVendorCode").focus();
        }

        /*设置供应商信息*/
        function setVendorInfo(entity) {
            $("#hdnVendorCode").val(entity.VendorCode);
            $("#txtVendorCode").val(entity.VendorCode);
            $("#<%=this.lblVendorName.ClientID %>").text(entity.VendorName);
            $("#txtGRNQty").focus();
        }

        /*设置供应商信息 历史物料包装*/
        function setVendorInfo2(entity) {
            $("#hdnVendorCode2").val(entity.VendorCode);
            $("#txtVendorCode2").val(entity.VendorCode);
            $("#lblVendorName2").html(entity.VendorName);
            $("#txtGrn").focus();
            $("#txtGrn").val("");
        }


        //选择仓库
        function selectWhCodeList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&CallBackFunc=setWhCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setWhCode(list) {
            var whCodes = list[0][1] + "|" + list[0][2];
            if (list[0][0] == "-1") {
                whCodes = "";

            }
            $("#<%=this.txtWhCode.ClientID %>").val(whCodes);
            $("#hdnWhID").val(list[0][0]);
            $("#hdnWhCode").val(list[0][1]);
            $("#txtCbarCode").val("");
        }

        /**
        *选择库位
        **/
        function selectWhBarCodeList() {
            var whCode = $.trim($("#hdnWhCode").val());
            if (whCode == "") {
                alert("请先选择仓库！");
                return false;
            }
            var conditions = " CWhCode = '" + whCode + "'";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=117&Multiple=false&CallBackFunc=setWhBarCode&PageCondition=" + escape(conditions) + "&rnd=" + Math.random(), width: 500, height: 300 });
        }

        /**
        *设置库位
        **/
        function setWhBarCode(list) {
            $("#txtCbarCode").val(list[0][3]);
        }

        /**
        *删除行
        */
        function deleteItems(_objs) {
            if (!confirm("确定要删除吗？")) {
                return false;
            }
            $(_objs).parent().parent().remove();
        }

        function getLog(strwhere, strwhere1) {
            $.ajax({
                url: 'OldMaterial.aspx?Action=getlog&strwhere=' + strwhere + '&strwhere1=' + strwhere1 + '&rnd=' + Math.random(),
                type: 'get',
                success: function (data) {
                    var _data = eval('(' + data + ')');
                    var logList = '';
                    var _css = 'ListTableOddRow';
                    $("table tr:gt(0)").remove();
                    if (parseInt(_data.totals) == 0) {
                        $("table").append('<tr class="ListTableEmptyDataRow"><td colspan="2">没有数据</td></tr>');
                        return false;
                    }
                    for (var i = 0; i < parseInt(_data.totals) ; i++) {
                        if (i % 2 == 0) _css = 'ListTableEvenRow';
                        else _css = 'ListTableOddRow';
                        logList += '<tr class="' + _css + '">';
                        logList += '<td>' + (i + 1).toString() + '</td>';
                        logList += '<td>' + _data.data[i].SerialNumber + '</td>';
                        logList += '</tr>';
                    }

                    $("table").append(logList);
                },
                datatype: 'text'
            });
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

        //校验货位产品唯一
        function verifyProductOnly(grn, itemCode, cBarCode) {
            var result = isItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode);
            if (result == -1) {
                return false;
            }
            if (result == 0) {
                alert("当前库位不支持存放多种产品，请选择其他库位！");
                $("#txtCbarCode").val("").focus();
                return false;
            }
            return true;
        }

        //判断产品是否能放入当前库位
        function isItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.IsItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return -1;
            }
            return ajax.value ? 1 : 0;
        }
        //获取批次号
        function getLotCode() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetLotCode();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            $("#txtLotCode").val(ajax.value);
            $("#txtLotCode").focus(function () { this.select() });
        }
    </script>
</asp:Content>
