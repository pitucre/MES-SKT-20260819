<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="SteelMeshDoInspectio.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelMeshDoInspectio" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<div style="margin-top: 15px; margin-bottom: 15px;">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label3">治具编号
                </td>
                <td class="Field3">
                    <span id="spanEquipmentCode"></span>
                </td>
                <td class="Label3">治具名称
                </td>
                <td class="Field3">
                    <span id="spanEquipmentName"></span>
                </td>
                <td class="Label3">供应商代码
                </td>
                <td class="Field3">
                    <span id="spanVendor"></span>
                </td>
            </tr>
            <tr>
                <td class="Label3">PCB型号
                </td>
                <td class="Field3">
                    <span id="ItemPCBModel"></span>
                </td>
                <td class="Label3">检验员
                </td>
                <td class="Field3" colspan="3">
                    <span id="spanUserName"></span>
                </td>
            </tr>
            <tr>
                <td class="Label3">最终检验结果
                </td>
                <td class="Field3" colspan="5" id="OKNGID">
                    <label style="color: Green; font-weight: bold;">
                        <input id='cbFormOK' type="checkbox"  onchange='FinalResult1(this)'/>合格</label>&nbsp;&nbsp;
                    <label style="color: Red; font-weight: bold;">
                        <input id='cbFormNG' type="checkbox"  onchange='FinalResult2(this)'/>不合格</label>
                </td>
            </tr>
            <tr>
                <td class="Label3">检验备注
                </td>
                <td class="Field3" colspan="5" id="txtSignID">
                    <textarea   type="text" id="txtSign" class="TextArea" style="min-width: 350px"></textarea>
                </td>
            </tr>
            <tr id="trSaveOrderBtn">
                <td class="Field3" colspan="6" style="text-align: center;">
                   <input id="InspectionStartBtn" type="button" value=" 检验开始 " onclick="InspectionStart()" style="margin-right:10px;" /> 
                   <input id="SaveBtn" type="button" value=" 检验完成  " onclick="SaveForm()" style="margin-right:10px;" />
                </td>
            </tr>
        </table>
    </div>
    <div class="wrap_tb" id="wrap_tb">
        <ul class="tb">
            <li class="current" id="Div1">检验明细</li>
        </ul>
        <div class="tb_c tb_content">
            <div id="divDtl">
            </div>
        </div>
    </div>
     <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/uploadify/jquery.uploadify.js"></script>
    <script type="text/javascript">
        var id = '<%=Request["ID"] %>'; 
        var EquipmentTypeName = "<%=Request.QueryString["EquipmentTypeName"] %>"; 
        var userName = '<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>'; 
        var cname = '<%=GetCNameByUserNames(SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName)%>';
        var SMIId = 0;
        var okcount = 0, ngcount = 0;//标记ok ng数
        var SMIInspectionStatus = 0;
        $("#cbFormOK").prop("checked", false);
        $("#cbFormNG").prop("checked", false);
        $(document).ready(function () {
            SaveSteelMeshInspection();
        });
        //检验生成
        function SaveSteelMeshInspection() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSteelMeshInspection.SaveSteelMeshInspection(id);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            SMIId = ajax.value;
            SenddivDtl(SMIId);
            Info(SMIId);
        }
        //检验信息
        function Info(id) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSteelMeshInspection.SelectSteelMeshInspection(id);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var data = ajax.value;
            $("#spanEquipmentCode").html(data.EquipmentCode);
            $("#spanEquipmentName").html(data.EquipmentName);
            $("#spanVendor").html(data.VendorBarcode);
            $("#ItemPCBModel").html(data.PCBModel);
            $("#spanUserName").html(cname);
            if (data.SMIInspectionStatus == 0) {
                $("#OKNGID").find("input").attr("disabled", "disabled");
                $("#txtSignID").find("textarea").attr("disabled", "disabled");
                $("#divDtl").find("input").attr("disabled", "disabled");
                $("#cbFormOK").prop("checked", false);
                $("#cbFormNG").prop("checked", false);
            }
            else if (data.SMIInspectionStatus == 1) {
                $("#OKNGID").find("input").removeAttr("disabled");
                $("#txtSignID").find("textarea").removeAttr("disabled");
                $("#divDtl").find("input").removeAttr("disabled");
                $("#cbFormOK").prop("checked", false);
                $("#cbFormNG").prop("checked", false);
            }
            else if (data.SMIInspectionStatus == 2) {
                $("#OKNGID").find("input").attr("disabled", "disabled");
                $("#txtSignID").find("textarea").attr("disabled", "disabled");
                $("#divDtl").find("input").attr("disabled", "disabled");
                $("#cbFormOK").prop("checked", true);
                $("#cbFormNG").prop("checked", false);
            }
            else if (data.SMIInspectionStatus == -2) {
                $("#OKNGID").find("input").attr("disabled", "disabled");
                $("#txtSignID").find("textarea").attr("disabled", "disabled");
                $("#divDtl").find("input").attr("disabled", "disabled");
                $("#cbFormOK").prop("checked", false);
                $("#cbFormNG").prop("checked", true);
            }
            else {
                $("#OKNGID").find("input").attr("disabled", "disabled");
                $("#txtSignID").find("textarea").attr("disabled", "disabled");
                $("#divDtl").find("input").attr("disabled", "disabled");
                $("#cbFormOK").prop("checked", false);
                $("#cbFormNG").prop("checked", false);
            }
            $("#txtSign").val(data.SMIInspectionRem);
            SMIInspectionStatus = data.SMIInspectionStatus;
            if (data.SMIInspectionStatus>0) {
                 $("#InspectionStartBtn").hide();
            }
            if (data.SMIInspectionStatus == 2 || data.SMIInspectionStatus == -2) {
                $("#SaveBtn").hide();
            }
        }
        //检验项目
        var okArr = [];
        var ngArr = [];
        function SenddivDtl(id) {
            $("#divDtl").html("");
            okcount = 0;
            ngcount = 0;
            okArr = [];
            ngArr = [];
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSteelMeshInspection.SelectSteelMeshInspectionDtl(id);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var data = ajax.value;
            var html = "";
            html = "<table id='tbDtl1' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
        + "<tr class='ListTableHeader' ><th >序号</th><th>检验项目</th><th>录入方式</th><th>判定标准</th><th>单位</th><th >检验结果</th><th>备注</th>"
            + "<th id='delId' style='color: #0066CC; cursor: pointer;' onclick='AddCheckItem()'>+添加检验项</th><th></th>" + "</tr>";
            var row = 0;
            for (var j = 0; j < data.length; j++) {
                row = row + 1;
                okArr.push("cbOK" + data[j].SMIDId);
                ngArr.push("cbNG" + data[j].SMIDId);
                html += "<tr name='TempLateTr' class='ListTableOddRow' id='" + data[j].SMIDId + "'><td>" + row + "<span style='display:none;'>" + data[j].SMIDId + "</span></td><td>" + data[j].SMIPName + "</td><td>" + data[j].SMIPEntryMode + "</td><td>" + data[j].SMIPCriterion + "</td><td>" + data[j].SMIPUnit + "</td>"
                html += "<td><label><input id='cbOK" + data[j].SMIDId + "' onclick='ckokng(\"" + data.length + "\")' type='radio' name='OkNgRa" + data[j].SMIDId + "'  " + (data[j].SMIDResult === 'OK' ? " checked='checked'" : " ") + "   />OK</label>&nbsp;&nbsp;";
                html += "<label><input id='cbNG" + data[j].SMIDId + "' onclick='ckokng(\"" + data.length + "\")' type='radio' name='OkNgRa" + data[j].SMIDId + "'  " + (data[j].SMIDResult === 'NG' ? " checked='checked'" : " ") + "/>NG</label>&nbsp;&nbsp;";
                html += "</td>";
                html += "<td  colspan='2'><input type='text' value='" + data[j].SMIDRem + "' onchange='UpdateRemark(this," + data[j].SMIDId + ")'  /></td>";
                html += "<td><span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(" + data[j].SMIDId + ", $(this))\"><%= Resources.Buttons.COM_Delete %></span></td></tr>";
            }
            html += "</table>";
            $("#divDtl").append(html);
        }
        function InspectionStart() {
            if (!confirm("是否确认检验开始？")) {
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSteelMeshInspection.StartSteelMeshInspection(id, SMIId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("检验开始成功！")
            SenddivDtl(SMIId);
            Info(SMIId);
        }

        function ckokng(cokng) {
            okcount = 0;
            ngcount = 0;
            for (var i = 0; i < okArr.length; i++) {
                if ($("#" + okArr[i]).prop("checked") == true) {
                    okcount = okcount + 1;
                } else if ($("#" + ngArr[i]).prop("checked") == true) {
                    ngcount = ngcount + 1;
                }
            }
            if (ngcount >= 1) {
                if ($("#cbFormNG").prop("checked") == false) {
                    $("#cbFormNG").removeAttr("disabled").click();
                    $("#cbFormOK").attr("disabled", true);
                }
            } else if (okcount == cokng) {
                if ($("#cbFormOK").prop("checked") == false) {
                    $("#cbFormOK").removeAttr("disabled").click();
                    $("#cbFormNG").attr("disabled", true);
                }
            } else {
                $("#cbFormNG").removeAttr("disabled");
                $("#cbFormOK").removeAttr("disabled");
                $("#cbFormOK").prop("checked", false);
                $("#cbFormNG").prop("checked", false);
            }
        }
        function SaveForm() {
            var list=[];
            var model = {};
            if (!$("#cbFormOK").prop('checked') && !$("#cbFormNG").prop('checked')) {
                alert("请勾选最终检验结果，再进行检验完成")
                return false;
            }
            for (var i = 0; i < $("tr[name='TempLateTr']").length; i++) {
                var radio1 = $($("tr[name='TempLateTr']")[i]).find("td:eq(5) input:eq(0):checked").val();
                var radio2 = $($("tr[name='TempLateTr']")[i]).find("td:eq(5) input:eq(1):checked").val();
                if (radio1 == undefined && radio2 == undefined) {
                    alert("请完成所有检验项的检验");
                    return false;
                }
            }
            if (!confirm("是否确认检验完成？")) {
                return false;
            }
            for (var i = 0; i < $("tr[name='TempLateTr']").length; i++) {
                model = {};
                var SMIDId = $($("tr[name='TempLateTr']")[i]).find("td:eq(0) span:eq(0)").html();
                var radio1 = $($("tr[name='TempLateTr']")[i]).find("td:eq(5) input:eq(0):checked").val();
                var radio2 = $($("tr[name='TempLateTr']")[i]).find("td:eq(5) input:eq(1):checked").val();
                var rem = $($("tr[name='TempLateTr']")[i]).find("td:eq(6) input:eq(0)").val();
                model.SMIDId = SMIDId;
                if (radio1 === "on") {
                    model.SMIDResult = "OK";
                }
                if (radio2 === "on") {
                    model.SMIDResult = "NG";
                }
                model.SMIDRem = rem;
                list.push(model);
            }
            var InspectionResult = $("#cbFormOK").prop('checked') ? 2 : ($("#cbFormNG").prop('checked') ? -2 : null);
            var SMIInspectionRem = $("#txtSign").val();
            //保存结果
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSteelMeshInspection.StopSteelMeshInspection(id, SMIId, InspectionResult, SMIInspectionRem, list);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("检验完成成功！")
            Info(SMIId);
            SenddivDtl(SMIId);
            window.parent.Refresh();
        }
        function AddCheckItem() {
            if (SMIInspectionStatus > 0) {
                alert("检验已经确认开始，不允许增加")
                return false;
            }
            var searchSearch = " SMIPStatus<>-2 ";
            var SMIPType = "0";
            if (EquipmentTypeName == "钢网") {
                SMIPType += ",1";
            } else {
                SMIPType += ",2";
            }
            searchSearch += " AND SMIPType IN (" + SMIPType + ")";
            dialog({
                title: "选择钢网刮刀检验项目", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=819&PageCondition="
                     + escape(searchSearch) + "&CallBackFunc=getReturnOrdersCb&Multiple=false&rnd=" + Math.random(), width: 650, height: 300
            });
        }
        function getReturnOrdersCb(list) {
            var mpid = list[0][0];
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSteelMeshInspection.AddSteelMeshInspectionDtl(SMIId, mpid);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            SenddivDtl(SMIId);
            Info(SMIId);
        }
        function deleteItem(id, t) {
            if (SMIInspectionStatus > 0) {
                alert("检验已经确认开始，不允许删除")
                return false;
            }
            if (!confirm("是否确认删除？")) {
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSteelMeshInspection.DeleteSteelMeshInspectionDtl(id);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            SenddivDtl(SMIId);
            Info(SMIId);
        }
        function FinalResult1(t) {
            if ($("#cbFormOK").prop('checked')) {
                $("#cbFormNG").prop("checked", false);
            }
        }
        function FinalResult2(t) {
            if ($("#cbFormNG").prop('checked')) {
                $("#cbFormOK").prop("checked", false);
            }
        }
    </script>
</asp:Content>
