<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="IPQCInspectionProject.aspx.cs" Inherits="SKT.LeanMES.Web.Client.IPQCInspectionProject" %>

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
        /* layui 时间选择器 不要秒的选项 */
        .layui-laydate-content > .layui-laydate-list {
            padding-bottom: 0px;
            overflow: hidden;
        }

            .layui-laydate-content > .layui-laydate-list > li {
                width: 50%
            }

        .merge-box .scrollbox .merge-list {
            padding-bottom: 5px;
        }
    </style>
    <div class="client-center">
        <!--采集信息入口-->

        <table id="tabTmplContent" class="EditeContentTable" style="width: 100%; margin-bottom: 10px;">
            <tr>
                <td class="Label3" align="right">产品<em>*</em>
                </td>
                <td class="Field4">
                    <input type="text" id="txtItem" name="txtItem" class="ui-textbox" readonly="readonly" />
                    <input id="btnItem" class="ButtonBox" type="button" onclick="openChoosePage(1)"
                        value="..." title="选择产品" />
                    <input type="hidden" id="hdnItemId" value="-1" />
                </td>
                <td class="Label3" align="right">类型<em>*</em>
                </td>
                <td class="Field4">
                    <select id="sltItem" isrequired="1">
                        <option value="">--请选择--</option>
                        <option value="首件检验">首件检验</option>
                        <option value="末件检验">末件检验</option>
                        <option value="工程检验">工程检验</option>
                    </select>
                </td>
                <td class="Label3" align="right">模板<em>*</em>
                </td>
                <td class="Field4">
                    <input type="text" id="txtTemplate" name="txtTemplate" class="ui-textbox" readonly="readonly" />
                    <input id="button6" class="ButtonBox" type="button" onclick="openChoosePage(841)"
                        value="..." title="选择模板" />
                    <input type="hidden" id="hdnInspectionTemplateId" value="-1" />
                </td>
                <td class="Label3" align="right">检验单号<em>*</em>
                </td>
                <td class="Field4" id="tdOrderNo"></td>
            </tr>
            <tr>
                <td class="Label3" align="right">产线<em>*</em>
                </td>
                <td class="Field4">
                    <input type="text" id="txtLine" name="txtProductionLine" class="ui-textbox" readonly="readonly" />
                    <input id="button5" class="ButtonBox" type="button" onclick="openChoosePage(21)"
                        value="..." title="选择生产产线" />
                    <asp:HiddenField ID="hdLineId" runat="server" Value="-1" />
                    <asp:HiddenField ID="hdnLineName" runat="server" Value="" />
                </td>
                <td class="Label3" align="right">检验人<em>*</em>
                </td>
                <td class="Field4">
                    <input type="text" id="txtSendMan" name="txtSendMan" class="ui-textbox" />
                </td>
                <td class="Label3" align="right">送检日期</td>
                <td class="Field4">
                    <input type="text" id="txtSJDate" readonly="readonly" class="ui-textbox" />
                </td>
                <td class="Label3" align="right">检验日期</td>
                <td class="Field4">
                    <input type="text" id="txtJYDate" readonly="readonly" class="ui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="Label3" align="right">模具名称
                </td>
                <td class="Field4">
                    <input type="text" id="txtMoudle" name="txtMoudle" class="ui-textbox" readonly="readonly" />
                    <input id="btnMoudle" class="ButtonBox" type="button" onclick="openChoosePage(54)"
                        value="..." title="选择模具" />
                    <asp:HiddenField ID="hdnMoudleId" runat="server" Value="-1" />
                </td>
                <td class="Label3" align="right">烘料温度设定
                </td>
                <td class="Field4">
                    <input type="text" id="txtDryingMaterialTemperature" name="txtDryingMaterialTemperature" class="ui-textbox" />
                </td>
                <td class="Label3" align="right">热流道温度设定
                </td>
                <td class="Field4" colspan="3">
                    <input type="text" id="txtHotRunnerTemperature" name="txtHotRunnerTemperature" class="ui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="Label3" align="right">料管温度
                </td>
                <td class="Field4" colspan="7">
                    <input type="text" id="txtBarrelTemperature1" name="txtHotRunnerTemperature" class="ui-textbox" />&nbsp;&nbsp;&nbsp;
                    <input type="text" id="txtBarrelTemperature2" name="txtHotRunnerTemperature" class="ui-textbox" />&nbsp;&nbsp;&nbsp;
                    <input type="text" id="txtBarrelTemperature3" name="txtHotRunnerTemperature" class="ui-textbox" />&nbsp;&nbsp;&nbsp;
                    <input type="text" id="txtBarrelTemperature4" name="txtHotRunnerTemperature" class="ui-textbox" />&nbsp;&nbsp;&nbsp;
                    <input type="text" id="txtBarrelTemperature5" name="txtHotRunnerTemperature" class="ui-textbox" />&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td class="Label3" align="right">模具温度(依实测)-动模
                </td>
                <td class="Field4">
                    <input type="text" id="txtMoldTemperatureDynamic" class="ui-textbox" />
                </td>
                <td class="Label3" align="right">模具温度(依实测)-静模
                </td>
                <td class="Field4">
                    <input type="text" id="txtMoldTemperatureStatic" class="ui-textbox" />
                </td>
                <td class="Label3" align="right">原料编号
                </td>
                <td class="Field4">
                    <input type="text" id="txtMaterialItemCode" name="txtItem" class="ui-textbox" readonly="readonly" />
                    <input id="btnMaterialItem" class="ButtonBox" type="button" onclick="openChoosePage(999)"
                        value="..." title="选择产品" />
                    <input type="hidden" id="hdnMaterialItemItemId" value="-1" />
                </td>
                <td class="Label3" align="right">原料名称
                </td>
                <td class="Field4">
                    <label id="lblMaterialItemName"></label>
                </td>
            </tr>
            <tr>
                <td class="Label3" align="right">原料规格
                </td>
                <td class="Field4">
                    <label id="lblMaterialItemSpc"></label>
                </td>
                <td class="Label3" align="right">原料批次
                </td>
                <td class="Field4">
                    <input type="text" id="txtMaterialItemLot" class="ui-textbox" />
                </td>
                <td class="Label3" align="right">备注
                </td>
                <td class="Field4">
                    <input type="text" id="txtRemark" name="txtRemark" class="ui-textbox" />
                </td>
                <td class="Label3" align="right">检验结果</td>
                <td class="Field4">
                    <label style="color: Green; font-weight: bold;">
                        <input id='cbFormOK' type="checkbox" disabled="disabled" onchange='FinalResult(this)' />合格</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                         <label style="color: Red; font-weight: bold;">
                             <input id='cbFormNG' type="checkbox" disabled="disabled" onchange='FinalResult(this)' />不合格</label>
                </td>
            </tr>
            <tr>
                <td class="Label3" align="right">文件
                </td>
                <td class="Field4" colspan="7">
                    <a id="fileshow" href="#" style="color: #0f33df">查看</a>
                </td>
            </tr>
            <tr>
                <td class="Label2" style="text-align: center;" colspan="8">
                    <label id="labtxt" style="color: red;"></label>
                </td>
            </tr>
            <tr>
            </tr>
            <tr>
                <td class="Field1" colspan="8" style="text-align: center;">
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
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        var filename = "";
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserName%>";
        var editProjectId = '<%=Request.QueryString["editProjectId"]%>';
        var ResourceId = $("#hdnCurrResourceId").val();
        var StationId = $("#hdnCurrStationId").val();
        var from = '<%=Request.QueryString["coming"]%>';
        $(function () {
            $("#fileshow").hide();
            $("#txtSendMan").val(userName);
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('IPQCInspection_ProCollectionUIProject');
                }, 10);
            $(".insppection-input .inputResult").live("focus", function () { $(this).select(); });
            $(".insppection-input .inputResult").live("change", function (e) {
                count(this);
            });
            $("input[type='radio']").live("click", function () { ChooseRad(this); });

            if (from != "") {
                $('#sltItem').val(from);
                $('#sltItem').prop('disabled', true);
                BindOtherText();

                $(".ListTable").hide();
            }

            var now = new Date();
            // 减去10分钟（将当前分钟数减去10）
            var lanow = now.setMinutes(now.getMinutes() - 10);

            $("#txtSJDate").val(formatDate(new Date(lanow)));
            $("#txtJYDate").val(formatDate(new Date()));

            layui.use('laydate', function () {
                var laydate = layui.laydate;
                laydate.render({
                    elem: $("#txtSJDate")[0],
                    theme: '#0c66ff',
                    trigger: 'click',
                    range: '~',
                    istime: false,
                    type: 'datetime',
                    range: false,
                    format: 'yyyy-MM-dd HH:mm'
                });
            });

            layui.use('laydate', function () {
                var laydate = layui.laydate;
                laydate.render({
                    elem: $("#txtJYDate")[0],
                    theme: '#0c66ff',
                    trigger: 'click',
                    range: '~',
                    istime: false,
                    type: 'datetime',
                    range: false,
                    format: 'yyyy-MM-dd HH:mm'
                });
            });

            //编辑模式
            if (editProjectId != "") {
                $('.ButtonBox').prop('disabled', true);

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetIPQCInspectionProjectInfo(editProjectId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                //主表
                var entityMainAry = ajax.value.Tables[0].Rows[0];

                if (entityMainAry) {
                    IOrderId = entityMainAry.IOrderId;
                    IOrderNo = entityMainAry.InspectionOrderNo;
                    LineId = entityMainAry.LineId;
                    TemplateId = entityMainAry.TemplateId;
                    ResourceId = entityMainAry.ResourceId;
                    StationId = entityMainAry.OpeId;
                    ItemId = entityMainAry.ItemID;

                    $("#txtItem").val(entityMainAry.ItemName);
                    $('#sltItem').prop('disabled', true);
                    $('#sltItem').val(entityMainAry.InspectionSelectType);
                    $("#txtTemplate").val(entityMainAry.InspectionTemplateName);
                    $("#tdOrderNo").text(entityMainAry.InspectionOrderNo);
                    $("#txtLine").val(entityMainAry.LineName);
                    $("#txtSendMan").val(entityMainAry.CreateBy);
                    $("#txtSJDate").val(formatDate(entityMainAry.SYDate));
                    $("#txtJYDate").val(formatDate(entityMainAry.JYDate));
                    $("#txtMoudle").val(entityMainAry.MoudleCode);
                    $("#txtDryingMaterialTemperature").val(entityMainAry.DryingMaterialTemperature);
                    $("#txtHotRunnerTemperature").val(entityMainAry.HotRunnerTemperature);
                    $("#txtBarrelTemperature1").val(entityMainAry.BarrelTemperature1);
                    $("#txtBarrelTemperature2").val(entityMainAry.BarrelTemperature2);
                    $("#txtBarrelTemperature3").val(entityMainAry.BarrelTemperature3);
                    $("#txtBarrelTemperature4").val(entityMainAry.BarrelTemperature4);
                    $("#txtBarrelTemperature5").val(entityMainAry.BarrelTemperature5);
                    $("#txtMoldTemperatureDynamic").val(entityMainAry.MoldTemperatureDynamic);
                    $("#txtMoldTemperatureStatic").val(entityMainAry.MoldTemperatureStatic);
                    $("#txtMaterialItemCode").val(entityMainAry.MaterialItemCode);
                    $("#hdnMaterialItemItemId").val(entityMainAry.MaterialItemId);
                    $("#lblMaterialItemName").text(entityMainAry.MaterialItemName);
                    $("#lblMaterialItemSpc").text(entityMainAry.MaterialItemSpec);
                    $("#txtMaterialItemLot").val(entityMainAry.MaterialItemLot);
                    $("#txtRemark").val(entityMainAry.Remark);
                    entityMainAry.Result == "1" ? $("#cbFormOK").attr("checked", true) : $("#cbFormNG").attr("checked", true);
                    if (entityMainAry.FileSaveName != "") {
                        filename = entityMainAry.FileSaveName;
                        $('#fileshow').text(entityMainAry.FileSaveName);
                        $("#fileshow").show();
                    }
                }


                //明细表
                var entityAry = ajax.value.Tables[1].Rows;

                $("#tabTurnOverList")[0].innerHTML = "";
                var rowdetail = Object.groupBy(entityAry, (x) => x.RowIndex);

                //var Row = Object.groupBy(entityAry, (x) => x.RowIndex);
                for (const key in rowdetail) {
                    addDetailNew(rowdetail[key], key);
                }
            }

        });



        function BindOtherText() {
            debugger
            var gd = getCookie('gd'); // 从cookie中读取工单

            if (gd == "") {
                alert("获取注塑工单失败，请前往【注塑】页面重新选择！")
                return false;
            }
            var LineName = '<%=Request.QueryString["prodline"]%>';
            var entity = {};
            entity.LineName = LineName;
            entity.OrderNo = gd;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetProdOrderByMachinedInjectionMoldingByIPQC", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return;
            } 

            var data = JSON.parse(ajax.value)[0];

            //产品
            $("#hdnItemId").val(data["ItemID"]);
            $("#txtItem").val(data["ItemName"]);
            ItemId = data["ItemID"];

            //产线
            $("#txtLine").val(LineName);
            $("#<%=this.hdLineId.ClientID %>").val(data["LineId"]);
            $("#<%=this.hdnLineName.ClientID %>").val(LineName);
            LineId = data["LineId"];

            //模具
            $("#hdnMoudleId").val(data["EquipmentId"]);
            $("#txtMoudle").val(data["EquipmentName"]);

            //原料编码
            $("#hdnMaterialItemItemId").val(data["YLItemId"]);
            $("#txtMaterialItemCode").val(data["YLItemCode"]);
            $("#lblMaterialItemName").text(data["YLItemName"]);
            $("#lblMaterialItemSpc").text(data["YLItemSpec"]);

        }


        function addDetailNew(listArr, key) {
            /*首尾各添加一个元素*/
            listArr.unshift(1);
            listArr.push(2);

            TemplateMemberByTemp = listArr;
            var html = "";
            if (null != listArr && listArr.length > 0 && key == "1") {
                //初始固定三行(检验项、检验方法以及第一行)
                for (var j = 0; j < 3; j++) {
                    var index = 1;
                    var htmltr = j < 2 ? "<tr class='ListTableHeader' style='height: 30px;'>" : "<tr class='ListTableOddRow'>";
                    for (var i = 0; i < listArr.length; i++) {
                        var entity = listArr[i];
                        //生成检验项目表头
                        if (j === 0) {
                            if (i == listArr.length - 1) {
                                htmltr += "<th scope='col' style='vertical-align:middle;'></th><th scope='col' onclick='addDetail(\"New\");' style='color: #0066CC;cursor:pointer; width:80px; vertical-align:middle;'><%= Buttons.COM_Add %></th>"
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
                            if (i == 0) {
                                htmltr += "<th scope='col' align='center'>检验方法</th>";
                            } else {
                                if (i == listArr.length - 1) {
                                    htmltr += "<th scope='col' align='center'>检验日期</th><th scope='col' align='center'></th>";
                                } else {
                                    htmltr += "<th scope='col' align='center'>" + entity.CheckFashion + "</th>";
                                }
                            }

                        }
                        else {
                            if (i == listArr.length - 1) {
                                htmltr += "<td align='center' class='Field pointer'><input type='text' id='txtSJDate" + listArr[i - 1].InspectionTemplateMemberId + "_" + i + "' readonly='readonly' class='ui-textbox layuidate' value='" + formatDateSecond(listArr[i - 1].InspectionDateTime) + "' /></td><td align='center' class='Field pointer'></td>";
                            } else {
                                if (i == 0) {
                                    htmltr += "<td align='center' class='Field pointer'>1</td>"
                                } else {
                                    htmltr += "<td align='center'  class='insppection-input " + (entity.InspectionResult == "不合格" ? "tdred" : "") + "'>"
                                        + (entity.InspectionMethodId == 2 ? "<input type='text' InspectionMethodValue='" + entity.InspectionMethodValue + "' id='inputResult" + entity.InspectionTemplateMemberId + "_" + i + "' class='inputResult' style=' height: 23px' " + (entity.InspectionResult == "不合格" ? "OkNgRa='0'" : "OkNgRa='1'") + " value='" + entity.InspectionValue + "' />" : "<label><input id='cbOK" + entity.InspectionTemplateMemberId + "' type='radio' class=\"fixed-ok\" name='OkNgRa"
                                            + entity.InspectionTemplateMemberId + "' value='OK' " + (entity.InspectionValue == "OK" ? "checked='checked'" : "") + " />OK</label>&nbsp;&nbsp;"
                                            + "<label><input id='cbNG" + entity.InspectionTemplateMemberId + "_" + i + "' class=\"fixed-ng\" type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId
                                            + "'  value='NG' " + (entity.InspectionValue == "NG" ? "checked='checked'" : "") + " />NG</label>&nbsp;&nbsp;<label><input id='cbNA" + entity.InspectionTemplateMemberId + "_" + i + "' class=\"fixed-NA\" type='radio' name='OkNgRa"
                                            + entity.InspectionTemplateMemberId + "'  value='N/A' " + (entity.InspectionValue == "NA" ? "checked='checked'" : "") + "/>N/A</label>")
                                        + "</td>";
                                }
                            }
                        }
                    }

                    htmltr += "</tr>";
                    html += htmltr;
                }
            }

            //除检验项、检验方法以及第一行
            if (null != listArr && listArr.length > 0 && key != "1") {
                addDetail("Edit");
            }

            $("#tabTurnOverList").eq(0).append(html);

            BindLayDate();
        }

        function BindLayDate() {
            layui.use('laydate', function () {
                var laydate = layui.laydate;
                lay('.layuidate').each(function () {
                    laydate.render({
                        elem: this,
                        theme: '#0c66ff',
                        trigger: 'click',
                        range: '~',
                        istime: false,
                        type: 'datetime',
                        range: false,
                        format: 'yyyy-MM-dd HH:mm:ss'
                    });
                });
            });
        }

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

            FinalResult();
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
                $(obj).parent().parent().removeClass("tdred");
                //$(obj).closest(".insppection-input").siblings(".nc-code").html("");//删除不良代码
            }
            else if ($(obj).attr("id").indexOf("NA") != -1) {
                $(obj).parent().parent().removeClass("tdred");
                //$(obj).closest(".insppection-input").siblings(".nc-code").html("");//删除不良代码
            }
            else {
                //NG时需要采集不良代码
                //openNCPage();
                $(obj).parent().parent().addClass("tdred")
                $("#cbFormOK").attr("checked", false);
                $("#cbFormNG").attr("checked", true);
            }

            FinalResult();
        }

        function FinalResult() {
            var flag = true;
            $('[okngra]').each(function () {
                var okngraValue = $(this).attr('okngra');
                if (okngraValue == 0) {
                    $("#cbFormOK").attr("checked", false)
                    $("#cbFormNG").attr("checked", true);
                    flag = false;
                    return false;
                } else {
                    $("#cbFormOK").attr("checked", true)
                    $("#cbFormNG").attr("checked", false);
                }
            });

            if (!flag) {
                return false;
            }
            var nglen = $('.fixed-ng').filter(':checked').length;
            if (nglen > 0) {
                $("#cbFormOK").attr("checked", false)
                $("#cbFormNG").attr("checked", true);
            } else {
                $("#cbFormOK").attr("checked", true)
                $("#cbFormNG").attr("checked", false);
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
                var value = parseInt($("#hd" + id).val());
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

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.InspectionProjectGeneral();
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

            if ($("#sltItem").val() == "") {
                alert("请选择类型!")
                return;
            }
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
                var InspectionDateTime;

                for (var j = 0; j < td.length - 2; j++) {
                    var list = {};
                    var input = $(td[j]).find('.inputResult').length;
                    var check = $(td[j]).find('input[type=radio]').length;
                    var thobj = $($($(tbody).find('.ListTableHeader')[0])[0]).find('th')[j + 1]

                    if (from != "") {
                        InspectionResult = -1;
                        InspectionValue = "";
                    } else {
                        if (input > 0 && $.trim($(td[j]).find('.inputResult').val()) == "") {
                            var InspecName = $(thobj)[0].innerText;
                            alert("检验项目【" + InspecName + "】，序号【" + (i + 1) + "】未填写!");
                            entity = [];
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
                                entity = [];
                                break;
                            } else {
                                InspectionValue = $(td[j]).find('.fixed-ng')[0].checked ? "NG" : $(td[j]).find('.fixed-ok')[0].checked ? "OK" : $(td[j]).find('.fixed-NA')[0].checked ? "NA" : "";
                                InspectionResult = $(td[j]).find('.fixed-ng')[0].checked ? "不合格" : $(td[j]).find('.fixed-ok')[0].checked ? "合格" : $(td[j]).find('.fixed-NA')[0].checked ? "不检测" : "";
                            }
                        }
                    }
                    InspectionTemplateMemberId = $(thobj).attr("inspectiontemplatememberid");

                    InspectionDateTime = $.trim($(td).find('.layuidate').val());

                    list.InspectionTemplateMemberId = InspectionTemplateMemberId;
                    list.RowIndex = (i + 1);
                    list.InspectionResult = InspectionResult;
                    list.InspectionValue = InspectionValue;
                    list.InspectionDateTime = InspectionDateTime;

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
                list.ResourceId = ResourceId;
                list.InspectionTypeId = InspectionTypeId;
                list.SNStr = FAISNStr;
                list.Remark = $.trim($("#txtRemark").val());
                list.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
                list.QualityInspectionMemberDetail = JSON.stringify(entity);
                list.InspectionSelectType = $("#sltItem").val();
                list.SYDate = $("#txtSJDate").val();
                list.JYDate = $("#txtJYDate").val();
                list.Result = $('#cbFormOK').is(':checked') ? 1 : 0;

                list.MoudleCode = $.trim($("#txtMoudle").val());
                list.DryingMaterialTemperature = $.trim($("#txtDryingMaterialTemperature").val());
                list.HotRunnerTemperature = $.trim($("#txtHotRunnerTemperature").val());
                list.BarrelTemperature1 = $.trim($("#txtBarrelTemperature1").val());
                list.BarrelTemperature2 = $.trim($("#txtBarrelTemperature2").val());
                list.BarrelTemperature3 = $.trim($("#txtBarrelTemperature3").val());
                list.BarrelTemperature4 = $.trim($("#txtBarrelTemperature4").val());
                list.BarrelTemperature5 = $.trim($("#txtBarrelTemperature5").val());
                list.MoldTemperatureDynamic = $.trim($("#txtMoldTemperatureDynamic").val());
                list.MoldTemperatureStatic = $.trim($("#txtMoldTemperatureStatic").val());
                list.MaterialItemId = $("#hdnMaterialItemItemId").val();
                list.MaterialItemLot = $.trim($("#txtMaterialItemLot").val());


                if (editProjectId != "") {
                    list.IOrderId = editProjectId;
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.SaveInspectionProjectFALEdit(JSON.stringify(list));
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        obj.removeAttribute("disabled");
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                        return;
                    }
                } else {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.SaveInspectionProjectFAL(JSON.stringify(list));
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        obj.removeAttribute("disabled");
                        //写入日志
                        SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                        return;
                    }
                }
                IOrderId = ajax.value;
                obj.removeAttribute("disabled");
                alert("保存成功！");
                //ClearAll();
            }
            else {
                return;
            }
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
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.InspectionItemExists(parseInt($("#hdnItemId").val()), 6);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                    }
                    if (ajax.value) {
                        condition = " SystemType=6 and ItemId = " + $("#hdnItemId").val();
                    } else {
                        condition = " SystemType=6 and ItemId = -1";
                    }
                    break;
                case 54:
                    condition = " EquipmentTypeId=-4";
                    break;
                case 999:
                    flags = 1;
                    break;
                case 76:
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
                    filename = list[0][4];
                    if (filename != "") {
                        $('#fileshow').text(filename);
                        $("#fileshow").show();
                    }
                    break;
                case 1:  //选择产品
                    $("#hdnItemId").val(list[0][0]);
                    $("#txtItem").val(list[0][1]);
                    ItemId = list[0][0];
                    break;
                case 54:  //选择模具
                    $("#hdnMoudleId").val(list[0][0]);
                    $("#txtMoudle").val(list[0][1]);
                    break;
                case 999: //原料
                    $("#hdnMaterialItemItemId").val(list[0][0]);
                    $("#txtMaterialItemCode").val(list[0][2]);
                    $("#lblMaterialItemName").text(list[0][1]);
                    $("#lblMaterialItemSpc").text(list[0][6]);
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
                                htmltr += "<th scope='col' style='vertical-align:middle;'></th><th scope='col' onclick='addDetail(\"New\");' style='color: #0066CC;cursor:pointer; width:80px; vertical-align:middle;'><%= Buttons.COM_Add %></th>"
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
                            if (i == 0) {
                                htmltr += "<th scope='col' align='center'>检验方法</th>";
                            } else {
                                if (i == listArr.length - 1) {
                                    htmltr += "<th scope='col' align='center'>检验日期</th><th scope='col' align='center'></th>";
                                } else {
                                    htmltr += "<th scope='col' align='center'>" + entity.CheckFashion + "</th>";
                                }
                            }

                        }
                        else {
                            if (i == listArr.length - 1) {
                                htmltr += "<td align='center' class='Field pointer'><input type='text' id='txtSJDate" + entity.InspectionTemplateMemberId + "_" + i + "' readonly='readonly' class='ui-textbox layuidate'  value='" + formatDateSecond(new Date()) + "' /><td align='center' class='Field pointer'></td>";
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
                BindLayDate();
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

        function addDetail(type) {
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

            if (type == "Edit") {
                for (var i = 0; i < listArr.length; i++) {
                    var entity = listArr[i];
                    if (i == listArr.length - 1) {
                        cell = row.insertCell(i + 1);
                        cell.align = "center";
                        cell.className = "Field pointer";
                        cell.innerHTML = "<input type='text' id='txtSJDate" + entity.InspectionTemplateMemberId + "_" + rowNewIdx + " readonly='readonly' class='ui-textbox layuidate' value='" + formatDateSecond(listArr[i - 1].InspectionDateTime) + "' />";

                        cell = row.insertCell(i + 2);
                        cell.align = "center";
                        cell.className = "Field pointer";
                        cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Buttons.COM_Delete %></span></td>";
                    } else {
                        cell = row.insertCell(i + 1);
                        cell.align = "center";
                        cell.className = "Field pointer insppection-input " + (entity.InspectionResult == "不合格" ? "tdred" : "") + "";
                        cell.innerHTML = (entity.InspectionMethodId == 2 ? "<input type='text' InspectionMethodValue='" + entity.InspectionMethodValue + "' id='inputResult" + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "' class='inputResult' style=' height: 23px' " + (entity.InspectionResult == "不合格" ? "OkNgRa='0'" : "OkNgRa='1'") + "  value='" + entity.InspectionValue + "'/>" : "<label><input id='cbOK" + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "' type='radio' class=\"fixed-ok\" name='OkNgRa"
                            + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "' value='OK' " + (entity.InspectionValue == "OK" ? "checked='checked'" : "") + "/>OK</label>&nbsp;&nbsp;"
                            + "<label><input id='cbNG" + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "' class=\"fixed-ng\" type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId
                            + "_" + rowNewIdx + "'  value='NG' " + (entity.InspectionValue == "NG" ? "checked='checked'" : "") + "/>NG</label>&nbsp;&nbsp;<label><input id='cbNA" + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "' class=\"fixed-NA\" type='radio' name='OkNgRa"
                            + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "'  value='N/A' " + (entity.InspectionValue == "NA" ? "checked='checked'" : "") + " />N/A</label>")

                    }
                }
            } else {
                for (var i = 0; i < listArr.length; i++) {
                    var entity = listArr[i];
                    if (i == listArr.length - 1) {
                        cell = row.insertCell(i + 1);
                        cell.align = "center";
                        cell.className = "Field pointer";
                        cell.innerHTML = "<input type='text' id='txtSJDate" + entity.InspectionTemplateMemberId + "_" + rowNewIdx + " readonly='readonly' class='ui-textbox layuidate' value='" + formatDateSecond(new Date()) + "' />";

                        cell = row.insertCell(i + 2);
                        cell.align = "center";
                        cell.className = "Field pointer";
                        cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Buttons.COM_Delete %></span></td>";
                    } else {
                        cell = row.insertCell(i + 1);
                        cell.align = "center";
                        cell.className = "Field pointer insppection-input";
                        cell.innerHTML = (entity.InspectionMethodId == 2 ? "<input type='text' InspectionMethodValue='" + entity.InspectionMethodValue + "' id='inputResult" + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "' class='inputResult' style=' height: 23px' OkNgRa='-1'/>" : "<label><input id='cbOK" + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "' type='radio' class=\"fixed-ok\" name='OkNgRa"
                            + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "' value='OK'/>OK</label>&nbsp;&nbsp;"
                            + "<label><input id='cbNG" + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "' class=\"fixed-ng\" type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId
                            + "_" + rowNewIdx + "'  value='NG'/>NG</label>&nbsp;&nbsp;<label><input id='cbNA" + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "' class=\"fixed-NA\" type='radio' name='OkNgRa"
                            + entity.InspectionTemplateMemberId + "_" + rowNewIdx + "'  value='N/A' />N/A</label>")

                    }
                }
            }

            TemplateMemberByTemp.unshift(2);
            BindLayDate();
        }


        function deleteItem(obj) {
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);

            var tbody = tab.getElementsByTagName('tbody')[0];
            var rows = $(tbody).find('.ListTableOddRow');
            for (var i = 0; i < rows.length; i++) {
                rows[i].cells[0].textContent = i + 1;
            }

            FinalResult();
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

        $('#fileshow').click(function (e) {
            e.preventDefault(); // 阻止默认的点击行为，即不跟随链接
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.GetFtpConfigInfoByFAI(filename);
            var fileUrl = encodeURI("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/UploadFiles/FAIInspectionTemplate/" + (filename));
            window.open(fileUrl, '_blank'); // 在新标签页中打开URL
        });

        // 定义格式化时间的函数
        function formatDate(date) {
            var year = date.getFullYear();
            var month = ('0' + (date.getMonth() + 1)).slice(-2);
            var day = ('0' + date.getDate()).slice(-2);
            var hours = ('0' + date.getHours()).slice(-2);
            var minutes = ('0' + date.getMinutes()).slice(-2);
            var seconds = ('0' + date.getSeconds()).slice(-2);
            return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes; //+ ':' + seconds;
        }

        function formatDateSecond(date) {
            var year = date.getFullYear();
            var month = ('0' + (date.getMonth() + 1)).slice(-2);
            var day = ('0' + date.getDate()).slice(-2);
            var hours = ('0' + date.getHours()).slice(-2);
            var minutes = ('0' + date.getMinutes()).slice(-2);
            var seconds = ('0' + date.getSeconds()).slice(-2);
            return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
        }

        // 读取cookie中的数据
        function getCookie(name) {
            var nameEQ = name + "=";
            var ca = document.cookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) == ' ') {
                    c = c.substring(1, c.length);
                }
                if (c.indexOf(nameEQ) == 0) {
                    return c.substring(nameEQ.length, c.length);
                }
            }
            return null;
        }

    </script>
</asp:Content>


