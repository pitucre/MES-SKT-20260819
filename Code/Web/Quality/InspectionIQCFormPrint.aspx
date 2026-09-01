<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Masters/Masters.master" CodeBehind="InspectionIQCFormPrint.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionIQCFormPrint" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<%--<div>
     <style type="text/css">
        /*覆写单据打印样式*/
        .FieldTd
        {
            height: 20px;
            text-align: left;
            font-size: 11px;
            border: 0px solid black;
        }
        .noBorder
        {
            font-size: 12px;
            height: 20px;
            text-align: left;
            font-size: 12px;
            border: 0px solid black;
        }
        .LabelTd
        {
            height: 15px;
            font-size: 12px;
            border: 0.5px solid black;
            margin-left:10px;
        }
        .lbDtl
        {
            min-height:15px;
            height: 15px;
            font-size: 10px;
            border: 0.5px solid black;
        }
        .Newpage {page-break-after: always;}
    </style>
    <object id="WebBrowser" style="display:none" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0" width="0">
    </object>   
    <table id="idPrint" width="100%" border="0" cellpadding="0" cellspacing="0">
        <thead id="idThead">
            <tr>
                <td colspan="10" align="center">
                    <div style="font-size: 20px; font-weight: bolder; text-align: center; font-family: @宋体;">
                        IQC&nbsp;&nbsp;&nbsp; 送&nbsp;&nbsp;&nbsp; 检&nbsp;&nbsp;&nbsp;
                        单</div>
                    <br />
                    <table width="100%" style="margin-top: 2px;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td colspan="5" class="FieldTd" style="width: 80%; height: 30px">
                            </td>
                            <td class="FieldTd" style="width: 20%; height: 30px">
                                <div id="barcode">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 12%;" class="noBorder">
                                供应商名称：
                            </td>
                            <td style="width: 28%;" class="FieldTd" id="venderName">
                            </td>
                            <td style="width: 10%; text-align:right" class="noBorder">
                                送检单号：
                            </td>
                            <td style="width: 20%; font-size: 11px;" class="FieldTd" id="deliNo">
                            </td>
                            <td style="width: 10%; text-align:right" class="noBorder">
                                日期：
                            </td>
                            <td style="width: 20%" class="FieldTd" id="date">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 12%" class="noBorder">
                                供应商编码：
                            </td>
                            <td style="width: 28%" class="FieldTd" id="venderCode">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="text-align:center">
                <td class="LabelTd" style="width: 13%">订单号</td> 
                <td class="LabelTd" style="width: 13%">物料编号</td> 
                <td class="LabelTd" style="width: 15%">物料描述</td> 
                <td class="LabelTd" style="width: 8%">仓位</td> 
                <td class="LabelTd" style="width: 5%">单位</td> 
                <td class="LabelTd" style="width: 8%">送货数量</td>
                <td class="LabelTd" style="width: 8%">收货数量</td> 
                <td class="LabelTd" style="width: 8%">合格数</td> 
                <td class="LabelTd" style="width: 8%">不合格数</td> 
                <td class="LabelTd" style="width: 13%">备注</td> 
            </tr>
        </thead>            
        <tbody id="idbody">           
        </tbody>
        <tfoot id="idfoot" style="display:table-footer-group; font-weight:bold; page-break-after: avoid;">
            <tr>
                <td colspan="10" class="LabelTd" style="height:40px;">
                    <div style="width: 100%; height:60px; float:left; vertical-align:bottom; text-align:left">
                    不良原因：<br /><br />
                    质量部意见：
                    </div>  
                </td>
            </tr>
            <tr">
                <td colspan="10" class="LabelTd">
                    <div style="width: 33%; float:left">收货人：</div>
                    <div style="width: 33%; float:left">仓管员：</div>
                    <div style="width: 33%; float:left">日期：</div>   
                </td>
            </tr>
        </tfoot>
    </table>
    <script type="text/javascript">
        var Id = '<%=Request.QueryString["ID"]%>';
        $(document).ready(function () {
            GetData(Id);
            $('#idThead').css('display', 'table-header-group; font-weight: bold');
            $('#idPrint tfoot').css('display', 'table-footer-group; font-weight: bold');
            $('#idPrint tr:gt(0)').each(
                function () {
                    $(this).css('pageBreakInside', 'avoid');
                }
            );
            //window.print();
            //打印单据
            PrintForm();
        });

        //获取数据
        function GetData(id) {
            //加载
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetIQCFormPrint(Id);
            if (ajax.error == null) {
                //表头信息
                var e = $.parseJSON(ajax.value);
                $("#venderName").html(e.VendorName);
                $("#venderCode").html(e.VenderNo);
                $("#deliNo").html(e.InspectionNo);
                $("#date").html(e.CreateDateTime);
                $("#barcode").barcode(e.InspectionNo, "code128", { barWidth: 1, barHeight: 30 });

                //表身信息
                addDetail(e);

            } else {
                alert(ajax.error.Message);
                return false;
            }
        }
        function addDetail(e) {
            var row = "";
           
                row = "<tr>" +
                  "<td class='lbDtl' style='text-align:center;'>" + e.POCode + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'>" + e.ItemCode + "</td>" +
                  "<td class='lbDtl' >" + e.ItemName + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'>" + e.Position + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'>" + e.Units + "</td>" +
                  "<td class='lbDtl' style='text-align:center;'>" + e.InspectionQty + "</td>" +
                  "<td class='lbDtl'></td>" +
                  "<td class='lbDtl'></td>" +
                  "<td class='lbDtl'></td>" +
                  "<td class='lbDtl'></td></tr>";
            
            $("#idbody").append(row);
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