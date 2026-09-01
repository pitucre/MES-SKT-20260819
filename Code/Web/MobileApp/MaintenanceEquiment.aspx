<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaintenanceEquiment.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.MaintenanceEquiment" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>

    <title>PDA保养</title>
    <style type="text/css">
        .clear { clear: both; height: 2px; }

        body, label { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px !important; color: #1d1007; }

        table { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px !important; color: #1d1007; }

        .ui-table th, .ui-table td { text-align: center; vertical-align: middle !important; }

        .fold { font-weight: bolder; display: inline-block; margin-bottom: 5px; }

        .flex { width: 99%; display: flex; }

        .flex_t_l { width: 32.55% !important; }
            .flex_t_l span { margin-bottom: 6px; }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false">
        <div data-role="page" id="pageOne">
            <div data-role="header" id="header" data-position="fixed">
                <h5 style="padding: 4px; margin: 0px;">
                    <div>
                        <label style="font-size: 17px !important; font-weight: bold; color: #FFFFFF">PDA保养</label>
                    </div>
                </h5>
                <a href="" data-rel="back" data="" role="button" class="ui-btn-left" data-icon="back"
                    data-transition="none" data-ajax="false">返回</a> <a href="Index.aspx" class="ui-btn-right"
                        data-icon="home" data-transition="none" data-ajax="false">主页</a>
            </div>
            <div data-role="content" style="margin-top: 0px; padding: 0.5em" id="content1">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <label for="txtEquipmentCode">扫描设备编码</label>
                        </td>
                        <td>
                            <input type="text" id="txtEquipmentCode" androidscan="true" />
                        </td>
                    </tr>
                    <%--<tr>
                        <td>
                            <label for="txtProcedureNo">点检确认</label>
                        </td>
                        <td>
                            <a href="#fpanel" data-rel="popup" data-mini="true" data-position-to="window" data-role="button" style="margin-top: 22px" onclick="Confirm()">确认</a>
                        </td>
                    </tr>--%>
                </table>
                <div style="text-align: center; font-size: 14px" id="rmsg" class="msg">
                </div>
                <div id="msg" style="text-align: center;">
                </div>
                <%--<div data-role="content" style="overflow: scroll; padding: 0px;">--%>
                <table data-role="table" id="tbTransferItem" data-mode="columntoggle" class="ui-responsive table-stroke"
                    style="width: 100%; word-break: break-all;">
                    <thead>
                        <tr>
                            <th style="display: none;"></th>
                            <th>保养名称</th>
                            <th>作业编号</th>
                            <th>点检状态</th>
                            <th>作业名称</th>
                        </tr>
                    </thead>
                    <tbody id="tbody">
                    </tbody>
                </table>

                <table style="width: 100%">
                    <tr>
                        <%-- <td>
                            <label>上传图片</label>
                        </td>--%>
                        <td colspan="2">
                            <div class="layui-upload">
                                <button type="button" class="layui-btn androidTakePicture" style="background-color: #4E8CD4" ontakepicture="onTakePicture" id="test1">上传图片</button>
                                <div class="flex">
                                    <div class="flex_t_l" onclick="ImgPosition(1)">
                                        <div>
                                            <asp:Image runat="server" CssClass="layui-upload-img" ID="imgEquipment1" ClientIDMode="Static" />
                                        </div>
                                        <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady1" Style="display: block; width: 120px; overflow-wrap: break-word;" ForeColor="Red" fileName="">未载入</asp:Label>
                                    </div>
                                    <div class="flex_t_l" onclick="ImgPosition(2)">
                                        <div>
                                            <asp:Image runat="server" CssClass="layui-upload-img" ID="imgEquipment2" ClientIDMode="Static" />
                                        </div>
                                        <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady2" Style="display: block; width: 120px; overflow-wrap: break-word;" ForeColor="Red" fileName="">未载入</asp:Label>
                                    </div>
                                    <div class="flex_t_l" onclick="ImgPosition(3)">
                                        <div>
                                            <asp:Image runat="server" CssClass="layui-upload-img" ID="imgEquipment3" ClientIDMode="Static" />
                                        </div>
                                        <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady3" Style="display: block; width: 120px; overflow-wrap: break-word;" ForeColor="Red" fileName="">未载入</asp:Label>
                                    </div>
                                </div>
                                <div class="flex">
                                    <div class="flex_t_l" onclick="ImgPosition(4)">
                                        <div>
                                            <asp:Image runat="server" CssClass="layui-upload-img" ID="imgEquipment4" ClientIDMode="Static" />
                                        </div>
                                        <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady4" Style="display: block; width: 120px; overflow-wrap: break-word;" ForeColor="Red" fileName="">未载入</asp:Label>
                                    </div>
                                    <div class="flex_t_l" onclick="ImgPosition(5)">
                                        <div>
                                            <asp:Image runat="server" CssClass="layui-upload-img" ID="imgEquipment5" ClientIDMode="Static" />
                                        </div>
                                        <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady5" Style="display: block; width: 120px; overflow-wrap: break-word;" ForeColor="Red" fileName="">未载入</asp:Label>
                                    </div>
                                    <div class="flex_t_l" onclick="ImgPosition(6)">
                                        <div>
                                            <asp:Image runat="server" CssClass="layui-upload-img" ID="imgEquipment6" ClientIDMode="Static" />
                                        </div>
                                        <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady6" Style="display: block; width: 120px; overflow-wrap: break-word;" ForeColor="Red" fileName="">未载入</asp:Label>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>

                <%--</div>--%>
            </div>
            <div data-role="footer" data-position="fixed" data-theme="a">
                <div data-role="navbar" data-theme="none">
                    <ul>
                        <li><a class="StartCheck" onclick="Confirm()" data-role="button" data-fullscreen="true" data-theme="a">确认</a></li>
                    </ul>
                </div>
            </div>

            <div data-role="popup" id="popupDialog" data-dismissible="false" data-theme="b">
                <div data-role="header" data-theme="b">
                    <h2>备注信息</h2>
                </div>
                <div role="main" class="ui-content">
                    <textarea cols="40" rows="30" id="remark"></textarea>
                    <a id="sava-remark" href="#" class="ui-shadow ui-btn ui-corner-all ui-btn-inline ui-mini">保存</a>
                    <a href="#" data-rel="back" class="ui-shadow ui-btn ui-corner-all ui-btn-inline ui-mini">关闭</a>
                </div>
            </div>

        </div>
    </form>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <script type="text/javascript">
        var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var IsOkArry = {};
        /*Radio禁用*/
        var disable = "disabled='disabled'";
        /*Radio选中*/
        var checked = "checked='checked'";
        $(function () {
            $(".ui-body-c").css("background", "#fff");
            //隐藏columntoggle列表按钮
            $(".ui-table-columntoggle-btn").css("display", "none");
            $("#txtEquipmentCode").blur(function () { $(this).css("background-color", "white") }).focus(function () { $(this).css("background-color", "#FFFFCC").select() });
            $("#txtEquipmentCode").val("").focus();

            //折叠隐藏
            $("#tbody").on("click", ".fold", function () {
                showOrHideItem($(this));
            });

            ////弹框备注框
            //$("#tbody").on("click", ".radio-ng", function () {
            //    $("#popupDialog").popup("open");
            //});

            //保存备注
            $("#sava-remark").on("click", function () {
                var remark = $.trim($("#remark").val());
                var eid = $("#popupDialog").attr("EId");
                var demoSubId = $("#popupDialog").attr("DemoSubId");

                var ngObj = $(".radio-ng[EId=\"" + eid + "\"][DemoSubId=\"" + demoSubId + "\"]");
                if (ngObj.length == 0) {
                    alert("数据异常，未获取到点击的NG单选框");
                    return false;
                }
                ngObj.attr("Remark", remark);
                $("#popupDialog").popup("close");
            });


            //普通图片上传
            if (typeof (android) == "undefined") {
                layui.use('upload', function () {
                    var $ = layui.jquery, upload = layui.upload;

                    var uploadInst = upload.render({
                        elem: '#test1',
                        accept: 'images',
                        exts: 'jpg|jpge|gif|png|bmp',
                        size: 1024 * 10,//限制文件大小，单位 KB
                        url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx?Action=EquipmentMaintenance&userName=' + username,
                        before: function (obj) {
                            //预读本地文件示例，不支持ie8
                            obj.preview(function (index, file, result) {
                                //debugger;
                                $("#imgEquipment" + ImgCount).attr('src', result);//图片链接（base64）
                            });
                        },
                        done: function (res) {

                            //debugger;
                            //如果上传失败
                            if (res.code == 1) {
                                $("#lbFileReady" + ImgCount).text("上传失败！").attr("server-name", "").attr("fileName", "");
                                return;
                            }
                            //上传成功
                            $("#lbFileReady" + ImgCount).text(res.data.FileName).attr("server-name", res.data.src).attr("fileName", res.data.FileName);
                            if (ImgCount == 6) {
                                ImgCount = 1;
                            } else {
                                ImgCount++;
                            }

                        },
                        error: function () {
                            //debugger;

                            $("#lbFileReady" + ImgCount).text("上传失败！").attr("server-name", "").attr("fileName", "");
                        }
                    });
                });
            }

        });

        //折叠、隐藏
        function showOrHideItem(obj) {
            //var trObj = $(this).closest("tr");
            //var tdObj = $(this).closest("td");
            var trObj = obj.closest("tr");
            var tdObj = obj.closest("td");
            var eId = trObj.attr("EId");
            var demoId = trObj.attr("DemoId");

            var len = $("#tbody tr[EId=\"" + eId + "\"][DemoId=\"" + demoId + "\"]").length;
            if (len > 0) {
                if (trObj.next().is(":visible")) {
                    tdObj.attr("rowspan", 1);
                    trObj.nextAll("tr[EId=\"" + eId + "\"][DemoId=\"" + demoId + "\"]").hide();
                } else {
                    tdObj.attr("rowspan", len);
                    trObj.nextAll("tr[EId=\"" + eId + "\"][DemoId=\"" + demoId + "\"]").show();
                }
            }
        }


        // 判断radio是否全选
        $(document).on('click', "input[type='radio']", function () {
            var identity = $(this).data("identity");

            if (!!identity) {
                var flag = true;
                $("input[type='radio']").each(function () {
                    if ($(this).data("identity") == identity && $(this).val() == "0" && !$(this).prop("checked")) {
                        flag = false;
                    }
                });
                $("#" + identity).prop("checked", flag);
            }
        });

        //验证设备编码
        $("#txtEquipmentCode").on("keydown", function () {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                $("#msg").html("");
                var EquipmentCodeNo = $.trim($("#txtEquipmentCode").val());
                if (EquipmentCodeNo == "") {
                    $("#msg").html("请扫描设备编码！").css("color", "red");
                    $("#txtEquipmentCode").val("").focus();
                    return false;
                }

                //验证设备编码
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenancRelation.PDA_GetMyRelationList(EquipmentCodeNo, 0);
                if (ajax.error != null) {
                    var html = "";
                    $("#msg").html(ajax.error.Message).css("color", "red");
                    $("#txtEquipmentCode").val("").focus();
                    var tbody = $("#tbody");
                    tbody.html("");
                    html += "<tr id='trNoInfo' class='ListTableOddRow'><td colspan='6' style='text-align: center;'>暂无数据</td></tr>";
                    tbody.append(html);
                    return false;
                }
                BindTable(ajax);
            }
        });

        function ClickOKRd(id, demoid, demoSubId, maintainWay, obj) {
            var key = id + "-" + demoid + "-" + demoSubId + "-" + maintainWay;
            if (Object.keys(IsOkArry).includes(key)) {
                IsOkArry[key] = 0
            } else {
                Object.assign(IsOkArry, { [key]: 0 });
            }
        }

        function ClickNGRd(id, demoid, demoSubId, maintainWay, obj) {
            var key = id + "-" + demoid + "-" + demoSubId + "-" + maintainWay;
            if (Object.keys(IsOkArry).includes(key)) {
                IsOkArry[key] = 1
            } else {
                Object.assign(IsOkArry, { [key]: 1 });
            }
            $("#remark").val("");
            $("#popupDialog").popup("open").attr("EId", id).attr("DemoSubId", demoSubId);
        }

        function ClickNARd(id, demoid, demoSubId, maintainWay, obj) {
            var key = id + "-" + demoid + "-" + demoSubId + "-" + maintainWay;
            if (Object.keys(IsOkArry).includes(key)) {
                IsOkArry[key] = -1
            } else {
                Object.assign(IsOkArry, { [key]: -1 });
            }
        }

        /*通过计划id获取保养项目列表*/
        function GetDemoListByPlanId(eid) {
            var myajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenancRelation.GetMyRelationList(eid, 1);
            if (myajax.error != null) {
                alert(myajax.error.Message);
                return false;
            }
            BindTable(myajax);
        }

        function OKRdCheckAll(obj, identity) {
            var radios = $('input[type="radio"]');
            var isChecke = obj.checked;
            radios.each(function () {
                var el = $(this);
                var data = el.data("identity");

                // val()=0 表示是OK按钮
                var isrdOK = el.val() == "0";
                if (identity == data && isrdOK) {
                    var rdID = el.data("rdid");
                    var demoID = el.data("demoid");
                    var demoSubId = el.data("demosubid");
                    var maintainWay = el.data("maintainway");

                    // 勾选了全部选中
                    if (isChecke) {
                        ClickOKRd(rdID, demoID, demoSubId, maintainWay);
                    } else {
                        ClickNARd(rdID, demoID, demoSubId, maintainWay);
                    }
                    el.prop('checked', isChecke);
                }
            });
        }

        /*绑定table*/
        function BindTable(ajax) {
            if (ajax != null) {
                var tbody = $("#tbody");
                tbody.html("");
                var html = "";
                var btnHtml = "";
                var demoID;
                var demoSubId;
                var maintainWay;
                var objTd;
                var objTdWay;
                var count = 0;
                var countWay = 0;

                var arrItem = [];
                for (var i = 0; i < ajax.value.Rows.length; i++) {
                    html = "";
                    var hideHtml = "";
                    if (arrItem.indexOf(ajax.value.Rows[i].DemoId) > -1) {
                        hideHtml = "display:none;";
                    }

                    Id = ajax.value.Rows[i].EId;
                    demoID = ajax.value.Rows[i].DemoId;
                    demoSubId = ajax.value.Rows[i].DemoSubId;
                    maintainWay = ajax.value.Rows[i].MaintainWay;

                    //html += "<tr class='ListTableOddRow' name='tr" + ajax.value.Rows[i].DemoId + "' style=\"" + hideHtml + "\">";
                    html += "<tr class='ListTableOddRow' name='tr" + ajax.value.Rows[i].DemoId + "' EId='" + Id + "' DemoId='" + ajax.value.Rows[i].DemoId + "'>";

                    arrItem.push(demoID);

                    objTdWay = $("#td_" + Id + "_way_" + maintainWay);
                    if (parseInt(objTdWay.length) <= 0 || objTdWay == null) {
                        countWay = 0;
                        for (var j = 0; j < ajax.value.Rows.length; j++) {
                            if (("" + ajax.value.Rows[j].EId + ajax.value.Rows[j].MaintainWay) == ("" + Id + maintainWay)) {
                                countWay += 1;
                            }
                        }

                        html += countWay > 1 ? "<td id='td_" + Id + "_way_" + maintainWay + "' rowspan='" + countWay + "' style=\"display:none\">" : "<td id='td_" + Id + "_way_" + maintainWay + "' style=\"display:none\">";

                        switch (maintainWay) {
                            case 1:
                                html += "时间类型";
                                break;
                            case 2:
                                html += "次数类型";
                                break;
                            case 3:
                                html += "时间/次数类型";
                                html += "<br />";
                                html += "<input type='radio' name='timeFrequency' value='1' checked=\"checked\"/>时间";
                                html += "<input type='radio' name='timeFrequency' value='2' />次数";
                                break;
                        }
                        html += "</td>";

                    }

                    objTd = $("#td_" + Id + demoID);
                    if (parseInt(objTd.length) <= 0 || objTd == null) {
                        count = 0;
                        for (var j = 0; j < ajax.value.Rows.length; j++) {
                            if (("" + ajax.value.Rows[j].EId + ajax.value.Rows[j].DemoId) == ("" + Id + demoID)) {
                                count += 1;
                            }
                        }
                        var identity = "rd" + Id + demoID + maintainWay;
                        html += count > 1 ? "<td id='td_" + Id + demoID + "' rowspan='" + count + "'  >" : "<td id='td_" + Id + demoID + "'>";
                        html += "<span class=\"fold\">" + ajax.value.Rows[i].DemoName + "</span>";
                        html += '<br />全选<input type="checkbox" id="' + identity + '" name="okRdCheck" onclick=OKRdCheckAll(this,"' + identity + '") />';
                        html += "</td>";
                    }

                    //作业编码
                    html += "<td style='text-align:center;'>";
                    html += ajax.value.Rows[i].DemoCode;
                    html += "</td>";

                    //点检状态
                    html += "<td style='text-align:center;'>";
                    html += "<input type='radio' data-maintainway='" + maintainWay + "' data-rdid='" + Id + "' data-demoid='" + demoID + "' data-demosubid='" + demoSubId + "' data-identity=" + "rd" + Id + demoID + maintainWay + " name='rd" + Id + demoID + "and" + demoSubId + "'  id='rdOk" + demoID + "and" + demoSubId + "' value='0' onclick='ClickOKRd(" + Id + "," + demoID + "," + demoSubId + "," + maintainWay + ",this)'";
                    html += "/>OK";

                    html += "<input type='radio' class=\"radio-ng\" EId='" + Id + "' DemoSubId='" + demoSubId + "' Remark='' data-maintainway='" + maintainWay + "' name='rd" + Id + demoID + "and" + demoSubId + "'" + "' data-identity=" + "rd" + Id + demoID + maintainWay + " id='rdNg" + demoID + "and" + demoSubId + "' value='1' onclick='ClickNGRd(" + Id + "," + demoID + "," + demoSubId + "," + maintainWay + ",this)'";
                    html += "/>NG";

                    //html += "<input type='radio' data-maintainway='" + maintainWay + "' name='rd" + Id + demoID + "and" + demoSubId + "'" + "' data-identity=" + "rd" + Id + demoID + maintainWay + " id='rdNa" + demoID + "and" + demoSubId + "' value='-1' onclick='ClickNARd(" + Id + "," + demoID + "," + demoSubId + "," + maintainWay + ",this)'";
                    //html += "/>N/A";
                    html += "</td>";

                    //作业名称
                    html += "<td style='text-align:center;'>";
                    html += ajax.value.Rows[i].DemoSubName;
                    html += "</td>";
                    html += '</tr>';
                    tbody.append(html);
                }

                //折叠、隐藏
                $(".fold").each(function () {
                    showOrHideItem($(this));
                });
            }
        }

        //保存
        function Confirm() {
            $("#msg").html("");
            var equipmentCodeNo = $.trim($("#txtEquipmentCode").val());
            if (equipmentCodeNo == "") {
                $("#msg").html("请扫描设备编码！").css("color", "red");
                $("#txtEquipmentCode").val("").focus();
                return false;
            }

            var maintenanceImg1 = $("#lbFileReady1").attr("fileName");
            var maintenanceImg2 = $("#lbFileReady2").attr("fileName");
            var maintenanceImg3 = $("#lbFileReady3").attr("fileName");
            var maintenanceImg4 = $("#lbFileReady4").attr("fileName");
            var maintenanceImg5 = $("#lbFileReady5").attr("fileName");
            var maintenanceImg6 = $("#lbFileReady6").attr("fileName");

            if (confirm("确认操作？")) {
                var flag = false;
                var maintains = [];

                for (var key in IsOkArry) {
                    // 0: OK 1:NG 至少勾选一条OK或者NG的数据
                    if (IsOkArry[key] == 0 || IsOkArry[key] == 1) {
                        flag = true;

                        var arr = key.split('-');
                        var planID = arr[0];
                        var demoId = arr[1];
                        var demoSubId = arr[2];
                        var maintainWay = arr[3];
                        var isDone = 1;
                        var isOK = IsOkArry[key];
                        //var ngObj = $(".radio-ng[EId=\"" + eid + "\"][DemoSubId=\"" + demoSubId + "\"]");
                        var remark = $(".radio-ng[EId=\"" + planID + "\"][DemoSubId=\"" + demoSubId + "\"]").attr("Remark");

                        var maintain = {};
                        maintain["PlanID"] = planID;
                        maintain["DemoID"] = demoId;
                        maintain["DemoSubID"] = demoSubId;
                        maintain["MaintainWay"] = maintainWay;
                        maintain["IsDone"] = isDone;
                        maintain["IsOK"] = isOK;
                        maintain["Remark"] = remark;

                        // maintainWay 为时间/次数类型
                        if (maintainWay == 3) {
                            var check = true;
                            var element = $('[name="timeFrequency"]');
                            if (!!element) {
                                for (var i = 0; i < element.length; i++) {
                                    if (element[i].checked) {
                                        check = false;
                                        maintain["MaintainWay"] = element[i].value;
                                        break;
                                    }
                                }

                                if (check) {
                                    confirmDialogFocus("时间/次数类型必须勾选其中一项！", function () { });
                                    return;
                                }
                            }
                        }

                        maintains.push(maintain);
                    }
                }

                if (!flag) {
                    confirmDialogFocus("至少勾选一条OK或者NG的数据！", function () { });
                    return false;
                }

                var arrImg = [];
                arrImg.push(maintenanceImg1);
                arrImg.push(maintenanceImg2);
                arrImg.push(maintenanceImg3);
                arrImg.push(maintenanceImg4);
                arrImg.push(maintenanceImg5);
                arrImg.push(maintenanceImg6);
                var serverImageNames = arrImg.join(",");

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenancRelation.MaintainDemoBatch(equipmentCodeNo, maintains, serverImageNames);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                alert("操作成功！");
                $("#tbody").html("");
                $("#txtEquipmentCode").val("");
                IsOkArry = {};
                window.location.reload();
            }
        }


        var ImgCount = 1;
        function ImgPosition(count) {
            ImgCount = count;
        }
        //安卓拍照图片上传
        function onTakePicture(content, name) {
            let file = this.base64toFile(content, name);
            let fileData = new FormData();
            fileData.append('file', file);
            $.ajax({
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx?Action=EquipmentMaintenance&userName=' + username,
                type: "POST",
                data: fileData,
                cache: false,
                processData: false,  // 不处理数据
                contentType: false,   // 不设置内容类型
                dataType: "json",
                success: function (res) {
                    //如果上传失败
                    if (res.code == 1) {
                        $("#lbFileReady" + ImgCount).text("上传失败！").attr("server-name", "").attr("fileName", "");
                        return;
                    }
                    $("#imgEquipment" + ImgCount).attr('src', content);
                    //上传成功
                    $("#lbFileReady" + ImgCount).text(res.data.FileName).attr("server-name", res.data.src).attr("fileName", res.data.FileName);
                    if (ImgCount == 6) {
                        ImgCount = 1;
                    } else {
                        ImgCount++;
                    }
                },
                error: function () {
                    $("#lbFileReady" + ImgCount).text("上传失败！").attr("server-name", "").attr("fileName", "");
                }
            });
        }

    </script>
</body>
</html>

