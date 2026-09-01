<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ProductionCollection.Master"
    CodeBehind="SDPPage.aspx.cs" Inherits="SKT.LeanMES.Web.SDP.Demo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="client-center" style="height: 350px; width: 100%; background-color: #ebebe4;
        overflow: auto">
        <!--采集信息入口-->
    </div>
    <div style="background-color: #ebebe4; height: 20px">
    </div>
    <div id="showInfo" style="border: 1px solid #d3d3d3; width: 97%; background-color: #ebebe4;
        margin-bottom: 10px; height: 100%; position: fixed;">
    </div>
    <input id="IsPass" value="1" style="display: none" />    
    <input id="Text5" value="1" style="display: none" />
    <script type="text/javascript" src="../Content/js/jquery.min.js"></script>
    <link href="../Content/Main.css" rel="Stylesheet" type="text/css" />
    <script type="text/javascript" src="../Content/js/skt.utility.validation.js"></script>
    <script type="text/javascript">
        var UserId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>"; //用户Id
        var CurrentTime = '<%=DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") %>';
        var RouteId = ""; //路由Id
        var ProOrderId = ""; //工单Id
        var ResourceId = ""; //资源Id
        var StationId = ""; //工位Id
        var prodline = ""; //线别名称
        var IsPass = $('#IsPass').val(); //0 true,1 false
        var basedata = "";
        var scanSN;
        var bindedSN;
        var vaType;

        function loadPage(a) {
            var line = $('#topbarproductionline').html().trim();
            var station = $('#topbarstation').html().trim();
            $.post("../SDPHandler/LoadPage.ashx?api=LoadActivity&basedata=" + basedata, { "station": StationId, "value": $(a).val() }, function (data) {
                if (data.indexOf("false") < 0) {
                    //如果SN正确绑定事件,取消入口事件
                    $(a).removeAttr("onchange");
                }
                eval(data);
            });
        }
        $(document).ready(function () {
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('Common_ProCollectionUI');
                },
                10
            );
            (function ($) {
                $.getUrlParam = function (name) {
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) return unescape(r[2]); return null;
                }
            })(jQuery);
            StationId = $.getUrlParam('stationid');
            ResourceId = $.getUrlParam('resourceid');
            //加载页面
            $.post("../SDPHandler/LoadPage.ashx?api=LoadPage", { "station": StationId }, function (data) {
                $(".client-center").append(data);
                show('页面加载成功！', true);
                //1.获取当前基本信息
                if ($("#hdnCurrRouteId").length > 0) { RouteId = $("#hdnCurrRouteId").val(); } //路由Id
                if ($("#hdnCurrProOrderId").length > 0) { ProOrderId = $("#hdnCurrProOrderId").val(); } //工单Id
                if ($("#hdnCurrResourceId").length > 0) { ResourceId = $("#hdnCurrResourceId").val(); } //资源Id 
                if ($("#hdnCurrStationId").length > 0) { StationId = $("#hdnCurrStationId").val(); } //工位Id
                //用户名+路由+工序+工单+资源+当前时间
                basedata = UserId + '_' + RouteId + '_' + StationId + '_' + ProOrderId + '_' + ResourceId + '_' + CurrentTime + '_' + IsPass;
                if (!StationId > 0) {
                    alert("请先在操作菜单列表进行切换工位操作！");
                    return;
                }
            }).error(function () { show('页面加载失败！', false); });
        });


        //显示信息(内容,结果)
        function show(info, result) {
            var co = result == true ? 'green' : 'red';
            var date = new Date();
            var time = date.getFullYear() + '-' + (date.getMonth() > 9 ? (date.getMonth() + 1) : "0" + (date.getMonth() + 1)) + '-' + (date.getDate() > 9 ? date.getDate() : "0" + date.getDate()) + ' ' + (date.getHours() > 9 ? date.getHours() : "0" + date.getHours()) + ':' + (date.getMinutes() > 9 ? date.getMinutes() : "0" + date.getMinutes()) + ':' + (date.getSeconds() > 9 ? date.getSeconds() : "0" + date.getSeconds());
            if ($('#showInfo').find('br').length < 9) {
                $('#showInfo').append("<strong style='color:" + co + "'>" + time + '  ' + info + "</strong></br>");
            } else {
                $('#showInfo  strong:eq(0)').remove();
                $('#showInfo  br:eq(0)').remove();
                $('#showInfo').append("<strong style='color:" + co + "'>" + time + '  ' + info + "</strong></br>");
            }
        }
        /******表格绑定方法****start**********/
        function TabelBind(id, rows, text) {
            if ($(id).find('tr').length < rows) {
                $('#' + id).append(text);
            } else {
                $('#' + id + '  tr:eq(0)').remove();
                $('#' + id).append(text);
            }
        }
        /******表格绑定方法*****end************/

        /***********列表方法*****start***********/
        function tbAddRow(dname) {
            var sTbid = $(dname).parent().parent().next('table').attr('id');
            //添加行内样式
            var trclass = "";
            var cc = JSON.stringify($(dname).parent().parent().next('table').find('tr:last').attr('class'));
            if ($(dname).parent().parent().next('table').find('tbody:eq(0)>tr:last').hasClass('ListTableOddRow')) {
                trclass = "ListTableEvenRow";
            } else {
                trclass = "ListTableOddRow";
            }
            $("#" + sTbid + " .template")
            //连同事件一起复制    
                                    .clone(true)
            //去除样式    
                                    .removeClass()
            //修改内部元素 
                                    .find(".delrow").show().end()
                                    .find("input").val("").end()
                                    .find("textarea").val("").end()
            //添加行内样式
                                    .addClass(trclass)
            //插入表格    
                                    .appendTo($("#" + sTbid));
        }
        /****统计****/
        function sum_total(dname) {
            //找到当前td是第几列td
            //循环所有tr 找出这一列的td 所有值相加
            var tdsum = 0;
            var tdname = $(dname).attr('name')
            $(dname).parent().parent().parent().find('input[name=' + tdname + ']').each(function (a) {
                if (isNaN($(this).val())) {
                    alert('请输入数字！');
                    $(this).val('').focus();
                } else {
                    if ($(this).val() != "") {
                        tdsum += parseInt($(this).val());
                    }
                    $('#tosum').find('input[name=' + tdname + ']').val(tdsum);
                }
            });
        }

        /*删除tr*/
        function fnDeleteRow(obj) {
            if ($(obj).parent().parent().attr('class').indexOf("template") < 0) {
                $($(obj).parent().parent()).remove();
            }
        }
        /***********列表方法*******end*********/

        /********************打印开始**********************/
        var SNInfo = "";
        var ibs;                    //秒
        var labelDocumentId = -1    //Label文档Id
        var lableTypeQty = 1;       //连板数量
        var printName = "";         //打印机名称
        var labelStationId = -1;    //工位Id
        var labelItemId = '';    //
        var labelProdOrderId = ''; //
        var labelType = -3;          //标签类型  (1.GRN 2.包装)
        var labelSequence = 2;      //标签序号
        var labelPrintWayId = -1;   //打印方式 78=Lab  79=ZPL
    
        var labelContent = "";      //标签ZPL指令内容
        var labelJsonData = "";     //标签Lab方式的 数据Json格式字符串
        var tempatePath = "";       //Lab模板文件路径

        //Print方法在后台调用的方法
        function AutoAddJSAndPrint() {
            <%--$.getScript('<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer4Auto.js?v=3')
                .done(function (script, textStatus) {                    
                    mesjsprint();
                })
                .fail(function (jqxhr, settings, exception) {
                    alert("动态引用打印JS失败," + exception.message);
                });--%>
            var script = document.createElement("script");
            script.type = "text/javascript";            
            if (script.readyState) {
                script.onreadystatechange = function () {
                    if (script.readyState == "loaded" || script.readyState == "complete") {
                        script.onreadystatechange = null;
                        mesjsprint();
                    }
                };
            } else {
                script.onload = function () {
                    mesjsprint();
                };
            }
            script.src = '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer4Auto.js?v=3';
            document.body.appendChild(script);
        }

        function mesjsprint() {            
            //获取文档信息
            var doc = getDocumentInfo();
            //根据打印方式决定 调用ZPL还是Lab打印
            if (doc) {
                usePrinMethod();
            }           
        }

        //获取文档模板基础信息
        function getDocumentInfo() {
            var ajax = [];
            if (lableType == -4 || lableType == -5) {
                ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetPackLabelDocumentInfo(SNInfo);
            }
            else {
                ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.GetLabelDocumentInfo(labelItemId, labelStationId, labelType, labelSequence);
            }
                
            if (ajax.error == null) {
                var entity = ajax.value;
                labelDocumentId = entity.LabelDocumentId;
                lableTypeQty = entity.PlateQty;
                printName = entity.PrinterName;
                labelPrintWayId = entity.PrintWayId;
                tempatePath = entity.TemplatePath.replace("\\", "\\\\");
            }
            else {
                alert(ajax.error.Message);
                $("#lblMessage").html(ajax.error.Message);
                return false;
            }
        }
       

        //根据打印方式决定 调用ZPL还是Lab打印
        function usePrinMethod() {
            //根据文档使用的打印方式，决定调用Lab模板方式，还是指令方式。
            if (labelPrintWayId == 78) {
                //codesoft打印  Lab模板方式
                mesLabLabelPrint();
            }
            else if (labelPrintWayId == 79) {
                //指令方式
                mesZPLPrintLabel();
            }
        }

        //codesoft打印  Lab模板方式
        function mesLabLabelPrint() {
            //从已释放的标签信息集合中，获取SN序列号集合。
            lableArr = SNInfo.split(",");

            for (var i = 0; i < lableArr.length; ) {
                //lableArr[i]
                //找到doucumentId打印文档id
                var labelStr = "";

                if (lableTypeQty == 1) {
                    labelStr = lableArr[i];
                }
                else {
                    for (var j = 0; j < lableTypeQty; j++) {
                        if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {
                        }
                        else {
                            //根据联板数，拼接SN字符串。 
                            labelStr += lableArr[i + j] + ",";
                        }
                    }
                }

                i = i + lableTypeQty;

                //每发送一次打印指令 初始化标签内容变量。
                labelContent = "";

                //获取标签模板中的标签值 集合
                var ajaxLabContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnLabelInfoForLab(labelDocumentId, labelStr, -1, -1, -1, labelItemId, labelProdOrderId);

                if (ajaxLabContent.error == null) {
                    //接收打印的ZPL标签  
                    try {
                        var list = ajaxLabContent.value;

                        if (list.length > 0) {

                            for (var h = 0; h < list.length; h++) {
                                labelContent += '{name:"' + list[h].LabelName + '",value:"' + list[h].LabelValue + '"}' + ",";
                            }

                            labelContent = labelContent.substring(0, labelContent.length - 1);
                            labelJsonData = "[{LabelContent:[" + labelContent + "]}]";

                            //labelPrintingPlugin.PrintLabel(tempatePath, labelJsonData);
                            printLabel(tempatePath, labelJsonData, printName, "lab");
                            //条码打印记录
                            var labelSNArr;
                            if (lableTypeQty == 1) { //单板
                                labelSNArr = labelStr.split(",")[0];
                                recordPrint(labelSNArr);
                            } else { //连板
                                labelSNArr = labelStr.split(",");
                                for (var k = 0; k < labelSNArr.length - 1; k++) {
                                    recordPrint(labelSNArr[k]);
                                }
                            }
                        }
                    } catch (e) {
                        alert(e);
                        $("#lblMessage").html(e);
                        return false;
                    }
                }
                else {
                    alert(ajaxLabContent.error.Message);
                    $("#lblMessage").html(ajaxLabContent.error.Message);
                    return false;
                }
            }

            ibs = 3;
            setInterval(function () { $("#lblPt").html("打印条码完成," + ibs + "秒后关闭窗口！"); ibs-- }, 1000)
            setTimeout(function () {
                parent.form1.submit(); ;
            }, 3000);
        }

        //指令方式
        function mesZPLPrintLabel() {
            lableArr = SNInfo.splt(",");
            for (var i = 0; i < lableArr.length; ) {

                //lableArr[i]
                //找到doucumentId打印文档id
                var labelStr = "";
                if (lableTypeQty == 1) {
                    labelStr = lableArr[i];
                }
                else {
                    for (var j = 0; j < lableTypeQty; j++) {
                        if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {
                        }
                        else {
                            labelStr += lableArr[i + j] + ",";
                        }
                    }
                }

                i = i + lableTypeQty;

                //获取此标签的zpl指令
                var ajaxZplContent = SKT.LeanMES.Web.AjaxServices.AjaxPrint.returnZplContent(labelDocumentId, labelStr, -1, -1, -1, labelItemId, labelProdOrderId);
                if (ajaxZplContent.error == null) {
                    zplStr = ajaxZplContent.value;
                    try {

                        //labelPrintingPlugin.DoPrint(zplStr, printName);
                        printLabel("", zplStr, printName, "zpl");

                        //条码打印记录
                        var labelSNArr;
                        if (lableTypeQty == 1) { //单板
                            labelSNArr = labelStr.split(",")[0];
                            recordPrint(labelSNArr);
                        } else { //连板
                            labelSNArr = labelStr.split(",");
                            for (var k = 0; k < labelSNArr.length - 1; k++) {
                                recordPrint(labelSNArr[k]);
                            }
                        }
                    } catch (e) {
                        alert(e);
                        $("#lblMessage").html(e);
                        return false;
                    }
                } else {
                    alert(ajaxZplContent.error.Message);
                    $("#lblMessage").html(ajaxZplContent.error.Message);
                    return false;
                }
            }
            ibs = 3;
            setInterval(function () { $("#lblPt").html("打印条码完成," + ibs + "秒后关闭窗口！"); ibs-- }, 1000)
            setTimeout(function () {
                parent.form1.submit(); ;
            }, 3000);
        }

        function recordPrint(sn) {
            var printRecodeEntity = {};
            printRecodeEntity.RecordId = -1;
            printRecodeEntity.ActionType = 1;
            printRecodeEntity.PrintType = labelType;
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
       
        /********************打印结束**********************/
    </script>
</asp:Content>
