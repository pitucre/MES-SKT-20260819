<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master"
    AutoEventWireup="true" CodeBehind="IPQCInspection.aspx.cs" Inherits="SKT.LeanMES.Web.Client.IPQCInspection" %>

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
            color:red;

        }
    </style>
    <div class="client-center">
        <!--采集信息入口-->

        <table id="tabTmplContent" class="EditeContentTable" style="width: 100%; margin-bottom: 10px;">
            <tr>
                <td class="Label2" align="right">工单
                </td>
                <td class="Field4">
                    <input type="text" id="txtOrder" class="ui-textbox" />
                    <input id="button4" class="ButtonBox" type="button" onclick="openChoosePage(44)"
                        value="..." title="选择生产订单号" />
                    <input id="hdOrderId" type="hidden" value="-1000" />
                    <input id="hdItemCode" type="hidden" />
                </td>
                <td class="Label2" align="right">工单数量
                </td>
                <td class="Field4">

                    <label id="txtOrderQty" name="BarCode" class="ui-textbox"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2" align="right">产品名称
                </td>
                <td class="Field4">
                    <label id="txtItemName" name="txtItemName" class="ui-textbox"></label>
                </td>
                <td class="Label2" align="right">产线<em>*</em>
                </td>
                <td class="Field4">
                    <input type="text" id="txtLine" name="txtProductionLine" class="ui-textbox" readonly="readonly" />
                    <input id="button5" class="ButtonBox" type="button" onclick="openChoosePage(21)"
                        value="..." title="选择生产产线" />
                    <asp:HiddenField ID="hdLineId" runat="server" Value="-1" />
                    <asp:HiddenField ID="hdnLineName" runat="server" Value="" />

                </td>
            </tr>
            <tr>
                <td class="Label2" align="right">模板<em>*</em>
                </td>
                <td class="Field4">
                    <input type="text" id="txtTemplate" name="txtTemplate" class="ui-textbox" readonly="readonly" />
                    <input id="button6" class="ButtonBox" type="button" onclick="openChoosePage(75)"
                        value="..." title="选择模板" />
                    <asp:HiddenField ID="hdnInspectionTemplateId" runat="server" Value="-1" />

                </td>
                <td class="Label2" align="right">班别<em>*</em>
                </td>
                <td class="Field4">
                    <input type="text" id="txtClass" name="txtClass" class="ui-textbox" readonly="readonly" />
                    <input id="button7" class="ButtonBox" type="button" onclick="openChoosePage(49)"
                        value="..." title="选择班别" />
                    <asp:HiddenField ID="hdclassId" runat="server" Value="-1" />

                </td>
            </tr>
            <tr>
                <td class="Label2" align="right">检验人<em>*</em>
                </td>
                <td class="Field4">
                    <input type="text" id="txtSendMan" name="txtSendMan" class="ui-textbox" />
                </td>
                <td class="Label2" align="right">样本数量<em>*</em>
                </td>
                <td class="Field4">
                    <input type="text" id="txtsampleQty" name="txtsampleQty" class="ui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="Label2" align="right">检验单号<em>*</em>
                </td>
                <td class="Field4" id="tdOrderNo"></td>
                <td class="Label2" style="text-align: center;" colspan="2">
                    <label id="labtxt" style="color: red;"></label>
                </td>

            </tr>
            <tr>
                <td class="Field1" colspan="4" style="text-align: center;">
                    <input id="btnCollectSN" onclick="collectSN();"
                        title=" 序列号收集 " style="cursor: pointer;" value=" 序列号收集 " type="button" />
                    <input id="Img1" class="SearchButton" onclick="SaveInspectionOrderMember('', this)" alt="" type="button"
                        title="保存" style="cursor: pointer;" value=" 保 存 " />
                    <input id="RevierSave" class="SearchButton" onclick="ClearAll();"
                        alt="" title="清空" style="cursor: pointer;" value="清 空" type="button" />
                </td>
            </tr>
        </table>
        <!--数据分析统计展示及操作区-->
        <table class="ListTable" id="tabTurnOverList">
            <tr class='ListTableHeader' style="height: 30px;">
                <th scope="col" style="width: 5%">NO</th>
                <th scope="col" style="width: 9%">工序</th>
                <th scope="col" style="width: 9%">检验项目</th>
                <th scope="col" style="width: 10%">录入方式</th>
                <th scope="col" style="width: 8%">判定标准</th>
                <th scope="col" style="width: 6%">单位</th>
                <th scope="col" style="width: 12%">检验方法</th>
                <th scope="col" style="width: 10%">检验结果</th>
                <th scope="col" style="width: 8%">不良代码</th>
                <th scope="col" style="width: 8%">输入值</th>
                <th scope="col" style="width: 10%">备注</th>
                <th scope="col" style="width: 12%">文件上传</th>
                <th scope="col" style="width: 10%">
                    <input onclick="SaveAll(this)" type="button" value="保存所有项" />
                </th>
                <th scope="col" style="width: 8%">保存结果</th>
            </tr>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="14" style="text-align: center;">暂无数据
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
                        loadClientButton('IPQCInspection_ProCollectionUI');
                    }, 10);
            $(".insppection-input .inputResult").live("focus", function () { $(this).select(); });
            //  $(".inputResult").live("change", function () { count(this); });
            $(".insppection-input .inputResult").live("keydown", function (e) {
                if (e.keyCode == 13) {
                    count(this);
                }                
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

        function GetIndex() {
            var list = $(tab).find("tr");
            for (var i = 0; i < list.length; i++) {
                if ($(list[i]).attr("class").indexOf(selectRowClass) > -1) {
                    return i;
                }
            }
            return tab.rows.length;
        }

        //function addDetail(entity, i) {
        //    var row, cell;
        //    rowNewIdx = GetIndex();
        //    row = tab.insertRow(rowNewIdx);
        //    row.className = "ListTableOddRow";

        //    $("#trNewInfo").remove();

        //    cell = row.insertCell(0);
        //    cell.align = "center";
        //    cell.className = "Field pointer";
        //    cell.innerHTML = i;

        //    cell = row.insertCell(1);
        //    cell.align = "center";
        //    cell.className = "Field pointer";
        //    cell.id = "InspectionItemName" + entity.InspectionTemplateMemberId;
        //    cell.innerHTML =  entity.InspectionItemName;


        //    $(cell).click(function() {
        //        var className = $(this.parentNode).attr("class");
        //        if (className.indexOf(selectRowClass) > -1) {
        //            $(this.parentNode).removeClass(selectRowClass);
        //        } else {
        //            $(tab).find("tr").removeClass(selectRowClass);
        //            $(this.parentNode).addClass(selectRowClass);
        //        }
        //    });


        //    cell = row.insertCell(2);
        //    cell.align = "center";
        //    cell.className = "Field pointer";
        //    cell.id = "TestMethod" + entity.InspectionTemplateMemberId;
        //    cell.innerHTML =entity.CheckFashion=='null'?'':entity.CheckFashion;

        //    cell = row.insertCell(3);
        //    cell.align = "center";
        //    cell.className = "Field pointer";
        //    cell.id = "InspectionAccording" + entity.InspectionTemplateMemberId;
        //    cell.innerHTML = entity.InspectionAccording=='null'?'':entity.InspectionAccording;



        //    cell = row.insertCell(4);
        //    cell.align = "center";
        //    cell.className = "Field";
        //    cell.innerHTML = '<select id="InspectionResult'+entity.InspectionTemplateMemberId+'"><option value="合格">合格</option><option value="不合格">不合格</option></select>';

        //   // cell = row.insertCell(5);
        //    //cell.align = "center";
        //   // cell.className = "Field";
        //    //cell.innerHTML = 'admin';
        //    //cell.style = "display:none;";




        //    cell = row.insertCell(5);
        //    cell.align = "center";
        //    cell.className = "Field";
        //    cell.innerHTML = '<input id = "Remark' + entity.InspectionTemplateMemberId + '" type="text"  style=" width:80% "/> ';


        //    cell = row.insertCell(6);
        //    cell.align = "center";
        //    cell.className = "Field";
        //    cell.innerHTML = '<input type="button" class="SaveInspectionItem" id="_' + entity.InspectionTemplateMemberId + '" value="保存" />';
        //    BindIsPercentage("IsPercentage" + entity.InspectionItemId);
        //    BingSaveInspectionItemBtn('_' + entity.InspectionTemplateMemberId);
        //}
        //2021-01-06修改
        function count(obj) {
            operateObj = obj;
           var InspectionMethodValue = $(obj).closest("tr").find(".InspectionMethodValue").text()//.parent().parent().find(".InspectionMethodValue").text();
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
                $(obj).parent().parent().find(".insppection-input input[type='radio']:first").prop("checked", "checked");
                $(obj).closest(".insppection-input").siblings(".nc-code").html("");//删除不良代码
                $(obj).removeClass("red");
            } else {
                $(obj).closest(".insppection-input").parent().find(".insppection-input input:radio[class='fixed-ng']").prop("checked", "checked");
                //NG时需要采集不良代码
                openNCPage();
                $(obj).addClass("red");
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
            //var row, cell;
            //$("#trNewInfo").remove();
            //var html = "<tr class='ListTableOddRow'>";
            //html += "<td align='center' class='Field pointer'>" + i + " </td>"
            //if (showCell) {
            //    html += "<td align='center' rowspan='" + leg + "' id='OpenName" + entity.InspectionTemplateMemberId + "' class='Field pointer'><span id='spOpenName_" + entity.InspectionTemplateMemberId + ">" + entity.OpenName + "</span> </td>"
            //}
            //html += "<td align='center' onclick='changeClass(this)' id='InspectionItemName" + entity.InspectionTemplateMemberId + "' class='Field pointer'>" + entity.InspectionItemName + " </td>"
            //html += "<td align='center'  id='TestMethod" + entity.InspectionTemplateMemberId + "' class='Field pointer'>" + (entity.InspectionMethodId == 1 ? "固定值结果" : "指定值") + " </td>"
            //html += "<td align='center'  id='InspectionMethodValue" + entity.InspectionTemplateMemberId + "' class='Field pointer'>" + entity.InspectionMethodValue + " </td>"
            //html += "<td align='center'  id='UnitName" + entity.InspectionTemplateMemberId + "' class='Field pointer'>" + entity.UnitName + " </td>"
            //html += "<td align='center'  id='CheckFashion" + entity.InspectionTemplateMemberId + "' class='Field pointer'>[" + entity.InspectionAccording + "]-[" + entity.CheckFashion + "]</td>"
            //html += "<td align='center'  class='insppection-input'>"
            //     + (entity.InspectionMethodId == 2 ? "<label><input id='cbOK" + entity.InspectionTemplateMemberId + "' type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId
            //     + "' value='OK'  disabled='disabled'  />OK</label>&nbsp;&nbsp;"
            //     + "<label><input id='cbNG" + entity.InspectionTemplateMemberId + "' class=\"fixed-ng\" type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId
            //     + "'  disabled='disabled'   value='NG' />NG</label>&nbsp;&nbsp;<label><input id='cbNA" + entity.InspectionTemplateMemberId + "' class=\"fixed-NA\"  type='radio' name='OkNgRa"
            //     + entity.InspectionTemplateMemberId + "'    value='N/A' />N/A</label>" : "<label><input id='cbOK" + entity.InspectionTemplateMemberId + "' type='radio' name='OkNgRa"
            //     + entity.InspectionTemplateMemberId + "' value='OK' />OK</label>&nbsp;&nbsp;"
            //     + "<label><input id='cbNG" + entity.InspectionTemplateMemberId + "' class=\"fixed-ng\" type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId
            //     + "'  value='NG' />NG</label>&nbsp;&nbsp;<label><input id='cbNA" + entity.InspectionTemplateMemberId + "' class=\"fixed-NA\" type='radio' name='OkNgRa"
            //     + entity.InspectionTemplateMemberId + "'  value='N/A' />N/A</label>")
            //+ "</td>";
            //html += "<td align='center'id='nccode" + entity.InspectionTemplateMemberId + "'  class='nc-code'></td>"
            //html += "<td align='center' class='insppection-input'>" + (entity.InspectionMethodId == 2 ? "<input type='text' id='inputResult" + entity.InspectionTemplateMemberId + "' class='inputResult' style=' height: 23px' />" : "") + "</td>"
            //html += "<td align='center' class='Field'><input id = 'Remark" + entity.InspectionTemplateMemberId + "' type='text'/> </td>"
            //html += "<td align='center' class='Field'><a  href='#' id='btnDoFile_" + entity.InspectionTemplateMemberId + "'  onclick='SeeDoFileRow(this," + entity.InspectionTemplateMemberId + ")'   title='上传'>上传</a>&nbsp;<span id='spsee_" + entity.InspectionTemplateMemberId + "'></span><input type='hidden' id='hdSaveUrl_" + entity.InspectionTemplateMemberId + "'  value=''  /></td>"
            //html += "<td align='center' class='Field'><input type='button' class='SaveInspectionItem' id='_" + entity.InspectionTemplateMemberId + "' value='保存' /></td>"
            //html += "<td align='center'id='SaveMessage" + entity.InspectionTemplateMemberId + "' class='Field pointer'><label id='SaveMessagelabel" + entity.InspectionTemplateMemberId + "'  class='ui-textboxlabel' >未保存</label></td>"
            //html += "</tr>";
            //console.log(html)
            //$("#tabTurnOverList>tbody").eq(0).append(html);
            //rowNewIdx = GetIndex();
            //row = tab.insertRow(rowNewIdx);
            //row.className = "ListTableOddRow";


            //cell = row.insertCell(0);
            //cell.align = "center";
            //cell.className = "Field pointer";
            //cell.innerHTML = i;

            //debugger
            //cell = row.insertCell(1);             
            //    cell.align = "center";
            //    cell.className = "Field pointer";
            //    cell.id = "OpenName" + entity.InspectionTemplateMemberId;
            //    cell.innerHTML = '<span id="spOpenName_' + entity.InspectionTemplateMemberId + '">' + entity.OpenName + '</span>';

            //cell = row.insertCell(2);
            //cell.align = "center";
            //cell.className = "Field pointer";
            //cell.id = "InspectionItemName" + entity.InspectionTemplateMemberId;
            //cell.innerHTML = entity.InspectionItemName;
            //$(cell).click(function () {
            //    var className = $($(el).parentNode).attr("class");
            //    if (className.indexOf(selectRowClass) > -1) {
            //        $($(el).parentNode).removeClass(selectRowClass);
            //    } else {
            //        $(tab).find("tr").removeClass(selectRowClass);
            //        $($(el).parentNode).addClass(selectRowClass);
            //    }
            //});

            //cell = row.insertCell(3);
            //cell.align = "center";
            //cell.className = "Field pointer";
            //cell.id = "TestMethod" + entity.InspectionTemplateMemberId;
            //cell.innerHTML = entity.InspectionMethodId == 1 ? "固定值结果" : "指定值";

            //cell = row.insertCell(4);
            //cell.align = "center";
            //cell.className = "Field pointer";
            //cell.id = "InspectionMethodValue" + entity.InspectionTemplateMemberId;
            //cell.innerHTML = entity.InspectionMethodValue;

            //cell = row.insertCell(5);
            //cell.align = "center";
            //cell.className = "Field pointer";
            //cell.id = "UnitName" + entity.InspectionTemplateMemberId;
            //cell.innerHTML = entity.UnitName;

            //cell = row.insertCell(6);
            //cell.align = "center";
            //cell.className = "Field pointer";
            //cell.id = "CheckFashion" + entity.InspectionTemplateMemberId;
            //cell.innerHTML = "[" + entity.InspectionAccording + "]-[" + entity.CheckFashion + "]";


            //cell = row.insertCell(7);
            //cell.align = "center";
            //cell.className = "insppection-input";
            //cell.innerHTML = entity.InspectionMethodId == 2 ? "<label><input id='cbOK" + entity.InspectionTemplateMemberId + "' type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId + "' value='OK'  disabled='disabled'  />OK</label>&nbsp;&nbsp;"
            //    + "<label><input id='cbNG" + entity.InspectionTemplateMemberId + "' class=\"fixed-ng\" type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId + "'  disabled='disabled'   value='NG' />NG</label>&nbsp;&nbsp;<label><input id='cbNA" + entity.InspectionTemplateMemberId + "' class=\"fixed-NA\"  type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId + "'    value='N/A' />N/A</label>" :
            //    "<label><input id='cbOK" + entity.InspectionTemplateMemberId + "' type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId + "' value='OK' />OK</label>&nbsp;&nbsp;"
            //        + "<label><input id='cbNG" + entity.InspectionTemplateMemberId + "' class=\"fixed-ng\" type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId + "'  value='NG' />NG</label>&nbsp;&nbsp;<label><input id='cbNA" + entity.InspectionTemplateMemberId + "' class=\"fixed-NA\" type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId + "'  value='N/A' />N/A</label>";


            //cell = row.insertCell(8);
            //cell.align = "center";
            //cell.className = "nc-code";
            //cell.id = "nccode" + entity.InspectionTemplateMemberId;
            //cell.innerHTML = "";


            //cell = row.insertCell(9);
            //cell.align = "center";
            //cell.className = "insppection-input";
            //cell.innerHTML = entity.InspectionMethodId == 2 ? "<input type='text' id='inputResult" + entity.InspectionTemplateMemberId + "' class='inputResult' style=' height: 23px' />" : "";


            //cell = row.insertCell(10);
            //cell.align = "center";
            //cell.className = "Field";
            //cell.innerHTML = '<input id = "Remark' + entity.InspectionTemplateMemberId + '" type="text"/> ';

            //cell = row.insertCell(11);
            //cell.align = "center";
            //cell.className = "Field";
            //cell.innerHTML = '<a  href="#" id="btnDoFile_' + entity.InspectionTemplateMemberId + '"  onclick="SeeDoFileRow(this,' + entity.InspectionTemplateMemberId + ')"   title="上传">上传</a>&nbsp;<span id="spsee_' + entity.InspectionTemplateMemberId + '"></span><input type="hidden" id="hdSaveUrl_' + entity.InspectionTemplateMemberId + '"  value=""  />';


            //cell = row.insertCell(12);
            //cell.align = "center";
            //cell.className = "Field";
            //cell.innerHTML = '<input type="button" class="SaveInspectionItem" id="_' + entity.InspectionTemplateMemberId + '" value="保存" />';

            //cell = row.insertCell(13);
            //cell.align = "center";
            //cell.className = "Field pointer";
            //cell.id = "SaveMessage" + entity.InspectionTemplateMemberId;
            //cell.innerHTML = "<label id=\"SaveMessagelabel" + entity.InspectionTemplateMemberId + "\"  class=\"ui-textboxlabel\" >未保存</label>";

            BindIsPercentage("IsPercentage" + entity.InspectionItemId);
            BingSaveInspectionItemBtn('_' + entity.InspectionTemplateMemberId);
        }
        //2021-01-06修改

        function SeeDoFileRow(obj, Id) {
            if (IOrderId == -1) {
                alert("请先通过保存生成检验单！")
                return;
            }
            var iod= $("#tdOrderNo").html();
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/IPQCInspectionAddFile.aspx?name=IPQCInspectionAddFile&ID=" + Id + "&IOD=" + iod;
            dialog({ title: "上传文件", src: openWinUrl, width: 750, height: 400 });
        }

        //返回地址
        function ReturnDoFileRow(url, Id) {
            if (url != "") {
                $("#hdSaveUrl_" + Id).val(url);
                $("#spsee_" + Id).html('<a   href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>' + url + '" title="查看" target="_blank">查看</a>');
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

            //抽样数量
            var txtSampleQty = $("#txtsampleQty").val();
            var txtItemCode = $("#hdItemCode").val();
            var LotCode = "";
            var ItemId = -1;
            var SNStr = "0000000";
            var txtSendMan = $("#txtSendMan").val();
            var ClassType = $("#txtClass").val();    //班别


            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.AdditionalSerialNumberGeneral(InspectionTypeId, ItemId, txtItemCode, SNStr, userName, IOrderId, operationId, LineId, ResourceId, StationId, OrderId, TemplateId, LotCode, EquipmentId, txtSampleQty, txtSendMan, ClassType);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                //写入日志
                SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                return;
            }

            IOrderId = ajax.value.split(',')[0];
            IOrderNo = ajax.value.split(',')[1];
            $("#tdOrderNo").html(IOrderNo);
            return true;

        }

        /*保存受检单结果*/
        function SaveInspectionOrderMember(result, obj) {

            //if (IOrderId == -1) {
            //    alert("请先通过保存生成检验单！")
            //    return;
            //}
            //var r = confirm("你将保存" + IOrderNo + "！");
            //if(r == true){
            //    $(obj).attr("disabled", "disabled");
            //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.SaveInspectionOrderResult(IOrderId, result);
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
            //else{
            //    return;
            //}

            if (IOrderId == -1) {
                alert("请先通过保存生成检验单！")
                return;
            }

            var savemessage = "";
            var fa = true;
            if (NumberData.length > 0) {
                for (var i = 0; i < NumberData.length; i++) {
                    savemessage = $("#SaveMessagelabel" + NumberData[i].InspectionTemplateMemberId).text();
                    if (savemessage == "未保存" || savemessage == "失败") {
                        fa = false;
                    }
                }
            }
            else {
                alert("检验项不能为空！")
                return;
            }

            if (fa == false) {
                alert("请完成所有检验项的检验！")
                return;
            }

            var hav = false;
            if (NumberData.length > 0) {
                for (var i = 0; i < NumberData.length; i++) {
                    savemessage = $("#SaveMessagelabel" + NumberData[i].InspectionTemplateMemberId).text();
                    if (savemessage == "成功") {
                        hav = true;
                    }
                }
            }
            else {
                alert("检验项不能为空！")
                return;
            }
            if (hav == false) {
                alert("检验项必须有一项检验！")
                return;
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
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.SaveInspectionOrderResult(IOrderId, result, FAISNStr);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    obj.removeAttribute("disabled");
                    //写入日志
                    SaveUserUILog("一般", stationId, resourceId, "", ajax.error.Message);
                    return;
                }
                obj.removeAttribute("disabled");
                alert("保存成功！");
                ClearAll();
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
            //TemplateId = -1;
            //IOrderId = -1;
            //IOrderNo = "";
            //LineId = -1;
            //ResourceId = -1;
            //StationId = -1;
            //OrderId = -1;

            //$("#txtResource").val("");
            //$("#hdResourceId").val("-1");
            //$("#txtOrder").val("");
            //$("#hdOrderId").val("-1");
            //$("#txtInspectionTemplate").val("");
            //$("#hdnInspectionTemplateId").val("-1");
            //$("#txtStation").val("");
            //$("#hdStationId").val("-1");
            //$("#txtLine").val("");
            //$("#hdLineId").val("-1");
            //$("#tdOrderNo").html("");
            //$("#txtItemCode").val("");
            //$("#txtsampleQty").val("");
            //$("#txtSendMan").val("");
            //$("#txtClass").val("");
            //$("#txtOrderQty").text("");
            //$("#txtItemName").text("");
            //$("#hdItemCode").val("");
            //$("#txtTemplate").val("");

            //$(tab).find(".ListTableOddRow").empty().remove();
            TemplateId = -1;
            IOrderId = -1;
            IOrderNo = "";
            LineId = -1;
            ResourceId = -1;
            StationId = -1;
            OrderId = -1;
            FAISNArr = [];
            FAISNStr = "";
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
            $("#txtSendMan").val("");
            $("#txtClass").val("");
            $("#txtOrderQty").text("");
            $("#txtItemName").text("");
            $("#hdItemCode").val("");
            $("#txtTemplate").val("");
            $("#btnCollectSN").show();
            $(tab).find(".ListTableOddRow").empty().remove();
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

            //var data = "<table>";
            //for (var i = 0; i < length; i++) {

            //}
            //data += "<tr></tr>";
            //data += "<tr></tr>";
            //data += "<tr></tr>";
            //data += "</table>";
            //layer.open({
            //    type: 1,
            //    area: ['45%', '65%'],
            //    shadeClose: true, //点击遮罩关闭
            //    content: data
            //});
        }

        function openChoosePage(flags) {
            var condition = "";
            globalFlag = flags;
            switch (flags) {
                case 116:
                    condition = " Status =1 ";
                    break;
                case 75:

                    condition = " SystemType=2 ";
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
                  case 44:   //选择工单

                      $("#txtOrder").val(list[0][1]);
                      $("#hdOrderId").val(list[0][0]);
                      OrderId = list[0][0];
                      $("#txtOrderQty").text(list[0][3]);
                      $("#txtItemName").text(list[0][5]);
                      $("#hdItemCode").val(list[0][2]);
                      getInspectionSN();

                      //获取产品绑定的模板
                      $("#hdnInspectionTemplateId").val(-1);
                      $("#txtTemplate").val("");
                      TemplateId = -1;
                      InspectionTypeId = -1;                    
                      $(tab).find(".ListTableOddRow").remove();

                      var entity = {};
                      entity.OrderNo = list[0][1];
                      entity.ItemID = -1;
                      entity.SystemType = 2;//模板类型 1：IQC;2:IPQC;3:PQC;4:FQC;5:OQC;6:FAI
                      var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetOrderItemTemplate", JSON.stringify(entity));
                      if (ajax.error != null) {
                          alert(ajax.error.Message);
                          return false;
                      }
                      if (ajax.value.length>0) {
                          var templateInfo = JSON.parse(ajax.value)
                          if (templateInfo.length > 0) {
                              $("#hdnInspectionTemplateId").val(templateInfo[0].InspectionTemplateId);
                              $("#txtTemplate").val(templateInfo[0].InspectionTemplateName);
                              TemplateId = templateInfo[0].InspectionTemplateId;
                              InspectionTypeId = templateInfo[0].InspectionTypeId;
                              BindTab(templateInfo[0].InspectionTemplateId);
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
                    BindTab(list[0][0]);
                    break;

                default:
                    break;
            }
        }

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
            $(tab).find(".ListTableOddRow").remove();
            var listArr = ajax.value;
            NumberData = listArr;

            var currentName = "";
            var showCell = true;
            if (null != listArr) {
                var html = "";
                var index = 1;
                for (var i = 0; i < listArr.length; i++) {
                    var leg = 1;//合并数量
                    var entity = listArr[i];
                    if (entity.OpenName) {

                        if (currentName != entity.OpenName) {
                            currentName = entity.OpenName;
                            showCell = true;
                        }
                        else if (currentName == entity.OpenName) {
                            showCell = false;
                        }
                        leg = $.grep(listArr, function (value) {
                            return value.OpenName == currentName;
                        }).length;
                    }

                    var htmltr = "<tr class='ListTableOddRow'>";                    
                    if (showCell) {
                        htmltr += "<td align='center' rowspan='" + leg + "' class='Field pointer'>" + index + " </td>"
                        htmltr += "<td align='center' rowspan='" + leg + "' class=  id='OpenName" + entity.InspectionTemplateMemberId + "' class='Field pointer'><span class='spOpenName' id='spOpenName_" + entity.InspectionTemplateMemberId + "'>" + entity.OpenName + "</span> </td>"
                        index++;
                    }
                    htmltr += "<td align='center' onclick='changeClass(this)' id='InspectionItemName" + entity.InspectionTemplateMemberId + "' class='Field pointer'>" + entity.InspectionItemName + " </td>"
                    htmltr += "<td align='center'  id='TestMethod" + entity.InspectionTemplateMemberId + "' class='Field pointer'>" + (entity.InspectionMethodId == 1 ? "固定值结果" : "指定值") + " </td>"
                    htmltr += "<td align='center' class='InspectionMethodValue'  id='InspectionMethodValue" + entity.InspectionTemplateMemberId + "' class='Field pointer'>" + entity.InspectionMethodValue + " </td>"
                    htmltr += "<td align='center'  id='UnitName" + entity.InspectionTemplateMemberId + "' class='Field pointer'>" + entity.UnitName + " </td>"
                    htmltr += "<td align='center'  id='CheckFashion" + entity.InspectionTemplateMemberId + "' class='Field pointer'>[" + entity.InspectionAccording + "]-[" + entity.CheckFashion + "]</td>"
                    htmltr += "<td align='center'  class='insppection-input'>"
                         + (entity.InspectionMethodId == 2 ? "<label><input id='cbOK" + entity.InspectionTemplateMemberId + "' type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId
                         + "' value='OK'  disabled='disabled'  />OK</label>&nbsp;&nbsp;"
                         + "<label><input id='cbNG" + entity.InspectionTemplateMemberId + "' class=\"fixed-ng\" type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId
                         + "'  disabled='disabled'   value='NG' />NG</label>&nbsp;&nbsp;<label><input id='cbNA" + entity.InspectionTemplateMemberId + "' class=\"fixed-NA\"  type='radio' name='OkNgRa"
                         + entity.InspectionTemplateMemberId + "'    value='N/A' />N/A</label>" : "<label><input id='cbOK" + entity.InspectionTemplateMemberId + "' type='radio' name='OkNgRa"
                         + entity.InspectionTemplateMemberId + "' value='OK' />OK</label>&nbsp;&nbsp;"
                         + "<label><input id='cbNG" + entity.InspectionTemplateMemberId + "' class=\"fixed-ng\" type='radio' name='OkNgRa" + entity.InspectionTemplateMemberId
                         + "'  value='NG' />NG</label>&nbsp;&nbsp;<label><input id='cbNA" + entity.InspectionTemplateMemberId + "' class=\"fixed-NA\" type='radio' name='OkNgRa"
                         + entity.InspectionTemplateMemberId + "'  value='N/A' />N/A</label>")
                    + "</td>";
                    htmltr += "<td align='center'id='nccode" + entity.InspectionTemplateMemberId + "'  class='nc-code'></td>"
                    htmltr += "<td align='center' class='insppection-input'>" + (entity.InspectionMethodId == 2 ? "<input type='text' id='inputResult" + entity.InspectionTemplateMemberId + "' class='inputResult' style=' height: 23px' />" : "") + "</td>"
                    htmltr += "<td align='center' class='Field'><input id = 'Remark" + entity.InspectionTemplateMemberId + "' type='text'/> </td>"
                    htmltr += "<td align='center' class='Field'><a  href='#' id='btnDoFile_" + entity.InspectionTemplateMemberId + "'  onclick='SeeDoFileRow(this," + entity.InspectionTemplateMemberId + ")'   title='上传'>上传</a>&nbsp;<span id='spsee_" + entity.InspectionTemplateMemberId + "'></span><input type='hidden' id='hdSaveUrl_" + entity.InspectionTemplateMemberId + "'  value=''  /></td>"
                    htmltr += "<td align='center' class='Field'><input type='button' openName='"+entity.OpenName+"' class='SaveInspectionItem' id='_" + entity.InspectionTemplateMemberId + "' value='保存' /></td>"
                    htmltr += "<td align='center'id='SaveMessage" + entity.InspectionTemplateMemberId + "' class='Field pointer'><label id='SaveMessagelabel" + entity.InspectionTemplateMemberId + "'  class='ui-textboxlabel' >未保存</label></td>"
                    htmltr += "</tr>";
                    html += htmltr;
                }
                $("#tabTurnOverList>tbody").eq(0).append(html);

                for (var i = 0; i < listArr.length; i++) {
                    addDetail(listArr[i], index);
                    index++;
                }
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
            if (parseInt($("#hdOrderId").val()) <= 0) {
                alert("请选择工单！");
                return;
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


