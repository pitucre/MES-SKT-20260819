<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="ReprintGRN.aspx.cs" Inherits="SKT.LeanMES.Web.Material.ReprintGRN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <!--打印插件未安装的提示区域-->
    <div id="noprtplg" class="Tips">
    </div>
    <!--打印状态的信息提示区域-->
    <div id="lblMessage" class="Tips" style="text-align: center">
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
            <td class="Label1">
                <%=Resources.lang.GRN %><em>*</em>
            </td>
            <td class="Field1">
                <input type="text" id="txtGRN" class="TextBox" style="height: 25px; width: 250px; text-transform: uppercase; font-size: 16px; font-weight: bold;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">打印机名称
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
    <div id="info" style="text-align: center; color: Green; font-weight: bold; text-transform: uppercase;">
    </div>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script type="text/javascript">
        var _grn = window.parent.printGRN;
        var _name='<%=Request.QueryString["name"] %>'
        $(function () {
            $("body").focus();
            $("#txtGRN").focus();
            if (_grn != "") {
                $("#txtGRN").val(_grn);
                $("#txtGRN").focus();
                $("#txtGRN").select();
            }
            bindPrinters('selPrintersList');
            /*扫描条码*/
            $("#txtGRN").keypress(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Print();
                    return false;
                }
            });
        });
        function Save()
        {
            Print();
        } 

        function Print() {
         
            var grn = $("#txtGRN").val();
            if ($.trim(grn) == "") {
                alert("<%=Resources.Messages.NeedScanGRN %>");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            var grnArray = grn.split(",");
            SNInfo = {};
            SNInfo.SNList = [];
            SNInfo.ItemList = [];
            for (var i = 0; i < grnArray.length; i++) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMaterialUnitInfoByGRN(grnArray[i]);

                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#info").html(ajax.error.Message);
                    $("#info").css("color", "red");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }
                if (ajax.value == null || ajax.value.SerialNumber == null) {
                    $("#info").html("无效的GRN或者该GRN对应的Item不存在！");
                    $("#info").css("color", "red");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }

                var ajaxSn = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.CheckGRNIsIsLineMaterial(grnArray[i]);
                var IsLineMaterial = ajaxSn.value;

                try {
                    labelItemId = ajax.value.PartId;
                    //是否供应商打印调用不同的模板
                    var IsSupper = ajax.value.IsSuplySerialNumber;
                    if (IsSupper) {
                    
                        labelType = -24; //调用供应商模板
                    }
                    else {
                        if (IsLineMaterial =="LineMaterial") {
                            labelType = -38;
                        }
                        else if (IsLineMaterial == "SrapFeeding") {
                            labelType = -40;
                        }
                        else {
                            labelType = -3;
                        }
                    }
                    //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                    getDocumentInfo();

                    //将GRN信息添加到SNInfo的SNInfo.SNList集合中
                    SNInfo.SNList.push(grnArray[i]);
                    SNInfo.ItemList.push(ajax.value.PartId);
                }
                catch (e) {
                    alert(e)
                    $("#lblMessage").html(e);
                }

            }
            PrintLabContent();
            if (_name == "Material_ReprintGRN" && _grn!="") {
                creatservicelog("补打物料", "物料管理|物料列表", "打印物料条码", _grn == "" ? $.trim($("#txtGRN").val()) : _grn, _grn == "" ? "物料列表补打物料【" + $.trim($("#txtGRN").val()) + "】" : "补打物料【" + _grn + "】");
                creatematerialhistorylog(8, _grn == "" ? $.trim($("#txtGRN").val()) : _grn, "物料管理|物料列表|打印物料条码", _grn == "" ? "物料列表补打物料【" + $.trim($("#txtGRN").val()) + "】" : "补打物料【" + _grn + "】");
            } else if (_name == "Material_RePrintGRNSuply" && _grn != "") {
                creatservicelog("补打物料", "供应商物料管理|供应商物料列表", "打印物料条码", _grn == "" ? $.trim($("#txtGRN").val()) : _grn, _grn == "" ? "供应商补打物料【" + $.trim($("#txtGRN").val()) + "】" : "供应商补打物料【" + _grn + "】");
                creatematerialhistorylog(8, _grn == "" ? $.trim($("#txtGRN").val()) : _grn, "供应商物料管理|供应商物料列表|打印物料条码", _grn == "" ? "供应商补打物料【" + $.trim($("#txtGRN").val()) + "】" : "供应商补打物料【" + _grn + "】");
            } else {
                creatservicelog("补打物料", "物料管理|GRN重打印", "补打", _grn == "" ? $.trim($("#txtGRN").val()) : _grn, _grn == "" ? "GRN重打印补打物料【" + $.trim($("#txtGRN").val()) + "】" : "GRN重打印补打物料【" + _grn + "】");
                creatematerialhistorylog(8, _grn == "" ? $.trim($("#txtGRN").val()) : _grn, "物料管理|GRN重打印|补打", _grn == "" ? "GRN重打印补打物料【" + $.trim($("#txtGRN").val()) + "】" : "GRN重打印补打物料【" + _grn + "】");
            }
           
        }




        /********************************************标签打印 开始  （zhibin.Chen 2016-03-11 整理）************************************************/

        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelItemId = -1;    //ItemId
        var labelProdOrderId = '<%=Request.QueryString["OrderID"] %>';
        var labelStationId = -1;    //工位Id
        var labelType = -3;          //标签类型 (-2：SN，-3：GRN)
        var labelSequence = 2;      //标签序号 (1产品，2GRN, 3单号......)
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL

        var lableArr = null;        //标签信息的SN序列号集合对象
        var SNInfo;                 //当前释放标签的信息集合对象
        var tempatePath = "";       //Lab模板文件路径

        //根据打印方式决定 调用ZPL还是Lab打印
        function getDocumentInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, -1, labelType, labelSequence);
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                lableTypeQty = entity.PlateQty;
                //获取打印机名称值
                printName = $("#selPrintersList").val();
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");

            }
            else {
                alert(ajax.error.Message);
                return false;
            }
        }

        var printCount = 1;
        function PrintLabContent() {
            try {
                printCount = 1;
                lableArr = SNInfo.SNList;
                labItemList = SNInfo.ItemList;
                var printdata = [];
                for (var i = 0; i < lableArr.length; i++) {
                    var labelStr = lableArr[i];
                    var lablabItem = labItemList[i];
                    var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, lablabItem, -1);
                    if (ajaxLabContent.error == null) {
                        var list = ajaxLabContent.value;
                        var page = { LabelContent: [] };
                    
                        for (var j = 0; j < list.length; j++) {

                            //xiang.yan 2024-06-28 物料编码10501.000410被认定为浮点数，打印时打印为10501.00041
                            if (isNumberVal(list[j].LabelValue) && list[j].LabelName!="物料编码")
                            {
                                page.LabelContent.push({ name: list[j].LabelName, value: parseFloat(list[j].LabelValue) });
                            }
                            else {
                                page.LabelContent.push({ name: list[j].LabelName, value: list[j].LabelValue });

                            }
                       

                        }
                        printdata.push(page);
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

        //判断是否为数字
        function isNumberVal(val) {
            var regPos = /^\d+(\.\d+)?$/; //非负浮点数
            var regNeg = /^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$/; //负浮点数
            if (val.substring(0, 1) == "0") {
                if (val.substring(1, 1) != ".") {
                    return false;
                }
            }
            if (regPos.test(val) || regNeg.test(val)) {
                return true;
            } else {
                return false;
            }
        }

        /*
        *写入系统操作日志
        */
        function creatservicelog(logtype, modulename, pagename, oederno, logcontent) {
           
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxErrorLog.CreateOperationLog(logtype, modulename, pagename, oederno, logcontent);
            if (ajax.error != null) {
                return false;
            }
        }
        function creatematerialhistorylog(logtype, operateorder, actiondesc, logcontent) {
          
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxErrorLog.CreateMaterialHistoryLog(logtype, operateorder, actiondesc, logcontent);
            if (ajax.error != null) {
                return false;
            }
        }
        

    </script>
</asp:Content>
