<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="IPQCInspectionNew.aspx.cs" Inherits="SKT.LeanMES.Web.Client.IPQCInspectionNew" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        .Field4 {
            width: 17%;
            height: 26px;
            text-align: left;
            background-color: #fff;
            padding: 3px;
            border-top: 1px solid #d3d3d3;
            border-left: 1px solid #d3d3d3;
            border-right: 1px solid #d3d3d3;
            border-bottom: 1px solid #d3d3d3;
            white-space: nowrap;
            word-break: break-all;
        }

        em {
            color: #F75000;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 11px;
            font-weight: bold;
            padding-left: 5px;
            padding-right: 5px;
            vertical-align: middle;
        }

        .red {
            color: red;
        }

        .tdred {
            background-color: lightpink;
        }
    </style>
    <div class="client-center">
        <!--采集信息入口-->

        <table id="tabTmplContent" class="EditeContentTable" style="width: 100%; margin-bottom: 10px;">
            <tr>
                <td class="Label2" align="right">产品<em>*</em>
                </td>
                <td class="Field4">
                    <input type="text" id="txtItem" name="txtItem" class="ui-textbox" readonly="readonly" />
                    <input id="btnItem" class="ButtonBox" type="button" onclick="openChoosePage(1)"
                        value="..." title="选择产品" />
                    <input type="hidden" id="hdnItemId" value="-1" />
                </td>
                <td class="Label2" align="right">模板<em>*</em>
                </td>
                <td class="Field4">
                    <input type="text" id="txtTemplate" name="txtTemplate" class="ui-textbox" readonly="readonly" />
                    <input id="button6" class="ButtonBox" type="button" onclick="openChoosePage(841)"
                        value="..." title="选择模板" />
                    <input type="hidden" id="hdnInspectionTemplateId" value="-1" />
                </td>
            </tr>
            <tr>
                <td class="Label2" align="right">产线<em>*</em>
                </td>
                <td class="Field4">
                    <input type="text" id="txtLine" name="txtProductionLine" class="ui-textbox" readonly="readonly" />
                    <input id="button5" class="ButtonBox" type="button" onclick="openChoosePage(21)"
                        value="..." title="选择生产产线" />
                    <asp:HiddenField ID="hdLineId" runat="server" Value="-1" />
                    <asp:HiddenField ID="hdnLineName" runat="server" Value="" />

                </td>
                <td class="Label2" align="right">检验人<em>*</em>
                </td>
                <td class="Field4">
                    <input type="text" id="txtSendMan" name="txtSendMan" class="ui-textbox" />
                </td>
            </tr>
            <tr>

                <td class="Label2" align="right">检验单号<em>*</em>
                </td>
                <td class="Field4" id="tdOrderNo"></td>
                <td class="Label2" align="right">备注
                </td>
                <td class="Field4">
                    <input type="text" id="txtRemark" name="txtRemark" class="ui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="Label2" style="text-align: center;" colspan="4">
                    <label id="labtxt" style="color: red;"></label>
                </td>
            </tr>
            <tr>
            </tr>
            <tr>
                <td class="Field1" colspan="4" style="text-align: center;">
                    <input id="btnUploadFile" onclick="UploadFile();" title=" 文件上传 " style="cursor: pointer;" value=" 文件上传 " type="button" />

                    <input id="btnCollectSN" onclick="collectSN();" title=" 序列号收集 " style="cursor: pointer;" value=" 序列号收集 " type="button" />
                    <input id="Img1" class="SearchButton" onclick="SaveInspectionOrderMember('', this)" alt="" type="button" title="保存" style="cursor: pointer;" value=" 保 存 " />
                    <input id="RevierSave" class="SearchButton" onclick="ClearAll();" alt="" title="清空" style="cursor: pointer;" value="清 空" type="button" />
                </td>
            </tr>
        </table>
        <!--数据分析统计展示及操作区-->
        <table class="ListTable" id="tabTurnOverList">
        </table>
        <!--实时信息输出-->
        <div id="divItemTypeInfo" style="width: 100%">
        </div>
    </div>
    <input type="hidden" id="controlId" />
    <script language="javascript" type="text/javascript">

        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserName%>";
        $(function () {
            $("#txtSendMan").val(userName);
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('IPQCInspection_ProCollectionUINew');
                }, 10);
            $(".insppection-input .inputResult").live("focus", function () { $(this).select(); });
            $(".insppection-input .inputResult").live("change", function (e) {
                count(this);
            });
            $("input[type='radio']").live("click", function () { ChooseRad(this); });

        });

        var tab = document.getElementById("tabTurnOverList");
        var globalFlag = -1;
        var selectRowClass = "selectRow";
        var index = 1;
        var InspectionTypeId = 0;
        var TemplateId = -1;
        var IOrderId = -1;
        var IOrderNo = "";
        var LineId = -1;
        var ResourceId = -1;
        var StationId = -1;
        var OrderId = -1;
        var EquipmentId = -1;
        var operationId = -1;
        var FAISNArr = [];
        var NumberData = [];
        var ItemId = -1;

        function count(obj) {
            operateObj = obj;
            var InspectionMethodValue = $(obj).attr("inspectionmethodvalue");
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
                if (data.indexOf(",") != -1) {
                    var datastr = data.split(',');
                    var allfa = true;
                    var standVal = arr[0].split('[');
                    var maxVal = parseFloat(standVal[O]) + parseFloat(standVal[1]);
                    var minVal = parseFloat(standVal[0]) + parseFloat(arr[1].replace('[', "").replace(']', ""));
                    for (var r = 0; r < datastr.length; r++) {
                        if (parseFloat(datastr[r]) >= parseFloat(minVal) && parseFloat(datastr[r]) <= parseFloat(maxVal)) {
                            Result = true;
                        }
                        else {
                            allfa = false;
                        }
                    }
                    Result = allfa;
                }
                else {
                    var standVal = arr[0].split('[');
                    var maxVal = parseFloat(standVal[0]) + parseFloat(standVal[1]);
                    var minVal = parseFloat(standVal[0]) + parseFloat(arr[1].replace('[', "").replace(']', ""));
                    if (parseFloat(data) >= parseFloat(minVal) && parseFloat(data) <= parseFloat(maxVal)) {
                        Result = true;
                    } else {
                        Result = false;
                    }
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
                $(obj).parent().removeClass("tdred");
                $(obj).attr("OkNgRa", 1);
            } else {
                $(obj).parent().addClass("tdred");
                $(obj).attr("OkNgRa", 0);
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
                debugger
                $(obj).parent().parent().removeClass("tdred")
                //$(obj).closest(".insppection-input").siblings(".nc-code").html("");//删除不良代码
            }
            else if ($(obj).attr("id").indexOf("NA") != -1) {
                $(obj).parent().parent().removeClass("tdred")
                //$(obj).closest(".insppection-input").siblings(".nc-code").html("");//删除不良代码
            }
            else {
                //NG时需要采集不良代码
                //openNCPage();
                $(obj).parent().parent().addClass("tdred")
            }
        }
        function changeClass(el) {
            var className = $($(el).parentNode).attr("class");
            if (className.indexOf(selectRowClass) > -1) {
                $($(el).parentNode).removeClass(selectRowClass);
            } else {
                $(tab).find("tr").removeClass(selectRowClass);
                $($(el).parentNode).addClass(selectRowClass);
            }
        }
        function addDetail(entity, i) {
            BindIsPercentage("IsPercentage" + entity.InspectionItemId);
            BingSaveInspectionItemBtn('_' + entity.InspectionTemplateMemberId);
        }
        //2021-01-06修改

        function SeeDoFileRow(obj, Id) {
            if (IOrderId == -1) {
                alert("请先通过保存生成检验单！")
                return;
            }
            var iod = $("#tdOrderNo").html();
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/IPQCInspectionAddFile.aspx?name=IPQCInspectionAddFile&ID=" + Id + "&IOD=" + iod;
            dialog({ title: "上传文件", src: openWinUrl, width: 750, height: 400 });
        }

        //返回地址
        function ReturnDoFileRow(url, Id) {
            if (url != "") {
                $("#hdSaveUrl_" + Id).val(url);
                $("#spsee_" + Id).html('<a  href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>' + url + '" title="查看" target="_blank">查看</a>');
            }
        }

        function UploadFile() {
            if (IOrderId == -1) {
                alert("请先通过保存生成检验单！")
                return;
            }
            var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionFileUpLoad.aspx?Action=IPQC&Id=" + IOrderId + "&OrderON=" + escape(IOrderNo);
            dialog({ title: "文件上传", src: url, width: 880, height: 650, resizeable: true });

        }

        function Show(type) {
            closeDialog();
        }

        function BindIsPercentage(id) {
            $("#" + id).click(function () {
                id = $(this).attr("id");
                var value = parseInt($("#hd" + id).val());;
                if (value == 1) {
                    value = 0;
                }
                else {
                    value = 1;
                }
                $("#hd" + id).val(value);
            });
        }


        //获取送检单号及其ID
        function GetInspectionOrderNo() {

            $("#tdOrderNo").html("");

            var keyString = OrderId + "_" + LineId + '_' + StationId + "_" + ResourceId + "_" + operationId + "_" + TemplateId + "_" + EquipmentId;
            //Quality_InspectionOrder
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.Search("1JtW7Jzckxq0lt8hWF09eoiq9NTfFes2cwb50dAlqqilbZ7RU5wcqA==", "d1QRWDMEGHLuymXz9dA7+g==",
                "d1QRWDMEGHJT4fQUh8Bzs6hC8bRoq6QR8KeTAOkGyxYGmwG70Z0kIg==",
                "SKGkMOfjRoh8nTzCiwzGRUqrNONNHhcd#{" + keyString + "}#PdmdcVChk40qLtwkGXLfLo0S+TnD4nOXe3FpW9+0y+I=",
                "d1QRWDMEGHLuymXz9dA7+g==");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
            }

            if (ajax.value.length > 0) {
                IOrderId = ajax.value[0].Field1;
                IOrderNo = ajax.value[0].Field2;
                $("#tdOrderNo").html(IOrderNo);
            }
        }


        function BingSaveInspectionItemBtn(id) {


            $("#" + id).click(function () {
                if (checkDate()) {
                    //获取送检单号及其ID
                    GetInspectionOrderNo();
                    if (IOrderId == -1) {
                        var r = confirm("暂无检验单号，是否创建？");
                        if (r == true) {
                            CreateIOrder();
                        } else {
                            return;
                        }
                    }
                    $(this).attr("disabled", "disabled");

                    var id = $(this).attr("id").replace("_", "");

                    var radiovalue = $("input:radio[name='OkNgRa" + id + "']:checked").val();

                    var InspectionResultString = "";
                    if (radiovalue == "OK") {
                        InspectionResultString = "合格";
                    }
                    else if (radiovalue == "NG") {
                        InspectionResultString = "不合格";
                    }
                    else if (radiovalue == "N/A") {
                        InspectionResultString = "";
                        $("#SaveMessagelabel" + id).text("不检测");
                        return;
                    }
                    else {
                        alert($("#InspectionItemName" + id).html() + "---还没检测");
                        InspectionResultString = "";
                        this.removeAttribute("disabled");
                        return;
                    }
                    var entity = {};
                    entity.IOMItemId = -1;
                    entity.IOrderId = IOrderId;
                    entity.IOMemberId = id;
                    entity.InspectionItemName = $("#InspectionItemName" + id).html();
                    entity.SnspectionItemName = "";
                    entity.StandardMaxValue = "0";
                    entity.StandardMinValue = "0";
                    if ($("#TestMethod" + id).html() == "指定值") {
                        //$("#CheckFashion" + id).html() + "-[" + $("#TestMethod" + id).html() + "" + $("#InspectionMethodValue" + id).html();
                        entity.InspectionAccording = "" + $("#InspectionMethodValue" + id).html();
                    }
                    else {
                        //$("#CheckFashion" + id).html() + "-[" + $("#TestMethod" + id).html() + "]-[" + $("#InspectionMethodValue" + id).html() + "]";
                        entity.InspectionAccording = "[" + $("#InspectionMethodValue" + id).html() + "]";
                    }
                    entity.SpecialRequest = "无";
                    entity.InspectionResult = InspectionResultString;
                    entity.InspectionValue = $("#TestMethod" + id).html() == "指定值" ? $("#inputResult" + id).val() : radiovalue;
                    entity.Remark = $("#nccode" + id).html() == "" ? $("#Remark" + id).val() : "[不良代码:" + $("#nccode" + id).html() + "]" + "" + $("#Remark" + id).val();
                    entity.CreateBy = userName;
                    entity.ModifyBy = "";
                    entity.SaveOpenName = $("#spOpenName_" + id).html();
                    if (!entity.SaveOpenName) {
                        entity.SaveOpenName = $(this).attr("openname");
                    }
                    entity.FUrlString = $("#hdSaveUrl_" + id).val();
                    entity.PUrlString = "";
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.SaveInspectionOrderMemberItemJW(entity);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        this.removeAttribute("disabled");
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                        $("#SaveMessagelabel" + id).text("失败");
                        return;
                    }
                    $("#SaveMessagelabel" + id).text("成功");
                    this.removeAttribute("disabled");
                }
            })

        }

        //创建检验单
        function CreateIOrder() {

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.InspectionIPQCGeneral();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return;
            }
            IOrderId = -1;
            IOrderNo = ajax.value;
            $("#tdOrderNo").html(IOrderNo);
            return true;

        }

        /*保存受检单结果*/
        function SaveInspectionOrderMember(result, obj) {


            if (ItemId == "-1") {
                alert("请先选择产品！")
                return;
            }

            if (IOrderNo == "") {
                alert("请先选择检验模板！")
                return;
            }

            if (LineId == "-1") {
                alert("请先选择产线！")
                return;
            }

            if ($.trim($("#txtSendMan").val()) == "") {
                alert("请填写检验人！")
                return;
            }


            var tbody = tab.getElementsByTagName('tbody')[0];
            var rows = $(tbody).find('.ListTableOddRow');
            var entity = [];
            for (var i = 0; i < rows.length; i++) {
                var td = $(rows[i]).find("td:not(:first)");
                var InspectionResult;
                var InspectionTemplateMemberId;
                var InspectionValue;
                for (var j = 0; j < td.length - 1; j++) {
                    var list = {};
                    var input = $(td[j]).find('.inputResult').length;
                    var check = $(td[j]).find('input[type=radio]').length;
                    var thobj = $($($(tbody).find('.ListTableHeader')[0])[0]).find('th')[j + 1]
                    if (input > 0 && $.trim($(td[j]).find('.inputResult').val()) == "") {
                        var InspecName = $(thobj)[0].innerText;
                        alert("检验项目【" + InspecName + "】，序号【" + (i + 1) + "】未填写!");
                        break;
                    } else {
                        InspectionValue = $.trim($(td[j]).find('.inputResult').val());
                        InspectionResult = $(td[j]).find('.inputResult').attr("okngra") == "1" ? "合格" : "不合格";
                    }

                    if (check > 0) {
                        var radio = $(td[j]).find('input[type=radio]');
                        let selectedCount = 0
                        for (var k = 0; k < check; k++) {
                            if (radio[k].checked) {
                                selectedCount++;
                            }
                        }

                        if (selectedCount == 0) {
                            var InspecName = $(thobj)[0].innerText;
                            alert("检验项目【" + InspecName + "】，序号【" + (i + 1) + "】未选择检测结果!");
                            break;
                        } else {
                            debugger
                            InspectionValue = $(td[j]).find('.fixed-ng')[0].checked ? "NG" : $(td[j]).find('.fixed-ok')[0].checked ? "OK" : $(td[j]).find('.fixed-NA')[0].checked ? "NA" : "";
                            InspectionResult = $(td[j]).find('.fixed-ng')[0].checked ? "不合格" : $(td[j]).find('.fixed-ok')[0].checked ? "合格" : $(td[j]).find('.fixed-NA')[0].checked ? "不检测" : "";
                        }
                    }
                    InspectionTemplateMemberId = $(thobj).attr("inspectiontemplatememberid");


                    list.InspectionTemplateMemberId = InspectionTemplateMemberId;
                    list.RowIndex = (i + 1);
                    list.InspectionResult = InspectionResult;
                    list.InspectionValue = InspectionValue;


                    entity.push(list)
                }
            }

            if (entity.length == 0) {
                return false;
            }

            var FAISNStr = "";
            //序列号
            parent.FAISNArr.forEach(function (obj) {
                FAISNStr += obj.IOMemberId + "$" + obj.SN + "$" + obj.Result + "$" + obj.NCCode + "$" + obj.ScanTime + "^";
            });

            FAISNStr = FAISNStr.substring(0, FAISNStr.length - 1);

            var r = confirm("你将保存" + IOrderNo + "！");
            if (r == true) {
                $(obj).attr("disabled", "disabled");
                var list = {};
                list.IOrderId = -1;
                list.ItemId = ItemId;
                list.IOrderNo = IOrderNo;
                list.LineId = LineId;
                list.TemplateId = TemplateId;
                list.StationId = StationId;
                list.InspectionTypeId = InspectionTypeId;
                list.SNStr = FAISNStr;
                list.Remark = $.trim($("#txtRemark").val());
                list.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
                list.QualityInspectionMemberDetail = JSON.stringify(entity);
                list.InspectionSelectType = "IPQC";

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.SaveInspectionIPQC(JSON.stringify(list));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    obj.removeAttribute("disabled");
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                    return;
                }
                IOrderId = ajax.value;
                obj.removeAttribute("disabled");
                alert("保存成功！");
                //ClearAll();
            }
            else {
                return;
            }


            //var savemessage = "";
            //var fa = true;
            //if (NumberData.length > 0) {
            //    for (var i = 0; i < NumberData.length; i++) {
            //        savemessage = $("#SaveMessagelabel" + NumberData[i].InspectionTemplateMemberId).text();
            //        if (savemessage == "未保存" || savemessage == "失败") {
            //            fa = false;
            //        }
            //    }
            //}
            //else {
            //    alert("检验项不能为空！")
            //    return;
            //}

            //if (fa == false) {
            //    alert("请完成所有检验项的检验！")
            //    return;
            //}

            //var hav = false;
            //if (NumberData.length > 0) {
            //    for (var i = 0; i < NumberData.length; i++) {
            //        savemessage = $("#SaveMessagelabel" + NumberData[i].InspectionTemplateMemberId).text();
            //        if (savemessage == "成功") {
            //            hav = true;
            //        }
            //    }
            //}
            //else {
            //    alert("检验项不能为空！")
            //    return;
            //}
            //if (hav == false) {
            //    alert("检验项必须有一项检验！")
            //    return;
            //}

            //var FAISNStr = "";
            ////序列号
            //parent.FAISNArr.forEach(function (obj) {
            //    FAISNStr += obj.IOMemberId + "$" + obj.SN + "$" + obj.Result + "$" + obj.NCCode + "$" + obj.ScanTime + "^";
            //});

            //FAISNStr = FAISNStr.substring(0, FAISNStr.length - 1);

            //var r = confirm("你将保存" + IOrderNo + "！");
            //if (r == true) {
            //    $(obj).attr("disabled", "disabled");
            //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.SaveInspectionOrderResult(IOrderId, result, FAISNStr);
            //    if (ajax.error != null) {
            //        alert(ajax.error.Message);
            //        obj.removeAttribute("disabled");
            //        //写入日志
            //        SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
            //        return;
            //    }
            //    obj.removeAttribute("disabled");
            //    alert("保存成功！");
            //    ClearAll();
            //}
            //else {
            //    return;
            //}
        }

        //保存所有
        function SaveAll(obj) {
            if (checkDate()) {
                //获取送检单号及其ID
                GetInspectionOrderNo();
                if (IOrderId == -1) {
                    var r = confirm("暂无检验单号，是否创建？");
                    if (r == true) {
                        CreateIOrder();
                    } else {
                        return;
                    }
                }
                $(obj).attr("disabled", "disabled");
                $(".SaveInspectionItem").click();
                obj.removeAttribute("disabled");
            }
        }

        function checkDate() {

            var txtLine = $("#txtLine").val();
            var hdLineId = $("#hdLineId").val();
            if (txtLine == "" || hdLineId <= 0) {
                $("#labtxt").text("请选择产线");
                return false;
            }

            var txtTemplate = $("#txtTemplate").val();
            var hdnInspectionTemplateId = $("#hdnInspectionTemplateId").val();
            if (txtTemplate == "" || hdnInspectionTemplateId <= 0) {
                $("#labtxt").text("请选择模板");
                return false;
            }

            var txtClass = $("#txtClass").val();
            var hdclassId = $("#hdclassId").val();
            if (txtClass == "" || hdclassId <= 0) {
                $("#labtxt").text("请选择班别");
                return false;
            }
            var txtSendMan = $("#txtSendMan").val();
            if (txtSendMan == "") {
                $("#labtxt").text("请输入送检人");
                return false;
            }

            var txtsampleQty = $("#txtsampleQty").val();
            if (txtsampleQty == "") {
                $("#labtxt").text("请输入样本数量");
                return false;
            }

            if (!checkNumber(txtsampleQty)) {
                $("#labtxt").text("请输入正确数字");
                return false;
            }
            if (txtsampleQty < 0) {
                $("#labtxt").text("输入样本数量不能小于0");
                return false;
            }
            var txtOrderQty = $("#txtOrderQty").text();

            if (txtOrderQty != "") {

                if (parseInt(txtOrderQty) < parseInt(txtsampleQty)) {

                    $("#labtxt").text("输入的样本数量不能大于工单数");
                    return false;
                }
            }
            $("#labtxt").text("");
            return true;

        }

        //验证字符串是否是数字
        function checkNumber(theObj) {
            var reg = /^[0-9]+.?[0-9]*$/;
            if (reg.test(theObj)) {
                return true;
            }
            return false;
        }
        /*清除所有*/
        function ClearAll() {
            TemplateId = -1;
            IOrderId = -1;
            IOrderNo = "";
            LineId = -1;
            ResourceId = -1;
            StationId = -1;
            OrderId = -1;
            ItemId = -1;
            FAISNArr = [];
            FAISNStr = "";
            $("#txtLine").val("");
            $("#hdLineId").val("-1");
            $("#tdOrderNo").html("");
            $("#txtRemark").val("");
            $("#txtSendMan").val("");
            $("#txtTemplate").val("");
            $("#btnCollectSN").show();
            $("#tabTurnOverList")[0].innerHTML = "";
            $("#txtSendMan").val(userName);
        }



        var GetValue = function (data, Id) {
            closeDialog();
            data = data.replace('&gt;', ">");
            data = data.replace('&lt;', "<");
            $("#tblExpand tr").eq(Id).find("td:eq(3) input[type='text']").val(data);

        }
        var Set = function (result) {
            var Id = $(result).parent().parent().find("td:eq(0)").html();
            var openWinUrl = "../Quality/InspectionTemplateEditValue.aspx?name=InspectionTemplateEditValue&Id=" + Id;
            dialog({ title: "", src: openWinUrl, width: 500, height: 300 });

        }

        function openChoosePage(flags) {
            if (flags == "841" && $("#hdnItemId").val() == "-1") {
                alert("请先选择产品!");
                return false;
            }
            var condition = "";
            globalFlag = flags;
            switch (flags) {
                case 116:
                    condition = " Status =1 ";
                    break;
                case 841:
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.InspectionItemExists(parseInt($("#hdnItemId").val()),2);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                    }
                    if (ajax.value) {
                        condition = " SystemType=2 and ItemId = " + $("#hdnItemId").val();
                    } else {
                        condition = " SystemType=2 and ItemId = -1";
                    }
                    break;
                default:
                    //condition = "1=1";
                    break;
            }
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags +
                    "&Multiple=false&PageCondition=" +
                    escape(condition) + "&callBackFunc=getChooseValue1" +
                    "&rnd=" +
                    Math.random(),
                width: 700,
                height: 300
            });

        }

        function getChooseValue1(list) {
            switch (globalFlag) {
                case 21:  //选择产线
                    $("#txtLine").val(list[0][1]);
                    $("#<%=this.hdLineId.ClientID %>").val(list[0][0]);
                    $("#<%=this.hdnLineName.ClientID %>").val(list[0][1]);

                    LineId = list[0][0];
                    break;
                case 841:  //选择模板
                    $("#hdnInspectionTemplateId").val(list[0][0]);
                    $("#txtTemplate").val(list[0][1]);
                    TemplateId = list[0][0];
                    InspectionTypeId = list[0][3];
                    CreateIOrder();
                    BindTab(list[0][0]);
                    break;
                case 1:  //选择产品
                    $("#hdnItemId").val(list[0][0]);
                    $("#txtItem").val(list[0][1]);
                    ItemId = list[0][0];
                    break;

                default:
                    break;
            }
        }

        var TemplateMemberByTemp;
        function BindTab(templateId) {

            if (templateId == "" || parseInt(templateId) == -1) {
                return null;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.GetInspectionTemplateMemberByTempId2(templateId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return null;
            }
            $("#tabTurnOverList")[0].innerHTML = "";
            var listArr = ajax.value;
            NumberData = listArr;
            /*首位歌添加一个元素*/
            listArr.unshift(1);
            listArr.push(2);

            TemplateMemberByTemp = listArr;

            var currentName = "";
            var showCell = true;
            if (null != listArr) {
                var html = "";
                //初始固定三行
                for (var j = 0; j < 3; j++) {
                    var index = 1;
                    var htmltr = j < 2 ? "<tr class='ListTableHeader' style='height: 30px;'>" : "<tr class='ListTableOddRow'>";
                    for (var i = 0; i < listArr.length; i++) {
                        var entity = listArr[i];
                        //生成检验项目表头
                        if (j === 0) {
                            if (i == listArr.length - 1) {
                                htmltr += "<th scope='col' onclick='addDetail();' style='color: #0066CC;cursor:pointer; width:80px; vertical-align:middle;'><%= Buttons.COM_Add %></th>"
                            } else {
                                if (i == 0) {
                                    htmltr += "<th scope='col' align='center'>检验项</th>";
                                } else {
                                    htmltr += "<th scope='col' align='center' InspectionTemplateMemberId='" + entity.InspectionTemplateMemberId + "'>" + entity.InspectionItemName + "</th>";
                                }
                            }
                        }
                        else if (j == 1) {
                            //检验方法
                            debugger
                            if (i == 0) {
                                htmltr += "<th scope='col' align='center'>检验方法</th>";
                            } else {
                                if (i == listArr.length - 1) {
                                    htmltr += "<th scope='col' align='center'></th>";
                                } else {
                                    htmltr += "<th scope='col' align='center'>" + entity.CheckFashion + "</th>";
                                }
                            }

                        }
                        else {
                            if (i == listArr.length - 1) {
                                htmltr += "<td align='center' class='Field pointer'></td>";
                            } else {
                                if (i == 0) {
                                    htmltr += "<td align='center' class='Field pointer'>1</td>"
                                } else {
                                    htmltr += "<td align='center'  class='insppection-input'>"
                                        + (entity.InspectionMethodId == 2 ? "<input type='text' InspectionMethodValue='" + entity.InspectionMethodValue + "' id='inputResult" + entity.InspectionTemplateMemberId + "_" + i + "' class='inputResult' style=' height: 23px' OkNgRa='-1' />" : "<label><input id='cbOK" + entity.InspectionTemplateMemberId + "' type='radio' class=\"fixed-ok\" name='OkNgRa"
                                            + entity.InspectionTemplateMemberId + "' value='OK' />OK</label>&nbsp;&nbsp;"
                                            + "<label><input id='cbNG" + entity.InspectionTemplateMemberId + "_" + i + "' class=\"fixed-ng\" type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId
                                            + "'  value='NG' />NG</label>&nbsp;&nbsp;<label><input id='cbNA" + entity.InspectionTemplateMemberId + "_" + i + "' class=\"fixed-NA\" type='radio' name='OkNgRa"
                                            + entity.InspectionTemplateMemberId + "'  value='N/A' />N/A</label>")
                                        + "</td>";
                                }
                            }
                        }
                    }

                    htmltr += "</tr>";
                    html += htmltr;
                }

                $("#tabTurnOverList").eq(0).append(html);
            }
        }

        function GetIndex() {
            var list = $(tab).find("tr");
            for (var i = 0; i < list.length; i++) {
                if ($(list[i]).attr("class").indexOf(selectRowClass) > -1) {
                    return i;
                }
            }
            return tab.rows.length;
        }

        function addDetail() {
            var row, cell;
            rowNewIdx = GetIndex();
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = rowNewIdx - 1;
            var listArr = TemplateMemberByTemp;
            TemplateMemberByTemp.shift(2);

            for (var i = 0; i < listArr.length; i++) {
                var entity = listArr[i];
                if (i == listArr.length - 1) {
                    cell = row.insertCell(i + 1);
                    cell.align = "center";
                    cell.className = "Field pointer";
                    cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Buttons.COM_Delete %></span></td>";
                } else {
                    cell = row.insertCell(i + 1);
                    cell.align = "center";
                    cell.className = "Field pointer insppection-input";
                    cell.innerHTML = (entity.InspectionMethodId == 2 ? "<input type='text' InspectionMethodValue='" + entity.InspectionMethodValue + "' id='inputResult" + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "' class='inputResult' style=' height: 23px' OkNgRa='-1' />" : "<label><input id='cbOK" + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "' type='radio' class=\"fixed-ok\" name='OkNgRa"
                        + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "' value='OK' />OK</label>&nbsp;&nbsp;"
                        + "<label><input id='cbNG" + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "' class=\"fixed-ng\" type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId
                        + "_" + rowNewIdx + "'  value='NG' />NG</label>&nbsp;&nbsp;<label><input id='cbNA" + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "' class=\"fixed-NA\" type='radio' name='OkNgRa"
                        + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "'  value='N/A' />N/A</label>")

                }
            }
            TemplateMemberByTemp.unshift(2);
        }


        function deleteItem(obj) {
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);

            var tbody = tab.getElementsByTagName('tbody')[0];
            var rows = $(tbody).find('.ListTableOddRow');
            for (var i = 0; i < rows.length; i++) {
                rows[i].cells[0].textContent = i + 1;
            }
        }

        function getInspectionSN() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetFAISNInfo(IOrderId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return;
            }
            if (ajax.value != null) {
                FAISNArr = ajax.value;
            }
        }

        function collectSN() {
            if (!SubmitValidation()) {
                return false;
            }

            dialog({
                title: "序列号采集",
                src: "<%= WebHelper.WebRoot %>/Client/FAIInspectionSN.aspx?IOrderId=" + $("#hdOrderId").val() + "&rnd=" + Math.random(),
                width: 700,
                height: 450
            });
        }


    </script>
</asp:Content>


