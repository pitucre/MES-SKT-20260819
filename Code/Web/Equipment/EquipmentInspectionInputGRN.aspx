<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="EquipmentInspectionInputGRN.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentInspectionInputGRN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table id="tbInspectionItem" class="ListTable" style="border-width: 0px; width: 98%; border-collapse: collapse; margin-top: 5px;">
        <thead>
            <tr class="ListTableOddRow">
                <th colspan="10" style="text-align: center; font-size: 20px; font-weight: 500">检测结果录入</th>
            </tr>
            <tr class="ListTableHeader">
                <th>检验项目</th>
                <th width="60">录入方式</th>
                <th>判定标准</th>
                <th width="60">单位</th>
                <th>检验方法</th>
                <%--<th width="80">需要检验个数</th>
                <th width="70">已检验个数</th>
                <th width="50">良数</th>
                <th width="50">不良数</th>--%>
                <th width="50">结果</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
    <div style="margin: 20px"></div>
    <div>
        <table class="EditeContentTable" width="70%" style="float: left">
            <tr style="display: none;">
                <td class="Label1">
                    <asp:Label ID="lbInspectionTypeName" runat="server" Text="GRN"></asp:Label><em>*</em>
                </td>
                <td class="Field1">
                    <input type="text" id="txtGRN" style="width: 250px" />
                </td>
            </tr>
            <tr>
                <td class="Label1">
                    <asp:Label ID="Label2" runat="server" Text="备注"></asp:Label>
                </td>
                <td class="Field1">
                    <input type="text" id="txtRemark" style="width: 250px" />
                </td>
            </tr>
            <tr id="rangeMsg">
                <td class="Label1" style="align-self: center; text-align: right;" align="right"></td>
                <td class="Field1">
                    <span id="spMsg" style="text-align: left; color: red;"></span>
                </td>
            </tr>
            <tr id="Standard">
                <td class="Label1">
                    <asp:Label ID="Label1" runat="server" Text="实际测量值"></asp:Label><em>*</em>
                </td>
                <td class="Field1">
                    <input type="text" id="txtValue" />
                </td>
            </tr>
            <tr id="range">
                <td class="Label1" style="align-self: center; text-align: right;" align="right">
                    <input type="radio" id="ActualValue" name="InputValue" checked="checked" />实际测量值<input type="radio" id="DeviationValue" name="InputValue" />公差值
                    <em>*</em><input type="hidden" id="hidValue" />
                </td>
                <td class="Field1">
                    <input type="text" id="txtRangeValue" />
                </td>
            </tr>
        </table>
        <div id="showresult" style="float: right; width: 29%; height: 111px; font-size: 60px; text-align: center; color: green; font-weight: 800">
            OK
        </div>
    </div>
    <div style="margin: 150px"></div>
    <table id="tbDetail" class="ListTable" style="border-width: 0px; width: 98%; border-collapse: collapse; margin-top: 5px;">
        <thead>
            <tr class="ListTableHeader">
                <th style="width: 5%">序号</th>
                <th style="width: 20%;" class="test-sn">GRN</th>
                <th style="width: 15%">测试值</th>
                <%--<th style="width: 5%">单位</th>--%>
                <th style="width: 6%">结果</th>
                <%--<th style="width: 10%">测试人</th>
                <th style="width: 20%">测试时间</th>
                <th>备注</th>--%>
                <th style="width: 5%">操作</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <script type="text/javascript" src="../Content/js/skt.utility.datetime.js"></script>
    <%--<script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>--%>

    <style type="text/css">
        .test-sn { display: none; }
        .green { color: green; }
        .red { color: red; }
    </style>

    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName %>";
        var list = [];
        var GRNList = [];

        (function ($) {
            $.getUrlParam = function (name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]); return null;
            }
        })(jQuery);
        //var InspectionItemName = $.getUrlParam('InspectionItemName');
        var InspectionItemId = $.getUrlParam('InspectionItemId');//模板--检验项---Pid
        //var InspectionMethodName = $.getUrlParam('InspectionMethodName');
        var InspectionMethodValue = ""; //$.getUrlParam('InspectionMethodValue');
        //var CheckFashion = $.getUrlParam('CheckFashion');
        var Units = ""; //$.getUrlParam('UnitName') == "undefined" ? "" : $.getUrlParam('UnitName');
        var OffsetUnitName = "";// $.getUrlParam('OffsetUnitName');
        //var Sum = $.getUrlParam('Sum');
        //var InspectionNo = $.getUrlParam('InspectionNo');
        <%--var InspectionId = "<%=Request.QueryString["InspectionId"]%>";--%>
        //var AcRc = $.getUrlParam('AcRc');
        var InspectionTemplateId = -1;// $.getUrlParam('InspectionTemplateId');
        var judgeValue = -1;//$.trim(AcRc.split('/')[1].substr(4, 6))//判断是否OK/NG的判断值
        //var IQCStatus = $.getUrlParam('IQCStatus');//IQC检验单状态
        var isView = $.getUrlParam('isView');//是否查看 0：否 1：是 
        //var GRNQty = 0;
        <%--var isEidt = "<%= SKT.Common.Account.BLL.Users.CheckUserIsWarrantted(SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId,40170111)%>";--%>
        var isEidt = false;

        var inspectionOrderOATemplateDetailId = "<%=Request.QueryString["inspectionOrderOATemplateDetailId"]%>";
        var inspectionStatus = "<%=Request.QueryString["inspectionStatus"]%>";
        var inspectionType = "<%=Request.QueryString["InspectionType"]%>";
        var inspectionId = "<%=Request.QueryString["InspectionId"]%>";

        $(function () {

            //var str = "<tr class='ListTableOddRow' name='InpsectionRow'>"
            //            + "<td>" + InspectionItemName + "</td>"
            //            + "<td>" + InspectionMethodName + "</td>"
            //            + "<td><span id='lblMethodValue' class='.lblMethodValue'>" + InspectionMethodValue + "</span>";
            //            str += isEidt == "True" ? "<input type='button' id='btnChageValue' value=' 修改 ' onclick='changeValue(this)' style='float:right;' />" : "";
            //            str += "<td><input type=\"text\" MaxLength=\"50\" value='" + (Units) + "' id='txtUnits' readonly='readonly' class=\"txtUnit\" style=\"width: 30px; \"/>"
            //            + "<input type=\"button\" onclick=\"selectUnit(this);\" class=\"ButtonBox\" value=\"...\" /><input name=\"txtOffsetUnit\" type=\"hidden\" value=\"" + OffsetUnitName + "\" />" + "</td>"
            //            + "<td>" + CheckFashion + "</td>"
            //            //+ "<td>" + Sum + "</td>"
            //            //+ "<td>0</td>"
            //            //+ "<td>0</td>"
            //            //+ "<td>0</td>"
            //            + "<td>OK</td></tr>";
            //$("#tbInspectionItem tbody").append(str);


            //获取检验项信息            
            var entity = getInspectionItemInfo();
            if (!entity || entity.InspectionOrderOATemplateDetailId == 0) {
                alert("未获取到检验项信息");
                return false;
            }
            var result = "";
            switch (entity.Result) {
                case 1: result = "OK"; break;
                case 0: result = "NG"; break;
                default: result = ""; break;
            }
            var hl = "<tr class='ListTableOddRow'>"
                + "<td class=\"InspectionItemName\">" + entity.InspectionItemName + "</td>"  //检验项目
                + "<td class=\"InspectionMethodName\">" + (entity.FixResultFlag == 0 ? "指定值" : "固定结果") + "</td>"         //录入方式
                + "<td><span id='lblMethodValue' class='lblMethodValue'>" + entity.StandardValue + "</span>"    //InspectionMethodValue
                + (isEidt == true ? "<input type='button' id='btnChageValue' value=' 修改 ' onclick='changeValue(this)' style='float:right;' />" : "<td><input type=\"text\" MaxLength=\"50\" value='" + (entity.Unit) + "' id='txtUnits' disabled='disabled' class=\"txtUnit\" style=\"width: 30px; \"/>")
                //+ "<input type=\"button\" onclick=\"selectUnit(this);\" class=\"ButtonBox\" value=\"...\" /><input name=\"txtOffsetUnit\" type=\"hidden\" value=\"" + OffsetUnitName + "\" />" + "</td>"
                + "<td>" + (entity.InspectionMethod == null ? "" : entity.InspectionMethod) + "</td>"
                //+ "<td>" + (entity.InspectionMethod == null ? "" : entity.InspectionMethod) + "</td>"    //检验方法
                //+ "<td><span id='lblStandardValue'>" + entity.StandardValue + "</span></td>"   //检验标准  <input type='button' id='btnChageValue' value=' 修改 ' onclick='changeValue()' style='float:right;' />
                //+ "<td>" + entity.Unit + "</td>"    //单位                
                + "<td class=\"result\" style=\"font-weight:700;\">" + result + "</td></tr>";   //结果
            $("#tbInspectionItem tbody").html(hl);

            InspectionMethodValue = entity.StandardValue;
            Units = entity.Unit;

            //if (inspectionType == 8 || inspectionType == 9 || inspectionType == 10 || inspectionType == 11) {
            //    //自检单，不需要显示抽样比例/标准
            //    $("th.aql,td.aql").hide();
            //}

            $("#max-value").text(entity.MaxValue);//最大值
            $("#min-value").text(entity.MinValue);//最小值
            $("#avg-value").text(entity.AvgValue);//平均值

            ////获取检验项
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetIQCInputGRNInfo(InspectionItemId);
            //if (ajax.error != null) {
            //    alert(ajax.error.Message);
            //    return false;
            //}
            //var data = ajax.value;
            //if (data.length > 0) {
            //    $("input[type='text']").attr("disabled", "disabled");
            //    $("#btnChageValue").hide();
            //    for (var i = 0; i < data.length; i++) {
            //        $("#tbDetail tbody").append("<tr class='ListTableOddRow' style='" + (data[i].DtlResult ? "" : "color:red") + "'><td>" + (data.length - i) + "</td><td>" + data[i].GRN + "</td><td>" + data[i].Value
            //            + "</td><td>" + Units + "</td><td>" + (data[i].DtlResult ? "OK" : "NG")
            //            + "</td><td>" + data[i].CreateBy + "</td><td>" + data[i].CreateDateTime + "</td><td>" + data[i].Remark + "</td><td></td></tr>");
            //        if (data[i].DtlResult) {
            //            $("#tbInspectionItem tbody tr:gt(0) td:eq(7)").html(parseInt($("#tbInspectionItem tbody tr:gt(0) td:eq(7)").html()) + 1);
            //        } else {
            //            $("#tbInspectionItem tbody tr:gt(0) td:eq(8)").html(parseInt($("#tbInspectionItem tbody tr:gt(0) td:eq(8)").html()) + 1);
            //        }
            //    }
            //    if ($("#tbInspectionItem tbody tr:gt(0):gt(0) td:eq(8)").html() >= judgeValue) {
            //        $("#tbInspectionItem tbody tr:gt(0) td:last").html("NG");
            //        $("#showresult").html("NG").css("color", "red");
            //    } else {
            //        $("#tbInspectionItem tbody tr:gt(0) td:last").html("OK");
            //        $("#showresult").html("OK").css("color", "green");
            //    }
            //    $("#tbInspectionItem tbody tr:gt(0) td:eq(6)").html(data.length);


            //    //$(".toolbar-btn:eq(1)").css("display", "none");
            //}

            //获取检验单检验项已检验的SN信息
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.GetInspectionOrderSN({ InspectionOrderOATemplateDetailId: parseInt(entity.InspectionOrderOATemplateDetailId) });
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = ajax.value;
            for (var i = 0; i < list.length; i++) {
                showCalcResult(list[i], 0);
            }


            //如果是查看，隐藏相关按钮、禁用文本框
            if (isView == 1 || (inspectionType == 7 && inspectionStatus != 1) || (inspectionType == 12 && inspectionStatus != 1) || (inspectionType == 13 && inspectionStatus != 1)) {
                $("input").prop("disabled", true);
                $("#toolbar").hide();
                $("#tbDetail tbody tr a.del").hide();
            }

            if (InspectionMethodValue.indexOf("[") >= 0) {
                $("#range,#rangeMsg").css("display", "");
                if (OffsetUnitName != "" && Units != "" && OffsetUnitName != Units) {
                    $("#spMsg").html(UnitTransforMag(Units, OffsetUnitName));
                } else {
                    $("#rangeMsg").css("display", "none");
                }
                $("#Standard").css("display", "none");
            }
            else {
                $("#range,#rangeMsg").css("display", "none");
                $("#Standard").css("display", "");
            }

        });

        //获取检验项信息
        function getInspectionItemInfo() {
            //获取检验项信息
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.GetInspectionOrderOATemplateDetailInfo({ InspectionOrderOATemplateDetailId: parseInt(inspectionOrderOATemplateDetailId) });
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            return entity;
        }

        //显示测量结果
        function showCalcResult(entity, type) {
            var fqcShow = "display:none";
            var len = $("#tbDetail tbody tr").length;
            if (inspectionType == 4) {
                fqcShow = "";
                if (len >= 1) {
                    alert("FQC只允许录入一行数据");
                    return false;
                }
            }
            var hl = "<tr class=\"ListTableOddRow\">" +
                "<td class=\"rownum\">" + (len + 1) + "</td>" +//序号
                "<td class=\"grn test-sn\">" + entity.SerialNumber + "</td>" +//GRN
                "<td class=\"test-val\">" + entity.InputValue + "</td>" + //测试值
                //"<td class=\"fqc calc-way\" style=\"" + fqcShow + "\" calc-way=\"" + entity.CalcWay + "\">" + getCalcWayName(entity.CalcWay) + "</td>" + //计算方式（FQC用到）
                //"<td class=\"fqc test-val1\" style=\"" + fqcShow + "\">" + entity.InputValue1 + "</td>" + //测试值1（FQC用到）
                //"<td class=\"fqc test-val2\" style=\"" + fqcShow + "\">" + entity.InputValue2 + "</td>" + //测试值2（FQC用到）
                "<td class=\"test-result " + (entity.Result == true ? "green" : "red") + "\">" + (entity.Result == true ? "OK" : "NG") + "</td>" +   //结果
                "<td><a href=\"javascript:void(0)\" class=\"del\" style='text-decoration: underline;' onclick='Del(this)'>删除</a></td>" +//操作
                "</tr>";
            $("#tbDetail tbody").append(hl);

            if (type == 1) {
                if (entity.Result) {
                    $("#showresult").html("OK").css("color", "green");
                } else {
                    $("#showresult").html("NG").css("color", "red");
                }
                //刷新检验项检验结果
                refreshInspectonItemReuslt();
            }
        }

        //$("#txtGRN").on("keydown", function (e) {
        //    var curKey = 0, e = e || window.event;
        //    curKey = e.keyCode || e.which || e.charCode;
        //    if (curKey == 13) {
        //        var GRN = $.trim($("#txtGRN").val());
        //        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.uspIsIQCInputGRNInfo(InspectionNo, GRN);
        //        if (ajax.error != null) {
        //            alert(ajax.error.Message);
        //            return false;
        //        }
        //        GRNQty = ajax.value;

        //        setTimeout(function () {
        //            if (InspectionMethodValue.indexOf("[") != -1) {
        //                $("#txtRangeValue").val("").focus();
        //            }
        //            else {
        //                $("#txtValue").val("").focus();
        //            }
        //        }, 10);
        //    }
        //});

        $("#txtRangeValue").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                //if ($.trim($("#txtGRN").val()) == "") {
                //    alert("请输入GRN");
                //    return false;
                //}
                if ($.trim($("#txtRangeValue").val()) == "") {
                    alert("不能输入空值");
                    return false;
                }
                var GRN = $("#txtGRN").val();
                var Flag = true;
                var CurrentQty = 0;
                var Mark = 0;
                //for (var i = 0; i < GRNList.length; i++) {
                //    if (GRNList[i].GRN == GRN) {
                //        GRNList[i].Qty++;
                //        CurrentQty = GRNList[i].Qty;
                //        Mark = i;
                //        Flag = false;
                //    }
                //}
                //if (CurrentQty > GRNQty) {
                //    GRNList[Mark].Qty--;
                //    alert("检验次数大于GRN数量");
                //    $("#txtValue").select();
                //    return false;
                //}
                //if (Flag || GRNList.length <= 0) {
                //    var en = {};
                //    en.GRN = GRN;
                //    en.Qty = 1;
                //    GRNList.push(en);
                //}

                InspectionMethodValue = $("#lblMethodValue").text();
                var data = $("#txtRangeValue").val();
                if (InspectionMethodValue.indexOf("[") != -1) {
                    //范围
                    var MethodValue = InspectionMethodValue;
                    if (MethodValue.substring(0, 1) == "[") {
                        MethodValue = MethodValue.substring(1, MethodValue.length - 1);
                    }
                    var standardValue = parseFloat(MethodValue.substring(0, MethodValue.indexOf("["))); //标准值
                    var arr = MethodValue.substring(MethodValue.indexOf("[") + 1, MethodValue.indexOf("]")).replace('[', '').replace(']', '').split('~');
                    var upper = parseFloat(arr[0]);//上限
                    var lower = parseFloat(arr[1]);//下限
                    if (document.getElementById("ActualValue").checked == true) {
                        if (parseFloat(data) >= parseFloat(lower + standardValue) && parseFloat(data) <= parseFloat(upper + standardValue)) {
                            Result = true;
                        } else {
                            Result = false;
                        }
                    }
                    else {
                        if (Units != "" && OffsetUnitName != "") {
                            var entity = UnitTransfor(Units, OffsetUnitName);
                            data = data / entity.TransforData;
                        }

                        if (parseFloat(data) >= parseFloat(lower) && parseFloat(data) <= parseFloat(upper)) {
                            Result = true;
                        } else {
                            Result = false;
                        }
                        data = parseFloat(standardValue) + parseFloat(data);
                    }

                    //$("#txtRemark").val(($("#txtRemark").val() == "" ? $("#txtRemark").val() : $("#txtRemark").val() + ",") + data);
                }
                else {
                    alert('范围值不符合标准');
                    return false;
                }
                var now = new Date();
                date = now.format("yyyy-mm-dd HH:MM:ss");
                var entity =
                {
                    SerialNumber: "",
                    InputValue: data,
                    Result: Result,
                    CalcWay: -1,
                    InputValue1: data,
                    InputValue2: ""
                };
                showCalcResult(entity, 1);
                $("#btnChageValue").hide();
                e.preventDefault();
                $("#txtValue").val("").select();
                return false;
                //show(Result, "RangeValue", data);
                //$("#btnChageValue").hide();
                //e.preventDefault();
                //$("#txtRangeValue").select();
                //return false;
            }
        });

        $("#txtValue").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                //if ($.trim($("#txtGRN").val()) == "") {
                //    alert("请输入GRN");
                //    return false;
                //}
                if ($.trim($("#txtValue").val()) == "") {
                    alert("不能输入空值");
                    return false;
                }
                var GRN = $("#txtGRN").val();
                var Flag = true;
                var CurrentQty = 0;
                var Mark = 0;
                //for (var i = 0; i < GRNList.length; i++) {
                //    if (GRNList[i].GRN == GRN) {
                //        GRNList[i].Qty++;
                //        CurrentQty = GRNList[i].Qty;
                //        Mark = i;
                //        Flag = false;
                //    }
                //}
                //if (CurrentQty > GRNQty) {
                //    GRNList[Mark].Qty--;
                //    alert("检验次数大于GRN数量");
                //    $("#txtValue").select();
                //    return false;
                //}
                //if (Flag || GRNList.length <= 0) {
                //    var en = {};
                //    en.GRN = GRN;
                //    en.Qty = 1;
                //    GRNList.push(en);
                //}

                var Result = false;
                // InspectionMethodValue = $('#tbInspectionItem tr:eq(2)').find('td:eq(2)').text();
                InspectionMethodValue = $("#lblMethodValue").text();
                var data = $("#txtValue").val();
                if (InspectionMethodValue.indexOf("(") != -1) {
                    //散列值
                    var arr = InspectionMethodValue.replace('(', '').replace(')', '').split(',');
                    if ($.inArray(data, arr) == -1) {
                        Result = false;
                    } else {
                        Result = true;
                    }
                } else if (InspectionMethodValue.indexOf("[") != -1) {
                    //范围
                    var arr = InspectionMethodValue.replace('[', '').replace(']', '').split('~');
                    if (parseFloat(data) >= parseFloat(arr[0]) && parseFloat(data) <= parseFloat(arr[1])) {
                        Result = true;
                    } else {
                        Result = false;
                    }
                } else {
                    if (InspectionMethodValue.indexOf("±") != -1) {
                        var value = InspectionMethodValue.replace("±", '');
                        var val1 = parseFloat(value) - 1;
                        var val2 = parseFloat(value) + 1;

                        if (parseFloat(data) >= val1 && parseFloat(data) <= val2) {
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
                //$("#txtRemark").val(($("#txtRemark").val() == "" ? $("#txtRemark").val() : $("#txtRemark").val() + ",") + data);
                var now = new Date();
                date = now.format("yyyy-mm-dd HH:MM:ss");
                //show(Result, "Value", data);
                var entity =
                {
                    SerialNumber: "",
                    InputValue: data,
                    Result: Result,
                    CalcWay: -1,
                    InputValue1: data,
                    InputValue2: ""
                };
                showCalcResult(entity, 1);
                $("#btnChageValue").hide();
                e.preventDefault();
                $("#txtValue").val("").select();
                return false;
                //setTimeout(function () { $("#txtValue").focus().select(); }, 100);
            }
        });

        function show(data, flag, value) {
            var number = $("#tbDetail tbody tr").length + 1;
            //$("#tbInspectionItem tbody tr:gt(0) td:eq(6)").html(parseInt($("#tbInspectionItem tbody tr:gt(0) td:eq(6)").html()) + 1);
            //if (data) {
            //    $("#showresult").html("OK").css("color", "green");
            //    $("#tbInspectionItem tbody tr:gt(0) td:eq(7)").html(parseInt($("#tbInspectionItem tbody tr:gt(0) td:eq(7)").html()) + 1);
            //} else {
            //    $("#showresult").html("NG").css("color", "red");
            //    $("#tbInspectionItem tbody tr:gt(0) td:eq(8)").html(parseInt($("#tbInspectionItem tbody tr:gt(0) td:eq(8)").html()) + 1);
            //}
            //if ($("#tbInspectionItem tbody tr:gt(0):gt(0) td:eq(8)").html() >= judgeValue) {
            //    $("#tbInspectionItem tbody tr:gt(0) td:last").html("NG");
            //}

            if (data) {
                $("#showresult").html("OK").css("color", "green");
            } else {
                $("#showresult").html("NG").css("color", "red");
            }

            var tbody = $("#tbDetail tbody")[0];
            var tr = document.createElement("tr");
            tr = tbody.insertRow(0);
            tr.className = "ListTableOddRow";
            if (!data) {
                $(tr).css("color", "red");
            }
            //序号
            var td1 = document.createElement("td");
            td1.innerText = number;
            tr.appendChild(td1);

            //GRN
            var td2 = document.createElement("td");
            td2.innerText = $("#txtGRN").val();
            td2.className = "test-sn";
            tr.appendChild(td2);

            //value
            var td3 = document.createElement("td");
            td3.innerText = value;
            tr.appendChild(td3);

            ////Units
            //var td4 = document.createElement("td");
            //td4.innerText = Units;
            //tr.appendChild(td4);

            //OK?NG?
            var td5 = document.createElement("td");
            td5.innerText = (data ? "OK" : "NG");
            tr.appendChild(td5);

            //UserName
            var td6 = document.createElement("td");
            td6.innerText = userName;
            tr.appendChild(td6);

            //date
            var td7 = document.createElement("td");
            td7.innerText = date;
            tr.appendChild(td7);

            //descript
            var td8 = document.createElement("td");
            td8.innerText = value;
            tr.appendChild(td8);

            //delete
            var td9 = document.createElement("td");
            td9.innerHTML = "<a href='#' style='text-decoration: underline;' onclick='Del(this)'>删除</a>";
            tr.appendChild(td9);
        }

        //删除
        function Del(obj) {
            $("#showresult").html("");
            //行删除
            $(obj).closest("tr").remove();

            //序号重置
            $("#tbDetail tbody tr td.rownum").each(function (i) {
                $(this).text(i + 1);
            });

            //刷新检验项检验结果
            refreshInspectonItemReuslt();
        }

        //获取检验项检验结果
        function refreshInspectonItemReuslt() {
            var isOK = true;
            $("#tbDetail tbody tr td.test-result").each(function (i) {
                var result = $.trim($(this).text());
                if (result == "NG") {
                    isOK = false;
                    return false;
                }
            });
            $("#tbInspectionItem tbody tr td.result").text(isOK == true ? "OK" : "NG");

            //更新最大值、最小值、平均值
            refreshInspectionData();
        }

        //更新最大值、最小值、平均值
        function refreshInspectionData() {
            var maxValue = "";
            var minValue = "";
            var avgValue = "";
            var arr = [];
            var sum = 0;

            $("#tbDetail tbody tr td.test-val").each(function (i) {
                var val = parseFloat($.trim($(this).text()));
                arr.push(val);
                sum = sum.add(val);
            });

            if (arr.length > 0) {
                maxValue = Math.max.apply(Math, arr);
                minValue = Math.min.apply(Math, arr);
                avgValue = sum.div(arr.length);
            }

            $("#max-value").text(maxValue);//最大值
            $("#min-value").text(minValue);//最小值
            $("#avg-value").text(avgValue);//平均值
        }


        function Save() {
            if ((inspectionType == 7 && inspectionStatus !=1) || (inspectionType == 12 && inspectionStatus != 1) || (inspectionType == 13 && inspectionStatus != 1)
            ) {
                alert("检验单已检验，无法修改");
                return false;
            }

            var trList = $("#tbDetail tbody tr");
            if (trList.length <= 0) {
                alert("请先进行检验");
                return false;
            }

            //遍历
            var list = [];
            trList.each(function (i) {
                var result = $.trim($(this).find(".test-result").text()) == "OK" ? 1 : 0;
                list.push({
                    GRN: "",
                    TestValue: $.trim($(this).find(".test-val").text()),
                    Result: result,
                    Remark: "",
                    CalcWay: parseInt($.trim($(this).find(".calc-way").attr("calc-way"))),
                    InputValue1: $.trim($(this).find(".test-val").text()),//$.trim($(this).find(".test-val1").text()),
                    InputValue2: $.trim($(this).find(".test-val").text()),//$.trim($(this).find(".test-val2").text()),
                });
            });

            var entity = {};
            entity.InspectionOrderOATemplateDetailId = parseInt(inspectionOrderOATemplateDetailId);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.SaveInspectionGRN(entity, JSON.stringify(list));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var entity = getInspectionItemInfo();
            parent.InputGRNResultBckFunction(entity);
        }

        function changeValue(obj) {
            var InspectionMethodValue = $.trim($("#lblMethodValue").text());
            var Id = -1;

            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionTemplateEditValue.aspx?name=InspectionTemplateEditValue&value=" + InspectionMethodValue + "&Id=" + Id + "&UnitName=" + Units + "&OffsetUnitName=" + OffsetUnitName;
            dialog({ title: "<%=Resources.Pages.InspectionTemplateEditValue %>", src: openWinUrl, width: 500, height: 300 });
        }

        function GetValue(data, k, StandardUnit, OffsetUnit) {
            data = data.replace('&gt;', ">");
            data = data.replace('&lt;', "<");
            Units = StandardUnit;
            OffsetUnitName = OffsetUnit;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.ChangIQCInputGRNInfoMethodValue(InspectionItemId, data, Units, OffsetUnitName);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            $("#lblMethodValue").text(data);
            parent.SetMehodValue(data, InspectionItemId, InspectionTemplateId, Units, OffsetUnitName);

            InspectionMethodValue = data;
            if (data.indexOf("[") >= 0) {
                $("#range,#rangeMsg").css("display", "");
                if (OffsetUnitName != "" && Units != "" && OffsetUnitName != Units) {
                    $("#spMsg").html(UnitTransforMag(Units, OffsetUnitName));
                }
                else {
                    $("#rangeMsg").css("display", "none");
                }
                $("#Standard").css("display", "none");
            }
            else {
                $("#range,#rangeMsg").css("display", "none");
                $("#Standard").css("display", "");
            }
            closeDialog();
        }

        //显示标准单位和公差单位的内容消息
        function UnitTransforMag(UnitName, TransforUnitName) {
            var entity = UnitTransfor(UnitName, TransforUnitName);
            return "标准值单位:" + UnitName + ",  公差单位:" + TransforUnitName + ";   1" + UnitName + " = " + entity.TransforData.toString() + TransforUnitName + ";"
        }


        //获取标准单位和公差单位的换算实例
        function UnitTransfor(UnitName, TransforUnitName) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDictionaryData.GetUnitTransforByUnitAndTransfor(UnitName, TransforUnitName);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var entity = ajax.value;
            return entity;

        }

        //删除重录
        function Clears() {
            if ((inspectionType == 7 && inspectionStatus != 1) || (inspectionType == 12 && inspectionStatus != 1) || (inspectionType == 13 && inspectionStatus != 1)
            ) {
                alert("检验单已检验，无法修改");
                return false;
            }
            if (confirm("是否清除检验记录")) {
                var entity = {};
                entity.InspectionOrderOATemplateDetailId = parseInt(inspectionOrderOATemplateDetailId);
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.DeleteInspectionGRN(entity);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                //打开输入框
                $("input[type='text']").attr("disabled", false);
                $("#tbInspectionItem tbody tr td.result").text("OK");
                $("#tbDetail tbody").html("");
                $("#showresult").html("");
                $("#txtGRN").focus();

                var entity = getInspectionItemInfo();
                parent.InputGRNResultBckFunction(entity);
            }
            //if (confirm("是否清除检验记录")) {
            //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.DeleteIQCInputGRNInfo(InspectionItemId);
            //    if (ajax.error != null) {
            //        alert(ajax.error.Message);
            //        return false;
            //    }
            //    list = [];
            //    GRNList = [];
            //    $("#btnChageValue").show();
            //    $("#tbInspectionItem tbody tr[name='InpsectionRow']").remove();
            //    var str = "<tr class='ListTableOddRow' name='InpsectionRow'>"
            //        + "<td>" + InspectionItemName + "</td>"
            //        + "<td>" + InspectionMethodName + "</td>"
            //        + "<td><span id='lblMethodValue' class='lblMethodValue'>" + InspectionMethodValue + "</span>";
            //    str += isEidt == "True" ? "<input type='button' id='btnChageValue' value=' 修改 ' onclick='changeValue(this)' style='float:right;' />" : "";
            //    str += "<td><input type=\"text\" MaxLength=\"50\" value='" + (Units) + "' id='txtUnits' readonly='readonly' class=\"txtUnit\" style=\"width: 30px; \"/>"
            //        + "<input type=\"button\" onclick=\"selectUnit(this);\" class=\"ButtonBox\" value=\"...\" />" + "</td>"
            //        + "<td>" + CheckFashion + "</td>"
            //        + "<td>" + Sum + "</td>"
            //        + "<td>0</td>"
            //        + "<td>0</td>"
            //        + "<td>0</td>"
            //        + "<td>OK</td></tr>";
            //    $("#tbInspectionItem tbody").append(str);
            //    //打开输入框
            //    $("input[type='text']").attr("disabled", false);
            //    $("#tbDetail tbody tr").remove();
            //    $("#txtValue,#txtRangeValue,#txtRemark").val("");
            //    //$("#txtGRN").focus();
            //}
        }

        var dateFormat = function () {
            var token = /d{1,4}|m{1,4}|yy(?:yy)?|([HhMsTt])\1?|[LloSZ]|"[^"]*"|'[^']*'/g,
                timezone = /\b(?:[PMCEA][SDP]T|(?:Pacific|Mountain|Central|Eastern|Atlantic) (?:Standard|Daylight|Prevailing) Time|(?:GMT|UTC)(?:[-+]\d{4})?)\b/g,
                timezoneClip = /[^-+\dA-Z]/g,
                pad = function (val, len) {
                    val = String(val);
                    len = len || 2;
                    while (val.length < len) val = "0" + val;
                    return val;
                };

            // Regexes and supporting functions are cached through closure  
            return function (date, mask, utc) {
                var dF = dateFormat;

                // You can't provide utc if you skip other args (use the "UTC:" mask prefix)  
                if (arguments.length == 1 && Object.prototype.toString.call(date) == "[object String]" && !/\d/.test(date)) {
                    mask = date;
                    date = undefined;
                }

                // Passing date through Date applies Date.parse, if necessary  
                date = date ? new Date(date) : new Date;
                if (isNaN(date)) throw SyntaxError("invalid date");

                mask = String(dF.masks[mask] || mask || dF.masks["default"]);

                // Allow setting the utc argument via the mask  
                if (mask.slice(0, 4) == "UTC:") {
                    mask = mask.slice(4);
                    utc = true;
                }

                var _ = utc ? "getUTC" : "get",
                    d = date[_ + "Date"](),
                    D = date[_ + "Day"](),
                    m = date[_ + "Month"](),
                    y = date[_ + "FullYear"](),
                    H = date[_ + "Hours"](),
                    M = date[_ + "Minutes"](),
                    s = date[_ + "Seconds"](),
                    L = date[_ + "Milliseconds"](),
                    o = utc ? 0 : date.getTimezoneOffset(),
                    flags = {
                        d: d,
                        dd: pad(d),
                        ddd: dF.i18n.dayNames[D],
                        dddd: dF.i18n.dayNames[D + 7],
                        m: m + 1,
                        mm: pad(m + 1),
                        mmm: dF.i18n.monthNames[m],
                        mmmm: dF.i18n.monthNames[m + 12],
                        yy: String(y).slice(2),
                        yyyy: y,
                        h: H % 12 || 12,
                        hh: pad(H % 12 || 12),
                        H: H,
                        HH: pad(H),
                        M: M,
                        MM: pad(M),
                        s: s,
                        ss: pad(s),
                        l: pad(L, 3),
                        L: pad(L > 99 ? Math.round(L / 10) : L),
                        t: H < 12 ? "a" : "p",
                        tt: H < 12 ? "am" : "pm",
                        T: H < 12 ? "A" : "P",
                        TT: H < 12 ? "AM" : "PM",
                        Z: utc ? "UTC" : (String(date).match(timezone) || [""]).pop().replace(timezoneClip, ""),
                        o: (o > 0 ? "-" : "+") + pad(Math.floor(Math.abs(o) / 60) * 100 + Math.abs(o) % 60, 4),
                        S: ["th", "st", "nd", "rd"][d % 10 > 3 ? 0 : (d % 100 - d % 10 != 10) * d % 10]
                    };

                return mask.replace(token, function ($0) {
                    return $0 in flags ? flags[$0] : $0.slice(1, $0.length - 1);
                });
            };
        }();

        // Some common format strings  
        dateFormat.masks = {
            "default": "ddd mmm dd yyyy HH:MM:ss",
            shortDate: "m/d/yy",
            mediumDate: "mmm d, yyyy",
            longDate: "mmmm d, yyyy",
            fullDate: "dddd, mmmm d, yyyy",
            shortTime: "h:MM TT",
            mediumTime: "h:MM:ss TT",
            longTime: "h:MM:ss TT Z",
            isoDate: "yyyy-mm-dd",
            isoTime: "HH:MM:ss",
            isoDateTime: "yyyy-mm-dd'T'HH:MM:ss",
            isoUtcDateTime: "UTC:yyyy-mm-dd'T'HH:MM:ss'Z'"
        };

        // Internationalization strings  
        dateFormat.i18n = {
            dayNames: [
                "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat",
                "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
            ],
            monthNames: [
                "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
                "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
            ]
        };

        // For convenience...  
        Date.prototype.format = function (mask, utc) {
            return dateFormat(this, mask, utc);
        };

        //获取单位
        var rowObj1 = null;
        function selectUnit(obj) {
            rowObj1 = obj.parentElement.parentElement;
            var searchCondition = " DicProperty='Unit' ";
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=3&CallBackFunc=getChooseValuesselectUnit&PageCondition= " + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }
        function getChooseValuesselectUnit(list) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.ChangIQCInputGRNInfoUnit(InspectionItemId, list[0][1]);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            $(rowObj1).find(".txtUnit").val(list[0][1]);
            parent.SetUnitValue(list[0][1], InspectionItemId, InspectionTemplateId);
            closeDialog();
        }

        //浮点型加法运算
        Number.prototype.add = function (val) {
            var len = getPointLen(this, val);
            return ((this * len) + (val * len)) / len;
        }

        //浮点型减法运算
        Number.prototype.subtract = function (val) {
            var len = getPointLen(this, val);
            return ((this * len) - (val * len)) / len;
        }

        //获取小数点最大长度
        function getPointLen(val1, val2) {
            var len1, len2;
            try {
                len1 = val1.toString().split(".")[1].length;
            } catch (e) {
                len1 = 0;
            }
            try {
                len2 = val2.toString().split(".")[1].length;
            } catch (e) {
                len2 = 0;
            }
            return Math.pow(10, Math.max(len1, len2));
        }

        //除法运算。
        Number.prototype.div = function (arg) {
            return accDiv(this, arg);
        }

        //除法函数，用来得到精确的除法结果
        function accDiv(arg1, arg2) {
            var t1 = 0, t2 = 0, r1, r2;
            try { t1 = arg1.toString().split(".")[1].length } catch (e) { }
            try { t2 = arg2.toString().split(".")[1].length } catch (e) { }
            with (Math) {
                r1 = Number(arg1.toString().replace(".", ""));
                r2 = Number(arg2.toString().replace(".", ""));
                return (r1 / r2) * pow(10, t2 - t1);
            }
        }
    </script>
</asp:Content>
