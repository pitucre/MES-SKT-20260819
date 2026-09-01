<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true" CodeBehind="FAIInspection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.FAIInspection" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        em {
            color: #F75000;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 11px;
            font-weight: bold;
            padding-left: 5px;
            padding-right: 5px;
            vertical-align: middle;
        }

        .ListTable {
            width: 99.9%;
        }

        .ui-textbox {
            height: 26px;
            line-height: 26px;
        }
    </style>
    <div class="client-center">
        <!--采集信息入口-->

        <table id="tabTmplContent" class="EditeContentTable" style="width: 100%; margin-bottom: 5px;">
            <tr>
                <td class="Label2" align="right">工单<em>*</em>
                </td>
                <td class="Field2">
                    <input type="text" id="txtOrder" class="ui-textbox" isrequired="1" /><input id="button4" class="ButtonBox" type="button" onclick="openChoosePage(44)"
                        value="..." title="选择生产订单号" />
                    <input id="hdOrderId" type="hidden" value="-1000" />
                    <input id="hdItemCode" type="hidden" />
                </td>
                <td class="Label2" align="right">工单数量
                </td>
                <td class="Field2">
                    <label id="txtOrderQty" name="BarCode" class="ui-textbox"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2" align="right">产线<em>*</em>
                </td>
                <td class="Field2">
                    <input type="text" id="txtLine" name="txtProductionLine" class="ui-textbox" readonly="readonly" isrequired="1" /><input id="button5" class="ButtonBox" type="button" onclick="openChoosePage(21)"
                        value="..." title="选择生产产线" />
                    <asp:HiddenField ID="hdLineId" runat="server" Value="-1" ClientIDMode="Static" />
                    <asp:HiddenField ID="hdnLineName" runat="server" Value="" ClientIDMode="Static" />

                </td>
                <td class="Label2" align="right">产品名称
                </td>
                <td class="Field2">
                    <label id="txtItemName" name="txtItemName" class="ui-textbox"></label>
                </td>

            </tr>
            <tr>
                <td class="Label2" align="right">检验单号<em>*</em>
                </td>
                <td class="Field2">
                    <select id="sltFAICode" isrequired="1">
                        <option value="">--请选择--</option>
                    </select>
                </td>
                <td class="Label2" align="right">班别<em>*</em>
                </td>
                <td class="Field2">
                    <input type="text" id="txtClass" name="txtClass" class="ui-textbox" readonly="readonly" isrequired="1" /><input id="button7" class="ButtonBox" type="button" onclick="openChoosePage(49)"
                        value="..." title="选择班别" />
                    <asp:HiddenField ID="hdclassId" runat="server" Value="-1" ClientIDMode="Static" />

                </td>

            </tr>

            <tr>
                <td class="Label2" align="right">模板<em>*</em>
                </td>
                <td class="Field2">
                    <input type="text" id="txtTemplate" name="txtTemplate" class="ui-textbox" readonly="readonly" isrequired="1" /><input id="button6" class="ButtonBox" type="button" onclick="openChoosePage(75)"
                        value="..." title="选择模板" />
                    <asp:HiddenField ID="hdnInspectionTemplateId" runat="server" Value="-1" ClientIDMode="Static" />

                </td>
                <td class="Label2" align="right">版本号
                </td>
                <td class="Field2" id="tdVersion"></td>
            </tr>
            <tr>
                <td class="Label2" align="right">送检人<em>*</em>
                </td>
                <td class="Field2">
                    <input type="text" id="txtSendMan" name="txtSendMan" class="ui-textbox" isrequired="1" />
                </td>
                <td class="Label2" align="right">样本数量<em>*</em>
                </td>
                <td class="Field2">
                    <input type="text" id="txtsampleQty" name="txtsampleQty" class="ui-textbox numbercheck" isrequired="1" />
                </td>
            </tr>
            <tr>
                <td class="Field1" colspan="4" style="text-align: center;">
                    <input id="btnCollectSN" onclick="collectSN();"
                        title=" 序列号收集 " style="cursor: pointer;" value=" 序列号收集 " type="button" />
                    <input id="RevierSave" onclick="ClearAll();"
                        title="清空" style="cursor: pointer; margin-left: 15px; margin-right: 40px;" value=" 清 空 " type="button" />

                    <input id="btnSaveFAICode" onclick="saveInspectionOrder(this)" type="button"
                        title="保存" style="cursor: pointer;" value=" 保存检验项 " />
                </td>
            </tr>
        </table>
        <!--数据分析统计展示及操作区-->
        <table class="ListTable" id="tabTurnOverList">
            <tr class="ListTableHeader" style="height: 30px;">
                <th scope="col" style="width: 5%">序号
                </th>
                <th scope="col" style="width: 9%">检验项目</th>

                <th scope="col" style="width: 10%">录入方式</th>
                <th scope="col" style="width: 8%">判定标准</th>
                <th scope="col" style="width: 6%">单位</th>
                <th scope="col" style="width: 12%">检验方法</th>
                <th scope="col" style="width: 10%">检验结果</th>
                <th scope="col" style="width: 8%">不良代码</th>
                <th scope="col" style="width: 8%">输入值</th>
                <th scope="col" style="width: 10%">备注</th>

                <%-- <th scope="col" style="width: 15%">检验项名称
                </th>
                <th scope="col" style="width: 35%">检验方法
                </th>
                <th scope="col" style="width: 15%">检验依据
                </th>
                <th scope="col" style="width: 10%">检验结果
                </th>               
                <th scope="col" style="width: 20%">备注--%>
            </tr>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="11" style="text-align: center;">暂无数据
                </td>
            </tr>
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
                        loadClientButton('FAIInspection');
                    }, 10);

            $(".inputResult").live("focus", function () { $(this).select(); });
            $(".inputResult").live("change", function () { count(this); });
            $(".inputResult").live("blur", function () { count(this); });
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
        var OrderId = -1;
        var EquipmentId = -1;
        var FAISNArr = [];
        $(document).ready(function () {
            $(".numbercheck").keyup(function () {
                getIntVal(this);
            });
        });

        $("#sltFAICode").change(function () {
            if ($(this).find("option:selected").attr("IOrderId") == "-1") {
                TemplateId = -1;
                IOrderId = -1;
                FAISNArr = [];

                $("#hdnInspectionTemplateId").val(-1);
                $("#txtTemplate").val("");
                $("#txtClass").val("");
                $("#txtSendMan").val(userName);
                $("#tdVersion").text("");
                $("#txtsampleQty").val("");
                $("#btnCollectSN,#btnSaveFAICode").show();
                $(tab).find(".ListTableOddRow").empty().remove();
                return;
            }
            if ($(this).find("option:selected").attr("Status") != "-1") {
                $("#btnCollectSN,#btnSaveFAICode").hide();
            }

            getFAIInspectionInfo(this.value);
            BindTab();
            getInspectionSN();

            getInspectionData($(this).find("option:selected").attr("iorderid"));
        });

        function getInspectionData(IOrderId) {
            if (IOrderId && IOrderId == -1) {
                return true;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetInspectionItem(parseInt(IOrderId));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return;
            }
            var data = ajax.value;

            if (data) {
                var dataList = JSON.parse(data);
                $.each(dataList.data, function (i, v) {
                    if (v.Remark.indexOf("不良代码") != -1) {
                        var remark = v.Remark.split(":")[1].split("]");
                        $("#nccode" + v.IOMemberId).text(remark[0]);
                        $("#Remark" + v.IOMemberId).val(remark[1]);
                    }
                    else {
                        $("#Remark" + v.IOMemberId).val(v.Remark);
                    }
                    if (v.InspectionResult == "合格") {
                        $("#cbOK" + v.IOMemberId).attr("checked", true);
                    } else {
                        $("#cbNG" + v.IOMemberId).attr("checked", true);
                    }
                    if (v.InspectionAccording.indexOf("OK/NG") == -1) {
                        $("#inputResult" + v.IOMemberId).val(v.InspectionValue);
                    }
                });

            }
        }

        /*保存受检单结果*/
        function saveInspectionOrder(obj) {
            if (!SubmitValidation()) {
                return false;
            }
            IOrderNo = $("#sltFAICode").val();

            var MemberItemStr = "";
            var id = "";
            var IOMItemId = "";
            var IOMemberId = "";
            var InspectionItemName = "";
            var InspectionAccording = "";
            var InspectionResult = "";
            var Remark = "";
            var radiovalue
            var InspectionResultString = "";
            var NCCode = "";


            //检验项
            $("#tabTurnOverList tr:gt(0)").each(function () {

                id = $(this).find("input[name=IOMemberId]").val();
                radiovalue = $("input:radio[name='OkNgRa" + id + "']:checked").val();

                if (radiovalue == "OK") {
                    InspectionResultString = "合格";
                }
                else if (radiovalue == "NG") {
                    InspectionResultString = "不合格";
                }
                else if (radiovalue == "N/A") {
                    InspectionResultString = "";
                }
                else {
                    InspectionResultString = "否";
                }

                if (InspectionResultString != "否") {
                    IOMItemId = $(this).find("input[name=IOMItemId]").val();
                    IOMemberId = id;
                    InspectionItemName = $("#InspectionItemName" + id).html();
                    if ($("#TestMethod" + id).html() == "指定值") {
                        InspectionAccording = "" + $("#InspectionMethodValue" + id).html();
                    }
                    else {
                        InspectionAccording = "[" + $("#InspectionMethodValue" + id).html() + "]";
                    }
                    InspectionResult = InspectionResultString;
                    InspectionValue = $("#TestMethod" + id).html() == "指定值" ? $("#inputResult" + id).val() : radiovalue;
                    //备注列
                    //Remark = $("#nccode" + id).html() == "" ? $("#Remark" + id).val() : "[不良代码:" + $("#nccode" + id).html() + "]" + "" + $("#Remark" + id).val();
                    NCCode = $("#nccode" + id).html() == "" ? $("#Remark" + id).val() : "[不良代码:" + $("#nccode" + id).html() + "]";
                    Remark =$("#Remark" + id).val();
                    MemberItemStr += IOMItemId + '$' + IOMemberId + '$' + InspectionItemName + '$' + InspectionAccording + '$' + InspectionResult + '$' + Remark + '$' + InspectionValue + ' $' + NCCode + ' ^';
                }


                //InspectionResult = $(this).find("select[name=InspectionResult]").val();
                //if (InspectionResult != ""){
                //    IOMItemId = $(this).find("input[name=IOMItemId]").val();
                //    IOMemberId = $(this).find("input[name=IOMemberId]").val();
                //    InspectionItemName = $(this).find("span[name=InspectionItemName]").text();
                //    InspectionAccording = $(this).find("span[name=InspectionAccording]").text();

                //    Remark = $(this).find("input[name=Remark]").val();
                //    MemberItemStr += IOMItemId + '$' + IOMemberId + '$' + InspectionItemName + '$' + InspectionAccording + '$' + InspectionResult + '$' + Remark+'^';
                //}
            });

            if (MemberItemStr == "") {
                alert("未找到检测结果信息，请选择检验结果！");
                return false;
            }
            MemberItemStr = MemberItemStr.substring(0, MemberItemStr.length - 1);

            var FAISNStr = "";
            //序列号
            parent.FAISNArr.forEach(function (obj) {
                FAISNStr += obj.IOMemberId + "$" + obj.SN + "$" + obj.Result + "$" + obj.NCCode + "$" + obj.ScanTime + "^";
            });

            FAISNStr = FAISNStr.substring(0, FAISNStr.length - 1);

            if (!confirm("你将保存" + IOrderNo + "！")) {
                return false;
            }
            var version = $("#tdVersion").text();

            var entity = {};
            entity.TemplateId = TemplateId;
            entity.TemplateVersion = version;
            entity.InspectionTypeId = InspectionTypeId;
            entity.ProdOrderId = OrderId;
            entity.LineId = LineId;
            entity.StationId = stationId;
            entity.ResourceId = resourceId;
            entity.FAICode = IOrderNo;
            entity.SampleQty = $("#txtsampleQty").val();
            entity.SendMan = $("#txtSendMan").val();
            entity.ClassType = $("#txtClass").val();
            entity.UserName = userName;
            entity.IOrderId = IOrderId;
            entity.MemberItemStr = MemberItemStr;
            entity.FAISNStr = FAISNStr;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.CollectFAIInspecitonInfo(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                obj.removeAttribute("disabled");
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return;
            }

            IOrderId = ajax.value;
            $("#sltFAICode").find("option:selected").attr("IOrderId", IOrderId);

            alert("保存成功！");

            BindTab();
            //ClearAll();

        }

        function count(obj) {
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
                $(obj).parent().parent().find("td:eq(6) input[type='radio']:first").prop("checked", "checked");
                $(obj).closest(".insppection-input").siblings(".nc-code").html("");//删除不良代码
            } else {
                $(obj).closest(".insppection-input").parent().find("td:eq(6) input:radio[class='fixed-ng']").prop("checked", "checked");
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
                $(obj).closest(".insppection-input").siblings(".nc-code").html("");//删除不良代码
            }
            else if ($(obj).attr("id").indexOf("NA") != -1) {
                $(obj).closest(".insppection-input").siblings(".nc-code").html("");//删除不良代码
            }
            else {
                //NG时需要采集不良代码
                openNCPage();
            }
        }


        function collectSN() {
            if (!SubmitValidation()) {
                return false;
            }

            dialog({
                title: "序列号采集",
                src: "<%= WebHelper.WebRoot %>/Client/FAIInspectionSN.aspx?IOrderId=" + IOrderId + "&rnd=" + Math.random(),
                width: 700,
                height: 450
            });
        }

        /**
        *生成首件单号
        **/
        function generateFAICode() {
            if (OrderId == -1) {
                return;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.GenerateFAICode(OrderId, stationId, resourceId, LineId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return;
            }

            var list = ajax.value;

            bindFAICode(list);
        }

        function bindFAICode(list) {
            var html = "";
            var obj = $("#sltFAICode");

            for (var i = 0; i < list.length; i++) {
                html += "<option IOrderId='" + list[i].IOrderId + "' Status='" + list[i].Status + "' value='" + list[i].FAICode + "'>" + list[i].FAICode + "</option>";
            }

            obj.html(html);
        }

        function getFAIInspectionInfo(faiCode) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetFAIInspectionInfo(faiCode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return;
            }
            var entity = ajax.value;

            if (entity != null && entity.IOrderId > 0) {
                IOrderId = entity.IOrderId;
                TemplateId = entity.TemplateId;
                InspectionTypeId = entity.InspectionTypeId;
                $("#hdnInspectionTemplateId").val(TemplateId);
                $("#txtTemplate").val(entity.InspectionTemplateName);
                $("#txtClass").val(entity.ClassType);

                $("#txtSendMan").val(entity.SendMan);
                $("#tdVersion").text(entity.TemplateVersion);
                $("#txtsampleQty").val(entity.SampleQty);
            }
        }

        function getTemplateVersion() {
            if (TemplateId == "" || parseInt(TemplateId) == -1) {
                return null;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetTemplateVersion(TemplateId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return null;
            }
            $("#tdVersion").text(ajax.value);
        }

        function BindTab() {
            if (TemplateId == "" || parseInt(TemplateId) == -1) {
                return null;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.GetFAITemplateInfo(IOrderId, TemplateId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return null;
            }
            $(tab).find(".ListTableOddRow").empty().remove();
            var listArr = ajax.value;
            if (null != listArr) {
                index = 1;
                for (var i = 0; i < listArr.length; i++) {
                    addDetail(listArr[i], index);
                    index++;
                }
            }
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
        function BingSaveInspectionItemBtn(id) {


            $("#" + id).click(function () {
                if (SubmitValidation()) {

                    if (IOrderId == -1) {
                        alert("暂无检验单号!");
                        return;
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
        function addDetail(entity, i) {
            var row, cell;
            row = tab.insertRow(tab.rows.length);
            row.className = "ListTableOddRow";

            $("#trNewInfo").remove();


            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = i + "<input type='hidden' name='IOMItemId' value='" + entity.IOMItemId + "'</input><input type='hidden' name='IOMemberId' value='" + entity.InspectionTemplateMemberId + "'</input>";

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.id = "InspectionItemName" + entity.InspectionTemplateMemberId;
            cell.innerHTML = entity.InspectionItemName



            $(cell).click(function () {
                var className = $(this.parentNode).attr("class");
                if (className.indexOf(selectRowClass) > -1) {
                    $(this.parentNode).removeClass(selectRowClass);
                } else {
                    $(tab).find("tr").removeClass(selectRowClass);
                    $(this.parentNode).addClass(selectRowClass);
                }
            });


            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.id = "TestMethod" + entity.InspectionTemplateMemberId;
            cell.innerHTML = entity.InspectionMethodId == 1 ? "固定值结果" : "指定值";

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.id = "InspectionMethodValue" + entity.InspectionTemplateMemberId;
            cell.innerHTML = entity.InspectionMethodValue;

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.id = "UnitName" + entity.InspectionTemplateMemberId;
            cell.innerHTML = entity.UnitName;

            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.id = "CheckFashion" + entity.InspectionTemplateMemberId;
            cell.innerHTML = "[" + entity.InspectionAccording + "]-[" + entity.CheckFashion + "]";


            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "insppection-input";
            cell.innerHTML = entity.InspectionMethodId == 2 ? "<label><input id='cbOK" + entity.InspectionTemplateMemberId + "' type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId + "' value='OK'  disabled='disabled'  />OK</label>&nbsp;&nbsp;"
                + "<label><input id='cbNG" + entity.InspectionTemplateMemberId + "' class=\"fixed-ng\" type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId + "'  disabled='disabled'   value='NG' />NG</label>&nbsp;&nbsp;<label><input id='cbNA" + entity.InspectionTemplateMemberId + "' class=\"fixed-NA\"  type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId + "'    value='N/A' />N/A</label>" :
                "<label><input id='cbOK" + entity.InspectionTemplateMemberId + "' type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId + "' value='OK' />OK</label>&nbsp;&nbsp;"
                    + "<label><input id='cbNG" + entity.InspectionTemplateMemberId + "' class=\"fixed-ng\" type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId + "'  value='NG' />NG</label>&nbsp;&nbsp;<label><input id='cbNA" + entity.InspectionTemplateMemberId + "' class=\"fixed-NA\" type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId + "'  value='N/A' />N/A</label>";


            cell = row.insertCell(7);
            cell.align = "center";
            cell.className = "nc-code";
            cell.id = "nccode" + entity.InspectionTemplateMemberId;
            cell.innerHTML = "";


            cell = row.insertCell(8);
            cell.align = "center";
            cell.className = "insppection-input";
            cell.innerHTML = entity.InspectionMethodId == 2 ? "<input type='text' id='inputResult" + entity.InspectionTemplateMemberId + "' class='inputResult' style=' height: 23px' />" : "";


            cell = row.insertCell(9);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = '<input id = "Remark' + entity.InspectionTemplateMemberId + '" type="text"/> ';

            //cell = row.insertCell(10);
            //cell.align = "center";
            //cell.className = "Field";
            //cell.innerHTML = '<a  href="#" id="btnDoFile_' + entity.InspectionTemplateMemberId + '"  onclick="SeeDoFileRow(this,' + entity.InspectionTemplateMemberId + ')"   title="上传">上传</a>&nbsp;<span id="spsee_' + entity.InspectionTemplateMemberId + '"></span><input type="hidden" id="hdSaveUrl_' + entity.InspectionTemplateMemberId + '"  value=""  />';


            //cell = row.insertCell(11);
            //cell.align = "center";
            //cell.className = "Field";
            //cell.innerHTML = '<input type="button" class="SaveInspectionItem" id="_' + entity.InspectionTemplateMemberId + '" value="保存" />';

            //cell = row.insertCell(12);
            //cell.align = "center";
            //cell.className = "Field pointer";
            //cell.id = "SaveMessage" + entity.InspectionTemplateMemberId;
            //cell.innerHTML = "<label id=\"SaveMessagelabel" + entity.InspectionTemplateMemberId + "\"  class=\"ui-textboxlabel\" >未保存</label>";

            BindIsPercentage("IsPercentage" + entity.InspectionItemId);
            BingSaveInspectionItemBtn('_' + entity.InspectionTemplateMemberId);
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
        function getChooseValue1(list) {
            switch (globalFlag) {
                case 21:  //选择产线
                    $("#txtLine").val(list[0][1]);
                    $("#<%=this.hdLineId.ClientID %>").val(list[0][0]);
                    $("#<%=this.hdnLineName.ClientID %>").val(list[0][1]);

                    LineId = list[0][0];

                    //生成首件单号
                    generateFAICode();
                    break;
                case 44:   //选择工单

                    $("#txtOrder").val(list[0][1]);
                    $("#hdOrderId").val(list[0][0]);
                    OrderId = list[0][0];
                    $("#txtOrderQty").text(list[0][3]);
                    $("#txtItemName").text(list[0][5]);
                    $("#hdItemCode").val(list[0][2]);

                    //获取产品绑定的模板
                    $("#hdnInspectionTemplateId").val(-1);
                    $("#txtTemplate").val("");
                    TemplateId = -1;
                    InspectionTypeId = -1;
                    $(tab).find(".ListTableOddRow").remove();
                    $("#tdVersion").text("");

                    var entity = {};
                    entity.OrderNo = list[0][1];
                    entity.ItemID = -1;
                    entity.SystemType = 6;//模板类型 1：IQC;2:IPQC;3:PQC;4:FQC;5:OQC;6:FAI
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetOrderItemTemplate", JSON.stringify(entity));
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    if (ajax.value.length > 0) {
                        var templateInfo = JSON.parse(ajax.value)
                        if (templateInfo.length > 0) {
                            $("#hdnInspectionTemplateId").val(templateInfo[0].InspectionTemplateId);
                            $("#txtTemplate").val(templateInfo[0].InspectionTemplateName);
                            TemplateId = templateInfo[0].InspectionTemplateId;
                            InspectionTypeId = templateInfo[0].InspectionTypeId;
                            getTemplateVersion(TemplateId);
                            BindTab();
                        };
                    }

                    break;
                case 49:   //选择班别
                    $("#txtClass").val(list[0][1]);
                    $("#<%=this.hdclassId.ClientID %>").val(list[0][0]);

                    break;
                case 75:  //选择模板
                    $("#hdnInspectionTemplateId").val(list[0][0]);
                    $("#txtTemplate").val(list[0][1]);
                    TemplateId = list[0][0];
                    InspectionTypeId = list[0][3];
                    getTemplateVersion(TemplateId);
                    BindTab();
                    break;

                default:
                    break;
            }
        }

        function openChoosePage(flags) {
            var condition = "";
            globalFlag = flags;
            switch (flags) {
                case 116:
                    condition = " Status =1 ";
                    break;
                case 75:

                    condition = " SystemType=6 ";
                    break;
                default:
                   // condition = "1=1";
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

        /*清除所有*/
        function ClearAll() {
            TemplateId = -1;
            IOrderId = -1;
            IOrderNo = "";
            LineId = -1;
            ResourceId = -1;
            StationId = -1;
            OrderId = -1;
            FAISNStr = "";
            FAISNArr = [];

            $("#tdVersion").text("");
            $("#txtResource").val("");
            $("#hdResourceId").val("-1");
            $("#txtOrder").val("");
            $("#hdOrderId").val("-1");
            $("#txtInspectionTemplate").val("");
            $("#hdnInspectionTemplateId").val("-1");
            $("#txtStation").val("");
            $("#hdStationId").val("-1");
            $("#txtLine").val("");
            $("#hdLineId").val("-1");
            $("#tdOrderNo").html("");
            $("#txtItemCode").val("");
            $("#txtsampleQty").val("");
            $("#txtSendMan").val(userName);
            $("#txtClass").val("");
            $("#txtOrderQty").text("");
            $("#txtItemName").text("");
            $("#hdItemCode").val("");
            $("#txtTemplate").val("");
            $("#btnCollectSN,#btnSaveFAICode").show();
            $("#sltFAICode").html("<option value=''>--请选择--</option>");
            $(tab).find(".ListTableOddRow").empty().remove();
        }

    </script>
</asp:Content>

