<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="Reinspection.aspx.cs" Inherits="SKT.LeanMES.Web.Material.Reinspection" %>

<%@ MasterType VirtualPath="~/Masters/ViewMaster.master" %>
<asp:Content ID="Content3" ContentPlaceHolderID="viewcontent" runat="Server">
    <style>
        #divProductSummaryInfo {
            font-size: 14px;
        }
    </style>
    <div>
        <%--查询模块--%>
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">重检单号
                </td>
                <td class="Field2">
                    <input type="hidden" value="" id="hdnDN" />
                    <input type="text" id="txtCheckNo" class="TextBox" disabled="disabled" style="width: 370px" />
                    <input type="button" id="Button1" class="ButtonBox" value="..." onclick="selectCheckOrder()" />
                </td>
            </tr>
            <tr>
                <td class="Label2">扫描GRN</td>
                <td class="Field2">
                    <input type="text" id="txtGRN" class="TextBox" style="width: 370px" /></td>
            </tr>
        </table>
    </div>
    <div class="clear5">
    </div>
    <div>
        <div class="divHeader">重检单明细</div>
        <div class="EditeContentTable" id="infotab" width="100%">
        </div>
    </div>
    <div class="clear5">
    </div>
    <div id="msg" style="text-align: center; font-size: 14px">
    </div>

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        var CheckListNo;//重检单
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var GrnList = [];//单据下GRN
        $(function () {
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxReinspection.ReinspectionCheck();

        });
        $("#txtGRN").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                var grn = $("#txtGRN").val();
                var flag = true;
                if ($.inArray(grn, GrnList) == -1) {
                    alert("GRN错误或不在重检验单中");
                    $("#txtGRN").focus().select();
                    return false;
                }
                for (var i = 0; i < $(".ContentTabl tbody tr").length; i++) {
                    var _tr = $($(".ContentTabl tbody tr")[i]);
                    if (_tr.find("td:eq(0)").html() == grn) {
                        _tr.fadeOut(500).fadeIn(500);
                        $(".ContentTabl").prepend(_tr);//置顶
                        if (_tr.find("td:eq(4)").html() == "NG") {
                            _tr.find("td:eq(4)").html("OK").css("background-color", "green");
                        } else {
                            _tr.find("td:eq(4)").html("NG").css("background-color", "red");
                        }
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxReinspection.ScanGrn(grn, userName, CheckListNo);
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            $("#txtGRN").focus().select();
                            return false;
                        }
                    }
                    $("#txtGRN").focus().select();
                }
                $("#txtGRN").focus().select();
            }
        });
        function selectCheckOrder() {
            var searchCondition = "Status =1"; // "Status=1"; 
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=674&PageCondition= " + searchCondition + "&Multiple=false&CallBackFunc=setCheckCode&rnd=" + Math.random(), width: 650, height: 300 });
        }
        function setCheckCode(list) {
            $("#txtCheckNo").val(list[0][0]);
            CheckListNo = list[0][0];
            CheckDifferenceList(CheckListNo);
            $("#txtGRN").focus();
        }
        function CheckDifferenceList(CheckListNo) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxReinspection.GetReinspectionList(CheckListNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
            }
            GrnList = [];
            var htmlstr = "<table width='100% ' class='ContentTabl'><thead><tr class='ListTableHeader'><th>GRN</th><th>物料编码</th><th>物料名称</th><th>物料规格</th><th>检验结果</th>"//<th>备注</th>"
                              + "</tr></thead>";
            var list = JSON.parse(ajax.value);
            for (var i = 0; i < list.data.length; i++) {
                GrnList.push(list.data[i].SerialNumber);
                var _td;
                htmlstr += "<tr class='ListTableEvenRow'>";
                if (list.data[i].CheckResult == 0) {
                    _td = "<td>未检验</td>"
                } else if (list.data[i].CheckResult==-1) {                 
                    _td = "<td style='background-color:green'>OK</td>"
                } else {
                    _td = "<td style='background-color:red'>NG</td>"
                }

                htmlstr += "<td id='" + list.data[i].SerialNumber + "'>" + list.data[i].SerialNumber + "</td>"
                         + "<td>" + list.data[i].ItemCode + "</td>"
                         + "<td>" + list.data[i].ItemName + "</td>"
                         + "<td>" + list.data[i].ItemSpec + "</td>"
                        + _td
                        + "<td>" + list.data[i].Remark + "</td>"
                        + "</tr>";
            }
            $("#infotab").html(htmlstr + "</table>");
        }
        //完成重检
        function Add() {
            if (CheckListNo == "" || CheckListNo == null) {
                alert("请选择重检单");
                return false;
            }
            if (confirm("是否完成检验")) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxReinspection.ReinspectionFinish(CheckListNo, userName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert("检验完成");
                document.forms[0].submit();
                //window.location.reload();
            }
        }
    </script>
</asp:Content>
