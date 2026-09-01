<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseCpOutStock.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseCpOutStock"
    Title="WarehouseCpOutStock List Page" %>

<%@ MasterType VirtualPath="~/Masters/ViewMaster.master" %>
<asp:Content ID="Content3" ContentPlaceHolderID="viewcontent" runat="Server">
    <style>
        #divProductSummaryInfo { font-size: 14px; }
    </style>
    <div>
        <%--查询模块--%>
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">
                    <%= Resources.lang.DN %>
                </td>
                <td class="Field2">
                    <input type="hidden" value="" id="hdnDN" />
                    <input type="text" id="txtDN" class="TextBox" disabled="disabled"  style="width: 70%;"/>
                    <input type="button" id="Button1" class="ButtonBox" value="..." onclick="selectSalOrder()"  />
                </td>
                <td class="Label2">上传文件</td>
                <td class="Field2">
                    <input type="file" name="fileUpload" id="fileUpload" style="width: 73px;" />
                    <%-- <div id="fileQueue"> </div>--%>
                </td>
            </tr>
        </table>
    </div>
    <div class="clear5">
    </div>
    <div>
        <table class="EditeContentTable" width="100%">
            <tr>
                <td style="width: 50%;">
                    <div class="divHeader" style="margin: -1px 0px 0px -1px;">
                        <span>备货单信息</span><label class="jslblProduct lblprompt"></label>
                    </div>
                    <div id="divProductSummaryInfo" runat="server" clientidmode="Static" class="InfoTable"
                        style="overflow-x: hidden; height: 150px; margin-left: 5px;">
                    </div>
                </td>
                <td style="width: 50%;">
                    <div class="divHeader" style="margin: -1px -1px 0px 9px;">
                        <span>附件信息</span><label class="jslblProduct lblprompt"></label>
                    </div>
                    <div id="divAttach" runat="server" clientidmode="Static" class="InfoTable"
                        style="overflow-x: hidden; height: 150px;">
                         <table id="tbAttach" class="ListTable" style="width: 100%;margin: 0px 0px 0px 9px;display:none;">
                        <thead>
                            <tr class="ListTableHeader">
                                <th style="width:60px;text-align:center;" >序号
                                </th>
                                <th style="text-align:center;">附件名
                                </th>
                                <th style="width:70px;text-align:center;">操作
                                </th>
                            </tr>
                        </thead>
                        <tbody id="tbodyAttach">
                        </tbody>
                    </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div class="clear5">
    </div>
    <div id="msg" style="text-align: center; font-size: 14px">
    </div>
    <%--产品信息下半部 --%>
    <div class="divBottom" style="width: 49%; float: left;">
        <table class="ListTable" width="100%" id="divProductHistoryRPT">
            <thead>
                <tr class="ListTableHeader">
                    <th style="width: 15%">
                        <%=Resources.lang.LineNo%>
                    </th>
                    <th style="width: 15%">
                        <%=Resources.lang.SalOrder%>
                    </th>
                    <th style="width: 20%">成品编码
                    </th>
                    <th style="width: 20%">成品名称
                    </th>
                    <th style="width: 15%">
                        <%=Resources.lang.PlanOutQty %>
                    </th>
                    <th style="width: 15%">
                        <%=Resources.lang.CurrentQty%>
                    </th>
                    <th style="width: 15%">
                        <%=Resources.lang.CarNo%>
                    </th>
                    <th style="width: 15%">
                        <%=Resources.lang.HGNo%>
                    </th>
                    <th style="width: 15%">
                        <%=Resources.lang.SealNo%>
                    </th>
                    <th style="width: 15%">
                        <%=Resources.lang.Remark%>
                    </th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div style="width: 49%; float: right" id="rightRequest">
        <table style="width: 100%;" class="EditeContentTable">
            <tr>
                <td colspan="2">
                    <div class="ListTableTitle" style="border: 0px;">
                        <span>扫描类型</span>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="Label1" style="width: 20%;"> <span>扫描类型</span>
                </td>
                <td class="Field1">
                    <input id="rdSN" type="radio" class="radio" name="sacntype" value="0" />
                    <span>SN</span>
                    <input id="rdXDSN" type="radio" class="radio" name="sacntype" value="3" />
                    <span>客户SN</span>
                    <input id="rdCon" type="radio" class="radio" name="sacntype" value="1" checked />
                    <span>卡通箱</span>
                    <input id="rdPl" type="radio" class="radio" name="sacntype" value="2" />
                   <span>栈板</span>
                    <input id="rdGRN" type="radio" class="radio" name="sacntype" value="-1" />
                    <span>GRN</span>
                </td>
            </tr>
            <tr id="grntr">
                <td class="Label1"  style="width: 20%;">扫描条码
                </td>
                <td class="Field1">
                    <input type="text" id="txtGRN" class="TextBox" style="width: 70%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                </td>
            </tr>
        </table>
        <div class="clear5">
        </div>
        <div style="height: 200px">
            <table id="SacnInfo" class="ListTable" style="width: 100%">
                <thead>
                    <tr class="ListTableHeader">
                        <th>条码
                        </th>
                        <th>数量
                        </th>
                        <th>删除
                        </th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        <%--var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";--%>
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var jsonStatus = [{ text: "Active", value: 0 }, { text: "Created", value: 1 }, { text: "Deleted", value: 2 }, { text: "InActive", value: 3 }, { text: "Processing", value: 4 }];
        var SalOrderID = '';//备货单ID
        //erp表中的备货单同步到MES表中
        function StockUp() {
            $("#txtDN").val();
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Warehouse/WarehouseCpOutStockUp.aspx?rnd=" + Math.random(), width: 700, height: 400 });
        }
        $("input[name='sacntype']:checked").change(function () { $("#txtGRN").val("").focus() });
        /*获取备货单列表*/
        function GetSalOrderList(code) {
            $("#msg").html('');
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.GetSalOrderList(code);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (ajax.value == null) {
                return;
            }
            $("#divProductSummaryInfo").html('');
            var list = ajax.value;
            var Status = '';
            switch (list[0].Status) {
                case 1:
                    Status = '备货中';
                    break
                case 2:
                    Status = '备货完成';
                    break
                case 3:
                    Status = '已检验';
                    break
                case 4:
                    Status = '已出货';
                    break
            }
            var innerhtml3 = "";
            innerhtml3 += "<table>"
                + "<tr style='display:none'><td>" + list[0].SalOrderID + "</td></tr>"
                + "<tr><td><%=Resources.lang.DNCode %>：</td><td>" + list[0].DNCode + "</td></tr>"
                + "<tr><td><%= Resources.lang.Status%>：</td><td>" + Status + "</td></tr>"
                + "<tr><td><%=Resources.lang.BackERPStatus%>：</td><td>" + list[0].BackERPStatus + "</td></tr>"
            <%--+ "<tr><td><%=Resources.lang.ClientCode %>：</td><td>" + list[0].CusCode + "</td></tr>"--%>
                + "<tr><td><%=Resources.lang.ClientName %>：</td><td>" + list[0].CusName + "</td></tr>"
                + "<tr><td><%= Resources.lang.ClientAddress%>：</td><td colspan='3'>" + GetValueStr(list[0].Address) + "</td></tr>"
                + "<tr><td><%=Resources.lang.SalOrderDate%>：</td><td>" + getDateString(list[0].SalOrderDate) + "</td></tr>"
                + "<tr><td><%=Resources.lang.CreateBy%>：</td><td>" + list[0].CreateBy + "</td><td><%=Resources.lang.CreateDateTime%>：</td><td>" + getDateString(list[0].CreateDateTime) + "</td></tr>"
                + "<tr><td><%=Resources.lang.DNModifyBy%>：</td><td>" + getStrVal(list[0].StockConfirmBy) + "</td><td><%=Resources.lang.DNModifyDateTime%>：</td><td>" + getDateString(list[0].StockConfirmTime) + "</td></tr>"
                <%--+ "<tr><td><%=Resources.lang.DNFinishBy%>：</td><td>" + list[0].FinishBy + "</td><td><%=Resources.lang.DNFinishDateTime%>：</td><td>" + (list[0].FinishDateTime.toLocaleDateString() == '9999/12/31' ? '' : list[0].FinishDateTime.toLocaleDateString()) + "</td></tr>"--%>
                + "</table>";
            $("#divProductSummaryInfo").html(innerhtml3);
            GetSalOrderDtlList(list[0].SalOrderID);
        }

        function getStrVal(str) {
            var val = "";
            if (str) {
                val = str;
            }
            return val;
        }

        /*获取备货单详情列表*/
        function GetSalOrderDtlList(Order) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.GetSalOrderDtlList(Order);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list1 = ajax.value;
        
            var innerhtml4 = "";
            for (var i = 0; i < list1.length; i++) {
                var trclass = '';
                if (i % 2 == 0) {
                    trclass = 'ListTableOddRow';
                } else {
                    trclass = 'ListTableEvenRow';
                }
                //innerhtml4 += "<tr onclick=clik(this) class='" + trclass + "'><td>" + list1[i].SalOrderDtlID + "</td>"
                innerhtml4 += "<tr onclick=clik(this) class='" + trclass + "' SalOrderDtlID=\"" + list1[i].SalOrderDtlID + "\"><td>" + list1[i].SalorderItem + "</td>"

                    + "<td style=word-break:break-all;width:40px;height:100px'>" + list1[i].SalOrderNo + "</td>"
                    + "<td>" + list1[i].ItemCode + "</td>"
                    + "<td title='" + list1[i].ItemName + "'>" + list1[i].ItemName.slice(0, 5) + "</td>"
                    + "<td>" + list1[i].PlanQty + "</td>"
                    + "<td>" + list1[i].CurrentQty + "</td>"
                    + "<td>" + list1[i].CarNo + "</td>"
                    + "<td>" + list1[i].ContainerNo + "</td>"
                    + "<td>" + list1[i].SealNo + "</td>"
                    + "<td>" + list1[i].Remark + "</td></tr>";
            }
            $("#divProductHistoryRPT tbody").html("");
            $("#divProductHistoryRPT tbody").html(innerhtml4);
        }
        /*扫描条码*/
        $("#txtGRN").keydown(function () {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                $("#msg").html('');
                if (SalOrderID == '' || SalOrderID == null) {
                    alert('请选择备货单！');
                    return false;
                }
                var scanType = $("input[name='sacntype']:checked").val();
                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.ScanSave($("#txtDN").val(), $("#txtGRN").val(), scanType, userName);
                //if (ajax.error != null) {
                //    alert(ajax.error.Message);
                //    return false;
                //}
                var sn = $.trim($("#txtGRN").val());
                if (sn == "") {
                    showMsg("请扫描条码", 0);
                    $("#txtGRN").val("").focus();
                    return false;
                }

                var entity =
                {
                    DNCode: $.trim($("#txtDN").val()),
                    SerialNumber: sn,
                    ScanType: scanType,
                    ModifyBy: userName,
                };
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspFinishProductOutStorageScan", JSON.stringify(entity));
                if (ajax.error != null) {
                   
                    showMsg(ajax.error.Message, 0);
                    $("#txtGRN").val("").focus();
                    return false;
                }

                $("#msg").html('扫描成功').css('color', "#00FF00")
                //刷新备货单物料详情信息
                GetSalOrderDtlList(SalOrderID);
                $("#txtGRN").val("").focus();

                //检测是否备货完成(备货完成确认)
                var flag = true;
                $("#divProductHistoryRPT tbody tr").each(function (i, j) {
                    var planqty = $(j).find("td:eq(4)").html();
                    var qty = $(j).find("td:eq(5)").html();
                    if (planqty != qty) {
                        flag = false;
                    }
                });
                if (flag && $("#divProductSummaryInfo tr:eq(2) td:eq(1)").html() == '备货中') {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.Stocking(SalOrderID, userName);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    alert('备货完成！');
                    GetSalOrderList(SalOrderID);
                }
            }
        });
        //获取扫描记录
        function GetSalOrderDtlMemberList(No) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.GetSalOrderDtlMemberList(No);
            if (ajax.error != null) {
                alert(ajax.error.Message);
            }
          
            $("#SacnInfo tbody").html('');
            var htmlstr = "";
            for (var i = 0; i < ajax.value.length; i++) {
                if (i % 2 == 0) {
                    htmlstr += "<tr class='ListTableEvenRow' id='" + ajax.value[i].ID + "'><td class=\"serial-number\" serial-number=\"" + ajax.value[i].Number + "\">" + ajax.value[i].Number + "</td><td>" + ajax.value[i].Qty + "</td><td><img src='../Content/images/delete.gif' onclick='imfclk(this)'></img></td></tr>";
                } else {

                    htmlstr += "<tr class='ListTableOddRow' id='" + ajax.value[i].ID + "'><td class=\"serial-number\" serial-number=\"" + ajax.value[i].Number + "\">" + ajax.value[i].Number + "</td><td>" + ajax.value[i].Qty + "</td><td><img src='../Content/images/delete.gif' onclick='imfclk(this)'></img></td></tr>";
                }

            }
            $("#SacnInfo tbody").html(htmlstr);
        }


        //物料点击事件 获取扫描历史信息
        var clik = function (data) {
            $("#divProductHistoryRPT tbody tr").removeAttr('style');
            $(data).css('background-color', '#FFEFDB');
            // var id = $(data).find("td:eq(0)").html();
            var id = $(data).attr("SalOrderDtlID");
            GetSalOrderDtlMemberList(id);
        }
        //删除条码事件
        var imfclk = function (t) {
            $("#msg").html('');
            //if (confirm('会删除该条码所有数量,需要删除吗？')) {
            if (confirm('确定要删除吗？')) {
                var id = $(t).parent().parent().attr("id");
                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.DeleteScanInfo(id);
                //if (ajax.error != null) {
                //    alert(ajax.error.Message);
                //    return false;
                //}
                var sn = $(t).closest("td").siblings(".serial-number").attr("serial-number");

                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspFinishProductOutStorageDeleteSN", JSON.stringify({ DNCode: $.trim($("#txtDN").val()), SerialNumber: sn, ModifyBy: userName }));
                if (ajax.error != null) {
                    showMsg(ajax.error.Message, 0);
                    return false;
                }

                GetSalOrderDtlList(SalOrderID);
                $("#msg").html('删除成功！').css('color', "#00FF00");
                $("#SacnInfo tbody").html('');
            }
        };
        //实物确认
        function OutDNAffirm() {
            if ($("#divProductSummaryInfo tr:eq(2) td:eq(1)").html() == '备货完成') {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.Stocking(SalOrderID, userName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert('实物验收完成！');
                GetSalOrderList(SalOrderID);
            } else {
                alert('单据不是备货完成状态，无法验收！');
            }
        }
        //出货确认
        function OutStockAffirm() {
            if ($("#divProductSummaryInfo tr:eq(2) td:eq(1)").html() == '已检验') {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.OutStockConfirmation(SalOrderID, userName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert('出货完成！');
                Refresh();
            } else {
                alert('请完成确认备货动作！');
            }
        }
        //删除事件
        function Delete() {
            if ($("#txtDN").val() == '' || $("#txtDN").val() == null) {
                alert('请选择备货单');
                return false;
            }
            if ($("#divProductSummaryInfo tr:eq(2) td:eq(1)").html() == '已出货') {
                alert('单据已出货,无法删除');
                return false;
            }
            if (confirm('是否删除该单据！！')) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.Delete(SalOrderID);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                }

                alert('删除成功！');
                document.forms[0].submit();
            }
        }

        //手动新增
        function Add() {

        }
        function selectSalOrder() {
            var searchCondition = " Status<>4 "; // "Status=1"; 
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=120&PageCondition= " + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 550, height: 300 });
        }
        function getChooseValue(list) {
            $("#txtDN").val(list[0][1]);
            $("#txtGRN").val('');
            GetSalOrderList(list[0][0]);
            SalOrderID = list[0][0];
            GetAttachFileInfo();
        }
        function GetValueStr(obj) {
            try {
                if (obj == undefined || obj == null) {
                    return '';
                } else {
                    return obj;
                }
            }
            catch (e) {
                return '';
            }
        }
        function Refresh() {
            document.forms[0].submit();
        }

        
        $(document).ready(function () {
            $('#fileUpload').uploadfile({ 
                uploader: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx',
                fileSizeLimit: 10,                
                buttonText: "上传",
                formData: function () {
                    return {
                        'Action': 'SalOrder', "salOrderID": SalOrderID, "userName": userName
                    };
                },
                //选择文件时执行             
                onUploadStart: function (file) {
                    if (SalOrderID == "") {
                        alert("请选择备货单号！");
                        return false;
                    }
                    return true;
                },
                //上传成功时执行
                onUploadSuccess: function (file, data, response) {
                    alert("上传成功");
                    GetAttachFileInfo();
                    $("#fileUpload").val("");
                },
                //上传错误信息
                onUploadError: function (file, text) {
                    alert(text);
                }
            });
        });

        function GetAttachFileInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.GetAttachFileInfo(SalOrderID);
            if (ajax.error != null) {
                playSound("ng");
                alert(ajax.error.Message);
            }
            $("#tbodyAttach").html("");
            var html = "";
            for (var i = 0; i < ajax.value.length; i++) {
                var entity = ajax.value[i];
                var n = entity.FilePath.lastIndexOf("/");
                var fileUrl = GetFilePath("SalOrder", entity.FilePath.substring(n + 1, entity.FilePath.length));
                html += "<tr class='ListTableOddRow'><td align='center'>" + (i + 1) + "<input type='hidden' name='hdnFileID' value='" + entity.FileID + "'/></td><td><a href='" + fileUrl + "' target='_blank' >" + entity.FileUpName + "</a></td><td align='center'><a href='#' onclick='deleteFile(" + entity.FileID + ")' style='color:red;cursor: pointer;' >删 除</a></td></tr>";
            }
            if (html == "") {
                $("#tbAttach").hide();
            }
            else {
                $("#tbAttach").show();
            }
            $("#tbodyAttach").html(html);
        }

        function deleteFile(fileId) {
            if (!confirm("确认删除该附件？")) {
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.DeleteAttachFileInfo(fileId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
            }
            GetAttachFileInfo();
        }

        //获取时间字符串形式
        function getDateString(date) {
            if (!date) {
                return "";
            }
            var today = new Date(date);
            return today.Format();
        }

        //时间转字符串
        Date.prototype.Format = function (fmt) {
            if (undefined == fmt || null == fmt) {
                fmt = "yyyy-MM-dd HH:mm:ss";
            }
            var t = this;
            var tf = function (str, len) {
                if (str.length < len) {
                    for (var i = 0; i < len - str.length; i++) {
                        str = "0" + str;
                    }
                }
                return str
            };
            var opt = {
                "y+": t.getFullYear().toString(),        // 年
                "M+": (t.getMonth() + 1).toString(),     // 月
                "d+": t.getDate().toString(),            // 日
                "H+": t.getHours().toString(),           // 时
                "m+": t.getMinutes().toString(),         // 分
                "s+": t.getSeconds().toString()          // 秒
                // 有其他格式化字符需求可以继续添加，必须转化成字符串
            };
            var ret;
            for (var k in opt) {
                ret = new RegExp("(" + k + ")").exec(fmt);
                if (ret) {
                    fmt = fmt.replace(ret[1], ret[1].length == 1 ? opt[k] : tf(opt[k], ret[1].length));
                }
            }
            return fmt;
        }


        //显示消息 type 1:成功 0：失败
        function showMsg(msg, type) {
            $("#msg").html(msg).css("color", type == 1 ? "#2ecc71" : "#ff0000");
        }
    </script>
</asp:Content>
