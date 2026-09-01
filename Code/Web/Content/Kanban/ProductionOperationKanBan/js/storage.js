// 基于准备好的dom，初始化echarts实例
var myChart = echarts.init(document.getElementById('NightingaleChart'));
// console.log(myChart, document.getElementById('NightingaleChart'))
// 指定图表的配置项和数据
//var option = {
//    color: [
//        '#089b81',
//        '#034c51',
//        '#748e9b',
//        // '#639fac'
//    ],
//    fontSize: 5,
//    // padding: [3, 10, 10, 5],
//    title: {
//        text: '',
//        subtext: '',
//        left: 'center'
//    },
//    tooltip: {
//        trigger: 'item',
//        formatter: '{a} <br/>{b} : {c} ({d}%)'
//    },
//    legend: {
//        left: 'right',
//        top: 'center',
//        orient: 'vertical',
//        textStyle: {
//            color: 'white'
//        }

//    },
//    series: [{
//        name: 'Radius Mode',
//        type: 'pie',

//        radius: [20, 50],
//        center: ['50%', '70%'],
//        roseType: 'radius',
//        itemStyle: {
//            borderRadius: 5,
//            //
//        },
//        label: {
//            formatter(ar) {
//                return ar.name + ' :  ' + ar.value + '   ' + ar.percent + '%'
//            }
//            //show: true,
//            //normal: {
//            //    fontSize: '12',
//            //    color: 'white'
//            //}

//        },
//        emphasis: {
//            label: {
//                show: true,
//                // fontSize: '30',
//                // fontWeight: 'bold'
//            }
//        },
//        data: [{
//            value: 33,
//            name: '中(60-330)',
//            itemStyle: {
//                normal: {
//                    borderWidth: 4,
//                    shadowBlur: 100,

//                    //borderColor: '#6fb0ba',
//                    //shadowColor: '#089b81'
//                }
//            }
//        },
//        {
//            value: 28,
//            name: '小60以下',
//            itemStyle: {
//                normal: {
//                    borderWidth: 4,
//                    shadowBlur: 100,
//                    //borderColor: '#6fb0ba',
//                    //shadowColor: '#089b81'
//                }
//            }
//        },
//        {
//            value: 40,
//            name: '大(330分以上)',
//            itemStyle: {
//                normal: {
//                    borderWidth: 4,
//                    shadowBlur: 100,
//                    //borderColor: '#6fb0ba',
//                    //shadowColor: '#089b81'
//                }
//            }
//        },
//        ]
//    },

//    ]
//};
// 使用刚指定的配置项和数据显示图表。


var labelData = [];
var labelData1 = [];
for (var i = 0; i < 150; ++i) {
    labelData.push({
        value: 1,
        name: i,
        itemStyle: {
            normal: {
                color: 'rgba(0,209,228,0)',
            }
        }
    });
}
for (var i = 0; i < labelData.length; ++i) {
    if (labelData[i].name < 50) {
        labelData[i].itemStyle = {
            normal: {
                color: new echarts.graphic.LinearGradient(
                    0, 1, 0, 0,
                    [{
                        offset: 0,
                        color: '#6dfbff'
                    },
                    {
                        offset: 1,
                        color: '#02aeff'
                    }
                    ]
                )
            },

        }
    }
}
for (var i = 0; i < 150; ++i) {
    labelData1.push({
        value: 1,
        name: i,
        itemStyle: {
            normal: {
                color: 'rgba(0,209,228,0)',
            }
        }
    });
}
for (var i = 0; i < labelData1.length; ++i) {
    if (labelData1[i].name < 150) {
        labelData1[i].itemStyle = {
            normal: {
                color: '#464451',
            },

        }
    }
}

function Pie() {
    let dataArr = [];
    for (var i = 0; i < 100; i++) {
        if (i % 10 === 0) {
            dataArr.push({
                name: (i + 1).toString(),
                value: 30,
                itemStyle: {
                    normal: {
                        color: "rgba(0,255,255,1)",
                        borderWidth: 0,
                        borderColor: "rgba(0,0,0,0)",
                    }
                }
            })
        } else {
            dataArr.push({
                name: (i + 1).toString(),
                value: 100,
                itemStyle: {
                    normal: {
                        color: "rgba(0,0,0,0)",
                        borderWidth: 0,
                        borderColor: "rgba(0,0,0,0)"
                    }
                }
            })
        }
    }
    return dataArr
}

function Pie1() {
    let dataArr = [];
    for (var i = 0; i < 100; i++) {
        if (i % 5 === 0) {
            dataArr.push({
                name: (i + 1).toString(),
                value: 20,
                itemStyle: {
                    normal: {
                        color: "rgba(0,255,255,1)",
                        borderWidth: 0,
                        borderColor: "rgba(0,0,0,0)"
                    }
                }
            })
        } else {
            dataArr.push({
                name: (i + 1).toString(),
                value: 100,
                itemStyle: {
                    normal: {
                        color: "rgba(0,0,0,0)",
                        borderWidth: 0,
                        borderColor: "rgba(0,0,0,0)"
                    }
                }
            })
        }
    }
    return dataArr
}

function Pie2() {
    let dataArr = [];
    for (var i = 0; i < 100; i++) {
        if (i % 5 === 0) {
            dataArr.push({
                name: (i + 1).toString(),
                value: 20,
                itemStyle: {
                    normal: {
                        color: "rgba(0,255,255,.3)",
                        borderWidth: 0,
                        borderColor: "rgba(0,0,0,0)"
                    }
                }
            })
        } else {
            dataArr.push({
                name: (i + 1).toString(),
                value: 100,
                itemStyle: {
                    normal: {
                        color: "rgba(0,0,0,0)",
                        borderWidth: 0,
                        borderColor: "rgba(0,0,0,0)"
                    }
                }
            })
        }
    }
    return dataArr
}

function Pie3() {
    let dataArr = [];
    for (var i = 0; i < 100; i++) {
        if (i % 10 === 0) {
            dataArr.push({
                name: (i + 1).toString(),
                value: 30,
                itemStyle: {
                    normal: {
                        color: "rgba(0,255,255,.5)",
                        borderWidth: 0,
                        borderColor: "rgba(0,0,0,0)"
                    }
                }
            })
        } else {
            dataArr.push({
                name: (i + 1).toString(),
                value: 100,
                itemStyle: {
                    normal: {
                        color: "rgba(0,0,0,0)",
                        borderWidth: 0,
                        borderColor: "rgba(0,0,0,0)"
                    }
                }
            })
        }
    }
    return dataArr
}
option = {
    title: {
        text: 'OEE',
        x: '50%',
        top: 'middle',
        textAlign: 'center',
        textStyle: {
            fontSize: '16',
            fontWeight: '100',
            color: '#79ffff',
            textAlign: 'center',
        },
    },
    polar: {
        radius: ['51%', '47%'],
        center: ['50%', '50%'],
    },
    angleAxis: {
        max: 100,
        show: false,
        startAngle: 0,
    },
    radiusAxis: {
        type: 'category',
        show: true,
        axisLabel: {
            show: false,
        },
        axisLine: {
            show: false,

        },
        axisTick: {
            show: false
        },
    },
    series: [{
        name: '',
        type: 'bar',
        roundCap: true,
        barWidth: 60,
        showBackground: true,
        backgroundStyle: {
            color: '#464451',
        },
        data: [75],
        coordinateSystem: 'polar',
        itemStyle: {
            normal: {
                color: new echarts.graphic.LinearGradient(1, 0, 0, 0, [{
                    offset: 0,
                    color: '#0ff'
                }, {
                    offset: 1,
                    color: '#02aeff'
                }]),
            }
        }
    },
    {
        hoverAnimation: false,
        type: 'pie',
        z: 2,
        data: labelData,
        radius: ['52%', '59%'],
        zlevel: -2,
        itemStyle: {
            normal: {
                borderColor: '#1f1e26',
                borderWidth: 4,
            }
        },
        label: {
            normal: {
                position: 'inside',
                show: false,
            }
        },
    },
    {
        hoverAnimation: false,
        type: 'pie',
        z: 1,
        data: labelData1,
        radius: ['52%', '59%'],
        zlevel: -2,
        itemStyle: {
            normal: {
                borderColor: '#1f1e26',
                borderWidth: 4,
            }
        },
        label: {
            normal: {
                position: 'inside',
                show: false,
            }
        },
    },
    {
        type: 'pie',
        radius: ['42%', '43%'],
        center: ['50%', '50%'],
        data: [{
            hoverOffset: 1,
            value: 100,
            name: '',
            itemStyle: {
                color: '#ff6189',
            },
            label: {
                show: false
            },
            labelLine: {
                normal: {
                    smooth: true,
                    lineStyle: {
                        width: 0
                    }
                }
            },
            hoverAnimation: false,
        },
        {
            label: {
                show: false
            },
            labelLine: {
                normal: {
                    smooth: true,
                    lineStyle: {
                        width: 0
                    }
                }
            },
            value: 100 - 75,
            hoverAnimation: false,
            itemStyle: {
                color: '#3c3a48',
            },
        }
        ]
    },

    {
        type: 'pie',
        zlevel: 0,
        silent: true,
        radius: ['67%', '65.5%'],
        z: 1,
        label: {
            normal: {
                show: false
            },
        },
        labelLine: {
            normal: {
                show: false
            }
        },
        data: Pie()
    },
    {
        type: 'pie',
        zlevel: 0,
        silent: true,
        startAngle: -150,
        radius: ['65%', '63.5%'],
        z: 1,
        label: {
            normal: {
                show: false
            },
        },
        labelLine: {
            normal: {
                show: false
            }
        },
        data: Pie3()
    },
    {
        type: 'pie',
        zlevel: 0,
        silent: true,
        startAngle: -140,
        radius: ['68%', '66.5%'],
        z: 1,
        label: {
            normal: {
                show: false
            },
        },
        labelLine: {
            normal: {
                show: false
            }
        },
        data: Pie()
    },
    {
        type: 'pie',
        zlevel: 0,
        silent: true,
        radius: ['61%', '60%'],
        z: 1,
        label: {
            normal: {
                show: false
            },
        },
        labelLine: {
            normal: {
                show: false
            }
        },
        data: Pie1()
    },
    {
        type: 'pie',
        zlevel: 0,
        silent: true,
        startAngle: -140,
        radius: ['61%', '60%'],
        z: 1,
        label: {
            normal: {
                show: false
            },
        },
        labelLine: {
            normal: {
                show: false
            }
        },
        data: Pie2()
    },
    {
        type: 'pie',
        zlevel: 0,
        silent: true,
        startAngle: -147.5,
        radius: ['61%', '60%'],
        z: 1,
        label: {
            normal: {
                show: false
            },
        },
        labelLine: {
            normal: {
                show: false
            }
        },
        data: Pie2()
    },

    ]
};

var myChart1 = echarts.init(document.getElementById('Histogram'));

var option1 = {
    legend: {
        data: [ '完成数量'],
    },
    xAxis: [{
        type: "category",
        data: ['8:00', '10:00', '12:00', '14:00', '16:00', '18:00', '20:00', '22:00', '24:00'],
        axisLine: {
            lineStyle: {
                color: '#00a0e9',
            }
        },

    }],

    yAxis: [
        {
            type: 'value',
            name: '数量',
            min: 0,
            max: 700,
            interval: 100,
            axisLabel: {
                formatter: '{value}',
                color: 'white',

            },
            axisLine: {

                lineStyle: {
                    color: '#00a0e9',
                }
            },
            splitLine: {
                show: false,
                lineStyle: {
                    color: '#00a0e9',
                }
            }
        }
    ],
    series: [
        {
            type: 'bar',
            name: '完成数量',
            barWidth: 24.5,
            data: [260, 240, 180, 220, 230, 200, 270, 320, 360],
            itemStyle: {
                normal: {
                    color: new echarts.graphic.LinearGradient(
                        0,
                        1,
                        0,
                        0,
                        [
                            {
                                offset: 0,
                                color: '#043245' // 0% 处的颜色
                            },
                            {
                                offset: 0.6,
                                color: '#038772' // 60% 处的颜色
                            },
                            {
                                offset: 1,
                                color: '#02c593' // 100% 处的颜色
                            }
                        ],
                        false
                    )
                }
            },
            // barGap: 0,
            label: {
                normal: {
                    show: true,
                    position: 'top',
                    textStyle: {
                        color: '#fff',
                        fontSize: 12
                    }
                }
            }
        }
    ]
};








