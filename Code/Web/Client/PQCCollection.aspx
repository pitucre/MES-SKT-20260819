<%@ Page Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true" CodeBehind="PQCCollection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.PQCCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="client-center">
        <!--采集信息入口-->
        <div id="scancenter" class="scan-center">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td align="left">
                        <span class="scan-center-title" id="labscancentertitle">
                            <span id="lblScanType">
                                <%=Resources.lang.AC_OBA_ScanSN%></span> <span id="lblGrnQty" style="color: Green;"></span></span>&nbsp;&nbsp;&nbsp;&nbsp;<div id="messageBox">
                                </div>
                    </td>
                    <td align="right" style="padding-right: 20px;">
                        <input type="checkbox" id="cbxforceuppercase" value="yes" checked />
                        <%=Resources.lang.ForcingUpperCase %>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <input type="text" id="txtSN" class="scan-center-sn" />
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <table>
                            <tr>
                                <td>
                                    <span class="scan-center-title">
                                        <%=Resources.lang.LastStation %>：</span>
                                </td>
                                <td>
                                    <div class="dropdown-station" id="laststationfirst">
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="right">
                        <table>
                            <tr>
                                <td>
                                    <span class="scan-center-title">
                                        <%=Resources.lang.NextStation %>：</span>
                                </td>
                                <td>
                                    <div class="dropdown-station" id="nextstationfirst">
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <%--<div class="tb_c tb_content">--%>
        <div id="activeinfo1" class="active-info">
            <div style="margin-top: 15px; margin-bottom: 15px;">
                <table class='ListTable' style='border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;'>
                    <tr class='ListTableOddRow' style="text-align: center; height: 35px; font-size: 14px">
                        <td>产品名称：
                        </td>
                        <td colspan="2" id="ItemName"></td>
                    </tr>
                    <tr class='ListTableOddRow' style="text-align: center; height: 35px; font-size: 14px">
                        <td>产品规格：
                        </td>
                        <td colspan="2" id="ItemSpec"></td>
                    </tr>
                    <tr class='ListTableOddRow' style="text-align: center; height: 35px">
                        <td>检验结果：
                        </td>
                        <td>
                            <label style="color: Green; font-weight: bold;">
                                <input id='cbFormOK' type="checkbox" disabled="disabled" onchange='FinalResult(this)' />合格</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <label style="color: Red; font-weight: bold;">
                        <input id='cbFormNG' type="checkbox" disabled="disabled" onchange='FinalResult(this)' />不合格</label>
                        </td>
                        <td>
                            <input type="button" style="width: 60px; height: 25px;" value="保存" onclick="save()" />
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divDtl">
            </div>
            <br />
        </div>
        <!--实时信息输出-->
        <div id="activeinfo" class="active-info">
            <div id="activeinfoarea" class="active-info-area"></div>
        </div>
    </div>
    <script language="javascript" type="text/javascript">
        var ajax = "";
        var scanSN = "";
        var routeId = "";
        var prodOrderId = "";
        var resourceId = "";
        var stationId = "";
        var operateObj;//检验时 指定结果项文本框 或者 固定结果单选框 对象

        $(document).ready(function () {
            //加载按钮
            setTimeout(
                function () {
                    loadClientButton('PQCCollection');
                },
                10
            );
            Load();
        });
        /**
        *扫描触发事件
        */
        function afterScan() {
            var currentSN = $.trim($("#txtSN").val());
            if (currentSN != "") {
                //重复扫描
                if (currentSN == scanSN) {
                    showAreaMessge(currentSN + ':已扫描，不允许重复扫描', "messageRed");
                    $("#txtSN").val("").focus();
                    return false;
                }
                //未保存结果
                if (scanSN && scanSN != currentSN) {
                    showAreaMessge(currentSN + ':检验结果未保存，请检查！', "messageRed");
                    $("#txtSN").val("").focus();
                    return false;
                }

                //1.查看是否有RouteId及工单Id
                routeId = $("#hdnCurrRouteId").val();
                prodOrderId = $("#hdnCurrProOrderId").val();
                resourceId = $("#hdnCurrResourceId").val();
                stationId = $("#hdnCurrStationId").val();
                //SN通用过站验证
                var entity = {};
                entity.SN = currentSN;
                entity.UserID = userId;
                entity.OpeID = stationId;
                entity.ResID = resourceId;
                entity.IsRepair = false;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspUnitProcessValidation", JSON.stringify(entity));
                if (ajax.error != null) {
                    updateCollectionList(currentSN, 'NG');
                    showAreaMessge(currentSN + ':' + ajax.error.Message, "messageRed");
                    $("#txtSN").val("").focus();
                    SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                    return false;
                }
                scanSN = currentSN;
                //1 获取检验项
                getFormInfo(currentSN, stationId);
                refreshProInfoBySN(currentSN);
                $("#txtSN").val("");
            }
        }
        //     var data = SKT.LeanMES.Web.AjaxServices.AjaxClientController.CommonValidate(scanSN, resourceId, stationId, false);
        //     if (data.error != null) {
        //         showAreaMessge(scanSN + ":" + data.error.Message, "messageRed");
        //         setMessageBox(scanSN + ":" + data.error.Message, "messageRed");
        //         $("#txtSN").select();
        //         return false;
        //     }
        //     //1 获取检验项
        //     getFormInfo(scanSN, stationId);
        //     refreshProInfoBySN(scanSN);
        //     $("#txtSN").val("");
        //  }
        //  }
        function Load() {
            $("input[type='button']").hide();
            var html = "<table id='tblExpand' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
               + "<tr class='ListTableHeader'  style='text-align: center;'><th colspan='6' >默认模板</th></tr>"
               + "</table>";
            $("#divDtl").append(html);
            html = "<table id='tbDtl' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                    + "<tr class='ListTableHeader' ><th>序号</th><th>检验项目</th><th>录入方式</th><th>判定标准</th><th>单位</th><th>检验方法</th><th >检验结果</th><th>不良代码</th><th>输入值</th>"
            html += "<tr name='TempLateTr' class='ListTableOddRow' >"
                                + "<td style='text-align:center; width:4%'>1</td>"
                                + "<td style='text-align:left; width:13%'>默认项目</td>"
                                + "<td style='text-align:left; width:7%'>指定值</td>"
                                + "<td style='text-align:left; width:12%'></td>"
                                + "<td style='text-align:left; width:5%'>ml</td>"
                                + "<td style='text-align:left; width:8%'></td>"
                                + "<td style='text-align:left; width:8%' class=\"insppection-input\"><label><input type='radio'  />OK</label>&nbsp;&nbsp;<label><input type='radio' disabled='disabled'/>NG</label></td>"
                                + "<td style='text-align:left; width:8%' class=\"nc-code\"></td>" //不良代码列
                                + "<td style='text-align:center; width:5%' class=\"insppection-input\"></td><tr></table>";
            $("#divDtl").append(html);

            //动态绑定事件
            $(".inputResult").live("focus", function () { $(this).select(); });
            $(".inputResult").live("blur", function () { count(this); });
            $("input[type='radio']").live("click", function () { ChooseRad(this); });
            //$(document).live("focus", ".inputResult", function () { $(this).select(); });
            //$(document).live("blur", ".inputResult", function () { count(this) });
            //$(document).live("click", "input[type='radio']", function () { ChooseRad(this); });
            //$(document).on("focus", ".inputResult", function () { $(this).select(); });
            //$(document).on("blur", ".inputResult", function () { count(this) });
            //$(document).on("click", "input[type='radio']", function () { ChooseRad(this); });

        }
        //计算检验项结果
        function count(obj) {
            debugger
            operateObj = obj;
            var InspectionMethodValue = $(obj).parent().parent().find("td:eq(3)").text();
            var data = $(obj).val();
            var Result = false;
            if (InspectionMethodValue.indexOf("(") != -1) {
                //散列值
                var arr = InspectionMethodValue.replace("(", "").replace(")", "").split(',');
                if ($.inArray(data, arr) == -1) {
                    Result = false;
                } else {
                    Result = true;
                }
            } else if (InspectionMethodValue.indexOf("[") != -1) {
                //范围
                var arr = InspectionMethodValue.replace('[', "").replace(']', "").split('~');
                var arrNum = arr[0].split("[");
                var Num0 = parseFloat(arrNum[0]);
                var numMax = parseFloat(arrNum[1]);
                var numMin = parseFloat(arr[1].replace(']', ""));

                if (parseFloat(data) >= (Num0+numMin) && parseFloat(data) <= (Num0+numMax)) {
                    Result = true;
                } else {
                    Result = false;
                }
            } else {
                if (InspectionMethodValue.indexOf("±") != -1) {
                    var value = InspectionMethodValue.replace("±");
                    if (data >= arr[0] && data <= arr[1]) {
                        Result = true;
                    } else {
                        Result = false;
                    }
                } else {
                    if (eval(data + InspectionMethodValue)) {
                        Result = true;
                    } else {
                        Result = false;
                    }
                }
            }
            if (Result) {
                $(obj).parent().parent().find("td:eq(6) input[type='radio']:first").prop("checked", "checked");
                if ($("#cbFormOK").attr('checked') == null && $("#cbFormNG").attr('checked') == null) {
                    $("#cbFormOK").attr("checked", true);
                } else {
                    if ($("#divDtl tr").find("td:eq(6) input[type='radio']:last:checked").length < 1) {
                        $("#cbFormOK").attr("checked", true)
                        $("#cbFormNG").attr("checked", false);
                    }
                }
                $(obj).closest(".insppection-input").siblings(".nc-code").html("");//删除不良代码
            } else {
                $(obj).closest(".insppection-input").parent().find("td:eq(6) input[type='radio']:last").prop("checked", "checked");
                $("#cbFormOK").attr("checked", false)
                $("#cbFormNG").attr("checked", true);
                //NG时需要采集不良代码
                openNCPage();
            }
        }

        //打开不良代码选择界面
        function openNCPage() {
            var ncCodes = $.trim($(operateObj).closest(".insppection-input").siblings(".nc-code").html());
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Client/InspectionNCCollection.aspx?name=InspectionNCCollection&stationId=" + stationId + "&ncCode=" + ncCodes + "";
            dialog({ title: "不良代码", src: openWinUrl, width: 600, height: 400 });
        }

        //QC页面回调函数
        function qcPageCallBack(arrNCCode) {
            if (arrNCCode == null || arrNCCode.length <= 0) {
                alert("未获取到不良代码");
                return;
            }
            var ncCodes = "";
            //获取不良代码
            for (var i = 0; i < arrNCCode.length; i++) {
                ncCodes += i == 0 ? arrNCCode[i] : "," + arrNCCode[i];
            }
            $(operateObj).closest(".insppection-input").siblings(".nc-code").html(ncCodes);//将不良代码显示到列表中
            closeDialog();
        }

        function ChooseRad(obj) {
            operateObj = obj;
            if ($(obj).attr("id").indexOf("OK") != -1) {
                if ($("#cbFormOK").attr('checked') == null && $("#cbFormNG").attr('checked') == null) {
                    $("#cbFormOK").attr("checked", true);
                } else {
                    if ($("#divDtl tr").find("td:eq(6) input[type='radio']:last:checked").length < 1) {
                        $("#cbFormOK").attr("checked", true)
                        $("#cbFormNG").attr("checked", false);
                    }
                }
                $(obj).closest(".insppection-input").siblings(".nc-code").html("");//删除不良代码
            } else {
                $("#cbFormOK").attr("checked", false)
                $("#cbFormNG").attr("checked", true);
                //NG时需要采集不良代码
                openNCPage();
            }
        }

        //获取根据检验单Id获取检验信息
        function getFormInfo(scanSN, stationId) {
            $("#divDtl").html("");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPQCInspection.GetInspectionTemplate(scanSN, stationId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                //updateCollectionList(scanSN, 'OK');
                //showAreaMessge(scanSN + ':通过', "messageGreen");
                if (InspectionId != -1) {
                    parent.Refresh();
                }
                return;
            }
            if (ajax.value != null) {
                var en = $.parseJSON(ajax.value);
                //产品名称、产品规格
                $("#ItemName").html(en.data2[0].ItemName);
                $("#ItemSpec").html(en.data2[0].ItemSpec);

                if (en.data.length <= 0 || en.data1.length <= 0) {
                    alert("请维护检验内容");
                    return false;
                }
                //加载检验模版项
                moCount = 0;
                LoadInspectionItem(en.data, en.data1);
            }
            stationRefreshBySN(scanSN);
            showAreaMessge(scanSN + ":扫描成功", "messageGreen");
            setMessageBox(scanSN + ':扫描成功', 'messageGreen');

        }
        //加载检验模版项
        function LoadInspectionItem(data, data1) {
            $("#divDtl").append("");
            listItem = [], moCount = 0;
            for (var i = 0; i < data.length; i++) {
                //模版头添加
                var head = data[i];
                if (head == undefined) {
                    return;
                }
                html = "<table id='tblExpand' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                              + "<tr class='ListTableHeader' id='" + head.InspectionTemplateId + "' style='text-align: center;'><th colspan='6' >" + head.InspectionTemplateName + "</th></tr>"
                              + "</table>";
                $("#divDtl").append(html);

                html = "<table id='tbDtl" + head.InspectionTemplateId + "' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                        + "<tr class='ListTableHeader' ><th >序号</th><th>检验项目</th><th>录入方式</th><th>判定标准</th><th>单位</th><th>检验方法</th><th>检验结果</th><th>不良代码</th><th>输入值</th>"
                for (var j = 0; j < data1.length; j++) {
                    if (data1[j].InspectionTemplateId == data[i].InspectionTemplateId) {
                        DetailItem(data1, j);
                    }
                }
                html += "</table>";
                $("#divDtl").append(html);
            }

            $("input[type='button']").show();
        }
        //模版检验项详细资料取得绑定
        function DetailItem(data1, j) {
            var Dtllist = data1;
            var InsItemNamestr = "", InspectionMethodValue = "", CheckFashion = "", DelRow = "";
            //for (var j = 0; j < Dtllist.length; j++) {
            Dtllist[j].CountRow = moCount;
            //复制
            var en = {}, eItem = JSON.stringify(Dtllist[j]);
            $.extend(en, Dtllist[j]);
            en.CheckResult = Dtllist[j].CheckResult === "" ? null : Dtllist[j].CheckResult;
            listItem.push(en);

            //检验项目
            InsItemNamestr = Dtllist[j].IsCustom === 1 ? ("<input type='text' IsRequired='1' style='width:80%' value='" +
                    Dtllist[j].InspectionItemName + "' onchange='ChangeInsItemName(" + moCount + ", $(this))'/><em>*</em>")
                : Dtllist[j].InspectionItemName;
            //判断标准
            InspectionMethodValue = Dtllist[j].IsCustom === 1 ? ("<input type='text' style='width:80%' IsRequired='1' value='" +
                    Dtllist[j].InspectJuge + "' onchange='ChangeJuge(" + moCount + ", $(this))'/><em>*</em>") : Dtllist[j].InspectionMethodValue;
            //检验方法
            CheckFashion = Dtllist[j].IsCustom === 1 ? ("<input type='text' style='width:80%' IsRequired='1' value='" +
                    Dtllist[j].InspectionAccording + "' onchange='ChangeInsAccording(" + moCount + ", $(this))'/><em>*</em>") : Dtllist[j].CheckFashion;

            DelRow = name === 'Material_IQCFormView' ? "" :
                ("<td style='text-align:center; width:5%'>" +
                    (Dtllist[j].IsCustom === 1 ? "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(" + moCount + ", $(this))\">删除</span>" : "") + "</td>");

            html += "<tr name='TempLateTr' class='ListTableOddRow' id='" + Dtllist[j].InspectionItemId + "' ><td style='text-align:center; width:4%'>" + (j + 1).toString() + "</td>"
                                    + "<td style='text-align:left; width:13%'>" + InsItemNamestr + "</td>"
                                    + "<td style='text-align:left; width:7%'>" + (Dtllist[j].InspectionMethodId == 1 ? "固定值结果" : "指定值") + "</td>"
                                    + "<td style='text-align:left; width:12%'>" + InspectionMethodValue + "</td>"
                                    + "<td style='text-align:left; width:5%'>" + Dtllist[j].UnitName + "</td>"
                                    + "<td style='text-align:left; width:8%'>" + CheckFashion + "</td>"

            if (Dtllist[j].InspectionMethodId == 2) {
                //指定值
                html += "<td style='text-align:left; width:8%'><label><input id='cbOK" + moCount + "' type='radio' name='OkNgRa" + moCount + "'  disabled='disabled'  />OK</label>&nbsp;&nbsp;"
                + "<label><input id='cbNG" + moCount + "' type='radio' name='OkNgRa" + moCount + "'  disabled='disabled'   />NG</label></td>"
                + "<td style='text-align:left; width:8%' class=\"nc-code\"></td>" //不良代码列
               + "<td style='text-align:center; width:5%' class=\"insppection-input\"><input type='text' id='inputResult" + moCount + "' class='inputResult' style=' height: 23px' /></td>"
            } else {
                //固定结果
                html += "<td style='text-align:left; width:8%' class=\"insppection-input\"><label><input id='cbOK" + moCount + "' type='radio' name='OkNgRa" + moCount + "' />OK</label>&nbsp;&nbsp;"
                    + "<label><input id='cbNG" + moCount + "' class=\"fixed-ng\" type='radio' name='OkNgRa" + moCount + "'  />NG</label></td>"
                    + "<td style='text-align:left; width:8%' class=\"nc-code\"></td>" //不良代码列
                    + "<td style='text-align:center; width:5%'></td>"

            }
            html += "<tr>";
            moCount++;
            //}
        }

        //检验完成
        function save() {
            for (var i = 0; i < $("tr[name='TempLateTr']").length; i++) {
                var $_tr = $($("tr[name='TempLateTr']")[i]);
                var radio1 = $($("tr[name='TempLateTr']")[i]).find("td:eq(6) input:eq(0):checked").val();
                var radio2 = $($("tr[name='TempLateTr']")[i]).find("td:eq(6) input:eq(1):checked").val();
                if (radio1 == null && radio2 == null) {
                    alert("请完成所有检验项的检验");
                    return false;
                }
                //如果检验项为NG，需要检查是否有采集不良代码
                if (radio2 != null) {
                    var ncCode = $.trim($_tr.find(".nc-code").html());
                    if (ncCode == null || ncCode == "") {
                        alert("检验项存在NG项，请采集不良代码");
                        return false;
                    }
                }
            }
            collectionPass();
        }
        /*
        *采集过站
        */
        function collectionPass() {
            var xml = resultToXml();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPassStation.CollectPassStation(-1, scanSN, resourceId, stationId, xml);
            if (ajax.error != null) {
                updateCollectionList(scanSN, 'NG');
                showAreaMessge(scanSN + ':' + ajax.error.Message, "messageRed");
                $("#txtSN").val("").focus();
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return false;
            }
            var result = true;
            if ($("#cbFormNG").attr("checked") != null) {
                result = false;
                updateCollectionList(scanSN, 'NG');
                showAreaMessge(scanSN + ':采集不良成功！', "messageGreen");
                setMessageBox(scanSN + ':采集不良成功！', 'messageGreen');
            } else {
                updateCollectionList(scanSN, 'OK');
                showAreaMessge(scanSN + ':通过', "messageGreen");
                setMessageBox(scanSN + ':通过', 'messageGreen');
                //自动打印 updata huangliang 2017-11-20
                AutoPrint(stationId, scanSN);
            }
            refreshProInfoBySN(scanSN);
            //记录检验结果
            setTimeout(function () { SaveList(result); }, 500);
        }

        /*
        *拼接不良信为XML字符串
        */
        function resultToXml() {
            var xml = "<PanelSN>";
            var list = $("#divDtl tr").find("td:eq(6) input[type='radio']:last:checked");
            var arrCode = [];
            for (var i = 0; i < list.length; i++) {
                //var id = $(list[i]).parent().parent().parent().attr('id');
                //xml += "<NCCode SN=\"" + scanSN + "\" CODE=\"" + id + "\" ></NCCode>";

                var code = $.trim($(list[i]).parent().parent().siblings(".nc-code").html());
                var arr = code.split(",");
                for (var j = 0; j < arr.length; j++) {
                    if ($.inArray(arr[j], arrCode) == -1) {
                        xml += "<NCCode SN=\"" + scanSN + "\" CODE=\"" + arr[j] + "\" ></NCCode>";
                        arrCode.push(arr[j]);
                    }
                }
            }
            xml += "</PanelSN>";
            console.log(xml);
            return xml;
        }

        function SaveList(result) {
            var DtlList = [];
            for (var i = 0; i < $("#divDtl tr[name='TempLateTr']").length; i++) {
                var _obj = $($("#divDtl tr[name='TempLateTr']")[i]);
                var M = {};
                M.InspectionTemplateId = parseInt($($(_obj).parents()[1]).prev().find('tr').attr('id'));
                M.InspectionTemplateName = $($(_obj).parents()[1]).prev().find('th').text();
                M.InspectionItemId = parseInt(_obj.attr('id'));
                M.InspectionItemName = _obj.find('td:eq(1)').text();
                M.InspectionMethodValue = _obj.find('td:eq(3)').text();
                M.UnitName = _obj.find('td:eq(4)').text();
                M.CheckFashion = _obj.find('td:eq(5)').text();
                M.Result = _obj.find("input[type='radio']:last:checked").length > 0 ? 1 : 0;
                M.Value = typeof (_obj.find('.inputResult').val()) == 'undefined' ? "" : _obj.find('.inputResult').val();
                DtlList.push(M);
            }
            var jr = {};
            jr.SN = scanSN;
            jr.Result = result;
            jr.DtlList = JSON.stringify(DtlList);

            console.log(JSON.stringify(jr));

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPQCInspection.Save(JSON.stringify(jr));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //updateCollectionList(scanSN, 'OK');
                //showAreaMessge(scanSN + ':通过', "messageGreen");
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return;
            }
            document.forms[0].submit();
        }
    </script>
</asp:Content>
