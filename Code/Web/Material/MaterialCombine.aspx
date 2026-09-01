<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master"
    CodeBehind="MaterialCombine.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialCombine" %>

<asp:Content ID="Content2" ContentPlaceHolderID="viewcontent" runat="server">

    <!--打印插件未安装的提示区域-->
    <div id="noprtplg" class="Tips">
    </div>
    <div class="clear5">
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label1">物料条码<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtGRN" class="TextBox" style="width: 250px; height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" /><input type="button" id="btnMaterialCombine" class="ButtonBox" value="..." style="height: 27px; font-weight: bold; margin-left: -6px; text-transform: uppercase;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">打印机名称
            </td>
            <td class="Field1">
                <select id="selPrintersList" style="width: 250px;">
                </select>
                <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机列表</a>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div style="text-align: center;" class="Tips" id="msg">
    </div>
    <div class="clear5">
    </div>
    <!--打印状态的信息提示区域-->
    <div id="lblMessage" class="Tips" style="text-align: center">
    </div>

    <!--打印插件的容器-->
    <div id="printerHolder">
        <!--lab-->
        <%--        <object classid="clsid:8542E25D-C6AE-47A9-8986-40ADBC2EAF7D" id="labelPrintingPluginLab" width="0"
        height="0" >
        </object>

        <!--zpl-->
        <object classid="clsid:F843DB2A-40AF-4D16-B695-F87A2DD566C2" id="labelPrintingPluginZPL" width="0"
        height="0" >
        </object>--%>
    </div>
    <div class="clear5">
    </div>
    <div style="width: 49%; float: left">
        <div class="ListTableTitle">
            <span>待合并GRN</span>
            <div style="position: absolute; right: 10px; top: 5px; line-height: 18px;">
                <a href="javascript:clearCombine();">清空列表</a>
            </div>
        </div>
        <div id="tblInfo" style="text-align: left; color: #810000; height: 25px; line-height: 22px; background: #f7f7f7; padding-left: 10px; border-left: 1px solid #d3d3d3; border-right: 1px solid #d3d3d3;">
            <img src="../Content/images/icon/comment.png" style="vertical-align: middle;" alt="" /><span>您可以选择其中一个GRN作为合并后的GRN</span>
        </div>
        <table class="ListTable" width="100%" id="tblRecHistory">
            <tr class="ListTableHeader">
                <th>序号
                </th>
                <th>选择
                </th>
                <th>物料条码
                </th>
                <th>物料名称
                </th>
                <th>合并数量
                </th>
            </tr>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="5" style="text-align: center;"><span>暂无数据</span>
                </td>
            </tr>
        </table>
    </div>
    <div style="width: 49%; float: right">
        <div class="ListTableTitle">
            <span>合并后GRN</span>
        </div>
        <div id="rightDiv" style="text-align: left; color: #810000; height: 25px; line-height: 22px; background: #f7f7f7; padding-left: 10px; border-left: 1px solid #d3d3d3; border-right: 1px solid #d3d3d3;">
        </div>
        <table class="ListTable" width="100%" id="tblRightHistory">
            <tr class="ListTableHeader">
                <th>序号
                </th>
                <th>物料条码
                </th>
                <th>合并数量
                </th>
                <th>操作
                </th>
            </tr>
            <tr id="trRight" class="ListTableOddRow">
                <td colspan="4" style="text-align: center;"><span>暂无数据</span>
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script type="text/javascript">
        var grn = "";
        var itemId = "";  //获取产品id
        var statusId = ""; //获取状态
        var materialSN = "";

        var orderNo = "";

        function enterToTab() {
        }

        $(document).ready(function () {
            //InityPrintingPlugin();

            $("#txtGRN").focus();
            /*扫描物料条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    comBineMaterial();
                    return false;
                }
            });
            $("#btnMaterialCombine").bind("click", function () {
                comBineMaterial();
                return false;
            });

            bindPrinters('selPrintersList');
        });
        $("form").submit(function (e) {
            if (e && e.preventDefault) {
                e.preventDefault();
            }
            else {
                window.event.returnValue = false;
            }
            return false;
        })
        //合并物料
        function comBineMaterial() {
            var newItemId = "";
            var newStatus = "";
            if ($.trim($("#txtGRN").val()) == "") {
                $("#msg").html("物料条码不能为空!");
                $("#msg").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            grn = $.trim($("#txtGRN").val());
            //校验物料
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.CheckMaterialCombine(grn);
            if (ajax.error != null) {
                $("#txtGRN").focus();
                $("#txtGRN").select();
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                return false;
            }

            /**显示待合并GRN**/
            var list = ajax.value;

            if (list.length == 0)
            {
                $("#msg").html("当前的物料【" + grn + "】查询关联的单据信息为空不能进行合并校验，请检查!");
                $("#msg").css("color", "red");
                return false;
            }

            if (!orderNo) {
                orderNo = list[0].POorder;
            }            
            else if (orderNo != list[0].POorder) {                
                $("#txtGRN").focus();
                $("#txtGRN").select();
                $("#msg").html("当前的物料【" + grn + "】采购单【" + list[0].POorder + "】与已扫描的物料采购单【" + orderNo + "】不一致!");
                $("#msg").css("color", "red");
                return false;
            }

            if (itemId != "") {
                newItemId = list[0].PartId;
                newStatus = list[0].Status;
                if (itemId != newItemId) {
                    $("#msg").html("不是同一个产品!");
                    $("#msg").css("color", "red");
                    return false;
                }
                else if (statusId != newStatus) {
                    $("#msg").html("不是同一个物料状态!");
                    $("#msg").css("color", "red");
                    return false;
                }
            }
            else {
                itemId = list[0].PartId;

                statusId = list[0].Status;
            }

            if (materialSN.indexOf(grn) >= 0) {
                $("#msg").html("该条码已经存在!");
                $("#msg").css("color", "red");
                return false;
            }

            materialSN += grn + ','
            $("#txtGRN").val("");
            $("#txtGRN").focus();
            $("#txtGRN").select();
            $("#msg").html("");
            /**判断比较**/
            //add by weixia on 2015/5/7
            $("#trNewInfo").remove();
            var r = "";
            for (var i = 0; i < list.length; i++) {
                var itemDesc = list[i].ItemDesc.split(":")[0];
                r += "<tr class='ListTableOddRow'><td></td>";
                r += "<td><input type='checkbox' name='chkSelect'  onclick='ckCombine(this)' /><input type='hidden' value='" + list[i].SerialNumber + "' style='display:none'/>";
                r += "<input type='hidden' value='" + list[i].BalanceQty + "' style='display:none'/><input type='hidden' value='" + itemDesc + "' style='display:none'/></td>";
                r += "<td>" + list[i].SerialNumber + "</td><td>" + list[i].ItemName + "</td><td>" + list[i].BalanceQty + "</td>";
                r += "</tr>";
            }
            showleftTable(r);


        }
        function showleftTable(r) {
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
            $("#tblInfo").html("<img src=\"../Content/images/icon/comment.png\" style=\"vertical-align:middle;\" alt=\"\"/>当前共有待合并GRN记录：<b>" + ($("#tblRecHistory tr").length - 1).toString() + "</b> 条.");
        }
        //复选框事件
        var combineSN = "";  //选中的GRN,
        var combineQty = ""; //选中的数量
        var combineItemDesc = ""; //选中的物料描述
        function ckCombine(obj) {
            $("#msg").html("");
            var length = materialSN.split(",").length - 1;
            if (length <= 1) {
                alert("一条数据不能合并!");
                $("#tblRecHistory :checkbox").prop("checked", "");
                return false;
            }
            /*判断是否选中了合并GRN,如果选择了，需要移除后才能合并*/
            if (combineSN != "") {
                alert("已经选择合并后的GRN,如需更换,请移除后再选择!");
                $("#tblRecHistory :checkbox").prop("checked", "");
                return false;
            }
            if (confirm('确定将此GRN作为合并后的GRN?')) {
                var $obj = $(obj);
                if ($obj.prop("checked")) {
                    $("#tblRecHistory :checkbox").prop("checked", "");
                    $obj.prop("checked", "checked");
                    combineSN = $obj.next().val();
                    combineQty = $obj.next().next().val();
                    combineItemDesc = $obj.next().next().next().val();
                    $(obj).parent().parent().remove();
                    //add by weixia on 2015/5/7
                    $("#trRight").remove();
                    var j = 0;
                    $("#tblRecHistory tr").each(function () {
                        $(this).children("td:eq(0)").html(j.toString());
                        j++;
                    });
                    $("#tblInfo").html("<img src=\"../Content/images/icon/comment.png\" style=\"vertical-align:middle;\" alt=\"\"/>当前共有待合并GRN记录：<b>" + ($("#tblRecHistory tr").length - 1).toString() + "</b> 条.");
                    SaveMaterialCombine();
                }
            }
            else {
                $("#tblRecHistory :checkbox").prop("checked", "");
            }
        }
        function clearGRN(obj) {
            if (confirm('确定移除该GRN吗？')) {
                var $obj = $(obj);
                $(obj).parent().parent().remove();
                var removeGRN = $obj.next().val();
                var removeQty = $obj.next().next().val();
                var removeItemDesc = $obj.next().next().next().val();
                var r = "";
                r += "<tr class='ListTableOddRow'><td></td>";
                r += "<td><input type='checkbox' name='chkSelect'  onclick='ckCombine(this)' /><input type='hidden' value='" + removeGRN + "' style='display:none'/>";
                r += "<input type='hidden' value='" + removeQty + "' style='display:none'/><input type='hidden' value='" + removeItemDesc + "' style='display:none'/>";
                r += "<td>" + removeGRN + "</td><td>" + removeItemDesc + "</td><td>" + removeQty + "</td>";
                r += "</tr>";
                showleftTable(r);
                //判断待合并信息是不是，加上暂无数据
                if ($("#tblRightHistory tr").length = 1) {
                    var str = "<tr id='trRight' class='ListTableOddRow'><td colspan='5' style='text-align:center;'>暂无数据</td></tr>";
                    $(str).appendTo($("#tblRightHistory"));
                }
                combineSN = "";
            }
        }
        //合并事件
        function SaveMaterialCombine() {
            var r = "";
            for (var i = 0; i < 1; i++) {
                r += "<tr class='ListTableOddRow'><td></td>";
                r += "<td>" + combineSN + "</td><td>" + combineQty + "</td>";
                r += "<td><a href='#' onclick ='clearGRN(this)'>移除</a><input type='hidden' value='" + combineSN + "' style='display:none'/>";
                r += "<input type='hidden' value='" + combineQty + "' style='display:none'/><input type='hidden' value='" + combineItemDesc + "' style='display:none'/></td>";
                r += "</tr>";
            }
            if ($("#tblRightHistory tr").length == 1) {
                $("#tblRightHistory tr:eq(0)").after(r);
            }
            else {
                $("#tblRightHistory tr:eq(1)").before(r);
            }
            var j = 0;
            $("#tblRightHistory tr").each(function () {
                $(this).children("td:eq(0)").html(j.toString());
                j++;
            });

        }
        /* 清空指定table中数据 */
        function clearWaitGrnTable() {
            if ($("#tblRecHistory tr").length > 1) {
                $("#tblRecHistory tr:not(:first)").remove();
                $("#tblInfo").html("<img src=\"../Content/images/icon/comment.png\" style=\"vertical-align:middle;\" alt=\"\"/>当前共有待合并GRN记录：<b>" + ($("#tblRecHistory tr").length - 1).toString() + "</b> 条.");
            }
            if ($("#tblRightHistory tr").length > 1) {
                $("#tblRightHistory tr:not(:first)").remove();
            }
            /*清空对应的数据*/
            grn = "";
            itemId = "";  //获取产品id
            labelItemId = -1;
            statusId = ""; //获取状态
            materialSN = "";
            combineSN = "";
        }
        function Save() {
            if (materialSN == "") {
                alert("请扫描要合并的GRN!");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            if (combineSN == "") {
                alert("请选择合并后的GRN!");
                return false;
            }
            if (confirm("确定合并该GRN?")) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SaveCombineMaterial(combineSN, materialSN);
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                else {
                    var list = ajax.value;
                    if (list.length == 0) {
                        alert("合并后的物料信息获取失败！")
                    }
                    else {
                        labelItemId = ajax.value[0].ItemId;
                    }


                    $("#txtGRN").val("");
                    $("#msg").html("合并成功!");
                    $("#msg").css("color", "green");
                    //add by weixia on 2015/5/7 加上暂无数据
                    var leftStr = "<tr id='trNewInfo' class='ListTableOddRow'><td colspan='5' style='text-align:center;'>暂无数据</td></tr>";
                    var rightStr = "<tr id='trRight' class='ListTableOddRow'><td colspan='4' style='text-align:center;'>暂无数据</td></tr>";
                    $(leftStr).appendTo($("#tblRecHistory"));
                    $(rightStr).appendTo($("#tblRightHistory"));


                    try {
                        //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                        getDocumentInfo();

                        //将GRN信息添加到SNInfo的SNInfo.SNList集合中
                        SNInfo = {};
                        SNInfo.SNList = [];
                        SNInfo.SNList.push(combineSN);

                        //根据打印方式决定 调用ZPL还是Lab打印
                        mesLabLabelPrint();
                        clearWaitGrnTable();//2017-2-16
                    }
                    catch (e) {
                        alert(e)
                        $("#lblMessage").html(e);
                    }
                }
            }
        }
        function clearCombine() {
            if (confirm("是否确定要清空合并列表信息？")) {
                $("#tblRecHistory tr:not(:first)").each(function () {
                    $(this).remove();
                });
                $("#tblRightHistory tr:not(:first)").each(function () {
                    $(this).remove();
                });
                //add by weixia on 2015/5/7 加上暂无数据
                $("#tblInfo").html("<img src=\"../Content/images/icon/comment.png\" style=\"vertical-align:middle;\" alt=\"\"/>当前共有待合并GRN记录：<b>" + ($("#tblRecHistory tr").length - 1).toString() + "</b> 条.");
                clearWaitGrnTable();
                $("#txtGRN").val("");
                var leftStr = "<tr id='trNewInfo' class='ListTableOddRow'><td colspan='5' style='text-align:center;'>暂无数据</td></tr>";
                var rightStr = "<tr id='trRight' class='ListTableOddRow'><td colspan='4' style='text-align:center;'>暂无数据</td></tr>";
                $(leftStr).appendTo($("#tblRecHistory"));
                $(rightStr).appendTo($("#tblRightHistory"));
            }
        }

        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = '<%=Request.QueryString["ItemID"] %>';    //ItemId
        var labelProdOrderId = '<%=Request.QueryString["OrderID"] %>';
        var labelStationId = -1;    //工位Id
        var labelType = -3;          //标签类型  (-2: 产品条码 -3：物料条码-4：包装箱条码-5: 栈板条码-6：批次号-7：送货单-8：到货单-9:入库单-10:领料单-11:退料单)
        var labelSequence = 2;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径




        //获取文档模板基础信息
        function getDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                lableTypeQty = entity.PlateQty;
                printName = $("#selPrintersList").val();
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");

            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return false;
            }
        }


        //codesoft打印  Lab模板方式
        var printCount = 1;
        function mesLabLabelPrint() {
            var printdata = [];
            try {
                printCount = 1;
                lableArr = SNInfo.SNList;

                labelJsonData = "[";
                for (var i = 0; i < lableArr.length; i++) {
                    var labelStr = lableArr[i];
                    var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, -1);
                    if (ajaxLabContent.error == null) {
                        var list = ajaxLabContent.value;
                        if (list.length > 0) {
                            var page = { LabelContent: [] };
                            for (var k = 0; k < list.length; k++) {
                                page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });
                            }
                            printdata.push(page);
                        }
                    }
                }
                if (printdata.length == 0)
                    return;
                sendPrintContent(JSON.stringify(printdata), printName, printCount, labelDocumentId);
            } catch (e) {
                alert(e);
                $("#lblMessage").html(e);
                return false;
            }
        }

        function recordPrint(sn) {
            var printRecodeEntity = {};
            printRecodeEntity.RecordId = -1;
            printRecodeEntity.ActionType = 1;
            printRecodeEntity.PrintType = -3;
            printRecodeEntity.PrintKey = sn;
            printRecodeEntity.StationId = -1;
            printRecodeEntity.ResourceId = -1;
            var ajaxPrintRecodes = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.RecodePrint(printRecodeEntity);
            if (ajaxPrintRecodes.error != null) {
                alert(ajaxPrintRecodes.error.Message);
                $("#lblMessage").html(ajaxPrintRecodes.error.Message);
                return false;
            }
        }
        /********************************************标签打印 结束   （zhibin.Chen 2016-03-11 整理）************************************************/
    </script>
</asp:Content>
