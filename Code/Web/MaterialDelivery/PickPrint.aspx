<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="PickPrint.aspx.cs"
    Inherits="SKT.LeanMES.Web.MaterialDelivery.PickPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        @media Print
        {
            .Noprn
            {
                display: none;
            }
        }
    </style>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js"></script>
    <style type="text/css">
        table
        {
            width: 100%;
            border: 0px;
            border-collapse: collapse;
            border-spacing: 0px;
            line-height: 30px;
            margin-top: 10px;
        }
        .bottomBorder
        {
            border-bottom: solid 1px black;
        }
        .bottomBorder td
        {
            border-bottom: solid 1px black;
            padding-left: 10px;
        }
        .label
        {
            width: 15%;
        }
        .value
        {
            width: 30%;
            padding-left: 3px;
        }
        .gap
        {
            width: 9%;
        }
        .style1
        {
            height: 32px;
        }
    </style>
</head>
<body style="overflow: scroll">
    <form id="form1" runat="server">
    <div style="width: 90%; margin: 5px auto;">
        <div style="border-bottom: solid 1px black; width: 99%; height: 35px; line-height: 25px;
            font-size: 25px; font-weight: bold; padding-left: 1%;">
            分捡单
            <div id="bcTarget" style="float: right;">
            </div>
        </div>
        <table>
            <tr>
                <td class="label">
                    分捡单号：
                </td>
                <td class="bottomBorder value">
                    <label id="lblPickNo" runat="server">
                    </label>
                </td>
                <td class="gap">
                </td>
                <td class="label ">
                    &nbsp;工单号：
                </td>
                <td class="bottomBorder value">
                    <label id="lblOrderNo" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td class="label">
                    创建时间：
                </td>
                <td class="bottomBorder value">
                    <label id="lblCreateDateTime" runat="server">
                    </label>
                </td>
                <td class="gap">
                </td>
                <td class="label">
                    需求数量：
                </td>
                <td class="bottomBorder value">
                    <label id="lblIssueQty" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td class="label">
                    工&nbsp;&nbsp;段：
                </td>
                <td class="bottomBorder value">
                    <label id="lblIssueTo" runat="server">
                    </label>
                </td>
                <td class="gap">
                </td>
                <td class="label">
                    线别名称：
                </td>
                <td class="bottomBorder value">
                    <label id="lblLineName" runat="server">
                    </label>
                </td>
            </tr>
        </table>
        <div style="border-bottom: solid 1px black; width: 100%; height: 1px; margin: 20px 0px;">
        </div>
        <div style="height: 670px;">
            <table id="tbDetailList">
                <tr>
                    <th width="5%">
                        序号
                    </th>
                    <th width="20%">
                        物料编号
                    </th>
                    <th width="20%">
                        物料名称
                    </th>
                    <th width="15%">
                        数量
                    </th>
                </tr>
                <tr id="trNewInfo">
                    <td colspan="4" style="text-align: center;" class="style1">
                        暂无数据
                    </td>
                </tr>
            </table>
        </div>
        <div style="padding-right: 150px; text-align: right; height: 90px; line-height: 30px;">
            签&nbsp;&nbsp;收&nbsp;&nbsp;人：
            <br />
            签收日期：
        </div>
    </div>
    <object classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0" id="WebBrowser"
        width="0">
    </object>
    </form>
</body>
</html>
<script type="text/javascript">
    var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
    var formNo = '<%=Request.QueryString["formNo"]%>';
    var pickId = '<%=Request.QueryString["ID"]%>';
    $(document).ready(function () {
        $("#bcTarget").barcode("" + formNo + "", "code128", { barWidth: 2, barHeight: 30 });
        loadPickDetailList();

        Print();
    })


    function Print() {
        if (document.all.WebBrowser) {
            document.all.WebBrowser.ExecWB(7, 1)
        }
        else {
            window.print();
        }
z
    }

    //保存重打印记录
    function SaveRePrintRecoard() {
        var ajax = SKT.LeanMES.Web.AjaxServices.Material.AjaxServiceMaterial.SaveRePrintRecoard(Id, userName);

        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }
    }

    //加载分检单明细列表
    function loadPickDetailList() {
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialDelivery.GetPickDetailList(pickId);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }

        var list = ajax.value;
        if (list.length > 0) {
            $("#trNewInfo").remove();
            var html = "";
            for (var i = 0; i < list.length; i++) {
                html += "<tr class='bottomBorder'>";
                html += "<td style='text-align:center;'>" + (i + 1) + "</td>";
                html += "<td style='text-align:center;'>" + list[i].ItemCode + "</td>";
                html += "<td style='text-align:center;'>" + list[i].ItemName + "</td>";
                html += "<td style='text-align:center;'>" + list[i].Quantity + "</td></tr>";
            }
        }
        else {
        }
        $("#tbDetailList").append(html);
    }

</script>
<script src="../Content/plugin/barCode/jquery-barcode.js" type="text/javascript"></script>
