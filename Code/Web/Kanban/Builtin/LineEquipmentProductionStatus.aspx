<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LineEquipmentProductionStatus.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.LineEquipmentProductionStatus" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>液压机实时设备状态看板</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <style type="text/css">
        html, body {
            width: 100%;
            height: 100%;
            margin: 0px;
            padding: 0px;
            border: 0px;
            font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif;
            color: powderblue;
            background-color: #041622;
            overflow: hidden;
        }

        .logo_cus {
            background: url('../../Content/images/logo/logo.png') no-repeat 15px center;
            background-size: 90%;
            background-color: #0D213A;
        }

        .logo_skt {
            background: url('../../Content/images/logo/skt-logo.png') no-repeat center center;
            background-size: 93%;
            background-color: #0D213A;
        }

        #_left_top_title {
            height: 100%;
            font-size: 1.5em;
            text-align: center;
        }

        #_left_top_welcome {
            height: 100%;
            font-size: 1.7em;
            color: Red;
        }

        #dateAndWeek {
            width: 13%;
            height: 100%;
            font-size: 1.0em;
            text-align: center;
        }

        table {
            width: 100%;
            height: 100%;
            border-collapse: collapse;
            border-spacing: 0px;
            padding: 0px;
            margin: 0px;
        }

            table td, table th {
                padding: 0px;
            }

        #_layout {
            position: absolute;
        }

        #_layout_right_table td {
            font-size: 1em;
            text-align: center;
            /*border-top: 1px solid #263C54;
            border-right: 1px solid #263C54;
            border-bottom: 1px solid #263C54;*/
        }

        #data_thead th, #data_tbody td, #data_tfoot td {
            text-align: center;
            font-size: 0.8em;
            /*width: 7%;*/
            /*border-top: 1px solid #263C54;
            border-left: 1px solid #263C54;
            border-bottom: 1px solid #263C54;*/
        }

        #data_thead th {
            border-bottom: 0px;
            /*background: #F2F2F2;
            background-image: linear-gradient(to bottom, #f8f8f8 0%, #ececec 100%);*/
        }

        #data_tbody td, #data_tfoot td {
            border-bottom: 0px;
            /*background-color: #fff;*/
        }

        #data_tfoot td {
            border-bottom: 1px solid #263C54;
            /*background-color: #F2F2F2;*/
        }

        .gauge {
            height: 100%;
            width: 33%;
        }

        .yjimg {
            width: 100%;          
            max-height:200px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <table id="_layout">
            <tr style="height: 100%;">
                <td style="height: 100%;">
                    <table id="_layout_left_table">
                        <tr style="height: 12%;">
                            <td style="height: 12%; vertical-align: top;">
                                <table style="background-color: #0D213A;">
                                    <tr>
                                        <td class="logo_cus" style="width: 250px; height: 100%;" rowspan="2"></td>
                                        <td rowspan="1">
                                            <div id="_left_top_title"  style="padding-top: 30px; font-size: 39px; color: #FFffff; text-shadow: 3px 3px 1px #4b4b6b; font-weight: bold;">-</div>

                                        </td>
                                        <td id="dateAndWeek" rowspan="2" style="color: #3CA2B0; white-space: nowrap;"></td>
                                        <td class="logo_skt" style="width: 250px; height: 100%;" rowspan="2"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <marquee id="marquee" behavior="scroll" onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;"
                                                scrollamount="3" onmouseover="this.stop();" loop="-1" onmouseout="this.start();">
                                    <div id="_welcome_text" style="font-weight: bold;color: red;font-size: 35px;font-family:Verdana, 微软雅黑,黑体, 宋体;"></div>
                                </marquee>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 88%;">
                            <td style="height: 88%;">
                                <table style="border-right: 1px solid #e3e3e3;">
                                    <tr>
                                        <td style="width: 75%">
                                            <table id="data_tbody" style="font-size: 32px;">
                                                <tr style="height: 22%;">
                                                    <td style="height: 22%;">
                                                        <table style="border-top: 5px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                            <tr>
                                                                <td style="height: 100%; width: 12%; border-right: 5px solid #041622; background-image:url(../../Content/images/YJ_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                    <%--<img src="../../Content/images/YJ_01.png" id="img1" class="yjimg" />--%>
                                                                </td>
                                                                <td style="height: 100%; width: 38%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td style="width: 30%">设备名称</td>
                                                                            <td>
                                                                                <label id="lblEquipmentName1">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备状态</td>
                                                                            <td>
                                                                                <label id="lblEquipmentStatus1" style="width: 98%; display: block; height: 26px; border-radius: 4px; margin: 0 auto;">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>首件单号</td>
                                                                            <td>
                                                                                <label id="lblFAICode1">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>产品名称</td>
                                                                            <td>
                                                                                <label id="lblItemName1">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>未生产时长</td>
                                                                            <td>
                                                                                <label id="lblNotProductionTime1">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td>
                                                                                <label id="lblYield1">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td style="height: 100%; width: 12%; border-right: 5px solid #041622; background-image:url(../../Content/images/YJ_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                    <%--<img src="../../Content/images/YJ_01.png" id="img2" class="yjimg" />--%>
                                                                </td>
                                                                <td style="height: 100%; width: 38%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td style="width: 30%">设备名称</td>
                                                                            <td>
                                                                                <label id="lblEquipmentName2">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备状态</td>
                                                                            <td>
                                                                                <label id="lblEquipmentStatus2" style="width: 98%; display: block; height: 26px; border-radius: 4px; margin: 0 auto;">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>首件单号</td>
                                                                            <td>
                                                                                <label id="lblFAICode2">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>产品名称</td>
                                                                            <td>
                                                                                <label id="lblItemName2">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>未生产时长</td>
                                                                            <td>
                                                                                <label id="lblNotProductionTime2">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td>
                                                                                <label id="lblYield2">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>

                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr style="height: 22%;">
                                                    <td style="height: 22%;">
                                                        <table style="border-top: 5px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                            <tr>
                                                                 <td style="height: 100%; width: 12%; border-right: 5px solid #041622; background-image:url(../../Content/images/YJ_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                    <%--<img src="../../Content/images/YJ_01.png" id="img3" class="yjimg" />--%>
                                                                </td>
                                                                <td style="height: 100%; width: 38%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td style="width: 30%">设备名称</td>
                                                                            <td>
                                                                                <label id="lblEquipmentName3">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备状态</td>
                                                                            <td>
                                                                                <label id="lblEquipmentStatus3" style="width: 98%; display: block; height: 26px; border-radius: 4px; margin: 0 auto;">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>首件单号</td>
                                                                            <td>
                                                                                <label id="lblFAICode3">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>产品名称</td>
                                                                            <td>
                                                                                <label id="lblItemName3">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>未生产时长</td>
                                                                            <td>
                                                                                <label id="lblNotProductionTime3">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td>
                                                                                <label id="lblYield3">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td style="height: 100%; width: 12%; border-right: 5px solid #041622; background-image:url(../../Content/images/YJ_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                    <%--<img src="../../Content/images/YJ_01.png" id="img4" class="yjimg" />--%>
                                                                </td>
                                                                <td style="height: 100%; width: 38%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td style="width: 30%">设备名称</td>
                                                                            <td>
                                                                                <label id="lblEquipmentName4">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备状态</td>
                                                                            <td>
                                                                                <label id="lblEquipmentStatus4" style="width: 98%; display: block; height: 26px; border-radius: 4px; margin: 0 auto;">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>首件单号</td>
                                                                            <td>
                                                                                <label id="lblFAICode4">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>产品名称</td>
                                                                            <td>
                                                                                <label id="lblItemName4">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>未生产时长</td>
                                                                            <td>
                                                                                <label id="lblNotProductionTime4">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td>
                                                                                <label id="lblYield4">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>

                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr style="height: 22%;">
                                                    <td style="height: 22%;">
                                                        <table style="border-top: 5px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                            <tr>
                                                                 <td style="height: 100%; width: 12%; border-right: 5px solid #041622; background-image:url(../../Content/images/YJ_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                    <%--<img src="../../Content/images/YJ_01.png" id="img5" class="yjimg" />--%>
                                                                </td>
                                                                <td style="height: 100%; width: 38%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td style="width: 30%">设备名称</td>
                                                                            <td>
                                                                                <label id="lblEquipmentName5">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备状态</td>
                                                                            <td>
                                                                                <label id="lblEquipmentStatus5" style="width: 98%; display: block; height: 26px; border-radius: 4px; margin: 0 auto;">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>首件单号</td>
                                                                            <td>
                                                                                <label id="lblFAICode5">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>产品名称</td>
                                                                            <td>
                                                                                <label id="lblItemName5">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>未生产时长</td>
                                                                            <td>
                                                                                <label id="lblNotProductionTime5">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td>
                                                                                <label id="lblYield5">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td style="height: 100%; width: 12%; border-right: 5px solid #041622; background-image:url(../../Content/images/YJ_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                    <%--<img src="../../Content/images/YJ_01.png" id="img6" class="yjimg" />--%>
                                                                </td>
                                                                <td style="height: 100%; width: 38%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td style="width: 30%">设备名称</td>
                                                                            <td>
                                                                                <label id="lblEquipmentName6">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备状态</td>
                                                                            <td>
                                                                                <label id="lblEquipmentStatus6" style="width: 98%; display: block; height: 26px; border-radius: 4px; margin: 0 auto;">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>首件单号</td>
                                                                            <td>
                                                                                <label id="lblFAICode6">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>产品名称</td>
                                                                            <td>
                                                                                <label id="lblItemName6">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>未生产时长</td>
                                                                            <td>
                                                                                <label id="lblNotProductionTime6">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td>
                                                                                <label id="lblYield6">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>

                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr style="height: 22%;">
                                                    <td style="height: 22%;">
                                                        <table style="border-top: 5px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                            <tr>
                                                                 <td style="height: 100%; width: 12%; border-right: 5px solid #041622; background-image:url(../../Content/images/YJ_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                    <%--<img src="../../Content/images/YJ_01.png" id="img7" class="yjimg" />--%>
                                                                </td>
                                                                <td style="height: 100%; width: 38%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td style="width: 30%">设备名称</td>
                                                                            <td>
                                                                                <label id="lblEquipmentName7">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备状态</td>
                                                                            <td>
                                                                                <label id="lblEquipmentStatus7" style="width: 98%; display: block; height: 26px; border-radius: 4px; margin: 0 auto;">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>首件单号</td>
                                                                            <td>
                                                                                <label id="lblFAICode7">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>产品名称</td>
                                                                            <td>
                                                                                <label id="lblItemName7">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>未生产时长</td>
                                                                            <td>
                                                                                <label id="lblNotProductionTime7">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td>
                                                                                <label id="lblYield7">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td style="height: 100%; width: 12%; border-right: 5px solid #041622; background-image:url(../../Content/images/YJ_01.png);background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;">
                                                                    <%--<img src="../../Content/images/YJ_01.png" id="img8" class="yjimg" />--%>
                                                                </td>
                                                                <td style="height: 100%; width: 38%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td style="width: 30%">设备名称</td>
                                                                            <td>
                                                                                <label id="lblEquipmentName8">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备状态</td>
                                                                            <td>
                                                                                <label id="lblEquipmentStatus8" style="width: 98%; display: block; height: 26px; border-radius: 4px; margin: 0 auto;">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>首件单号</td>
                                                                            <td>
                                                                                <label id="lblFAICode8">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>产品名称</td>
                                                                            <td>
                                                                                <label id="lblItemName8">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>未生产时长</td>
                                                                            <td>
                                                                                <label id="lblNotProductionTime8">-</label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>设备利用率</td>
                                                                            <td>
                                                                                <label id="lblYield8">-</label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>

                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="width: 30%">
                                            <table>
                                                <tr>
                                                    <td style="height: 25%;">
                                                        <table style="border-top: 5px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                            <tr>
                                                                <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td colspan="2" style="font-size: 18px;color: #f5f5f5;text-shadow: 2px 2px 2px #5a5af7;font-weight: bold;">设备状态</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 42%">生产中</td>
                                                                            <td style="width: 60%">
                                                                                <label style="border-radius: 4px; background-color: #00B050; width: 80%; display: block; height: 24px; margin: 0 auto;"></label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>待机中</td>
                                                                            <td>
                                                                                <label style="border-radius: 4px; background-color: #FFFF00; width: 80%; display: block; height: 24px; margin: 0 auto;"></label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>

                                                                            <td>计划维护</td>
                                                                            <td>
                                                                                <label style="border-radius: 4px; background-color: #BFBFBF; width: 80%; display: block; height: 24px; margin: 0 auto;"></label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>

                                                                            <td>机器故障</td>
                                                                            <td>
                                                                                <label style="border-radius: 4px; background-color: #C00000; width: 80%; display: block; height: 24px; margin: 0 auto;"></label>
                                                                            </td>

                                                                        </tr>
                                                                        <tr>

                                                                            <td>模具故障</td>
                                                                            <td>
                                                                                <label style="border-radius: 4px; background-color: #FF0000; width: 80%; display: block; height: 24px; margin: 0 auto;"></label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 25%;">
                                                        <table style="border-top: 10px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                            <tr>
                                                                <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td colspan="2" style="font-size: 18px;color: #f5f5f5;text-shadow: 2px 2px 2px #5a5af7;font-weight: bold;">产线概况</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 42%">产线名称</td>
                                                                            <td>
                                                                                <label id="lblLineName"></label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>所属车间</td>
                                                                            <td>
                                                                                <label id="lblWorkShopName"></label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>车间主管</td>
                                                                            <td>
                                                                                <label id="lblCName"></label>
                                                                            </td>

                                                                        </tr>
                                                                        <tr>
                                                                            <td>车间班制</td>
                                                                            <td>
                                                                                <label id="lblShiftName"></label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>产线压机数量</td>
                                                                            <td>
                                                                                <label id="lblLineEquipmentQty">0</label> 台</td>
                                                                        </tr>
                                                                    </table>
                                                                </td>



                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 25%;">
                                                        <table style="border-top: 10px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                            <tr>
                                                                <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>
                                                                            <td colspan="2" style="font-size: 18px;color: #f5f5f5;text-shadow: 2px 2px 2px #5a5af7;font-weight: bold;">运行概况</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 42%">生产中</td>
                                                                            <td>
                                                                                <label id="lblProductionCount">0</label> 台</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>待机中</td>
                                                                            <td>
                                                                                <label id="lblStandByCount">0</label> 台</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>计划维护</td>
                                                                            <td>
                                                                                <label id="lblMaintenanceCount">0</label> 台</td>

                                                                        </tr>
                                                                        <tr>
                                                                            <td>机器故障</td>
                                                                            <td>
                                                                                <label id="lblEquipmentErrorCount">0</label> 台</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>模具故障</td>
                                                                            <td>
                                                                                <label id="lblMouldErrorCount">0</label> 台</td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 25%;">
                                                        <table style="border-top: 5px solid #e3e3e3; background-color: #0E223B; border-top: 5px solid #041622;">
                                                            <tr>
                                                                <td style="height: 100%; width: 50%; border-right: 5px solid #041622;">
                                                                    <table border="1" style="border: 1px solid #041622; text-align: center;">
                                                                        <tr>

                                                                            <td style="width: 42%">总运行时长(Min)</td>
                                                                            <td>
                                                                                <label id="lblTotalRunTime"></label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>

                                                                            <td>总待机时长(Min)</td>
                                                                            <td>
                                                                                <label id="lblTotalStandByTime"></label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>

                                                                            <td>总维护时长(Min)</td>
                                                                            <td>
                                                                                <label id="lblTotalMaintenanceTime"></label>
                                                                            </td>

                                                                        </tr>
                                                                        <tr>

                                                                            <td>总设备利用率</td>
                                                                            <td>
                                                                                <label id="lblTotalYield"></label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>

                                                                            <td colspan="2" style="height: 34%;">
                                                                                <%--  <img src="../../Content/images/logo/logo2.png" style="width: 90%" /><br/><br/>--%>
                                                                                <label style="font-size: 14px; color: #8da1b7">
                                                                                    Copyright © <%=DateTime.Now.Year %><br />
                                                                                    深圳市深科特信息技术有限公司 版权所有</label>
                                                                            </td>

                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
<script type="text/javascript">
    /*
    _S1,_S2是滚动内容区域外的两个DIV的ID
    如
    <div id="_S1">
    <div id="_S2">
    _W为滚动内容的宽度
    _H为滚动内容的高度
    _T为滚动后每次停留言时间
    */
    var isScroll = false;
    function _InitScroll(_S1, _S2, _W, _H, _T) {
        if (isScroll) { return false; }
        marqueesHeight = _H;
        stopScroll = false;
        scrollElem = document.getElementById(_S1);
        scrollTable = document.getElementById('data_tbody');
        if (scrollTable.offsetHeight < marqueesHeight) {
            return;
        }
        with (scrollElem) {
            style.width = _W;
            style.height = marqueesHeight;
            style.overflow = 'hidden';
            noWrap = true;
        }
        scrollElem.onmouseover = new Function('stopScroll = true');
        scrollElem.onmouseout = new Function('stopScroll = false');
        preTop = 0;
        //currentTop = 0;
        //stopTime = 0;
        var leftElem = document.getElementById(_S2);
        var childElems = $(scrollElem).children();
        if (childElems.length > 1) {
            $(childElems[0]).nextAll().remove();
        }
        scrollElem.appendChild(leftElem.cloneNode(true));
        pauseTime = _T;
        //setTimeout('init_srolltext()', 1000);
        init_srolltext();
    }

    function init_srolltext() {
        scrollElem.scrollTop = 0;
        scrollIntervalId = setInterval('scrollUp()', 50);
    }

    function scrollUp() {
        if (stopScroll) {
            return;
        }
        preTop = scrollElem.scrollTop;
        scrollElem.scrollTop += 1;
        if (preTop == scrollElem.scrollTop) {
            scrollElem.scrollTop = 0;
            scrollElem.scrollTop += 1;
        }
    }
</script>
<script type="text/javascript">
    var timeInterval = 1000 * 60 * 3;

    $(window).resize(function () {
        ResizeAll();
    });

    var lineId, lineName, welcomeMsg;
    $(document).ready(function () {
        /*设置title*/
        lineId = getQueryString("lineId");
        lineName = getQueryString("lineName");
        welcomeMsg = getQueryString("welcomeMsg");;

        $("#_left_top_title").html("液压机实时状态看板");
        ResizeAll();
        getWelcome();

        initProductionData();
    });

    function getWelcome() {
        if (welcomeMsg == "") {
            welcomeMsg = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetWelcome(lineId, -1).value;
        }
        var dataWeek = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeek().value;

        $("#dateAndWeek").text(dataWeek);
        $("#_welcome_text").html(welcomeMsg);

        clearTimeout(gwTimeout);
        var gwTimeout = setTimeout("getWelcome()", 1000 * 60 * 5);
    }

    var currentPage = 1;
    var pageList = [];
    var eInterVal;
    var uphTimeout;

    function initProductionData() {
        var entity = {};
        entity.LineId = lineId;
        //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspKabBanEquipmentProductionStatus", JSON.stringify(entity));

       // var result = JSON.parse(ajax.value);
        var result = [[{ "LineId": 31, "LineName": "压制车间A线", "WorkShopName": "一楼压制车间", "CName": "张金波", "ShiftName": "双班制", "LineEquipmentQty": 7, "TotalRunTime": 2702, "ProductionCount": 4, "StandByCount": 3, "MaintenanceCount": 0, "EquipmentErrorCount": 0, "MouldErrorCount": 0, "TotalStandByTime": 1158, "TotalMaintenanceTime": 0, "TotalYield": "57.00%" }], [{ "CareDepNo": "SC01", "Id": 1, "EquipmentId": 7028, "EquipmentCode": "POCO02224-A1#", "EquipmentName": "A1#液压机", "EquipmentStatus": "待机中", "FAICode": "Y200107055", "ItemName": "NPF106060", "NotProductionTime": 386, "Yield": "0.00%" }, { "CareDepNo": "SC01", "Id": 2, "EquipmentId": 7029, "EquipmentCode": "POCO02201-A2#", "EquipmentName": "A2#液压机", "EquipmentStatus": "生产中", "FAICode": "Y191223036", "ItemName": "PPF157060-19", "NotProductionTime": 0, "Yield": "100.00%" }, { "CareDepNo": "SC01", "Id": 3, "EquipmentId": 7030, "EquipmentCode": "POCO02223-A3#", "EquipmentName": "A3#液压机", "EquipmentStatus": "生产中", "FAICode": "y200105008", "ItemName": "NPHR2021-75", "NotProductionTime": 0, "Yield": "100.00%" }, { "CareDepNo": "SC01", "Id": 4, "EquipmentId": 7031, "EquipmentCode": "POCO02323-A4#", "EquipmentName": "A4#液压机", "EquipmentStatus": "生产中", "FAICode": "Y200108038", "ItemName": "NPHR2524-60", "NotProductionTime": 0, "Yield": "100.00%" }, { "CareDepNo": "SC01", "Id": 5, "EquipmentId": 7032, "EquipmentCode": "POCO02324-A5#", "EquipmentName": "A5#液压机", "EquipmentStatus": "生产中", "FAICode": "Y200102027", "ItemName": "TSD08P-SQ503009", "NotProductionTime": 0, "Yield": "100.00%" }, { "CareDepNo": "SC01", "Id": 6, "EquipmentId": 7033, "EquipmentCode": "POCO02325-A6#", "EquipmentName": "A6#液压机", "EquipmentStatus": "待机中", "FAICode": "Y200108037", "ItemName": "NPFR3325-60", "NotProductionTime": 386, "Yield": "0.00%" }, { "CareDepNo": "SC01", "Id": 7, "EquipmentId": 7034, "EquipmentCode": "POCO02273-A7#", "EquipmentName": "A7#液压机", "EquipmentStatus": "待机中", "FAICode": "Y191229014", "ItemName": "NPHR3320-40", "NotProductionTime": 386, "Yield": "0.00%" }]];
        var entity = result[0][0];//设备状态、产线概况、运行概况信息
        pageList = result[1];//压机列表

        //$("#lblLineName").text(entity.LineName);
        $("#lblLineName").text(lineName);
        $("#lblWorkShopName").text(entity.WorkShopName);
        $("#lblCName").text(entity.CName);
        $("#lblShiftName").text(entity.ShiftName);
        $("#lblLineEquipmentQty").text(entity.LineEquipmentQty);
        $("#lblProductionCount").text(entity.ProductionCount);
        $("#lblStandByCount").text(entity.StandByCount);
        $("#lblMaintenanceCount").text(entity.MaintenanceCount);
        $("#lblEquipmentErrorCount").text(entity.EquipmentErrorCount);
        $("#lblMouldErrorCount").text(entity.MouldErrorCount);
        $("#lblTotalRunTime").text(entity.TotalRunTime);
        $("#lblTotalStandByTime").text(entity.TotalStandByTime);
        $("#lblTotalMaintenanceTime").text(entity.TotalMaintenanceTime);
        $("#lblTotalYield").text(entity.TotalYield);

        EquipmentChange();

        if (eInterVal != undefined) {
            clearInterval(eInterVal);
        }

        eInterVal = setInterval("EquipmentChange()", 1000 * 10);

        if (uphTimeout != undefined) {
            clearTimeout(uphTimeout);
        }
        uphTimeout = setTimeout("initProductionData()", timeInterval);
    }

    /*
    *设备分页刷新
    */
    function EquipmentChange() {
        var pageSize = 8;

        var list = pageList;

        if (list.length / pageSize == 1) {//如果只有一页
            currentPage = 1;
        }
        for (var i = 1; i <= pageSize; i++) {
            var entity = {};

            if (currentPage * pageSize > list.length) {
                if (((currentPage - 1) * pageSize + i - 1) < list.length) {
                    entity = list[(currentPage - 1) * pageSize + i - 1];
                }
                else {
                    $("#lblEquipmentStatus" + i).css("background-color", "");
                    $("#lblEquipmentStatus" + i).text("-");
                    $("#lblEquipmentName" + i).text("-");
                    $("#lblFAICode" + i).text("-");
                    $("#lblItemName" + i).text("-");
                    $("#lblNotProductionTime" + i).text("-");
                    $("#lblYield" + i).text("-");
                    continue;
                }

            }
            else {
                entity = list[(currentPage - 1) * pageSize + i - 1];
            }

            $("#lblEquipmentName" + i).text(entity.EquipmentName);
            $("#lblEquipmentName" + i).css("color", "mediumspringgreen");

            $("#lblEquipmentStatus" + i).text(entity.EquipmentStatus);

            if (entity.EquipmentStatus == "生产中") {
                $("#lblEquipmentStatus" + i).css("background-color", "#00B050");
            }
            else if (entity.EquipmentStatus == "待机中") {
                $("#lblEquipmentStatus" + i).css("background-color", "#FFFF00").css("color", "rosybrown");
            }
            else if (entity.EquipmentStatus == "计划维护") {
                $("#lblEquipmentStatus" + i).css("background-color", "#BFBFBF").css("color", "lightyellow");
            }
            else if (entity.EquipmentStatus == "机器故障") {
                $("#lblEquipmentStatus" + i).css("background-color", "#C00000");
            }
            else if (entity.EquipmentStatus == "模具故障") {
                $("#lblEquipmentStatus" + i).css("background-color", "#FF0000");
            }

            $("#lblFAICode" + i).text(entity.FAICode);
            $("#lblItemName" + i).text(entity.ItemName);
            $("#lblNotProductionTime" + i).text(entity.NotProductionTime == "" ? "" : entity.NotProductionTime + ' Min');
            $("#lblYield" + i).text(entity.Yield);
        }

        if (parseInt(list.length / pageSize) < currentPage || (list.length % pageSize == 0 && parseInt(list.length / pageSize) == currentPage)) {
            currentPage = 1;
        }
        else {
            currentPage++;
        }
    }

    function ResizeAll() {
        //某些浏览器不兼容div自适应高度
        $(".gauge").height($(window).height() * 0.9 * 0.27);

        var _contentHeight = $(window).height() * 0.9 * 0.3;

        $("#_layout_left_data_div_tbody").css("height", "auto");

        $(".rows").height(_contentHeight * 0.16)

        if ($(".rows").length * _contentHeight * 0.16 > _contentHeight) {
            $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.16 * 2 - 2);
            _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 150, 1000 * 6);
            isScroll = true;
        }
    }

    /**
     *   获取URL参数值
     **/
    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    }

</script>
</html>
