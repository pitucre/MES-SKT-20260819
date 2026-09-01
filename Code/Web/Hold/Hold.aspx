<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Hold.aspx.cs" Inherits="SKT.LeanMES.Web.Hold.Hold"
    MasterPageFile="~/Masters/ViewMaster.master" %>

<asp:Content ContentPlaceHolderID="viewcontent" runat="server">
    <style>
        .wrap_tb > div {
            clear: both;
            display: none;
            height: auto;
            padding-top: 5px;
        }
    </style>
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <%--选项卡 开始--%>
    <div class="wrap_tb" id="infoTabs">
        <ul class="tb">
            <li class="current" onclick="selHoldObjec(this,1)">工单QHold</li>
            <li onclick="selHoldObjec(this,2)">产品QHold</li>
            <li onclick="selHoldObjec(this,3)">物料QHold</li>
            <li onclick="selHoldObjec(this,4)">在制品QHold</li>
        </ul>
        <%--选项卡内容 工单Hold--%>
        <div id="infoTabContent-1" class="tb_c">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">
                        <em>*</em>工单号：
                    </td>
                    <td class="Field1">
                        <input type="text" id="txtOrderNO" class="TextBox" />
                        <input type="button" class="ButtonBox" value="..." onclick="chooseOrderNO()" />                       
                    </td>
                </tr>
            </table>
        </div>
        <%--选项卡内容 产品Hold--%>
        <div id="infoTabContent-2">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">
                        <em>*</em>产品编号：
                    </td>
                    <td class="Field1">
                        <input type="text" id="txtItemCode" class="TextBox" />
                        <input type="button" class="ButtonBox" value="..." onclick="chooseItem()" />
                    </td>
                </tr>
            </table>
        </div>
        <%--选项卡内容 物料Hold--%>
        <div id="infoTabContent-3">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">
                        <em>*</em>物料条码：
                    </td>
                    <td class="Field1">
                        <input type="text" id="txtMaterialCode" class="TextBox" />
                        <input type="button" id="" value="上传" onclick="MaterialImport()" class="" title="上传">
                        <%--<input type="button" class="ButtonBox" value="..." onclick="chooseMaterial()" />--%>
                    </td>
                </tr>
                <%--<tr>
                    <td class="Label1">供应商：
                    </td>
                    <td class="Field1">
                        <input type="text" id="txtVendorCode" class="TextBox" />
                        <input type="button" class="ButtonBox" value="..." onclick="chooseVendorCode()" />
                    </td>
                </tr>
                <tr>
                    <td class="Label1">DateCode(周数)：
                    </td>
                    <td class="Field1">
                        <input type="text" id="txtDateCode" class="TextBox" />
                        <input type="button" class="ButtonBox" value="..." onclick="chooseDateCode()" />
                    </td>
                </tr>
                <tr>
                    <td class="Label1">批次号：
                    </td>
                    <td class="Field1">
                        <input type="text" id="txtLotCode" class="TextBox" />
                        <input type="button" class="ButtonBox" value="..." onclick="chooseLotCode()" />
                    </td>
                </tr>--%>
            </table>
        </div>
        <%--选项卡内容 在制品Hold--%>
        <div id="infoTabContent-4">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">
                        <em>*</em>产品序列号：
                    </td>
                    <td class="Field1">
                        <input type="text" id="txtSN" class="TextBox" />
                         <input type="button" id="" value="上传" onclick="Import()" class="" title="上传">
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div style="height: 60px; clear: both">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label1">
                    <em>*</em>原因说明：
                </td>
                <td class="Field1">
                    <input type="text" id="txtCauseDescription" class="TextArea TextBox" />
                </td>
            </tr>
        </table>
    </div>
    <div style="height: 300px;">
        <div class="ListTableTitle">
             <%//=Resources.lang.ProductionHistory%><span>Hold操作历史</span>
            
        </div>
        <table class="ListTable" width="100%">
            <tr class="ListTableHeader">
                <th style="width: 20%">对象<%//=Resources.lang.AC_Operation%>
                </th>
                <th style="width: 30%">编号<%//=Resources.lang.IsPass %>
                </th>
                <th style="width: 20%">操作人<%//=Resources.lang.ExitTime %>
                </th>
                <th style="width: 30%">操作时间<%//=Resources.lang.Staff %>
                </th>
            </tr>
        </table>
        <table id="tbHoldHistory" class="ListTable" width="100%">
        </table>
    </div>
    <script type="text/javascript">
        var chooseFlag = 0;
        var objectFlag = 1; //默认工单
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"
        var curretCName = "";   //当前用户中文名

        $(document).ready(function () {
            //处理操作人为中文名
            if (userName) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetByName(userName)
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                } else {
                    if (ajax.value) {
                        curretCName = ajax.value.EmployeeCName;
                    }
                }
            }
        })

        function selHoldObjec(obj, tag) {
            objectFlag = tag;
            selectTab(obj, tag);
        }

        function chooseOrderNO() {
            chooseFlag = 44;
            //pageCondition = "Status = 1";
            pageCondition = "";
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=607&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function chooseItem() {
            chooseFlag = 1;
            pageCondition = "Status = 1";
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + chooseFlag + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function chooseMaterial() {
            chooseFlag = 1;
            //pageCondition = "Status = 1";
            pageCondition = "";
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + chooseFlag + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });

            chooseFlag = -9;
        }
        function chooseDateCode() {
            chooseFlag = 5;
            var itemcode = $("#txtMaterialCode").val();
            if (itemcode == '') {
                alert("请先选择物料");
                return false;
            }
            pageCondition = "ItemCode='" + itemcode + "'";

            if ($("#txtVendorCode").val() != '') {
                pageCondition += " and VendorCode='" + $("#txtVendorCode").val() + "'";
            }
            if ($("#txtLotCode").val() != "") {
                pageCondition += " and LotCode='" + $("#txtLotCode").val() + "'";
            }
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + 601 + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 370 });
        }
        function chooseVendorCode() {
            chooseFlag = 7;
            var itemcode = $("#txtMaterialCode").val();
            if (itemcode == '') {
                alert("请先选择物料");
                return false;
            }
            pageCondition = "ItemCode='" + itemcode + "'";
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + 606 + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
        function chooseLotCode() {
            chooseFlag = 6;
            //pageCondition = "Status = 1";
            var itemcode = $("#txtMaterialCode").val();
            if (itemcode == '') {
                alert("请先选择物料");
                return false;
            }
            pageCondition = "ItemCode='" + itemcode + "'";
            if ($("#txtVendorCode").val() != '') {
                pageCondition += " and VendorCode='" + $("#txtVendorCode").val() + "'";
            }
            if ($("#txtDateCode").val() != "") {
                pageCondition += " and DateCode='" + $("#txtDateCode").val() + "'";
            }
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=" + 602 + "&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
        function getChooseValue(list) {
            switch (chooseFlag) {
                case 44: $("#txtOrderNO").val(list[0][1]);
                    break;
                case 1: $("#txtItemCode").val(list[0][2]);
                    break;
                case -9: $("#txtMaterialCode").val(list[0][2]);
                    break;
                case 5: $("#txtDateCode").val(list[0][0]=='-1'?'':list[0][0]);
                    break;
                case 6:
                    $("#txtLotCode").val(list[0][0] == '-1' ? '' : list[0][0]);
                    break;
                case 7:
                    $("#txtVendorCode").val(list[0][0] == '-1' ? '' : list[0][0]);
                    break;
                default:;
                    break;
            }
            chooseFlag = 0;
        }


        function Hold() {
            var objectNO = "";
            var txtCauseDescription = $("#txtCauseDescription").val();

            if (objectFlag == 1) {
                objectNO = $("#txtOrderNO").val();
                if (isNull(objectNO)) {
                    alert("请输入工单号！")
                    return false;
                }
            }
            else if (objectFlag == 2) {
                objectNO = $("#txtItemCode").val();
                if (isNull(objectNO)) {
                    alert("请输入产品编号！")
                    return false;
                }
            }
            else if (objectFlag == 3) {
                var itemcode = $("#txtMaterialCode").val();
                var datecode = $("#txtDateCode").val();
                var lotcode = $("#txtLotCode").val();

                var vendorcode = $("#txtVendorCode").val();
                //objectNO = $("#txtMaterialCode").val();
                //if ($("#txtDateCode").val() == "") {
                //    objectNO += ',' + $("#txtDateCode").val()
                //}
                //if ($("#txtLotCode").val() == "") {
                //    objectNO += ',' + $("#txtLotCode").val()
                //}
                var en = {};
                en.ItemCode = itemcode;
                en.DateCode = datecode;
                en.LotCode = lotcode;
                en.VendorCode = vendorcode;
                objectNO = JSON.stringify(en);

                //黄亮 2018-08-15 
                objectNO = $("#txtMaterialCode").val();
                
                if (isNull(objectNO)) {
                    alert("请输入物料编号！")
                    return false;
                }
            }
            else if (objectFlag == 4) {
                objectNO = $("#txtSN").val();
                if (isNull(objectNO)) {
                    alert("请输入在制品序列号！")
                    return false;
                }
            }

            if (isNull(txtCauseDescription)) {
                alert("请填写原因！")
                return false;
            }

            var ajaxHold = SKT.LeanMES.Web.AjaxServices.AjaxQuality.HoldOrUnHold(objectNO, objectFlag, txtCauseDescription, userName, 1);
            if (ajaxHold.error != null) {
                alert(ajaxHold.error.Message);
                return false;
            } else {
                addHoldHistory(ajaxHold.value);
                $(".TextBox").val('');
            }
        }


        function addHoldHistory(entity) {
            var html = "";
            html += '<tr class="ListTableOddRow">';
            html += '<td style="width:20%">' + entity.ObjectName + '</td>';
            html += '<td style="width:30%">' + entity.ObjectCode + '</td>';
            html += '<td style="width:20%">' + curretCName + '</td>';
            html += '<td style="width:30%">' + formatDate(entity.OperateDateTime) + '</td>';
            html += '</tr>';

            $("#tbHoldHistory").append(html);
        }
        function Import() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Hold/QHoldImport.aspx";
            dialog({ title: "Qhold导入在制品信息", src: openWinUrl, width: 850, height: 450 });
        }

        function MaterialImport() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Hold/QHoldMaterialImport.aspx";
            dialog({ title: "Qhold导入物料信息", src: openWinUrl, width: 850, height: 450 });
        }
        
        function load(data) {
            //$("#tbHoldHistory tr").remove();
            for (var i = 0; i < data.length; i++) {
                var entity = data[i];
                if (entity.ObjectName != "null" || entity.ObjectCode != "null") {
                    addHoldHistory(entity)
                }
            }
        }

        //日期格式化
        function formatDate(date, format) {
            if (!date) return "";
            if (!format) format = "yyyy-MM-dd HH:mm:ss";
            if (typeof (date) === "string") date = new Date(date);

            var o = {
                "M+": date.getMonth() + 1, //month
                "d+": date.getDate(), //day
                "H+": date.getHours(), //hour
                "m+": date.getMinutes(), //minute
                "s+": date.getSeconds(), //second
                "q+": Math.floor((date.getMonth() + 3) / 3), //quarter
                "S": date.getMilliseconds() //millisecond
            }

            if (/(y+)/.test(format)) {
                format = format.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
            }

            for (var k in o) {
                if (new RegExp("(" + k + ")").test(format)) {
                    format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
                }
            }
            return format;
        }
    </script>
</asp:Content>
