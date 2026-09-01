<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EnergyMonitoringKanBan.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.EnergyMonitoringKanBan" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <!-- ECharts单文件引入 -->
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/echarts.min.js" type="text/javascript"></script>
    <title>能耗监控看板</title>
    <style type="text/css">
        html, body, form { width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif; color: #fff; background-color: rgba(3, 7, 38, 1); font-size: 14px; overflow: hidden; }
        ul, li { margin: 0px; padding: 0px; list-style: none; text-align: center; /*border: 1px solid rgba(75, 212, 255, 1);*/ }
        .logo_cus { background: url('../../Content/images/logo/logo.png') no-repeat center; background-size: 94%; /*background-color: #0D213A;*/ }
        .logo_cus2 { background: url('../../Content/images/logo/skt-logo.png') no-repeat center; background-size: 90%; }
        .table { display: table; height: 100%; width: 100%; position: relative; }
        .cell { display: table-cell; width: 100%; height: 100%; vertical-align: middle; }
        th { height: 35px; line-height: 35px; text-align: center; font-size: 20px; color: #1ab2c7; }
        tr { height: 22px; line-height: 22px; text-align: center; font-size: 14px; color: rgba(75, 212, 255, 1); }
        .thTitle { font-size: 20px; color: #fff; }
        .chart-tit { font-size: 20px; color: #fff; font-weight: bold; text-align: center; text-shadow: 3px 2px 8px #5a5af7; }

        #div1 { display: black; width: 110px; height: 50px; line-height: 50px; white-space: nowrap; overflow: hidden; background-color: #a2a2a2; margin: 15px; padding: 5px 15px; }
        span { display: inline-block; color: #fff; padding-right: 20px; }
        .auto-style2 {
            width: 100%;
            table-layout: fixed;
        }
        .auto-style5 {
            width: 100%;
            height: 100%;
        }
        .auto-style6 {
            background-color:rgba(17, 31, 55, 0.7);
        }
        #lineInfo li {
            margin-left: 15px;
            width: 40%;
            line-height: 40px;
        }
        .logo_cus {
            background: url('../../Content/images/logo/logo.png') no-repeat 13px center;
            background-size: 94%;
            background-color: rgba(3, 7, 38, 1);
        }
        .logo_skt {           
            background: url('../../Content/images/logo/skt-logo.png') no-repeat center center;
            background-size: 93%;
            background-color: rgba(3, 7, 38, 1);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; height: 100%;background-color: rgba(3, 7, 38, 1);">
            <ul style="height: 6%;">
                <li style="height: 100%;">
                    <table style="height:55px;width:100%; ">
                        <tr>
                            <td class="logo_cus" style="width: 250px; height: 100%;" ></td>
                            <td align="center">
                                <div id ="_left_top_title" class="cell" style="font-size: 36px; color: rgba(75, 212, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:right;">
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;能耗监控看板
                                </div>
                            </td>
                            <td id="dateAndWeek" style="color: rgba(75, 212, 255, 1); white-space:nowrap;font-size: 18px;width: 250px;"></td>
                            <td class="logo_skt" style="width: 250px; height: 100%;"></td>
                        </tr>
                    </table>
                </li>
            </ul>
            <div style="height: 94%;">
                <table style="height: 100%; width:100%;">
                    <tr>
                        <td style="height: 100%; width:100%">
                            <div style="height: 100%; width:100%">
                                <table style="border-top:1px solid #000000;height: 100%; width:100% ;">
                                    <tr style="">
                                        <td style="border-bottom:1px solid #000000;border-right: 1px solid #000000;width:31%;" class="auto-style6">
                                            <table style="width: 100%;table-layout: fixed;">
                                                <tr>
                                                    <td>
                                                        <div id="echarts_bar_WeekFirstRate8"  class="auto-style5"  style="height: 350px;  width:100%"></div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="border-bottom:1px solid #000000;border-right: 1px solid #000000;width:23%;" class="auto-style6">
                                            <table style="width:100%;">
                                                <tr><td style="font-size: 20px; color: rgba(75, 212, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;" colspan="6">3F制造一部</td></tr>
                                                <tr>
                                                    <td>
                                                        <table style="width:100%;">
                                                            <tr>
                                                                <td colspan="2">当前能耗(KW/h)</td>
                                                                <td colspan="2">当前电流(A)</td>
                                                                <td colspan="2">当前电压(V)</td>
                                                            </tr>
                                                            <tr>
                                                                <td rowspan="3" style="font-size:20px;font-weight: bold;color:rgba(255, 255, 255, 1);" colspan="2"><label id="TbNowEnergy4">79</label></td>
                                                                <td>IA:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbIALab4">150</label></td>
                                                                <td>UA:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUALab4">342</label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>IB:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbIBLab4">162</label></td>
                                                                <td>UB:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUBLab4">361</label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>IC:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbICLab4">154</label></td>
                                                                <td>UC:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUCLab4">360</label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table style="width:100%;">
                                                            <tr>
                                                                <td style="font-size: 20px; color: rgba(75, 212, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;">总能耗</td>
                                                                <td style="font-size: 20px; color: rgba(255, 255, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;" ><label id="TbAllNHLab4">342</label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div id="echarts_bar_WeekFirstRate4"  class="auto-style5"  style="height: 290px;  width:100%"></div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="border-bottom:1px solid #000000;border-right: 1px solid #000000;width:23%;" class="auto-style6">
                                             <table style="width:100%;">
                                                <tr><td style="font-size: 20px; color: rgba(75, 212, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;" colspan="6">2F制造二部</td></tr>
                                                <tr>
                                                    <td>
                                                        <table style="width:100%;">
                                                            <tr>
                                                                <td colspan="2">当前能耗(KW/h)</td>
                                                                <td colspan="2">当前电流(A)</td>
                                                                <td colspan="2">当前电压(V)</td>
                                                            </tr>
                                                            <tr>
                                                                <td rowspan="3" style="font-size:20px;font-weight: bold;color:rgba(255, 255, 255, 1);" colspan="2"><label id="TbNowEnergy5">79</label></td>
                                                                <td>IA:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbIALab5">150</label></td>
                                                                <td>UA:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUALab5">342</label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>IB:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbIBLab5">162</label></td>
                                                                <td>UB:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUBLab5">361</label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>IC:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbICLab5">154</label></td>
                                                                <td>UC:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUCLab5">360</label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td>
                                                        <table style="width:100%;">
                                                            <tr>
                                                                <td style="font-size: 20px; color: rgba(75, 212, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;">总能耗</td>
                                                                <td style="font-size: 20px; color: rgba(255, 255, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;" ><label id="TbAllNHLab5">342</label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div id="echarts_bar_WeekFirstRate5"  class="auto-style5"  style="height: 290px; width:100%"></div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="border-bottom:1px solid #000000;border-right: 1px solid #000000;width:23%;" class="auto-style6">
                                             <table style="width:100%;">
                                                <tr><td style="font-size: 20px; color: rgba(75, 212, 255, 1); text-shadow: 3px 2px 8px #3DC2DF; font-weight: bold;text-align:center;" colspan="6">1F制造二部</td></tr>
                                                <tr>
                                                    <td>
                                                        <table style="width:100%;">
                                                            <tr>
                                                                <td colspan="2">当前能耗(KW/h)</td>
                                                                <td colspan="2">当前电流(A)</td>
                                                                <td colspan="2">当前电压(V)</td>
                                                            </tr>
                                                            <tr>
                                                                <td rowspan="3" style="font-size:20px;font-weight: bold;color:rgba(255, 255, 255, 1);" colspan="2"><label id="TbNowEnergy6">79</label></td>
                                                                <td>IA:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbIALab6">150</label></td>
                                                                <td>UA:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUALab6">342</label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>IB:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbIBLab6">162</label></td>
                                                                <td>UB:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUBLab6">361</label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>IC:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbICLab6">154</label></td>
                                                                <td>UC:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUCLab6">360</label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table style="width:100%;">
                                                            <tr>
                                                                <td style="font-size: 20px; color: rgba(75, 212, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;">总能耗</td>
                                                                <td style="font-size: 20px; color: rgba(255, 255, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;" ><label id="TbAllNHLab6">342</label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div id="echarts_bar_WeekFirstRate6"  class="auto-style5"  style="height: 290px;  width:100%"></div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border-bottom:1px solid #000000;border-right: 1px solid #000000;width:31%;" class="auto-style6">
                                            <table style="width:100%;">
                                                <tr style="height:10%;"><td style="font-size: 20px; color: rgba(75, 212, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;" colspan="6">电驱动器自动化线</td></tr>
                                                <tr style="height:30%;">
                                                    <td>
                                                        <table style="width:100%;">
                                                            <tr>
                                                                <td colspan="2">当前能耗(KW/h)</td> 
                                                                <td colspan="2">当前电流(A)</td>
                                                                <td colspan="2">当前电压(V)</td>
                                                            </tr>
                                                            <tr>
                                                                <td rowspan="3" style="font-size:20px;font-weight: bold;color:rgba(255, 255, 255, 1);" colspan="2"><label id="TbNowEnergy1">79</label></td>
                                                                <td>IA:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbIALab1">150</label></td>
                                                                <td>UA:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUALab1">342</label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>IB:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbIBLab1">162</label></td>
                                                                <td>UB:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUBLab1">361</label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>IC:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbICLab1">154</label></td>
                                                                <td>UC:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUCLab1">360</label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table style="width:100%;">
                                                            <tr>
                                                                <td style="font-size: 20px; color: rgba(75, 212, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;">总能耗</td>
                                                                <td style="font-size: 20px; color: rgba(255, 255, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;" ><label id="TbAllNHLab1">342</label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr style="height:60%;">
                                                    <td class="auto-style6">
                                                        <div id="echarts_bar_WeekFirstRate1"  class="auto-style5"  style="height: 290px; width:100%"></div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="border-bottom:1px solid #000000;border-right: 1px solid #000000;width:23%;" class="auto-style6">
                                             <table style="width:100%;">
                                                <tr><td style="font-size: 20px; color: rgba(75, 212, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;" colspan="6">电动撑杆自动化线</td></tr>
                                                <tr style="font-size: 10px;">
                                                    <td>
                                                        <table style="width:100%;">
                                                            <tr>
                                                                <td colspan="2">当前能耗(KW/h)</td>
                                                                <td colspan="2">当前电流(A)</td>
                                                                <td colspan="2">当前电压(V)</td>
                                                            </tr>
                                                            <tr>
                                                                <td rowspan="3" style="font-size:20px;font-weight: bold;color:rgba(255, 255, 255, 1);" colspan="2"><label id="TbNowEnergy2">79</label></td>
                                                                <td>IA:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbIALab2">150</label></td>
                                                                <td>UA:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUALab2">342</label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>IB:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbIBLab2">162</label></td>
                                                                <td>UB:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUBLab2">361</label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>IC:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbICLab2">154</label></td>
                                                                <td>UC:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUCLab2">360</label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td>
                                                        <table style="width:100%;">
                                                            <tr>
                                                                <td style="font-size: 20px; color: rgba(75, 212, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;">总能耗</td>
                                                                <td style="font-size: 20px; color: rgba(255, 255, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;" ><label id="TbAllNHLab2">342</label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div id="echarts_bar_WeekFirstRate2"  class="auto-style5"  style="height: 290px;  width:100%"></div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="border-bottom:1px solid #000000;border-right: 1px solid #000000;width:23%;" class="auto-style6">
                                             <table style="width:100%;">
                                                <tr><td style="font-size: 20px; color: rgba(75, 212, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;" colspan="6">电踏板支架线</td></tr>
                                                <tr>
                                                    <td>
                                                        <table style="width:100%;">
                                                            <tr>
                                                                <td colspan="2">当前能耗(KW/h)</td>
                                                                <td colspan="2">当前电流(A)</td>
                                                                <td colspan="2">当前电压(V)</td>
                                                            </tr>
                                                            <tr>
                                                                <td rowspan="3" style="font-size:20px;font-weight: bold;color:rgba(255, 255, 255, 1);" colspan="2"><label id="TbNowEnergy3">79</label></td>
                                                                <td>IA:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbIALab3">150</label></td>
                                                                <td>UA:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUALab3">342</label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>IB:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbIBLab3">162</label></td>
                                                                <td>UB:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUBLab3">361</label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>IC:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbICLab3">154</label></td>
                                                                <td>UC:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUCLab3">360</label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td>
                                                        <table style="width:100%;">
                                                            <tr>
                                                                <td style="font-size: 20px; color: rgba(75, 212, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;">总能耗</td>
                                                                <td style="font-size: 20px; color: rgba(255, 255, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;" ><label id="TbAllNHLab3">342</label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div id="echarts_bar_WeekFirstRate3"  class="auto-style5"  style="height: 290px; width:100%"></div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="border-bottom:1px solid #000000;border-right: 1px solid #000000;width:23%;" class="auto-style6">
                                            <table style="width:100%;">
                                                <tr><td style="font-size: 20px; color: rgba(75, 212, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;" colspan="6">电踏板主机一线</td></tr>
                                                <tr>
                                                    <td>
                                                        <table style="width:100%;">
                                                            <tr>
                                                                <td colspan="2">当前能耗(KW/h)</td>
                                                                <td colspan="2">当前电流(A)</td>
                                                                <td colspan="2">当前电压(V)</td>
                                                            </tr>
                                                            <tr>
                                                                <td rowspan="3" style="font-size:20px;font-weight: bold;color:rgba(255, 255, 255, 1);" colspan="2"><label id="TbNowEnergy7">79</label></td>
                                                                <td>IA:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbIALab7">150</label></td>
                                                                <td>UA:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUALab7">342</label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>IB:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbIBLab7">162</label></td>
                                                                <td>UB:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUBLab7">361</label></td>
                                                            </tr>
                                                            <tr>
                                                                <td>IC:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbICLab7">154</label></td>
                                                                <td>UC:</td>
                                                                <td style="color:rgba(255, 255, 255, 1);"><label id="TbUCLab7">360</label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table style="width:100%;">
                                                            <tr>
                                                                <td style="font-size: 20px; color: rgba(75, 212, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;">总能耗</td>
                                                                <td style="font-size: 20px; color: rgba(255, 255, 255, 1); text-shadow: 3px 2px 8px #5a5af7; font-weight: bold;text-align:center;" ><label id="TbAllNHLab7">342</label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div id="echarts_bar_WeekFirstRate7"  class="auto-style5"  style="height: 290px;  width:100%"></div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

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
            (function ($) {
                $.getUrlParam = function (name) {
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) return unescape(r[2]); return null;
                }
            })(jQuery);
            var welcomeMsg = $.getUrlParam('welcomeMsg');
            debugger
            if (welcomeMsg != null && welcomeMsg != "" && welcomeMsg != undefined) {
                $("#_left_top_welcome_text").html(welcomeMsg);
            }
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
            var echart1, echart2, echart3,echartBadDistribute,echartOEEDistribute,echartSafeLightAbnormal;
            var chartTemplate1 = null;
            var chartTemplate2 = null;
            var chartTemplate3 = null;
            var chartTemplate4 = null;
            var chartTemplate5 = null;
            var chartTemplate6 = null;
            var chartTemplate7 = null;
            var chartTemplate8 = null;
            var outFirstRate = 50;
            var outOEERate = 50;
            var outAchievedRate=50;
            var lineId, lineName;
            var timeInterval = 1000 * 60 * 2;
            $(document).ready(function () {
                /*设置title*/
                lineId = getQueryString("lineId");
                lineName = getQueryString("lineName");

                //$("#_left_top_title").html(lineName + "品质看板");

                //$("#_left_top_title").html(WhName + "备料看板");
                
                ResizeAll();
                //绑定预警记录表格数据
                bulidDataTb();
                /*获取第一个模块数据*/
                GetTemplateData1();
                /*获取第二个模块数据*/
                GetTemplateData2();
                /*获取第三个模块数据*/
                GetTemplateData3();
                /*获取第四个模块数据*/
                GetTemplateData4();
                /*获取第五个模块数据*/
                GetTemplateData5();
                /*获取第六个模块数据*/
                GetTemplateData6();
                /*获取第七个模块数据*/
                GetTemplateData7();
                /*获取第八个模块数据*/
                GetTemplateData8();
                /*获取所有能耗电流电压表信息*/
                GetEnergyTableData();
                //获取时间
                GetNowTime();
            });

            function GetEnergyTableData()
            {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/EnergyMonitoringKanBanData.ashx',
                    data: { "api": "GetEnergyTableData" },
                    dataType: "json",                
                    success: function (data) {
                        var xData = [];
                        var yData = [];
                        var myID = 0;
                        $.each(data, function (i, item) {
                            myID = i + 1;
                            $("#TbNowEnergy" + myID).html(item.NowEnergy);
                            $("#TbIALab" + myID).html(item.NowCurrentIA);
                            $("#TbIBLab" + myID).html(item.NowCurrentIB);
                            $("#TbICLab" + myID).html(item.NowCurrentIC);
                            $("#TbUALab" + myID).html(item.NowVoltageUA);
                            $("#TbUBLab" + myID).html(item.NowVoltageUB);
                            $("#TbUCLab" + myID).html(item.NowVoltageUC);
                            $("#TbAllNHLab" + myID).html(item.NowAllNH);
                        });
                    }
                });

                setTimeout("GetEnergyTableData()", 1000 * 60 * 5);
            }

            function GetTemplateData1()
            {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/EnergyMonitoringKanBanData.ashx',
                    data: { "api": "GetTemplateData1" },
                    dataType: "json",                
                    success: function (data) {
                        var xData = [];
                        var yData = [];
                        $.each(data, function (i, item) {
                            xData.push(item.TimeName);
                            yData.push(item.TimeCount);
                        });

                        // 初始化echarts实例
                        chartTemplate1 = echarts.init(document.getElementById('echarts_bar_WeekFirstRate1'));
                        var option = {
                            title: {
                                text: "能耗趋势分析(近12H)",
                                x: 'left',
                                textStyle: {
                                    fontSize: 15,
                                    color: 'rgba(75, 212, 255, 1)',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                    textShadowBlur: 15,
                                    textShadowOffsetX: 2,
                                    textShadowOffsetY: 2,
                                },
                                top: 3
                            },
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: [
                                {
                                    type: 'category',
                                    data: xData,
                                    axisTick: {
                                        alignWithLabel: true
                                    },
                                    axisLabel: {
                                        interval: 0,
                                        rotate: 44,
                                        textStyle: {
                                            color: '#378DBD',//坐标值得具体的颜色
                                            fontSize: 14,
                                        }
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                }
                            ],
                            yAxis: [
                                {
                                    type: 'value',
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                    splitLine: {
                                        lineStyle: {
                                            color: '#1f1529',
                                        }
                                    }
                                }
                            ],
                            series: [
                                {
                                    name: 'Kwh',
                                    type: 'line',
                                    smooth: true,
                                    itemStyle: {
                                        normal: {
                                            color: '#FDE669'
                                        }
                                    },
                                    label: {
                                        show: false
                                    },
                                    areaStyle: {
                                        color: '#055327'
                                    },
                                    data: yData
                                }
                            ]
                        };

                        // 使用刚指定的配置项和数据显示图表。
                        chartTemplate1.setOption(option);
                    }
                });

                setTimeout("GetTemplateData1()", 1000 * 60 * 5);
            }

            function GetTemplateData2()
            {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/EnergyMonitoringKanBanData.ashx',
                    data: { "api": "GetTemplateData2" },
                    dataType: "json",                
                    success: function (data) {
                        var xData = [];
                        var yData = [];
                        $.each(data, function (i, item) {
                            xData.push(item.TimeName);
                            yData.push(item.TimeCount);
                        });

                        // 初始化echarts实例
                        chartTemplate2 = echarts.init(document.getElementById('echarts_bar_WeekFirstRate2'));
                        var option = {
                            title: {
                                text: "能耗趋势分析(近12H)",
                                x: 'left',
                                textStyle: {
                                    fontSize: 15,
                                    color: 'rgba(75, 212, 255, 1)',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                    textShadowBlur: 15,
                                    textShadowOffsetX: 2,
                                    textShadowOffsetY: 2,
                                },
                                top: 3
                            },
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: [
                                {
                                    type: 'category',
                                    data: xData,
                                    axisTick: {
                                        alignWithLabel: true
                                    },
                                    axisLabel: {
                                        interval: 0,
                                        rotate: 44,
                                        textStyle: {
                                            color: '#378DBD',//坐标值得具体的颜色
                                            fontSize: 14,
                                        }
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                }
                            ],
                            yAxis: [
                                {
                                    type: 'value',
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                    splitLine: {
                                        lineStyle: {
                                            color: '#1f1529',
                                        }
                                    }
                                }
                            ],
                            series: [
                                {
                                    name: 'Kwh',
                                    type: 'line',
                                    smooth: true,
                                    itemStyle: {
                                        normal: {
                                            color: '#FDE669'
                                        }
                                    },
                                    label: {
                                        show: false
                                    },
                                    areaStyle: {
                                        color: '#055327'
                                    },
                                    data: yData
                                }
                            ]
                        };

                        // 使用刚指定的配置项和数据显示图表。
                        chartTemplate2.setOption(option);
                    }
                });

                setTimeout("GetTemplateData2()", 1000 * 60 * 5);
            }

            function GetTemplateData3()
            {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/EnergyMonitoringKanBanData.ashx',
                    data: { "api": "GetTemplateData3" },
                    dataType: "json",                
                    success: function (data) {
                        var xData = [];
                        var yData = [];
                        $.each(data, function (i, item) {
                            xData.push(item.TimeName);
                            yData.push(item.TimeCount);
                        });

                        // 初始化echarts实例
                        chartTemplate3 = echarts.init(document.getElementById('echarts_bar_WeekFirstRate3'));
                        var option = {
                            title: {
                                text: "能耗趋势分析(近12H)",
                                x: 'left',
                                textStyle: {
                                    fontSize: 15,
                                    color: 'rgba(75, 212, 255, 1)',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                    textShadowBlur: 15,
                                    textShadowOffsetX: 2,
                                    textShadowOffsetY: 2,
                                },
                                top: 3
                            },
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: [
                                {
                                    type: 'category',
                                    data: xData,
                                    axisTick: {
                                        alignWithLabel: true
                                    },
                                    axisLabel: {
                                        interval: 0,
                                        rotate: 44,
                                        textStyle: {
                                            color: '#378DBD',//坐标值得具体的颜色
                                            fontSize: 14,
                                        }
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                }
                            ],
                            yAxis: [
                                {
                                    type: 'value',
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                    splitLine: {
                                        lineStyle: {
                                            color: '#1f1529',
                                        }
                                    }
                                }
                            ],
                            series: [
                                {
                                    name: 'Kwh',
                                    type: 'line',
                                    smooth: true,
                                    itemStyle: {
                                        normal: {
                                            color: '#FDE669'
                                        }
                                    },
                                    label: {
                                        show: false
                                    },
                                    areaStyle: {
                                        color: '#055327'
                                    },
                                    data: yData
                                }
                            ]
                        };

                        // 使用刚指定的配置项和数据显示图表。
                        chartTemplate3.setOption(option);
                    }
                });

                setTimeout("GetTemplateData3()", 1000 * 60 * 5);
            }

            function GetTemplateData4()
            {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/EnergyMonitoringKanBanData.ashx',
                    data: { "api": "GetTemplateData4" },
                    dataType: "json",                
                    success: function (data) {
                        var xData = [];
                        var yData = [];
                        $.each(data, function (i, item) {
                            xData.push(item.TimeName);
                            yData.push(item.TimeCount);
                        });

                        // 初始化echarts实例
                        chartTemplate4 = echarts.init(document.getElementById('echarts_bar_WeekFirstRate4'));
                        var option = {
                            title: {
                                text: "能耗趋势分析(近12H)",
                                x: 'left',
                                textStyle: {
                                    fontSize: 15,
                                    color: 'rgba(75, 212, 255, 1)',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                    textShadowBlur: 15,
                                    textShadowOffsetX: 2,
                                    textShadowOffsetY: 2,
                                },
                                top: 3
                            },
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: [
                                {
                                    type: 'category',
                                    data: xData,
                                    axisTick: {
                                        alignWithLabel: true
                                    },
                                    axisLabel: {
                                        interval: 0,
                                        rotate: 44,
                                        textStyle: {
                                            color: '#378DBD',//坐标值得具体的颜色
                                            fontSize: 14,
                                        }
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                }
                            ],
                            yAxis: [
                                {
                                    type: 'value',
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                    splitLine: {
                                        lineStyle: {
                                            color: '#1f1529',
                                        }
                                    }
                                }
                            ],
                            series: [
                                {
                                    name: 'Kwh',
                                    type: 'line',
                                    smooth: true,
                                    itemStyle: {
                                        normal: {
                                            color: '#FDE669'
                                        }
                                    },
                                    label: {
                                        show: false
                                    },
                                    areaStyle: {
                                        color: '#055327'
                                    },
                                    data: yData
                                }
                            ]
                        };

                        // 使用刚指定的配置项和数据显示图表。
                        chartTemplate4.setOption(option);
                    }
                });

                setTimeout("GetTemplateData4()", 1000 * 60 * 5);
            }

            function GetTemplateData5()
            {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/EnergyMonitoringKanBanData.ashx',
                    data: { "api": "GetTemplateData5" },
                    dataType: "json",                
                    success: function (data) {
                        var xData = [];
                        var yData = [];
                        $.each(data, function (i, item) {
                            xData.push(item.TimeName);
                            yData.push(item.TimeCount);
                        });

                        // 初始化echarts实例
                        chartTemplate5 = echarts.init(document.getElementById('echarts_bar_WeekFirstRate5'));
                        var option = {
                            title: {
                                text: "能耗趋势分析(近12H)",
                                x: 'left',
                                textStyle: {
                                    fontSize: 15,
                                    color: 'rgba(75, 212, 255, 1)',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                    textShadowBlur: 15,
                                    textShadowOffsetX: 2,
                                    textShadowOffsetY: 2,
                                },
                                top: 3
                            },
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: [
                                {
                                    type: 'category',
                                    data: xData,
                                    axisTick: {
                                        alignWithLabel: true
                                    },
                                    axisLabel: {
                                        interval: 0,
                                        rotate: 44,
                                        textStyle: {
                                            color: '#378DBD',//坐标值得具体的颜色
                                            fontSize: 14,
                                        }
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                }
                            ],
                            yAxis: [
                                {
                                    type: 'value',
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                    splitLine: {
                                        lineStyle: {
                                            color: '#1f1529',
                                        }
                                    }
                                }
                            ],
                            series: [
                                {
                                    name: 'Kwh',
                                    type: 'line',
                                    smooth: true,
                                    itemStyle: {
                                        normal: {
                                            color: '#FDE669'
                                        }
                                    },
                                    label: {
                                        show: false
                                    },
                                    areaStyle: {
                                        color: '#055327'
                                    },
                                    data: yData
                                }
                            ]
                        };

                        // 使用刚指定的配置项和数据显示图表。
                        chartTemplate5.setOption(option);
                    }
                });

                setTimeout("GetTemplateData5()", 1000 * 60 * 5);
            }

            function GetTemplateData6()
            {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/EnergyMonitoringKanBanData.ashx',
                    data: { "api": "GetTemplateData6" },
                    dataType: "json",                
                    success: function (data) {
                        var xData = [];
                        var yData = [];
                        $.each(data, function (i, item) {
                            xData.push(item.TimeName);
                            yData.push(item.TimeCount);
                        });

                        // 初始化echarts实例
                        chartTemplate6 = echarts.init(document.getElementById('echarts_bar_WeekFirstRate6'));
                        var option = {
                            title: {
                                text: "能耗趋势分析(近12H)",
                                x: 'left',
                                textStyle: {
                                    fontSize: 15,
                                    color: 'rgba(75, 212, 255, 1)',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                    textShadowBlur: 15,
                                    textShadowOffsetX: 2,
                                    textShadowOffsetY: 2,
                                },
                                top: 3
                            },
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: [
                                {
                                    type: 'category',
                                    data: xData,
                                    axisTick: {
                                        alignWithLabel: true
                                    },
                                    axisLabel: {
                                        interval: 0,
                                        rotate: 44,
                                        textStyle: {
                                            color: '#378DBD',//坐标值得具体的颜色
                                            fontSize: 14,
                                        }
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                }
                            ],
                            yAxis: [
                                {
                                    type: 'value',
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                    splitLine: {
                                        lineStyle: {
                                            color: '#1f1529',
                                        }
                                    }
                                }
                            ],
                            series: [
                                {
                                    name: 'Kwh',
                                    type: 'line',
                                    smooth: true,
                                    itemStyle: {
                                        normal: {
                                            color: '#FDE669'
                                        }
                                    },
                                    label: {
                                        show: false
                                    },
                                    areaStyle: {
                                        color: '#055327'
                                    },
                                    data: yData
                                }
                            ]
                        };

                        // 使用刚指定的配置项和数据显示图表。
                        chartTemplate6.setOption(option);
                    }
                });

                setTimeout("GetTemplateData6()", 1000 * 60 * 5);
            }

            function GetTemplateData7() {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/EnergyMonitoringKanBanData.ashx',
                    data: { "api": "GetTemplateData7" },
                    dataType: "json",
                    success: function (data) {
                        var xData = [];
                        var yData = [];
                        $.each(data, function (i, item) {
                            xData.push(item.TimeName);
                            yData.push(item.TimeCount);
                        });

                        // 初始化echarts实例
                        chartTemplate7 = echarts.init(document.getElementById('echarts_bar_WeekFirstRate7'));
                        var option = {
                            title: {
                                text: "能耗趋势分析(近12H)",
                                x: 'left',
                                textStyle: {
                                    fontSize: 15,
                                    color: 'rgba(75, 212, 255, 1)',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                    textShadowBlur: 15,
                                    textShadowOffsetX: 2,
                                    textShadowOffsetY: 2,
                                },
                                top: 3
                            },
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: [
                                {
                                    type: 'category',
                                    data: xData,
                                    axisTick: {
                                        alignWithLabel: true
                                    },
                                    axisLabel: {
                                        interval: 0,
                                        rotate: 44,
                                        textStyle: {
                                            color: '#378DBD',//坐标值得具体的颜色
                                            fontSize: 14,
                                        }
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                }
                            ],
                            yAxis: [
                                {
                                    type: 'value',
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                    splitLine: {
                                        lineStyle: {
                                            color: '#1f1529',
                                        }
                                    }
                                }
                            ],
                            series: [
                                {
                                    name: 'Kwh',
                                    type: 'line',
                                    smooth: true,
                                    itemStyle: {
                                        normal: {
                                            color: '#FDE669'
                                        }
                                    },
                                    label: {
                                        show: false
                                    },
                                    areaStyle: {
                                        color: '#055327'
                                    },
                                    data: yData
                                }
                            ]
                        };

                        // 使用刚指定的配置项和数据显示图表。
                        chartTemplate7.setOption(option);
                    }
                });

                setTimeout("GetTemplateData7()", 1000 * 60 * 5);
            }

            function GetTemplateData8() {
                $.ajax({
                    type: "post",
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/EnergyMonitoringKanBanData.ashx',
                    data: { "api": "GetTemplateData8" },
                    dataType: "json",
                    success: function (data) {
                        debugger
                        // 初始化echarts实例
                        chartTemplate8 = echarts.init(document.getElementById('echarts_bar_WeekFirstRate8'));
                        var option = {
                            title: {
                                text: "制造一部二部总能耗KW/H",
                                x: 'left',
                                textStyle: {
                                    fontSize: 15,
                                    color: 'rgba(75, 212, 255, 1)',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                    textShadowBlur: 15,
                                    textShadowOffsetX: 2,
                                    textShadowOffsetY: 2,
                                },
                                top: 3
                            },
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            legend: {
                                data: ['制造一部', '制造二部'],
                                textStyle: {
                                    fontSize: 15,
                                    color: 'rgba(75, 212, 255, 1)',          // 主标题文字颜色
                                    textShadowColor: '#5a5af7',
                                    textShadowBlur: 15,
                                    textShadowOffsetX: 2,
                                    textShadowOffsetY: 2,
                                }
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: [
                                {
                                    type: 'category',
                                    data: data.Echarts.Axis,
                                    axisTick: {
                                        alignWithLabel: true
                                    },
                                    axisLabel: {
                                        interval: 0,
                                        rotate: 44,
                                        textStyle: {
                                            color: '#378DBD',//坐标值得具体的颜色
                                            fontSize: 14,
                                        }
                                    },
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                }
                            ],
                            yAxis: [
                                {
                                    type: 'value',
                                    axisLine: {
                                        lineStyle: {
                                            color: '#378DBD',
                                        }
                                    },
                                    splitLine: {
                                        lineStyle: {
                                            color: '#1f1529',
                                        }
                                    }
                                }
                            ],
                            series: [
                                {
                                    name: '制造一部',
                                    type: 'bar',
                                    smooth: true,
                                    itemStyle: {
                                        normal: {
                                            color: '#84F5F7'
                                        }
                                    },
                                    label: {
                                        show: false
                                    },
                                    areaStyle: {
                                        color: '#84F5F7'
                                    },
                                    data: data.Echarts.Series[0]
                                },
                                {
                                    name: '制造二部',
                                    type: 'bar',
                                    smooth: true,
                                    itemStyle: {
                                        normal: {
                                            color: '#B2F29D'
                                        }
                                    },
                                    label: {
                                        show: false
                                    },
                                    areaStyle: {
                                        color: '#B2F29D'
                                    },
                                    data: data.Echarts.Series[1]
                                }
                            ]
                        };

                        // 使用刚指定的配置项和数据显示图表。
                        chartTemplate8.setOption(option);
                    }
                });

                setTimeout("GetTemplateData8()", 1000 * 60 * 5);
            }

            /**
            *   获取URL参数值
            **/
            function getQueryString(name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]); return null;
            }

            function GetNowTime() {
                $("#dateAndWeek").html($.trim(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeekHour().value));
                setTimeout("GetNowTime()", 1000);
            }

            $(window).resize(function () {
                ResizeAll();
                if (chartTemplate1 != null) { chartTemplate1.resize(); }
                if (chartTemplate2 != null) { chartTemplate2.resize(); }
                if (chartTemplate3 != null) { chartTemplate3.resize(); }
                if (chartTemplate4 != null) { chartTemplate4.resize(); }
                if (chartTemplate5 != null) { chartTemplate5.resize(); }
                if (chartTemplate6 != null) { chartTemplate6.resize(); }
                if (chartTemplate7 != null) { chartTemplate7.resize(); }
                if (chartTemplate8 != null) { chartTemplate8.resize(); }
            });

            function ResizeAll() {
                //某些浏览器不兼容div自适应高度
                var _contentHeight = $(window).height() * 1 * 0.3;
                $("#_layout_left_data_div_tbody").css("height", "auto");
                $(".rows").height(_contentHeight * 0.1)
                if ($(".rows").length * _contentHeight * 0.1 > _contentHeight) {
                    $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.16 * 2 - 2);
                    _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", 1000, 150, 1000 * 6);
                    isScroll = true;
                }
            }
            //绑定表格数据
            function bulidDataTb() {

                $.ajax({
                    type: 'POST',
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/EnergyMonitoringKanBanData.ashx',
                    data: { 'api': 'DjListData' },
                    dataType: 'json',                
                    success: function (data) {
                        var html = "";
                        if (data == null) { return false; }
                        $.each(data.List, function () {
                            html += "<tr class=\"rows\">" +
                                "<td style=\"width:10%\">" + this.TimeName + "</td>" +
                                "<td style=\"width:60%\">" + this.EqumentName + "</td>" +
                                "<td style=\"width:30%\">" + this.MissgeData + "</td>" +
                                "</tr>";
                        });
                        debugger;
                        document.getElementById("dataList").innerHTML = html;
                        ResizeAll();
                        debugger;
                    }, error: function (e) {
                        debugger;
                    }
                });
                setTimeout("bulidDataTb()", 1000 * 60 * 5);
            }

        </script>
    </form>
</body>
</html>
