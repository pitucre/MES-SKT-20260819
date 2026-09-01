<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/Masters.master"
    CodeBehind="LineProductLoadList.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.LineProductLoadList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-1.9.1.js"></script>
    <link href="../Content/tableJs/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" />
    <script src="../Content/plugin/tabs/jPlugin-tabs.js"></script>
    <script src="../Content/plugin/echarts/echarts.min.js"></script>
    <style type="text/css">
        body {
            padding-top: 50px;
            padding-bottom: 30px;
        }

        table.table > tbody > tr > td {
            height: 28px;
            vertical-align: middle;
        }

        .width100 {
            min-width: 100px;
        }

        .width120 {
            min-width: 120px;
        }

        .width140 {
            min-width: 140px;
        }

        .toolBar {
            height: 27px;
            padding: 0px 0px 0px 0px;
            margin: 0px 0px 2px 0px;
            background: url(../content/images/l_bg_hover.gif) repeat-x;
            position: relative;
            z-index: 1;
            width: 100%;
        }

        .toolbar-btn {
            float: left;
            padding: 1px 2px 1px 2px;
            margin: 4px 0px 0px 5px;
            height: 20px;
            display: inline;
        }

        .icon-16-view {
            background: url(../content/images/icon/view.png) no-repeat;
            width: 16px;
            height: 16px;
            float: left;
            margin-right: 3px;
            margin-top: 2px;
        }


        .btn-text {
            float: left;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 12px;
            line-height: 18px;
            *line-height: 22px;
            height: 22px;
            text-decoration: none;
        }

        input[type=checkbox] {
            margin: 0px;
        }

        #div2 ::-webkit-scrollbar {
            display: none;
        }

        .divPreview {
            width: 900px;
            overflow: auto;
            height: 208px;
        }

            .divPreview td, th {
                /*border: 1px solid gray;*/
                width: 100px;
                height: 30px;
            }

            .divPreview th {
                background-color: #ffffff;
            }

            .divPreview table {
                table-layout: fixed;
                width: 200px;
            }

            .divPreview td:first-child.td1, th:first-child {
                position: sticky;
                left: 0;
                z-index: 1;
                background-color: #ffffff;
            }

            .divPreview thead tr th {
                position: sticky;
                top: 0;
            }

        th:first-child {
            z-index: 2;
        }
    </style>
    <style>
       .bordered  {
            cellspacing:0 ;
            *border-collapse: collapse; /* IE7 and lower */
            border-spacing: 0;
            width: 100%;
        }
        .bordered tr:hover {
            background: #fbf8e9;
            -o-transition: all 0.1s ease-in-out;
            -webkit-transition: all 0.1s ease-in-out;
            -moz-transition: all 0.1s ease-in-out;
            -ms-transition: all 0.1s ease-in-out;
            transition: all 0.1s ease-in-out;
        }
 
        .bordered th {
            padding: 7px;
            text-align: center;
            cellspacing:0;
        }
 
        .bordered td{
            padding: 7px;
            text-align: center;
            cellspacing:0;
        }
 
 
        .bordered th {
 
             background-image: -webkit-gradient(linear, left top, left bottom, from(#ebf3fc), to(#dce9f9));
             background-image: -webkit-linear-gradient(top, #ebf3fc, #dce9f9);
             background-image:    -moz-linear-gradient(top, #ebf3fc, #dce9f9);
             background-image:     -ms-linear-gradient(top, #ebf3fc, #dce9f9);
             background-image:      -o-linear-gradient(top, #ebf3fc, #dce9f9);
             background-image:         linear-gradient(top, #ebf3fc, #dce9f9);
        }
        /*.bordered td:first-child, .bordered th:first-child {
            border-left: none;
        }*/
 
 
 
        .bordered  tr:nth-of-type(2n){background:#FFFFFF;cursor: pointer;}
        .bordered  tr:nth-of-type(2n+1){background:#F7FAFC;cursor: pointer;}
 
        .bordered  tbody tr:hover{  background: #fbf8e9;
            -o-transition: all 0.1s ease-in-out;
            -webkit-transition: all 0.1s ease-in-out;
            -moz-transition: all 0.1s ease-in-out;
            -ms-transition: all 0.1s ease-in-out;
            transition: all 0.1s ease-in-out;
        }
 
 
    </style>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="EditeContentTable" style="width: 100%; margin: 2px;">
        <tr>
            <td id="Td1" class="Label3">资源
            </td>
            <td class="Field3">
                <input type="text" id="txtLineName" class="TextBox" /><input type="button" id="bnOper"
                    class="ButtonBox" onclick="openChoosePage(6)" value="..." />
            </td>
            <td>
                <div id="bnView" style="font-size: 16px; width: 80px; cursor: pointer; float: left; margin-left: 40%; text-decoration: underline;">
                    <img src="../Content/images/search.png" /><%=Resources.lang.Search%>
                </div>
            </td>


        </tr>


    </table>
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current">表格查询</li>
            <li class="">图表展示</li>
        </ul>
        <div id="divReport" class="tb_c">
            <div style="position: relative; width: 1240px" id="divPreview" class="divPreview">

                <table id="tblPreview" class="table table-bordered " style="width: 1240px; vertical-align: middle; position: absolute;word-break:break-all">
                    <thead id="thd1">
                    </thead>
                    <tbody id="tby1">
                    </tbody>
                </table>

            </div>
        </div>
        <div id="divChart" class="">
            <div id="ChartContainer">
            </div>
        </div>
    </div>


    <script type="text/javascript">


      
        var option, echart;

        option = {
            title: {
                text: '<%=Resources.lang.ResourceProductionLoad%>'
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'shadow'
                }
            },
            toolbox: {
                feature: {
                    dataView: {
                        show: true,
                        title: '<%=Resources.lang.ResourceProductionLoad%>',
                        readOnly:false,
                        optionToContent: function(opt) {
                         
                            var dataview = opt.toolbox[0].feature.dataView;  //获取dataview
                            var table = '<div style="position:absolute;top: 5px;left: 0px;right: 0px;line-height: 1.4em;text-align:center;font-size:14px;">'+dataview.title+'</div>'
                            table += getTable(opt);
                            return table;
                        }
                       

                    },
                    //magicType: {show: true, type: ['bar']},
                    //restore: {show: true},

                    saveAsImage: {show: true}
                }
            },
            legend: {
                data: []
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
                    axisLabel:{
                        interval:0,
                        rotate:45,//倾斜度 -90 至 90 默认为0
                        margin:15,
                        textStyle:{
                            fontWeight:"bolder",
                            color:"#000000"
                        }
                    },
                    data: [],
                    axisPointer: {
                        type: 'shadow'
                    }
                   
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    name: '',
                        //min: 0,
                        //max: 100,
                    interval: 10,
                    axisLabel: {
                        formatter: '{value} %',
                        textStyle:{
                            fontWeight:"bolder",
                            color:"#000000"
                        }
                    }
                },
            ],
            series: []
        };


        var DayArr = [];
        var dayTime,shiftId;
        var nowdate = new Date();
        var iframeWidth = (document.body.clientWidth < 1366 ? 1366 : document.body.clientWidth) - 10;
        var width12 = parseInt(iframeWidth * 0.12);
        var width10 = parseInt(iframeWidth * 0.11);
        var width4 = parseInt(iframeWidth * 0.065);
        var width8 = parseInt(iframeWidth * 0.08);
        var width9 = parseInt(iframeWidth * 0.09);
        var width7 = parseInt(iframeWidth * 0.065);
        var module = '<%=Request.QueryString["module"] %>';
        if (module == 1) {
            $("#toolbar>div")[0].style.display = "none";
            $("#toolbar>div")[1].style.display = "none";
        }
        $(function () {
            Load();
            $("#bnView").bind("click", function() {
                List();
            });
           

        });


        function getTable(opt){
            var axisData = opt.xAxis[0].data;
            var series = opt.series;//获取series
            var num = 0;
            var sum = new Array();
            for(var i=0; i<series.length; i++){
                sum[i] = 0;
            }
            var table = '<table class="bordered"><thead><tr>'
                + '<th>日期</th>';
            for(var i=0; i<series.length;i++){
                table += '<th>'+series[i].name+'(负荷%)</th>'
            }
          
            table += '</tr></thead><tbody>';
            for (var i = 0, l = axisData.length; i < l; i++) {
                num += 1;
                for(var n=0;n<series.length;n++){
                    if(series[n].data[i]){
                        sum[n] += Number(series[n].data[i]);
                    }else{
                        sum[n] += Number(0);
                    }
 
                }
                table += '<tr>';
                if (i == axisData.length-1) {
                        table += '<td>' + axisData[i].value + '</td>';
                    } else {
                        table += '<td>' + axisData[i] + '</td>';
                    }
                  
                for(var j=0; j<series.length;j++){
                    if (series[j].data[i]) {
                      
                        table += '<td>' + series[j].data[i] + '%</td>';
                    }else{
                        table += '<td>' + 0 + '%</td>';
                    }
 
                }
                table += '</tr>';
            }
         
       
            table += '</tbody></table>';
            return table;
        }

        function Load() {
           
            List();
            //var iframeWidth = (document.body.clientWidth < 1366 ? 1366 : document.body.clientWidth)-10;
            //var divPreview = document.getElementById('divPreview');
            //var resizeContainer = function () {
            //    divPreview.style.width = window.innerWidth - 25 + 'px';
            //    divPreview.style.height = window.innerHeight - 127 + 'px';
            //};
        
            //$("#tblPreview").css("width", iframeWidth + "px");
            //$("#divPreview").css("width", iframeWidth + "px");
            //$("#divPreview").css("width", iframeWidth + "px");

            //$("#ChartContainer").css("width", iframeWidth + "px");
            //$("#ChartContainer").css("height", iframeHeight + "px");
        }

        function initEcharts(data) {
         
            var container=document.getElementById('ChartContainer');
            var divPreview = document.getElementById('divPreview');
            var resizeContainer = function () {
                container.style.width = window.innerWidth - 25 + 'px';
                container.style.height = window.innerHeight - 127 + 'px';
                divPreview.style.width = window.innerWidth - 25 + 'px';
                divPreview.style.height = window.innerHeight - 127 + 'px';
            };
            resizeContainer();
            echart = echarts.init(container);
            option.series = [];
            option.xAxis[0].data = data.XAxis;
            option.xAxis[0].data[data.XAxis.length - 1] =
            {
                value: data.XAxis[data.XAxis.length - 1],
                textStyle: {
                    color: '#447DFF',
                    fontWeight: 'bold'
                }
            };

            //设置Legen值
            option.legend.data = data.Legend;
            /*默认插入空值显示时间段，后续有数据则清空*/
            option.series.push({
                name: '',
                type: 'bar',
                yAxisIndex: 0,
                data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                label: {
                    normal: {
                        show: true,
                        position: 'inside',
                        textStyle: {
                            color: '#3CA2B0',
                            fontWeight: 'lighter',
                            fontSize: 10
                        },
                        formatter: function (p) {
                            if (p.value === 0) { return ""; }
                            return p.value;
                        }
                    }
                }
            });
          
            if (data == null || data.Series == null || data.Series.length < 1) { return false; }
            if (data.Series[0].length > 0) { option.series = []; }

            for (var i = 0; i < data.Series[0].length; i++) {

                var arrOutput = new Array();

                for (var j = 0; j < data.Series.length; j++) {
                    arrOutput.push(data.Series[j][i].LineLoad);
                }

                option.series.push({
                    name: data.Series[0][i].LineName,
                    type: 'bar',
                    barGap: 0,
                    yAxisIndex: 0,
                    data: arrOutput,
                    label: {
                        normal: {
                            show: true,
                            position: 'inside',
                            textStyle: {
                                color: '#FFFFFF',
                                fontWeight: 'lighter',
                                fontSize: 10
                            },
                            //formatter: '{c}%'
                        }
                    }
                    //,itemStyle: {
                    //    normal: {
                    //        color: function(p) {
                    //            var colorList = ['#32e0e7', '#148fe4', '#fbfa23', '#32E0E7', '#826A4F', '#51DE8A', '#fbfa23', '#447DFE', '#95CA13', '#1EB950', '#266CA3', '#CA8622', '#25851D', '#ADC7B8'];
                    //            var index = p.seriesIndex;
                    //            return colorList[index / (data.Series[0].length + 1)];
                    //        }
                    //    }
                    //}
                });
              
            }

            echart.setOption(option,true);
        }
   
        function GetDayArr() {
            var dayNum = SKT.LeanMES.Web.Plan.LineProductLoadList.GetPreviewDays().value;
            var currentDate = nowdate.getTime();
            DayArr = [];
            for (var i = 0; i <dayNum; i++) {
                var oneDateTime = new Date(currentDate + i * 86400000);
                var one = ReturnTime(oneDateTime);
                DayArr.push(one);
            }
        }
        function List() {
            GetDayArr();
            var html = "";   //表1数据
            html += "<tr><th style=\"min-width:" + width12 + "px\" class=\"td1\"><%=Resources.lang.AC_Resource%></th><th style=\"min-width:" + width12 + "px\"><%=Resources.lang.OrderNum%></th><th style=\"min-width:" + width4 + "px\"><%=Resources.lang.Layout%></th><th style=\"min-width:" + width9 + "px\"><%=Resources.lang.ProductCode%></th>";
            for (var k = 0; k < DayArr.length; k++) {
                var dt = new Date(DayArr[k]).getDay();
                if (dt == 0 || dt == 6) {
                    html += " <th style=\"min-width:" + width7 + "px;background-color: beige;\">" + DayArr[k] + "</th>";
                } else {
                    html += " <th style=\"min-width:" + width7 + "px\">" + DayArr[k] + "</th>";
                }
               
            }
            html += "</tr>";
            $("#thd1").html(html);
            html = "";
            var rowSpan = 0;
            //获取排产工单列表
          
            var ajax = SKT.LeanMES.Web.Plan.LineProductLoadList.GetLineSchedulLoadList($("#txtLineName").val(),"");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (ajax.error == null) {
                var result = ajax.value.Legend;
                var resultDatas = ajax.value.Table;
                for (var i = 0; i < result.length; i++) {
                    var lineName = result[i];
                    var lineAjax=resultDatas.Rows.filter(function(resultDatas) { return resultDatas.LineName ==lineName });
                  
                    if (lineAjax.length > 0) {
                        rowSpan = lineAjax.length;
                    } else {
                        rowSpan = 1;
                    }
                    html += '<tr><td style="min-width:' + width12 + 'px;font-weight:bold;" rowspan="' + rowSpan + '" class="td1">' + lineName + '</td>';
                  
                    if (lineAjax.length > 0) {
                        for (var j = 0; j < lineAjax.length; j++) {
                            if (j != 0) {
                                html += '<tr>';
                            }
                            var tableName = lineAjax[j]["TableName"];
                            var orderNo = lineAjax[j]["OrderNO"];
                            var itemCode = lineAjax[j]["ItemCode"];
                            html += '<td  style="min-width:' + width12 + 'px">' + orderNo + '</td>';
                            html += '<td  style="min-width:' + width4 + 'px"  "> '+ tableName + '</label></td>';
                            html += '<td  style="min-width:' + width9 + 'px"  "> '+ itemCode + '</label></td>';
                            
                            for (var f = 0; f < DayArr.length; f++) {
                                var dt1 = new Date(DayArr[f]).getDay();
                                if (dt1 == 0 || dt1 == 6) {
                                    html += '<td style="min-width:' + width7 + 'px;background-color: beige;">';
                                } else {
                                    html += '<td style="min-width:' + width7 + 'px">';
                                }
                                html += lineAjax[j][DayArr[f]]+"</td>";
                                
                            }
                            html += "</tr>";
                        }
                    } 
                    html += "</tr>";
                }
                initEcharts(ajax.value);
            }
            $("#tby1").html(html);
        }

  

        function ReturnTime(twoDateTime) {

            var twoMonth = twoDateTime.getMonth() + 1;
            var twoDate = twoDateTime.getDate();
            var two = twoDateTime.getFullYear() + '-' + (twoMonth > 9 ? twoMonth : '0' + twoMonth) + '-' + (twoDate > 9 ? twoDate : '0' + twoDate);
            return two;
        }
        
        function openChoosePage(flags) {
            var condition = "";
            dialog({ title: "选择窗口", src: "../Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&SearchCondition=" + condition + "&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
        
            $("#txtLineName").val(list[0][1]);
        }

        function InsertOrder() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/PlanInsertOrder.aspx?name=Plan_InsertOrder";
            dialog({ title: "生产插单", src: openWinUrl, width: 1000, height: 520 });
           
        }
    </script>


</asp:Content>


