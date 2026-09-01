<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="InspectionInputGRN.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionInputGRN" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table id="tbDtl1" class="ListTable" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;">
        <tbody>
            <tr class="ListTableOddRow">
                <td colspan="10" style="text-align: center; font-size: 20px; font-weight: 500">GRN检测结果录入</td>
            </tr>
            <tr class="ListTableHeader">
                <th>检验项目</th>
                <th width="60">录入方式</th>
                <th>判定标准</th>
                <th width="60">单位</th>
                <th>检验方法</th>
                <th width="80">需要检验个数</th>
                <th width="70">已检验个数</th>
                <th width="50">良数</th>
                <th width="50">不良数</th>
                <th width="50">结果</th>
            </tr>
        </tbody>
    </table>
    <div style="margin: 20px"></div>
    <div>
        <table class="EditeContentTable" width="70%" style="float: left">
            <tr>
                <td class="Label1">
                    <asp:Label ID="lbInspectionTypeName" runat="server" Text="GRN"></asp:Label><em>*</em>
                </td>
                <td class="Field1">
                    <input type="text" id="txtGRN" style="width:250px"/>
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
            <tr id="range" >
                <td class="Label1" style="align-self:center;text-align:right;" align="right">
                    <%--<asp:RadioButtonList ID="Label3" runat="server" RepeatDirection="Horizontal" Width="220px">
                        <asp:ListItem Text="实际测量值" Value="1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="偏差值" Value="2"></asp:ListItem>
                    </asp:RadioButtonList>--%>
                    <input type="radio" id="ActualValue" name="InputValue" checked="checked" />实际测量值<input type="radio" id="DeviationValue" name="InputValue" />公差值
                    <em>*</em><input type="hidden" id="hidValue" />
                </td>
                <td class="Field1">
                    <input type="text" id="txtRangeValue" />
                </td>
            </tr>
            <tr id="rangeMsg" >
                <td class="Label1" style="align-self:center;text-align:right;" align="right">                   
                </td>
                <td class="Field1">
                    <span id="spMsg" style="text-align:left;color:red;" ></span>
                </td>
            </tr>
            <tr>
                <td class="Label1">
                    <asp:Label ID="Label2" runat="server" Text="备注"></asp:Label>
                </td>
                <td class="Field1">
                    <input type="text" id="txtRemark" style="width:250px"/>
                </td>
            </tr>
        </table>
        <div id="showresult" style="float: right; width: 29%; height: 111px; font-size: 60px; text-align: center; color: green; font-weight: 800">
            OK
        </div>
    </div>
    <div style="margin: 150px"></div>
    <table id="tbDtl2" class="ListTable" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;">
        <thead>
            <tr class="ListTableHeader">
                <th style="width:5%">次数</th>
                <th style="width:20%">GRN</th>
                <th style="width:15%">测试值</th>
                <th style="width:5%">单位</th>
                <th style="width:6%">结果</th>
                <th style="width:10%">测试人</th>
                <th style="width:20%">测试时间</th>
                <th>备注</th>
                <th style="width:5%">操作</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <script type="text/javascript" src="../Content/js/skt.utility.datetime.js"></script>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/js/math.js"></script>
    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName %>";
        var userNo =  "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var list = [];
        var GRNList = [];
       
        (function ($) {
            $.getUrlParam = function (name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]); return null;
            }
        })(jQuery);
        var InspectionItemName = $.getUrlParam('InspectionItemName');
        var InspectionItemId = $.getUrlParam('InspectionItemId');//模板--检验项---Pid
        var InspectionMethodName = $.getUrlParam('InspectionMethodName');
        var InspectionMethodValue = $.getUrlParam('InspectionMethodValue');
        var CheckFashion = $.getUrlParam('CheckFashion');
        var Units = $.getUrlParam('UnitName') == "undefined" ? "" : $.getUrlParam('UnitName');
        var OffsetUnitName = $.getUrlParam('OffsetUnitName');
        var Sum = $.getUrlParam('Sum');
        var InspectionNo = $.getUrlParam('InspectionNo');
        var InspectionId = $.getUrlParam('InspectionId');
        var AcRc = $.getUrlParam('AcRc');
        var InspectionTemplateId = $.getUrlParam('InspectionTemplateId');
        var judgeValue = $.trim(AcRc.split('/')[1].substr(4, 6))//判断是否OK/NG的判断值
        var IQCStatus = $.getUrlParam('IQCStatus');//IQC检验单状态
        var isView = $.getUrlParam('isView');//是否查看 0：否 1：是 
        var GRNQty = 0;
        var isEidt = "<%= SKT.Common.Account.BLL.Users.CheckUserIsWarrantted(SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId,40170111)%>";
        $(function () {

            var str = "<tr class='ListTableOddRow' name='InpsectionRow'>"
                        + "<td>" + InspectionItemName + "</td>"
                        + "<td>" + InspectionMethodName + "</td>"
                        + "<td><span id='lblMethodValue' class='.lblMethodValue'>" + InspectionMethodValue + "</span>";
                        str += isEidt == "True" ? "<input type='button' id='btnChageValue' value=' 修改 ' onclick='changeValue(this)' style='float:right;' />" : "";
                        str += "<td><input type=\"text\" MaxLength=\"50\" value='" + (Units) + "' id='txtUnits' readonly='readonly' class=\"txtUnit\" style=\"width: 30px; \"/>"
                        + "<input type=\"button\" onclick=\"selectUnit(this);\" class=\"ButtonBox\" value=\"...\" /><input name=\"txtOffsetUnit\" type=\"hidden\" value=\"" + OffsetUnitName + "\" />" + "</td>"
                        + "<td>" + CheckFashion + "</td>"
                        + "<td>" + Sum + "</td>"
                        + "<td>0</td>"
                        + "<td>0</td>"
                        + "<td>0</td>"
                        + "<td>OK</td></tr>";
            $("#tbDtl1 tbody").append(str);
            //获取检验项
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetIQCInputGRNInfo(InspectionItemId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var data = ajax.value;
            if (data.length > 0) {
                $("input[type='text']").attr("disabled", "disabled");
                $("#btnChageValue").hide();
                for (var i = 0; i < data.length; i++) {
                    $("#tbDtl2 tbody").append("<tr class='ListTableOddRow' style='" + (data[i].DtlResult ? "" : "color:red") + "'><td>" + (data.length - i) + "</td><td>" + data[i].GRN + "</td><td>" + data[i].Value
                        + "</td><td>" + Units + "</td><td>" + (data[i].DtlResult ? "OK" : "NG")
                        + "</td><td>" + data[i].CreateBy + "</td><td>" + data[i].CreateDateTime + "</td><td>" + data[i].Remark + "</td><td></td></tr>");
                    if (data[i].DtlResult) {
                        $("#tbDtl1 tbody tr:gt(0) td:eq(7)").html(parseInt($("#tbDtl1 tbody tr:gt(0) td:eq(7)").html()) + 1);
                    } else {
                        $("#tbDtl1 tbody tr:gt(0) td:eq(8)").html(parseInt($("#tbDtl1 tbody tr:gt(0) td:eq(8)").html()) + 1);
                    }
                }
                if ($("#tbDtl1 tbody tr:gt(0):gt(0) td:eq(8)").html() >= judgeValue) {
                    $("#tbDtl1 tbody tr:gt(0) td:last").html("NG");
                    $("#showresult").html("NG").css("color", "red");
                } else {
                    $("#tbDtl1 tbody tr:gt(0) td:last").html("OK");
                    $("#showresult").html("OK").css("color", "green");
                }
                $("#tbDtl1 tbody tr:gt(0) td:eq(6)").html(data.length);


                //$(".toolbar-btn:eq(1)").css("display", "none");
            }
            //如果是查看，隐藏相关按钮、禁用文本框
            if(isView == 1){
                $("input").prop("disabled", true);
                $("#toolbar .toolbar-btn").hide();
            }

            if (InspectionMethodValue.indexOf("[") >= 0) {
                $("#range,#rangeMsg").css("display", "");
                if (OffsetUnitName != "" && Units != "" && OffsetUnitName != Units ) {
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

        $("#txtGRN").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                var GRN = $.trim($("#txtGRN").val());
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.uspIsIQCInputGRNInfo(InspectionNo, GRN);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                GRNQty = ajax.value;
                
                setTimeout(function () {
                    if (InspectionMethodValue.indexOf("[") != -1) {
                        $("#txtRangeValue").val("").focus();
                    }
                    else {
                        $("#txtValue").val("").focus();
                    }                   
                }, 10);
            }
        });
        $("#txtRangeValue").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                if ($.trim($("#txtGRN").val()) == "") {
                    alert("请输入GRN");
                    return false;
                }
                if ($.trim($("#txtRangeValue").val()) == "") {
                    alert("不能输入空值");
                    return false;
                }
                var GRN = $("#txtGRN").val();
                var Flag = true;
                var CurrentQty = 0;
                var Mark = 0;
                for (var i = 0; i < GRNList.length; i++) {
                    if (GRNList[i].GRN == GRN) {
                        GRNList[i].Qty++;
                        CurrentQty = GRNList[i].Qty;
                        Mark = i;
                        Flag = false;
                    }
                }
                if (CurrentQty > GRNQty) {
                    GRNList[Mark].Qty--;
                    alert("检验次数大于GRN数量");
                    $("#txtValue").select();
                    return false;
                }
                if (Flag || GRNList.length <= 0) {
                    var en = {};
                    en.GRN = GRN;
                    en.Qty = 1;
                    GRNList.push(en);
                }
                
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
                        if (math.number(data) >= math.number(math.add(math.bignumber(lower), math.bignumber(standardValue))) && math.number(data) <= math.number(math.add(math.bignumber(upper), math.bignumber(standardValue)))) {
                            Result = true;
                        } else {
                            Result = false;
                        }
                        //if (parseFloat(data) >= parseFloat(lower + standardValue) && parseFloat(data) <= parseFloat(upper + standardValue)) {
                        //    Result = true;
                        //} else {
                        //    Result = false;
                        //}
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

                    $("#txtRemark").val(($("#txtRemark").val() == "" ? $("#txtRemark").val() : $("#txtRemark").val() + ",") + data);
                }
                else {
                    alert('范围值不符合标准');
                    return false;
                }
                var now = new Date();
                date = now.format("yyyy-mm-dd HH:MM:ss");
                show(Result, "RangeValue", data);
                $("#btnChageValue").hide();
                e.preventDefault();
                $("#txtRangeValue").select();
                return false;

            }
        });

        $("#txtValue").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                if ($.trim($("#txtGRN").val()) == "") {
                    alert("请输入GRN");
                    return false;
                }
                if ($.trim($("#txtValue").val()) == "") {
                    alert("不能输入空值");
                    return false;
                }
                var GRN = $("#txtGRN").val();
                var Flag = true;
                var CurrentQty = 0;
                var Mark = 0;
                for (var i = 0; i < GRNList.length; i++) {
                    if (GRNList[i].GRN == GRN) {
                        GRNList[i].Qty++;
                        CurrentQty = GRNList[i].Qty;
                        Mark = i;
                        Flag = false;
                    }
                }
                if (CurrentQty > GRNQty) {
                    GRNList[Mark].Qty--;
                    alert("检验次数大于GRN数量");
                    $("#txtValue").select();
                    return false;
                }
                if (Flag || GRNList.length <= 0) {
                    var en = {};
                    en.GRN = GRN;
                    en.Qty = 1;
                    GRNList.push(en);
                }

                var Result = false;
                // InspectionMethodValue = $('#tbDtl1 tr:eq(2)').find('td:eq(2)').text();
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
                $("#txtRemark").val(($("#txtRemark").val() == "" ? $("#txtRemark").val() : $("#txtRemark").val() + ",") + data);
                var now = new Date();
                date = now.format("yyyy-mm-dd HH:MM:ss");
                show(Result, "Value", data);
                $("#btnChageValue").hide();
                e.preventDefault();
                $("#txtValue").select();
                return false;
                //setTimeout(function () { $("#txtValue").focus().select(); }, 100);
            }
        });

        function show(data, flag, value) {
            var number = $("#tbDtl2 tbody tr").length + 1;
            $("#tbDtl1 tbody tr:gt(0) td:eq(6)").html(parseInt($("#tbDtl1 tbody tr:gt(0) td:eq(6)").html()) + 1);
            if (data) {
                $("#showresult").html("OK").css("color", "green");
                $("#tbDtl1 tbody tr:gt(0) td:eq(7)").html(parseInt($("#tbDtl1 tbody tr:gt(0) td:eq(7)").html()) + 1);
            } else {
                $("#showresult").html("NG").css("color", "red");
                $("#tbDtl1 tbody tr:gt(0) td:eq(8)").html(parseInt($("#tbDtl1 tbody tr:gt(0) td:eq(8)").html()) + 1);
            }
            if ($("#tbDtl1 tbody tr:gt(0):gt(0) td:eq(8)").html() >= judgeValue) {
                $("#tbDtl1 tbody tr:gt(0) td:last").html("NG");
            }

            var tbody = $("#tbDtl2 tbody")[0];
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
            tr.appendChild(td2);

            //value
            var td3 = document.createElement("td");
            td3.innerText = value;
            tr.appendChild(td3);

            //Units
            var td4 = document.createElement("td");
            td4.innerText = Units;
            tr.appendChild(td4);

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

            //var value = $("#txtValue").val();
            //if (flag == "RangeValue") {
            //    value = $("#txtRangeValue").val();
            //}$("#txtRemark").val()
            //if ($("#tbDtl2 tbody tr").length == 1) {
                //$("#tbDtl2 tbody").append("<tr class='ListTableOddRow'><td>" + number + "</td><td>" + $("#txtGRN").val() + "</td><td>" + value + "</td><td>" + (data ? "OK" : "NG")
                //    + "</td><td>" + userName + "</td><td>" + date + "</td><td>" + value + "</td><td><a href='#' style='text-decoration: underline;' onclick='Del(this)'>删除</a></td></tr>");
            //}
            //else {
            //    $("#tbDtl2 tbody tr").insertBefore("<tr class='ListTableOddRow'><td>" + number + "</td><td>" + $("#txtGRN").val() + "</td><td>" + value + "</td><td>" + (data ? "OK" : "NG")
            //       + "</td><td>" + userName + "</td><td>" + date + "</td><td>" + value + "</td><td><a href='#' style='text-decoration: underline;' onclick='Del(this)'>删除</a></td></tr>");
            //}
            
        }

        function Del(obj) {
            $("#showresult").html("");

            var GRN = $(obj).parent().parent().find("td:eq(1)").html();
            var result = $(obj).parent().parent().find("td:eq(4)").html();
            var number = $(obj).parent().parent().find("td:eq(0)").html();

            //行删除
            $(obj).parent().parent().remove();
            //序号重置
            var $rows = $("#tbDtl2 tbody tr");
            for (var i = 0; i < $rows.length; i++) {
                $($rows[i]).find("td:first").html($rows.length - i);
            }
            //处理备注（手动修改后的备注不做处理）
            var remark = $("#txtRemark").val();
            var listRemark = remark.split(",");
            if (listRemark.length == $rows.length + 1) {
                listRemark.splice(number - 1, 1);
                $("#txtRemark").val(listRemark.join(","));
            }

            //已检数量修改
            $("#tbDtl1 tbody tr:gt(0):gt(0) td:eq(6)").html(parseInt($("#tbDtl1 tbody tr:gt(0):gt(0) td:eq(6)").html()) - 1);
            //
            if (result == "OK") {
                $("#tbDtl1 tbody tr:gt(0):gt(0) td:eq(7)").html(parseInt($("#tbDtl1 tbody tr:gt(0):gt(0) td:eq(7)").html()) - 1);
            } else {
                $("#tbDtl1 tbody tr:gt(0):gt(0) td:eq(8)").html(parseInt($("#tbDtl1 tbody tr:gt(0):gt(0) td:eq(8)").html()) - 1);
            }
            if ($("#tbDtl1 tbody tr:gt(0):gt(0) td:eq(8)").html() >= judgeValue) {
                $("#tbDtl1 tbody tr:gt(0) td:last").html("NG");
            } else {
                $("#tbDtl1 tbody tr:gt(0) td:last").html("OK");
            }
            //没有GRN时可修改设置
            $("#btnChageValue").show();
            for (var i = 0; i < GRNList.length; i++) {
                if (GRNList[i].GRN == GRN) {
                    GRNList[i].Qty--;                    
                }
                if (GRNList[i].Qty > 0) {
                    $("#btnChageValue").hide();
                }
            }             
        }

        function Save() {
            if (IQCStatus=="true") {
                alert("IQC检验单已保存，无法修改");
                return false;
            }
            var xjsl = parseInt($("#tbDtl1 tbody tr:gt(0) td:eq(5)").html());
            var yjsl = parseInt($("#tbDtl1 tbody tr:gt(0) td:eq(6)").html());
            if (yjsl < xjsl) {
                alert("检验数量小于需要检验数量，请继续检验");
                return false;
            }
            for (var i = 0; i < $("#tbDtl2 tbody tr").length; i++) {
                var $_tr = $($("#tbDtl2 tbody tr")[i])

                var ent = {};
                ent.Pid = InspectionItemId;
                ent.GRN = $_tr.find("td:eq(1)").html();
                ent.Value = $_tr.find("td:eq(2)").html();
                ent.Remark = $_tr.find("td:eq(7)").html();
                ent.Result = $_tr.find("td:eq(4)").html() == "OK" ? 1 : 0;
                ent.CreateBy = $_tr.find("td:eq(5)").html();
                ent.CreateDateTime = $_tr.find("td:eq(6)").html();                
                list.push(ent);
            }

            var result = $("#tbDtl1 tbody td:last").html();
            var en = {};
            en.Result = result == "OK" ? 2 : 1;
            en.Tab = JSON.stringify(list);
            en.MethodValue = $("#lblMethodValue").text();
            en.Remark = $("#txtRemark").val();
            en.ModifyBy = userNo;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.InsertIQCInputGRNInfoDtl(JSON.stringify(en));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = {};
            //entity.InspectionTemplateMemberId = InspectionItemId;
            entity.InspectionItemId = InspectionItemId;
            entity.list = list;
            entity.result = result;
            entity.Remark = $("#txtRemark").val();
            parent.InputGRNResultBckFunction(entity);
            //closeDialog();
        }
 
        function changeValue(obj) {
            var InspectionMethodValue = $.trim($("#lblMethodValue").text());
            var Id = -1;
            debugger
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
                if (OffsetUnitName != "" && Units != "" && OffsetUnitName != Units ) {
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
        function UnitTransforMag(UnitName, TransforUnitName)
        {
            if (TransforUnitName != "null")
            {
                var entity = UnitTransfor(UnitName, TransforUnitName);
                return "标准值单位:" + UnitName + ",  公差单位:" + TransforUnitName + ";   1" + UnitName + " = " + entity.TransforData.toString() + TransforUnitName + ";"
            }
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
            if (IQCStatus == "true") {
                alert("IQC检验单已保存，无法修改");
                return false;
            }
            if (confirm("是否清除检验记录")) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.DeleteIQCInputGRNInfo(InspectionItemId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                list = [];
                GRNList = [];
                $("#btnChageValue").show();
                $("#tbDtl1 tbody tr[name='InpsectionRow']").remove();
                var str = "<tr class='ListTableOddRow' name='InpsectionRow'>"
                       + "<td>" + InspectionItemName + "</td>"
                       + "<td>" + InspectionMethodName + "</td>"
                       + "<td><span id='lblMethodValue' class='.lblMethodValue'>" + InspectionMethodValue + "</span>";
                      str += isEidt == "True" ? "<input type='button' id='btnChageValue' value=' 修改 ' onclick='changeValue(this)' style='float:right;' />" : "";
                      str += "<td><input type=\"text\" MaxLength=\"50\" value='" + (Units) + "' id='txtUnits' readonly='readonly' class=\"txtUnit\" style=\"width: 30px; \"/>"
                       + "<input type=\"button\" onclick=\"selectUnit(this);\" class=\"ButtonBox\" value=\"...\" />" + "</td>"
                       + "<td>" + CheckFashion + "</td>"
                       + "<td>" + Sum + "</td>"
                       + "<td>0</td>"
                       + "<td>0</td>"
                       + "<td>0</td>"
                       + "<td>OK</td></tr>";
                $("#tbDtl1 tbody").append(str);
               // alert(11);
                //parent.getFormInfo();
               // alert(22);

                //打开输入框
                $("input[type='text']").attr("disabled", false);
                $("#tbDtl2 tbody tr").remove();
                $("#txtValue,#txtRangeValue,#txtRemark").val("");
                $("#txtGRN").focus();
            }
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
    </script>
</asp:Content>
