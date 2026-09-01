<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialSplit.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialSplit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <!--打印插件未安装的提示区域-->
    <div id="noprtplg" class="Tips">
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.GRN %><em>*</em>
            </td>
            <td class="Field1">
                <input type="text" id="txtGRN" class="TextBox" style="width: 250px; height: 25px; text-transform: uppercase; font-size: 16px; font-weight: bold;" /><span class="Tips">回车即可获取GRN数量</span>
            </td>
        </tr>

        <tr>
            <td class="Label1">
                <%=Resources.lang.GRNBalanceQty %>
            </td>
            <td class="Field1">
                <span id="lblGRNQty">0</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <input type="checkbox" id="isprint" value="yes" checked /><span>是否打印主条码</span> 
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.SplitMaterialQty %>
            </td>
            <td class="Field1">
                <input type="text" id="txtQty" class="TextBox" value="0" onkeyup="if(isNaN(value))execCommand('undo')"
                    onafterpaste="if(isNaN(value))execCommand('undo')" style="width: 100px; height: 25px; text-transform: uppercase; font-size: 15px; font-weight: bold; text-align: right" />
                <input type="button" id="btnSelectProject" class="ButtonBox" value="..." style="height: 27px; font-weight: bold; text-transform: uppercase;" />
                <span class="Tips">回车即可获得分料信息</span>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.SplitMaterialInfo %>
            </td>
            <td class="Field1">
                <span id="lblSplitInfo"></span>
            </td>
        </tr>
        <tr>
            <td class="Label1">打印方式
            </td>
            <td class="Field1">
                <input type="radio" name="print" value="offLinePrint" checked="checked"><span>离线打印</span></input>&nbsp;&nbsp;
                <input type="radio" name="print" value="onLinePrint"><span>在线打印</span></input>
            </td>
        </tr>
        <tr>
            <td class="Label1">打印机名称
            </td>
            <td class="Field2" colspan="1">
              <select id="selPrintersList" style=" width: 250px; ">
                </select>
               <a href="#" onclick="bindPrinters('selPrintersList');">重新加载打印机列表</a>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div id="info" class="Tips" style="width: 99%; text-align: center;">
    </div>
    <div class="clear5">
    </div>
    <div id="subGrnList">
    </div>

    <div class="clear5">
    </div>
    <!--打印状态的信息提示区域-->
    <div id="lblMessage" class="Tips" style="text-align: center">
    </div>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            var _grn = '<%=Request.QueryString["GRN"] %>';
            $("#txtGRN").focus();
            if (_grn != "") {
                $("#txtGRN").val(_grn);
                $("#txtGRN").select();
            }
            $("#txtGRN").keypress(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    GetGRNQty($.trim($("#txtGRN").val()));
                    return false;
                }
            });

            $("#txtQty").keypress(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    CheckQty($.trim($("#txtQty").val()), $("#lblGRNQty").html());
                    return false;
                }
            });
            $("#btnSelectProject").bind("click", function () {
                CheckQty($("#txtQty").val(), $("#lblGRNQty").html());
            });

            bindPrinters('selPrintersList');
        });

        function Save() {
            var txtQty = $("#txtQty").val();
            var txtGRN = $.trim($("#txtGRN").val());

            if ($.trim(txtGRN) == "") {
                alert("<%=Resources.Messages.RequiredGRN %>");
                $("#txtGRN").focus();
                return false;
            }
            if ($.trim(txtQty) == "" || parseFloat(txtQty) <= 0) {
                alert("请正确输入分料数量，分料数量需大于0!");
                $("#txtQty").focus();
                return false;
            }
            if (!confirm("<%=Resources.Messages.ConfirmToSplit %>")) {
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.SplitMaterial(txtQty, txtGRN);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#lblSplitInfo").html("");
                return false;
            }
            var list = ajax.value;
            alert("<%=Resources.Messages.SplitMaterialSuccessed %>");
            GetSubGrn(txtGRN, list);

            $("#lblGRNQty").html((parseFloat($("#lblGRNQty").html()) - parseFloat(txtQty)).toFixed(6));
            $("#lblGRNQty").html(parseFloat($("#lblGRNQty").html()));
            //判断是否为在线打印
            var printStyle = $('input:radio[name="print"]:checked').val();
            if (printStyle == "onLinePrint") {
                var grnQty = $("#lblGRNQty").html();
                var n = list.length - 1;
                onLinePrint(list[0].SerialNumber, list[n].SerialNumber, list[0].BalanceQty, list[0].VendorCode, list[0].ItemName, list[0].MPN, list[0].SplitTime, list[0].LotCode, txtGRN, grnQty, list[0].ItemId);
            }
        }

        function GetGRNQty(grn) {
            $("#subGrnList").html("");
            $("#lblSplitInfo").html("");
            if ($.trim(grn) == "") {
                alert("<%=Resources.Messages.RequiredGRN %>");
                $("#txtGRN").focus();
                return false;
            }
            $("#lblGRNQty").html("<%=Resources.Messages.GettingGRNQty %>");
            $("#lblGRNQty").css("color", "");
            $("#lblGRNQty").css("font-weight", "normal");
            setTimeout(function () {
                var ishavpack = false;
                var pkserialnumber = "";
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetGRNQuantity(grn);
                if (ajax.error != null) {
                    if (ajax.error.Message.indexOf("P") != -1) {
                        ishavpack = true;
                        pkserialnumber = ajax.error.Message.substring(ajax.error.Message.indexOf("P")).substring(0, ajax.error.Message.substring(ajax.error.Message.indexOf("P")).length - 5).split("|")[1];
                    }else{
                        alert(ajax.error.Message);
                        $("#lblSplitInfo").html(ajax.error.Message);
                        $("#lblSplitInfo").css("color", "red");
                        $("#lblGRNQty").html("0");
                        $("#txtGRN").focus();
                        $("#txtGRN").select();
                        return false;
                    }
                }
               
                if (ishavpack) {
                    if (confirm("当前物料条码存在包装关系，是否解除包装?")) {
                        if (pkserialnumber == "") {
                            alert("未获取到物料包装箱信息");
                            return false;
                        } 
                        //解除物料条码与包装箱
                        var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.UnPack(pkserialnumber);
                        if (ajax1.error != null) {
                            alert(ajax1.error.Message);
                            return false;
                        }
                        var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.RemoveGRN(pkserialnumber, grn);
                        if (ajax2.error != null) {
                            alert(ajax2.error.Message);
                            return false;
                        }
                        var ajax3 = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ClosePack(pkserialnumber);
                        if (ajax3.error != null) {
                            alert(ajax3.error.Message);
                            return false;
                        }
                        ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetGRNQuantity(grn);
                        if (ajax.error != null) {
                                return false;
                        }
                    } else {
                        return false;
                    }
                }
                
                var ajaxArr = ajax.value;
                var grnQty = ajaxArr[0];
                if (grnQty != null) {
                    if (parseFloat(grnQty) == 0) {
                        $("#lblGRNQty").html("0");
                        $("#lblGRNQty").css("color", "red");
                        $("#lblGRNQty").css("font-weight", "bold");
                        $("#txtGRN").select();
                    }
                    else {
                        $("#lblGRNQty").html(parseFloat(grnQty).toString());
                        $("#lblGRNQty").css("color", "green");
                        $("#lblGRNQty").css("font-weight", "bold");
                        $("#txtQty").focus();
                        $("#txtQty").select();
                    }
                }

                GetSubGrn(grn, ajaxArr[1]);

            }, 100);
        }

        function CheckQty(qty, totalqty) {
            if (qty == "") {
                alert("<%=Resources.Messages.SplitQtyInvalid %>");
                $("#txtQty").focus();
                $("#txtQty").select();
                return false;
            }
            if (totalqty == "") {
                alert("GRN:[" + $("#txtGRN").val().toString() + "]<%=Resources.Messages.NoGRNToSplit %>");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            if (parseInt(qty) >= parseInt(totalqty)) {
                alert(String.format("<%=Resources.Messages.SplitErrorInfo %>", qty.toString(), totalqty.toString()));
                $("#txtQty").focus();
                $("#txtQty").select();
                return false;
            }
            $("#lblSplitInfo").html(String.format("<%=Resources.Messages.SplitDetail %>", "<b>" + $("#txtGRN").val().toString() + "</b>", "<b>" + qty.toString() + "</b>"));
            $("#lblSplitInfo").css("color", "");

            Save();
        }

        $(function () {

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

        function GetSubGrn(txtGRN, list) {
            console.log(list);
            var tbl = "<div class='ListTableTitle'><%=Resources.lang.SupGRN %>: " + txtGRN + "</div>";
            tbl += "<table width='100%' class='ListTable'>";
            tbl += "<tr class='ListTableHeader'>";
            tbl += "<th scope='col'  width='14%'><%=Resources.lang.SubGrnSerialNumber %></th>";
            tbl += "<th scope='col' width ='7%'><%=Resources.lang.SubGrnQuantity %></th>";
            tbl += "<th scope='col' width='14%'><%=Resources.lang.Supplier %></th>";
            tbl += "<th scope='col' width='14%'><%=Resources.lang.ItemsName %></th>";
            tbl += "<th scope='col' width ='18%'><%=Resources.lang.ItemDesc %></th>";
            tbl += "<th scope='col' width ='12%'><%=Resources.lang.SubGrnGenPeople %></th>";
            tbl += "<th scope='col' width='14%'><%=Resources.lang.SubGrnGenDatetime %></th>";
            tbl += "<th scope='col' width='11%'><%=Resources.lang.Print %></th>";
            tbl += "</tr>";
            var tqty = 0;
            if (list == null || list.length == 0) {
                tbl += "<tr class='ListTableEmptyDataRow'><td colspan='8'><%=Resources.Messages.NoSubGrn %></td></tr>";
                tbl += "<tr class='ListTablePager'><td colspan='8'>共有GRN个数为: <b>" + list.length + "</b> ,子GRN总数量为：<b>" + tqty.toString() + "</b></td></tr>";
                tbl += "</table>";
                $("#subGrnList").html(tbl);
                return false;
            }

            for (var i = 0; i < list.length; i++) {

                if (i % 2 == 0) {
                    tbl += "<tr class='ListTableOddRow'>";
                }
                else {
                    tbl += "<tr class='ListTableEvenRow'>";
                }
                if (i == 0) {
                    tbl += "<td><b>" + list[i].SerialNumber + "</b></td>";
                }
                else {
                    tbl += "<td>" + list[i].SerialNumber + "</td>";
                }
                tbl += "<td>" + list[i].GRNStr + "</td>";
                tbl += "<td>" + list[i].VendorCode + "</td>";
                tbl += "<td>" + list[i].ItemName + "</td>";
                tbl += "<td>" + list[i].MPN + "</td>";
                if (list[i].CreateBy == undefined || list[i].CreateBy == null) {
                    tbl += "<td></td>";
                } else {
                    tbl += "<td>" + list[i].CreateBy + "</td>";
                }

                tbl += "<td>" + list[i].SplitTime + "</td>";
                tbl += "<td><a href='javascript:void(0);' onclick=\"Reprint('" + list[i].SerialNumber + "'," + list[i].BalanceQty + ",'" + list[i].VendorCode + "','" + list[i].ItemName + "','" + list[i].MPN + "','" + list[i].LotCode + "','" + list[i].LotCode + "', " + list[i].ItemId + ")\"><img style='cursor:pointer;' src='<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/icon/printer.png' alt='' title='<%=Resources.lang.RePrint %>' border='0'/><%=Resources.lang.RePrint %></a></td>";
                tbl += "</tr>";
                tqty += list[i].BalanceQty;
            }
            tbl += "<tr class='ListTablePager'><td colspan='8'>共有GRN个数为: <b>" + list.length + "</b> ,子GRN总数量为：<b>" + tqty.toString() + "</b></td></tr>";
            tbl += "</table>";
            $("#subGrnList").html(tbl);
        }


        //在线打印条码
        function onLinePrint(grnsn1, grnsn2, qty, vendor, itemname, itemdesc, dtm, lotCode, bigSn, bigQty, itemId) {

            try {
                labelItemId = itemId;

                //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                getDocumentInfo();

                //将GRN信息添加到SNInfo的SNInfo.SNList集合中
                SNInfo = {};
                SNInfo.SNList = [];
                if ($("#isprint").prop("checked")) {
                    SNInfo.SNList.push(grnsn1);
                }
                //SNInfo.SNList.push(grnsn1);
                SNInfo.SNList.push(grnsn2);

                mesLabLabelPrint();
            } catch (e) {
                alert(e);
                $("#lblMessage").html(e);
            }
        }

        function Reprint(grnsn, qty, vendor, itemname, itemdesc, dtm, lotCode, itemId) {
            try {
                labelItemId = itemId;


                //获取标签文档的配置信息，并且根据标签文档配置的打印类型，进行打印插件的验证。插件引用成功，则初始化打印插件对象。
                getDocumentInfo();

                //将GRN信息添加到SNInfo的SNInfo.SNList集合中
                SNInfo = {};
                SNInfo.SNList = [];
                SNInfo.SNList.push(grnsn);

                mesLabLabelPrint();
            }
            catch (e) {
                alert(e);
                $("#lblMessage").html(e);
            }
        }

        //离线条码打印
        function Print() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/PrintSplitMaterial.aspx?name=Material_OffLinePrint";
            dialog({ title: "<%= Resources.Pages.Material_OffLinePrint %>", src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 100) });
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
    </script>
</asp:Content>
