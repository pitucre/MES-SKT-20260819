<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentEarlyWarningBoard.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentEarlyWarningBoard" MasterPageFile="~/Masters/ViewMaster.master" %>


<asp:Content ContentPlaceHolderID="viewcontent" runat="server">
    <style>
        .Label2 {
            width: 10%;
            height: 45px;
            font-size: 16px !important;
            text-align: right;
        }
    </style>
    <div class="clear5">
    </div>
    <div  style="width: 1150px; height: 50%;">
     <div style="width: 600px; float: left; height: 360px; text-align: center; " id="divLoading1"></div>
        <div style="width: 450px; float: right; height: 360px; text-align: right;" id="divLoading2"></div>
    </div>
    <hr style="border: 2px brown;width: 1350px"/>
     <div  style="width: 1150px;height: 50%">
      <div style="width: 600px; float: left; height: 360px; text-align: center;" id="divLoading3"></div>
         <div style="width: 450px; float: right; height: 360px; text-align: right;" id="divLoading4" ></div>
    </div>
    <asp:HiddenField ID="lbFileReady" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="HiddenField1" runat="server" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>  
 <%--<script src="../Content/plugin/charts/FusionCharts.js" type="text/javascript"></script>--%>
  <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/echarts.min.js" type="text/javascript"></script>
<script type="text/javascript">
    var hideCharts = false; //隐藏图表
    var data1 = 0;
    var data2 = 0;
    var data3 = 0;
    var data4 = 0;
    var data5 = 0;
    var data6 = 0;
    var data7 = 0;
    var data8 = 0;
    var data9 = 0;
    var data10 = 0;
    var data11 = 0;
    var data12 = 0;
    $(function () {

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EquipmentEarlyWarning();
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }

        var data = $.parseJSON(ajax.value).data;
        data1 = data[0].Value;
        data2 = data[1].Value;
        data3 = data[2].Value;
        data4 = data[3].Value;
        data5 = data[4].Value;
        data6 = data[5].Value;
        data7 = data[6].Value;
        data8 = data[7].Value;
        data9 = data[8].Value;
        data10 = data[9].Value;
        data11 = data[10].Value;
        data12 = data[11].Value;

        if (!hideCharts) {

            char1();
            char2();
            char3();
            char4();
        }
    });
    function FullScreen() {
        window.open("EquipmentEarlyWarningBoard.aspx");
    }

    function char1() {
        option = {
            title: {
                text: mesLang('保养计划预警信息'),
                textStyle: {
                    align: 'center',
                },
                top: '5%',
                left: 'center',
            },
            xAxis: {
                type: 'category',
                data: [mesLang('超期未执行计划'), mesLang('今日到期'), mesLang('明日到期'), mesLang('本月计划')]
            },
            yAxis: {
                type: 'value'
            },
            series: [
                {
                    barWidth: 60,
                    itemStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(0, 1, 0, 0, [{
                                offset: 0,
                                color: "#1268f3" // 0% 处的颜色
                            }, {
                                offset: 0.6,
                                color: "#08a4fa" // 60% 处的颜色
                            }, {
                                offset: 1,
                                color: "#01ccfe" // 100% 处的颜色
                            }], false)
                        }
                    },
                    data: [data1, data2, data3, data4],
                    type: 'bar'
                }
            ]
        };
        echart1 = echarts.init(document.getElementById('divLoading1'));
        echart1.setOption(option, true);
    }

    function char2() {
        option = {
            title: {
                text: mesLang('保养记录预警'),
                textStyle: {
                    align: 'center',
                },
                top: '5%',
                left: 'center',
            },
            xAxis: {
                type: 'category',
                data: [mesLang('本月保养记录'), mesLang('上月保养记录')]
            },
            yAxis: {
                type: 'value'
            },
            series: [
                {
                    barWidth: 60,
                    itemStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(0, 1, 0, 0, [{
                                offset: 0,
                                color: "#1268f3" // 0% 处的颜色
                            }, {
                                offset: 0.6,
                                color: "#08a4fa" // 60% 处的颜色
                            }, {
                                offset: 1,
                                color: "#01ccfe" // 100% 处的颜色
                            }], false)
                        }
                    },
                    data: [data5, data6],
                    type: 'bar'
                }
            ]
        };
        echart2 = echarts.init(document.getElementById('divLoading2'));
        echart2.setOption(option, true);

    }
    function char3() {
        option = {
            title: {
                text: mesLang('设备校验预警'),
                textStyle: {
                    align: 'center',
                },
                top: '5%',
                left: 'center',
            },
            xAxis: {
                type: 'category',
                data: [mesLang('超期未检设备'), mesLang('三天内检查'), mesLang('本月到期'), mesLang('下月到期')]
            },
            yAxis: {
                type: 'value'
            },
            series: [
                {
                    barWidth: 60,
                    itemStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(0, 1, 0, 0, [{
                                offset: 0,
                                color: "#1268f3" // 0% 处的颜色
                            }, {
                                offset: 0.6,
                                color: "#08a4fa" // 60% 处的颜色
                            }, {
                                offset: 1,
                                color: "#01ccfe" // 100% 处的颜色
                            }], false)
                        }
                    },
                    data: [data7, data8, data9, data10],
                    type: 'bar'
                }
            ]
        };
        echart3 = echarts.init(document.getElementById('divLoading3'));
        echart3.setOption(option, true);
    }

    function char4() {
        option = {
            title: {
                text: mesLang('备件预警'),
                textStyle: {
                    align: 'center',
                },
                top: '5%',
                left: 'center',
            },
            xAxis: {
                type: 'category',
                data: [mesLang('库存不足'), mesLang('库存超出上限')]
            },
            yAxis: {
                type: 'value'
            },
            series: [
                {
                    barWidth: 60,
                    itemStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(0, 1, 0, 0, [{
                                offset: 0,
                                color: "#1268f3" // 0% 处的颜色
                            }, {
                                offset: 0.6,
                                color: "#08a4fa" // 60% 处的颜色
                            }, {
                                offset: 1,
                                color: "#01ccfe" // 100% 处的颜色
                            }], false)
                        }
                    },
                    data: [data11, data12],
                    type: 'bar'
                }
            ]
        };
        echart4 = echarts.init(document.getElementById('divLoading4'));
        echart4.setOption(option, true);

    }
</script>
</asp:Content>
