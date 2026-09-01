<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"  EnableViewState="true" 
    AutoEventWireup="true" CodeBehind="CustomAuthorize.aspx.cs" Inherits="SKT.LeanMES.Web.CustomMenu.CustomAuthorize" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
        <!--打印插件未安装的提示区域-->
    <div id="noprtplg" class="Tips">
    </div>
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label" align="center" colspan="2" style="font-size: 22px; font-weight: bold;">
                <%=Resources.lang.GRNCartonSN%>:<span id="GrnPackingSN" style="font-size: 22px; font-weight: bold;"></span>
            </td>
        </tr>
        <tr id="showSupplierList" style="display: none">
            <td class="Label1">
                选择供应商<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" id="txtVendorCode" class="TextBox" disabled="disabled" value=""  /><input
                    type="button" id="btnSelectSupplier" class="ButtonBox" value="..." onclick="selectSupplier()" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.GRN %><em>*</em>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtGRN" class="TextBox" style="width: 250px; height: 25px;
                    text-transform: uppercase; font-size: 16px; font-weight: bold;" />
                <input type="hidden" value="" id="hdnVendorCode" />
                <input class="TextBox" id="hidtxt" style="display: none;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                打印机名称
            </td>
            <td class="Field2" colspan="1">
               <select id="selPrintersList" style=" width: 250px; ">
                </select>
            </td>
        </tr>
        <tr>
            <td class="Label1">
            </td>
            <td class="Field2" colspan="1">
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
                <th>
                    未关闭的包装箱号
                </th>
                <th>
                    物料编码
                </th>
                <th>
                    物料名称
                </th>
                <th>
                    供应商名称
                </th>
                <th>
                    批次号
                </th>
            </tr>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="7" style="text-align: center;">
                    暂无数据
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
                    <%=Resources.lang.GRNCartonSN%>&nbsp;&nbsp;<span id="CartonSN"></span>
                </th>
            </tr>
            <tr class="ListTableEvenRow">
                <td align="left" colspan="2">
                    <%=Resources.lang.PackedGRN %><span id="packedItemQty">0</span>
                </td>
            </tr>
        </table>
    </div>
        <input type="button" value="保存" onclick="ClosePack()"/>
    <input type="hidden" value="" id="hdnCartonSN" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        var vendorCode = "";
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var userId = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>';
        var num = 0; //取消次数

        $(function () {
            $("#divPackScanCode").hide();
            bindPrinters('selPrintersList');
        });


        function selectSupplier() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 700, height: 350 });
        }

        function getChooseValue(list) {
            $("#txtVendorCode").val(list[0][1]);
            vendorCode = list[0][1];
            $("#hdnVendorCode").val(vendorCode);
        }

        $(document).ready(function () {
            //通过用户获取对应的供应商
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetVenCodeByUserId(userId);
            var entity={};
            entity.UserId=userId;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetVendorByUserId", JSON.stringify(entity), "1");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var obj = JSON.parse(ajax.value);
            vendorCode = obj.data[0].VendorCode;
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
                        PackGRN();
                    }
                    else {
                        alert("请先扫描GRN条码");
                        return false;
                    }
                }
            });

            //$(".ListTableOddRow,.ListTableEvenRow,.ListTableSelectedRow").live({
            //    mouseenter: function () {
            //        $(this).addClass("ListTableHoverRow");
            //    },
            //    mouseleave: function () {
            //        $(this).removeClass("ListTableHoverRow");
            //    },
            //    click: function () {
            //        $(".ListTableSelectedRow").not($(this)).removeClass("ListTableSelectedRow");
            //        $(this).toggleClass("ListTableSelectedRow");
            //    }
            //});
        });

        //包装GRN
        function PackGRN() {
             
            $("#msg").html("");
            $("#msg").css("color", "red");
            $(".StrongFont").removeClass("StrongFont");
            var txtGRN = $.trim($("#txtGRN").val());
            var hdnCartonSN = $.trim($("#hdnCartonSN").val());
            vendorCode = $("#hdnVendorCode").val();
            if (vendorCode == "") {
                alert("请选择供应商!");
                return false;
            }
            if (txtGRN == "") {
                alert("请扫GRN条码！");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }          

            //验证包装的GRN条码是否合法
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ValidateGRN(txtGRN, hdnCartonSN, vendorCode);
            var entity = {};
            entity.GRN = txtGRN;
            entity.UserName = userName;
            entity.CartonSN = hdnCartonSN;
            entity.VendorCode = vendorCode;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspValidatePackingGRNTemplate", JSON.stringify(entity), "1");
            if (ajax.error != null) {
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                highListCurrentItem(txtGRN);
                return false;
            }
            var messageStr = JSON.parse(ajax.value);
            vendorCode = messageStr.data[0].returnVendorCode;
            $("#hdnVendorCode").val(vendorCode);
            //有错误信息
            if (messageStr.data[0].ErrorType == -1) {
                $("#msg").html(messageStr.data[0].ErrorMessage);
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }

            //数据库中没有未关闭的包装箱，系统生成新carton箱条码并成功包装GRN
            if (messageStr.data[0].ErrorType == 0) {
                setCartonSN(messageStr.data[0].ErrorMessage);
                setPackInfo(txtGRN);
                appendPackItem(txtGRN);
                return false;
            }
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
            $("#msg").html("[" + info + "]<%=Resources.Messages.PackingSuccessful %>");
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

        //function getPackedItemList(cartonsn) {
        //    $(".StrongFont").removeClass("StrongFont");
        //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetPackedItemList(cartonsn);
        //    if (ajax.error != null) {
        //        alert(ajax.error.Message);
        //        return false;
        //    }

        //    var list = ajax.value;
        //    var l = "";
        //    var rows = $("#packingItemListTbl tr").length - 2;
        //    var scaningGRN = $.trim($("#txtGRN").val());
        //    for (var i = 0; i < list.length; i++) {
        //        if ((rows + i) % 2 == 0) {
        //            if (list[i].SerialNumber == scaningGRN) {
        //                l += "<tr class='ListTableOddRow StrongFont'><td width='3%'>" + (rows + i + 1) + "</td><td>" + list[i].SerialNumber + "</td></tr>";
        //            }
        //            else {
        //                l += "<tr class='ListTableOddRow'><td width='3%'>" + (rows + i + 1) + "</td><td>" + list[i].SerialNumber + "</td></tr>";
        //            }
        //        }
        //        else {
        //            if (list[i].SerialNumber == scaningGRN) {
        //                l += "<tr class='ListTableEvenRow StrongFont'><td width='3%'>" + (rows + i + 1) + "</td><td>" + list[i].SerialNumber + "</td></tr>";
        //            }
        //            else {
        //                l += "<tr class='ListTableEvenRow'><td width='3%'>" + (rows + i + 1) + "</td><td>" + list[i].SerialNumber + "</td></tr>";
        //            }
        //        }
        //    }
        //    $(l).appendTo($("#packingItemListTbl"));
        //    $("#packedItemQty").html(list.length.toString());
        //}

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

            if (confirm(String.format("<%=Resources.Messages.ConfirmCloseCarton %>", txtCartonSN.toString(), grncount.toString()))) {
                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ClosePack(txtCartonSN);
                var entity = {};
                entity.CartonSN = txtCartonSN;
                entity.UserName = userName;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCloseGrnPack", JSON.stringify(entity), "1");
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                $("#CartonSN").html("<span style='color:green;'>" + txtCartonSN + "[<%=Resources.lang.CartonIsClosed %>]</span>");
                $("#GrnPackingSN").html("");
                $("#hdnCartonSN").val("");
                $("#txtGRN").val("");
                $("#txtGRN").focus();

                $("#msg").html("正在打印...");
                printCartonLabel(txtCartonSN);

            }
        }

        //打印包装箱
        function printCartonLabel(grn) {
            //获取包装箱物料信息
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitInfoByGRN(grn);
            var entity = {};
            entity.FieldValue = grn;
            entity.IsByID = false;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("Prod_MaterialUnit_GetInfo", JSON.stringify(entity), "1");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = JSON.parse(ajax.value);
            labelItemId = entity.data[0].PartId

            //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
            SNInfo = {};
            SNInfo.SNList = [];
            SNInfo.SNList.push(grn);
            if (SNInfo.SNList.length == 0) return false;

            //根据打印方式决定 调用ZPL还是Lab打印
            mesLabLabelPrint();
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
        var labelSequence = 8;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径



        //获取文档模板基础信息
        function getDocumentInfo() {
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            var entity = {};
            entity.ItemId = labelItemId;
            entity.StationId = labelStationId;
            entity.TypeId = labelType;
            entity.Sequence = labelSequence;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspProdGetLableDocumentId", JSON.stringify(entity), "1");
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
            var printdata = [];
            for (var i = 0; i < lableArr.length; ) {
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
                i = i + lableTypeQty; //连片的递增
                //获取标签模板中的标签值 集合
                //var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, -1);
                var entity = {};
                entity.LabelDocumentId = labelDocumentId;
                entity.SN = labelStr;
                entity.StationId = -1;
                entity.ResId = -1;
                entity.LineId = -1;
                entity.ItemId = labelItemId;
                entity.WOId = -1;
                var ajaxLabContent = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetLabelContentForLabPrint", JSON.stringify(entity), "1");
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
            ibs = 3;
            setTimeout(function () {
                $("#lblMessage").html('条码打印完成!');
            }, 300);
        }

    </script>
    </asp:Content>
   

   <%--<asp:Content ID="Content1" ContentPlaceHolderID="EditContentReport" runat="server">
       <div id="onprocess" style="text-align: center;">
    </div>
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current">数据库链接配置</li>
            <li>Logo设置</li>
        </ul>
        <div class="tb_c">
            <div class="divHeader">
                <img src="../Content/images/icon/edit_dblink.png" class="imgText" />&nbsp;模版TEST</div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">
                        模版名称<em>*</em>
                    </td>
                    <td class="Field1">
                        <input type="text" id="TemplateName" style="width:250px;"/>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        用户名<em>*</em>
                    </td>
                    <td class="Field1">
                        <input type="text" id="UserName"/>
                    </td>
                </tr>
            </table>
            </div>
        <div>
            <div class="infoTips">
                在此上传的logo将会在系统框架右上角显示，logo尺寸：宽*高 = 200px*45px
            </div>
            <table class="EditeContentTable" width="100%"><tr>
            <td class="Label1">选择Logo文件：</td>
                <td class="Field1"><input type="file" id="Filedata" name="Filedata"/><img id="llLogo" src=""/>
                    <a href="#" id="btnDeleteLogo">删除自定义LOGO</a>
                </td>
                </tr>
                </table>
            <div style="text-align:center; padding:10px;">
                <input type="button" value="上传Logo" class="button" id="btnUploadLogo"/>  
   
            </div>
            <div id="viewLogo" style="text-align:center; padding:10px;">
                <img src=""/>
            </div>
        </div>
    </div>
    <div style=" height:38px; ">
        <div id="loading" style="display: none; z-index: 111;">
            <div style="background: #cccccc; position: absolute; z-index: 112; top: 0; left: 0px;
                filter: Alpha(opacity=60); -moz-opacity: 0.6; opacity: 0.6;" id="loading-bg">
            </div>
            <div style="position: absolute; top: 35%; left: 35%; z-index: 113; background: #f7f7f7;
                width: 360px; border: 1px solid #333333; height: 65px; line-height: 65px; text-align: center;"
                id="loading-content">
                正在执行方法,请耐心等待...
            </div>
        </div>
    </div>
    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/tabs/jPlugin-tabs.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        $(function () {
            $("#btnUploadLogo").click(function () {
                var form = new FormData($("#form1")[0]);
                try {
                    $.ajax({
                        type: "POST",  //提交方式  
                        url: "../Handler/UploadHander.ashx?Action=UploadCustomerLogo&rnd=" + Math.random(),//路径  
                        data: form,//数据
                        contentType: false, //禁止设置请求类型
                        processData: false, //禁止jquery对DAta数据的处理,默认会处理
                        success: function (data) {//返回数据根据结果进行相应的处理  
                            $("#viewLogo").children("img").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>"+data.replace("//","/"));
                            alert("Logo上传成功。");
                            //top.location.href = top.location.href;
                        },
                        error: function (xhr, status, error) {
                            alert(error);
                        }
                    });
                }
                catch (ex) {
                    alert(ex);
                }
            });

            $("#btnDeleteLogo").click(function () {
                if (confirm("是否确定要删除自定义LOGO？删除后将不再显示自定义LOGO！")) {
                    document.forms[0].submit();
                }
                else {
                    return false;
                }
            });
        });
        function Save() {
            var TemplateName = $.trim($("#TemplateName").val());
            var UserName = $.trim($("#UserName").val());
            if (!TemplateName) {
                alert("模版名称不能为空!");
                return false;
            }
            if (!UserName) {
                alert("用户名不能为空!");
                return false;
            }
            var entity = {};
            entity.TemplateName = TemplateName;
            entity.UserName = UserName;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSavePagingTemplate", JSON.stringify(entity), "1");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("保存成功!");
        }
    </script>
   </asp:Content>--%>

   <%-- <asp:Content ID="Content1" ContentPlaceHolderID="EditContentReport" runat="server">
    <div>
         <table class="EditeContentTable" id="tbEditInfo" width="100%">
           <tr>
            <td class="Label2">
                <span>用户名</span>
            </td>
            <td class="Field2">
                <span id="username"></span>
            </td>
            <td class="Label2">
                <span>工号</span>
            </td>
            <td class="Field2">
                <span id="lblEmployeeNOText"></span>
            </td>
        </tr>
      </table>
    <div class="clear5">
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <span id="ChooseRole">选择角色</span>
            </td>
            <td class="Label" style="width: 10%; text-align: center;">
            </td>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <span id="UserRole">用户的角色</span>
            </td>
        </tr>
        <tr style="height: 300px;" valign="top">
            <td align="center" style="width: 45%; vertical-align: top;">
                <div id="loadingmessages1" class="Tips">
                    <table class="EditeContentTable" style="width: 100%">
	                    <tr>
		                    <td class="Label3">
			                    单号
		                    </td>
		                    <td class="Field3">
			                    <input type="text" class="TextBox " value="" id="leftOrderNO" />
		                    </td>
		                    <td class="Label3">
			                    客户订单号
		                    </td>
		                    <td class="Field3">
			                    <input type="text" class="TextBox " value="" id="leftCustomerOrder" />
		                    </td>
	                    </tr>
	                    <tr>
		                    <td class="Label3" colspan="6" align="center" style="text-align:center">
			                    <span style="margin-right:15px;">
				                    <input type="checkbox" id="leftchkEqul"/>
				                    全字匹配
			                    </span>
			                    <input type="submit" id="leftsearch" value="查询" onclick="LeftSearch()" class="SearchButton">
			                    <input type="button" id="leftclear" value="清空" onclick="LeftClearSearch()" class="SearchButton" title="清空查询条件">
                            </td>
	                    </tr>
                    </table>
                </div>
                <div id="LeftList">
                </div>
            </td>
            <td class="Field" style="width: 10%; text-align: center; vertical-align: middle;">
                <input type="button" id="btnLeftChoose" runat="server" value="" class="rightButton" onclick="btnChooseOnClick(0);" />
                <br />
                <br />
                <br />
                <br />
                <input type="button" id="btnRightChoose" runat="server" value="" class="leftButton" onclick="btnChooseOnClick(1);" />
            </td>
            <td align="center" style="width: 45%; vertical-align: top;">
                <div id="loadingmessages2" class="Tips">
                    <table class="EditeContentTable" style="width: 100%">
	                    <tr>
		                    <td class="Label3">
			                    单号
		                    </td>
		                    <td class="Field3">
			                    <input type="text" class="TextBox " value="" id="rightOrderNO" />
		                    </td>
		                    <td class="Label3">
			                    客户订单号
		                    </td>
		                    <td class="Field3">
			                    <input type="text" class="TextBox " value="" id="rightCustomerOrder" />
		                    </td>
	                    </tr>
	                    <tr>
		                    <td class="Label3" colspan="6" align="center" style="text-align:center">
			                    <span style="margin-right:15px;">
				                    <input type="checkbox" id="rightchkEqul"/>
				                    全字匹配
			                    </span>
			                    <input type="submit" id="rightsearch" value="查询" onclick="RightSearch()" class="SearchButton">
			                    <input type="button" id="rightclear" value="清空" onclick="RightClearSearch()"  class="SearchButton" title="清空查询条件">
                            </td>
	                    </tr>
                    </table>
                </div>
               <div id="RightList">
               </div>
            </td>
        </tr>
    </table>
   </div>
    <script type="text/javascript">
        var RowIDs = "";
        function LeftShow(leftCon) {
            if (leftCon == null) {
                leftCon = " AND ProdOrderID='" + $("#hdnKeyValue").val() + "'";
            }
            $("#LeftList").replaceWith("<div id=LeftList ></div>");
            var leftGrid = $("#LeftList").SktMesGrid({
                columns: [{
                    "display": "单号",
                    "name": "OrderNO",
                    "align": "left",
                    "width": 180,
                    "minWidth": 60
                },
                {
                    "display": "客户订单号",
                    "name": "CustomerOrder",
                    "align": "left",
                    "width": 180,
                    "minWidth": 60
                }],
                width: "100%",
                height: "98%",
                dataAction: "TABLE",
                dataSource: "SKTCustom_ProOrderListTemplateLeft",
                conditions: leftCon == null ? null : leftCon,
                multiselect: true,
                checkbox:true,
                onSelectRow: function (rowid, status) {
                    //$("#hdnKeyValue").val(rowid[$("#hdnKey").val()]);
                },
                onCheckRow: function (isCheck, rowid, status) {
                    var arr = leftGrid.getCheckedRows();
                    RowIDs = "";
                    for (var i = 0; i < arr.length; i++) {
                        if (i == arr.length - 1) {
                            RowIDs += "'" + arr[i].ID + "'";
                        } else {
                            RowIDs += "'" + arr[i].ID + "',";
                        }
                    }
                },
                onCheckAllRow: function (isCheck, obj) {
                    var arr = leftGrid.getCheckedRows();
                    RowIDs = "";
                    for (var i = 0; i < arr.length; i++) {
                        if (i == arr.length - 1) {
                            RowIDs += "'" + arr[i].ID + "'";
                        } else {
                            RowIDs += "'" + arr[i].ID + "',";
                        }
                    }
                },
                sortName: "OrderNO",
                selectFields: "ID,OrderNO,CustomerOrder"
            });
        }
        function RightShow(rightCon) {
            if (rightCon == null) {
                rightCon = " AND ProdOrderID='" + $("#hdnKeyValue").val() + "'";
            }
            $("#RightList").replaceWith("<div id=RightList ></div>");
            var rightGrid = $("#RightList").SktMesGrid({
                columns: [{
                    "display": "单号",
                    "name": "OrderNO",
                    "align": "left",
                    "width": 180,
                    "minWidth": 60
                },
                {
                    "display": "客户订单号",
                    "name": "CustomerOrder",
                    "align": "left",
                    "width": 180,
                    "minWidth": 60
                }],
                width: "100%",
                height: "98%",
                dataAction: "TABLE",
                dataSource: "SKTCustom_ProOrderListTemplateRight",
                conditions: rightCon == null ? null : rightCon,
                multiselect: true,
                checkbox: true,
                onSelectRow: function (rowid, status) {
                    //$("#hdnKeyValue").val(rowid[$("#hdnKey").val()]);
                },
                sortName: "OrderNO",
                selectFields: "ID,OrderNO,CustomerOrder"
            });
        }

        $(function () {
            LeftShow(null);
            RightShow(null);
        });

        function LeftSearch() {
            var conds = " AND ProdOrderID='" + $("#hdnKeyValue").val() + "'";
            var conds2 = " AND ProdOrderID='" + $("#hdnKeyValue").val() + "'";
            var leftOrderNO = $("#leftOrderNO").val();
            var leftCustomerOrder = $("#leftCustomerOrder").val();
            if (leftOrderNO !== "") {
                conds2 += " AND OrderNO= N'" + $.trim($("#leftOrderNO").val()) + "'";
                conds += " AND OrderNO LIKE N'%" + $.trim($("#leftOrderNO").val()) + "%'";
            }
            if (leftCustomerOrder !== "") {
                conds2 += " AND CustomerOrder= N'" + $.trim($("#leftCustomerOrder").val()) + "'";
                conds += " AND CustomerOrder LIKE N'%" + $.trim($("#leftCustomerOrder").val()) + "%'";
            }
            if ($("#leftchkEqul").is(":checked")) {
                conds = conds2;
            }
            LeftShow(conds);
        }
        function RightSearch() {
            var conds = " AND ProdOrderID='" + $("#hdnKeyValue").val() + "'";
            var conds2 = " AND ProdOrderID='" + $("#hdnKeyValue").val() + "'";
            var rightOrderNO = $("#rightOrderNO").val();
            var rightCustomerOrder = $("#rightCustomerOrder").val();
            if (rightOrderNO !== "") {
                conds2 += " AND OrderNO= N'" + $.trim($("#rightOrderNO").val()) + "'";
                conds += " AND OrderNO LIKE N'%" + $.trim($("#rightCustomerOrder").val()) + "%'";
            }
            if (rightCustomerOrder !== "") {
                conds2 += " AND CustomerOrder= N'" + $.trim($("#rightCustomerOrder").val()) + "'";
                conds += " AND CustomerOrder LIKE N'%" + $.trim($("#rightCustomerOrder").val()) + "%'";
            }
            if ($("#rightchkEqul").is(":checked")) {
                conds = conds2;
            }
            RightShow(conds);
        }
        function LeftClearSearch() {
            $("#leftOrderNO").val("");
            $("#leftCustomerOrder").val("");
        }
        function RightClearSearch() {
            $("#rightOrderNO").val("");
            $("#rightCustomerOrder").val("");
        }
        function btnChooseOnClick(index) {
            if (index == 0) {
                var entity = {};
                entity.RowIDS = RowIDs;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSKTCustomProOrderListTemplateLeftToRight", JSON.stringify(entity), "1");
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
            } else {
                var entity = {};
                entity.RowIDS = RowIDs;
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSKTCustomProOrderListTemplateRightToLeft", JSON.stringify(entity), "1");
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
            }
        }
    </script>
    </asp:Content>--%>
