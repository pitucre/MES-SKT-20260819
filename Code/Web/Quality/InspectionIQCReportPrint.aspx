<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/Masters.master" CodeBehind="InspectionIQCReportPrint.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionIQCReportPrint" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<%--<div id="printIqc">
    <object id="WebBrowser" style="display:none" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0" width="0">
    </object>   
    <table id="idPrint" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td align="left" style=" width:15%">
                <img src="../Content/images/logo/logo.png" alt=""/>
            </td>
            <td align="center" style=" width:60%">
                <span id="lbGroupName" style="font-size: 20px; font-weight: bolder; vertical-align:middle; text-align: center; font-family: @宋体;">
                </span>
                <br />
            </td>
            <td align="right" style="vertical-align: bottom; width:25%">
                <span id="lbPrintLv"></span>
            </td>
        </tr>
    </table>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3" style="text-align:center">物料名称</td>
            <td class="Field3">
                <label id="lbItemName"></label>
            </td>
            <td class="Label3" style="text-align:center">物料编码</td>
            <td class="Field3">
                <label id="lbItemCode"></label>
            </td>
            <td class="Label3" style="text-align:center">送检单号</td>
            <td class="Field3">
                <label id="lbFormNo"></label>
            </td>
        </tr>
        <tr>
            <td class="Label3" style="text-align:center">供应商名</td>
            <td class="Field3">
                <label id="lbVendorName"></label>
            </td>
            <td class="Label3" style="text-align:center">来料数量</td>
            <td class="Field3" style="text-align:center">
                <label id="lbCheckQty"></label>
            </td>
            <td class="Label3" style="text-align:center">检验日期</td>
            <td class="Field3">
                <label id="lbCheckDate"></label>
            </td>
        </tr>
    </table>
    <div id="divDtl">
    </div>
    <br />
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label" style=" width:20%; text-align:center">最终检验结果</td>
            <td class="Field" style=" width:16%; text-align:center">
                <label style=" color:Red"><input id='cbFormOK' type="checkbox" onchange='FinalResult(this)'/>合格</label>&nbsp;
                <label style=" color:Red"><input id='cbFormNG' type="checkbox" onchange='FinalResult(this)'/>不合格</label>
            </td>
            <td class="Label" style=" width:16%;text-align:center">检验员</td>
            <td class="Field" style=" width:16%;">
                <label id="lbCheckUser"></label>
            </td>
            <td class="Label" style=" width:16%;text-align:center">审核</td>
            <td class="Field" style=" width:16%;">
                <label id="lbSign"></label>
            </td>
        </tr>
    </table>
    <br />
    <div style=" border-width:0px ;">备注：<span id="lbRemark"></span></div>
    <br />
    <div style=" border-width:0px ;font-size:8px">仪器编号：<span style="font-size:8px" id="lbInstrument"></span></div>
    <script type="text/javascript">
        var Id = '<%=Request.QueryString["ID"]%>';
        $(document).ready(function () {
            getFormInfo();
            //input 时间焦点设定
            $('input:checkbox').attr("disabled", "disabled");

            $('#printIqc tr:gt(0)').each(
                function () {
                    $(this).css('pageBreakInside', 'avoid');
                }
            );
            PrintForm();
        });

            //获取根据检验单Id获取检验信息
            function getFormInfo() {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetIqcFormModel(Id);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                if (ajax.value != null) {
                    var en = $.parseJSON(ajax.value)
                    $("#lbItemName").text(en.data[0].ItemName);
                    $("#lbGroupName").text("来料检验报告("+en.data[0].GroupName+")");
                    $("#lbPrintLv").text(en.data[0].PrintLv);
                    $("#lbItemCode").text(en.data[0].ItemCode);
                    $("#lbVendorName").text(en.data[0].VendorName);
                    $("#lbCheckQty").text(en.data[0].InspectionQty);
                    $("#lbCheckDate").text(en.data[0].CheckDate);
                    $("#lbFormNo").text(en.data[0].InspectionNo);
                    $("#lbCheckUser").text(en.data[0].InspectionUser);
                    $("#lbSign").text(en.data[0].Auditing);
                    $("#lbInstrument").text(en.data[0].Instrument);
                    $("#lbRemark").text(en.data[0].Remark);

                    if (en.data[0].InspectionResult === 0) {
                        $("#cbFormNG").attr("checked", "checked");
                        $("#cbFormOK").removeAttr('checked');
                    }
                    else if (en.data[0].InspectionResult === 1) {
                        $("#cbFormNG").removeAttr('checked');
                        $("#cbFormOK").attr("checked", "checked");
                    }
                    //加载检验模版项
                    moCount = 0;
                    LoadInspectionItem(en.data1);
                    //加载LCR检验项
                    DetailLcrItem(en.data[0].InspectionId);
                }
            }

            //加载检验模版项
            function LoadInspectionItem(data1) {
                $("#divDtl").append("");
                listItem = [], moCount = 0;
                for (var i = 0; i < data1.length; i++) {
                    DetailItem(data1[i].InspectionId, data1[i].InspectionTemplateId, i);
                }
            }

            //模版检验项详细资料取得绑定
            function DetailItem(InspectionId, InspectionTemplateId) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetIqcFormItem(InspectionId, InspectionTemplateId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                var value = $.parseJSON(ajax.value);
                //模版头添加
                var head = value.data[0];
                var html = "<table id='tblExpand' class='ListTable' style='border-width:0.5px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                          + "<tr class='ListTableHeader' style='font-size: 12px;'><th colspan='6' >" + head.InspectionTemplateName + "</th></tr>"
                          + "<tr class='ListTableHeader' style='font-size: 10px;'><th>抽样水平</th><th>" + head.LotName + "/AQC=" + head.RuleName + "</th>"
                          + "<th>抽样数量</th><th>" + head.SamplingValue + "</th>"
                          + "<th>Ac/Re</th><th>" + "Ac=  " + head.ACValue + "/ Re=  " + head.REValue + "</th></tr></table>";
                $("#divDtl").append(html);
                //加载检验项
                var Dtllist = value.data1;

                var InsItemNamestr = "", Jugestr = "", According = "";

                html = "<table id='tbDtl" + head.InspectionTemplateId + "' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                    + "<tr class='ListTableHeader' ><th>序号</th><th>检验项目</th><th>判定标准</th><th>检验方法</th><th>描述</th><th>检验结果</th>"
                    + "</tr>";
                for (var j = 0; j < Dtllist.length; j++) {
                    Dtllist[j].CountRow = moCount;
                    //复制
                    var en = {}, eItem = JSON.stringify(Dtllist[j]);
                    $.extend(en, Dtllist[j]);
                    en.CheckResult = Dtllist[j].CheckResult === "" ? null : Dtllist[j].CheckResult;
                    listItem.push(en);

                    //检验项目
                    InsItemNamestr = Dtllist[j].InspectionItemName;
                    //判断标准
                    Jugestr = Dtllist[j].InspectJuge;
                    //检验方法
                    According = Dtllist[j].InspectionAccording;

                    html += "<tr class='ListTableOddRow'><td style='width:10px;'>" + (j + 1).toString() + "</td>"
                        + "<td style='width:25%'>" + InsItemNamestr + "</td>"
                        + "<td style='width:30%'>" + Jugestr + "</td>"
                        + "<td style='width:8%'>" + According + "</td>"
                        + "<td style='width:25%'>" + Dtllist[j].Discretion + "</td>"
                        + "<td style='width:8%'><label><input id='cbOK" + moCount + "' type='checkbox' "
                            + (Dtllist[j].CheckResult === 1 ? " checked='checked'" : " ") + " onchange='ChangeResult(" + moCount + ", $(this))' />OK</label>&nbsp;&nbsp;"
                        + "<label><input id='cbNG" + moCount + "' type='checkbox' " + (Dtllist[j].CheckResult === 0 ? "checked='checked'" : "")
                            + " onchange='ChangeResult(" + moCount + ", $(this))' />NG</label></td>"
                        + "<tr>";

                    moCount++;
                }
                html += "</table>";
                $("#divDtl").append(html);
            }


            //模版检验项详细资料取得绑定
            function DetailLcrItem(InspectionId) {
                Lcrlist = [];
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetIqcFormLcrItem(InspectionId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                var value = $.parseJSON(ajax.value);
                //模版头添加
                var head = value.data[0];
                var html = "<table id='tblExpand' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >"
                          + "<tr class='ListTableHeader'><th colspan='6' >" + head.InspectionTemplateName + "</th></tr>"
                          + "<tr class='ListTableHeader'><th>抽样水平</th><th>" + head.LotName + "/AQC=" + head.RuleName + "</th>"
                          + "<th>抽样数量</th><th>" + head.SamplingValue + "</th>"
                          + "<th>Ac/Re</th><th>" + "Ac=  " + head.ACValue + "/ Re=  " + head.REValue + "</th></tr></table>";
                $("#divDtl").append(html);
                //加载LCR检验项
                Lcrlist = value.data1;
                var itemCount = 0;

                html = "<table id='tbDtl" + head.InspectionTemplateId + "' class='ListTable' style='border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;'  >";
                for (var j = 0; j < Lcrlist.length; j++) {
                    html += "<tr class='ListTableOddRow'><td style='text-align:center; width:10%'>" + Lcrlist[j].IQCLcrItemName + "</td>";
                    for (var a = 1; a <= 10; a++) {
                        //ID赋值
                        var Iid = j.toString() + a.toString();

                        if (Lcrlist[j].IQCLcrItemType === 2) {
                            itemCount++;
                            html += "<td style='text-align:center; width:9%'>(" + itemCount + ")</td>";
                        }
                        else if (Lcrlist[j].IQCLcrItemType === 1) {
                            html += "<td style='text-align:center; width:9%'><label style='font-size: 9px;'><input id='cbLcrOK"
                            + j.toString() + a.toString() + "' type='checkbox' " + (Lcrlist[j]["Value" + a] === '1' ? " checked='checked'" : " ")
                            + " style='zoom: 70%'/>OK<label>&nbsp;"
                            + "<label style='font-size: 9px;'><input id='cbLcrNG" + j.toString() + a.toString() + "' type='checkbox' "
                            + (Lcrlist[j]["Value" + a] === '0' ? " checked='checked'" : " ")
                            + " style='font-size: 7px; zoom: 70%'/>NG<label></td>";
                        }
                        else if (Lcrlist[j].IQCLcrItemType === 0) {
                        html += "<td style='text-align:center; width:9%'>" + Lcrlist[j]["Value" + a] + "</td>";
                        }
                    }
                    html += "<tr>";
                }
                html += "</table>";
                $("#divDtl").append(html);
            }

        //打印单据
        function PrintForm() {
            if (document.all.WebBrowser) {
                document.all.WebBrowser.ExecWB(7, 1)
            }
            else {
                //  window.print();
                WebBrowser.ExecWB(7, 1)
            }
        }


    </script>
        <script src="../Content/plugin/barCode/jquery-barcode.js" type="text/javascript"></script>
        <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
        <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
            type="text/javascript"></script>
        <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
            type="text/javascript" charset="GBK"></script>
        <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
            type="text/javascript"></script>
        <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/jqPrint/jquery.jqprint-0.3.js"
            type="text/javascript"></script>
</div>--%>
</asp:Content>