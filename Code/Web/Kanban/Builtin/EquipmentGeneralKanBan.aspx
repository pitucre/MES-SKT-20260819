<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentGeneralKanBan.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.EquipmentGeneralKanBan" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <link href="../../Content/svg/iconfont.css" rel="stylesheet" />
    <link href="../../Content/plugin/liMarquee/jQuery.liMarquee.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot%>/Content/plugin/liMarquee/jQuery.liMarquee.js" type="text/javascript"></script>
    <!-- ECharts单文件引入 -->
    <script src="../../Content/js/echarts.min.js"></script>
    <title>设备概况看板</title>
    <link href="../../Content/index.css" rel="stylesheet" />

</head>
<body>
    <div id="app">
        <%-- <div class="_t">
            <div class="_c">
                <div class="_c_lf">
                    <div class="_c_lf_img" style="/*width: 150px; height: 20px*/">
                        <img
                            src="../../Content/images/logo/skt-logo.png"
                            class="_c_lf_img_inner"
                            style="object-fit: cover" />
                    </div>
                </div>
                <div class="_c_lf_company">
                    <span>设备概况看板</span>
                </div>
               
            </div>
        </div>--%>
        <div class="_head">
            <div class="flex_w logo">
                <div class="flex_w_img" style="width: 100%; height: 100%; display: flex;">
                    <img src="../../Content/images/logo/skt-logo.png" class="flex_w_img_inner" style="object-fit: cover" alt="" />
                </div>
            </div>
            <div class="flex_w title">设备概况看板</div>
            <div class="flex_w time" id="dateAndWeek"></div>
        </div>
        <div class="_t" style="margin: 10px 0px">
            <div class="_c">
                <div class="_c_lf">
                    <div class="_h_c_lf_dashboard">
                        <div class="iconfont dashboard">&#xeb94;</div>
                        <div>DASHBOARD</div>
                        <div>设备概览</div>
                    </div>
                </div>
                <div class="_c_lf_company StatusDesc" style="width:73%;font-size:10px">
                    <div class="_h_c_ctr_flex">
                        <span
                            class="iconfont _h_c_ctr_all"
                            style="color: rgb(101, 219, 252)">&#xe71e;
                        </span>
                        <span>全部</span>
                        <span class="number_m" id="AllCount">0</span>
                    </div>
                    <div class="_h_c_ctr_flex">
                        <span
                            class="iconfont _h_c_ctr_all"
                            style="color: rgb(101, 208, 152)">&#xeacb;
                        </span>
                        <span>工作</span>
                        <span class="number_m" id="ProductionCount">0</span>
                    </div>
                    <div class="_h_c_ctr_flex">
                        <span
                            class="iconfont _h_c_ctr_all"
                            style="color: #8b92f3">&#xe7ac;
                        </span>
                        <span>空闲</span>
                        <span class="number_m" id="AwaitCount">0</span>
                    </div>
                    <div class="_h_c_ctr_flex">
                        <span class="iconfont _h_c_ctr_all" style="color: red">&#xe6a0;
                        </span>
                        <span>故障</span>
                        <span class="number_m" id="BreakdownCount">0</span>
                    </div>
                    <div class="_h_c_ctr_flex">
                        <span class="iconfont _h_c_ctr_all" style="color: grey">&#xe60e;
                        </span>
                        <span>离线</span>
                        <span class="number_m" id="OfflineCount">0</span>
                    </div>
                </div>
             
            </div>
        </div>
        <div class="content">
            <div class="content_top">
                <div class="content_top_left">
                    <div class="content_top_left2">

                        <%-- <div class="ifarme">
                        <div class="ifarme_t">12</div>
                        <div class="ifarme_c">
                            <div class="ifarme_left">
                                <div class="_c_lf_img" style="width: 100px; height: 100px">
                                    <img
                                        src="https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg"
                                        class="_c_lf_img_inner"
                                        style="object-fit: cover" />
                                </div>
                            </div>
                            <div class="ifarme_right">
                                <div class="ifarme_right_m">
                                    <div class="ifarme_right_m_f">GMOC-CS20231118003</div>
                                    <div class="ifarme_right_m_f">泵固定架</div>
                                    <div class="ifarme_right_m_f">3000</div>
                                    <div class="ifarme_right_m_f">运行</div>
                                </div>
                            </div>
                        </div>
                    </div>--%>
                    </div>
                   <%-- <div class="page_ctrl">
                        <span class="page_total"></span>
                        <span class="page_text">页</span>
                        <button class="prev_page btn_dis" disabled>上一页</button>
                        <button class="next_page">下一页</button>
                    </div>--%>
                </div>
            </div>
            <%--<div class="content_bottom">
                <div class="content_bottom_c">
                    <div class="content_bottom_c_t">
                        <div class="content_bottom_c_t_l">
                            <span class="iconfont dashboard _h_c_ctr_all">&#xe609;</span>
                            <span class="_h_c_ctr_all _tl">BOOT UTILIZATION</span>
                            <span>开机利用率</span>
                        </div>
                        <div class="content_bottom_c_t_r">
                            <span class="iconfont dashboard">&#xe64d;</span>
                            <span class="_h_c_ctr_all" id="NowDay"></span>
                        </div>
                    </div>
                    <div class="content_bottom_c_b">
                        <div class="content_bottom_c_b_p">
                            <div class="content_bottom_c_b_r">
                                <div class="content_bottom_c_b_r_c">
                                    <div class="content_bottom_c_b_r_c_l">
                                        <div class="content_bottom_c_b_r_c_l_n" id="YesterDay">0%</div>
                                        <div style="color: white">昨天</div>
                                    </div>
                                    <div class="content_bottom_c_b_r_c_l" id="pieChart"></div>
                                </div>
                                <div class="content_bottom_c_b_r_c">
                                    <div class="content_bottom_c_b_r_c_l">
                                        <div class="content_bottom_c_b_r_c_l_n" id="ServenDay">0%</div>
                                        <div style="color: white">最近7天</div>
                                    </div>
                                    <div class="content_bottom_c_b_r_c_l" id="pieChart1"></div>
                                </div>
                                <div class="content_bottom_c_b_r_c">
                                    <div class="content_bottom_c_b_r_c_l">
                                        <div class="content_bottom_c_b_r_c_l_n" id="ThreeDay">0%</div>
                                        <div style="color: white">最近30天</div>
                                    </div>
                                    <div class="content_bottom_c_b_r_c_l" id="pieChart2"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="content_bottom_c">
                    <div class="content_bottom_c_t">
                        <div class="content_bottom_c_t_l">
                            <span class="iconfont dashboard _h_c_ctr_all">&#xe791;</span>
                            <span class="_h_c_ctr_all _tl chart_f">CHART</span>
                            <span>OEE曲线</span>
                        </div>
                    </div>
                    <div class="content_bottom_c_b">
                        <div class="content_bottom_c_b_p">
                            <div class="content_bottom_c_b_r" id="lineChart"></div>
                        </div>
                    </div>
                </div>
            </div>--%>
        </div>
    </div>
    <form runat="server">
        <script type="text/javascript">
            var workshopId;
            var autoPageInterval = null;
            let dataSource = [];
            let totalCount = 0; //内容总数
            let pageIndex = 1; //当前页数
            let pageSize = 24; //一屏展示多少数据
            let pageCount = Math.ceil(totalCount / (pageSize * pageIndex));

            $(document).ready(() => {
                workshopId = getQueryString("workshopId");
                if (!workshopId) {
                    workshopId = -1;
                }

                getKanbanData();

                //getRecentPowerRate();

                ResizeAll();

                //3分钟自动分页（如果手动点击了上一页、下一页、则需要重置时间）              
                setAutoInterval();

                //15秒刷新一次设备状态图、列表数据
               

                //setInterval(function () { getRecentPowerRate(); }, 1000 * 15);

                $('.next_page').click(() => {
                    pageIndex++
                    $('.input_page_num').val(pageIndex)
                    $('.prev_page').removeClass('btn_dis').removeAttr('disabled')
                    $('.content_top_left2').empty();
                    let data = pagination(dataSource, pageSize, pageIndex);
                    appendHtml(data)

                    if (pageIndex >= pageCount) {
                        $('.next_page').addClass('btn_dis')
                        $('.next_page').attr('disabled', 'disabled')
                    }
                    setAutoInterval();
                    return false;
                })
                $('.prev_page').click(() => {
                    pageIndex--
                    $('.input_page_num').val(pageIndex)
                    $('.next_page').removeClass('btn_dis').removeAttr('disabled')
                    $('.content_top_left2').empty();
                    let data = pagination(dataSource, pageSize, pageIndex);
                    appendHtml(data)

                    setAutoInterval();
                    return false;
                })
                $('.input_page_num').blur(() => {
                    let num = $('.input_page_num').val()
                    pageIndex = Math.ceil(parseInt($('.input_page_num').val()))
                    if (isNaN(parseFloat(num)) || pageIndex > pageCount || pageIndex <= 1) {
                        pageIndex = 1
                        $('.prev_page').addClass('btn_dis')
                        $('.prev_page').attr('disabled', 'disabled')
                        $('.next_page').removeClass('btn_dis').removeAttr('disabled')
                    }
                    $('.input_page_num').val(pageIndex)
                    $('.content_top_left2').empty();
                    let data = pagination(dataSource, pageSize, pageIndex);
                    appendHtml(data)

                    return false;
                })

              


                function getKanbanData() {

                    var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspFinishWarehousEquipment", JSON.stringify({ WorkshopId: workshopId }));
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    var data = JSON.parse(ajax.value).data;
                    var data1 = JSON.parse(ajax.value).data1; 
                    if (data != null && data.length > 0) {
                        appendHtml1(data);

                        //var htmlstr = "";
                         
                        //$("#AllCount").html(data[0]["AllCount"]);
                        //$("#ProductionCount").html(data[0]["ProductionCount"]);
                        //$("#AwaitCount").html(data[0]["AwaitCount"]);
                        //$("#BreakdownCount").html(data[0]["BreakdownCount"]);
                        //$("#OfflineCount").html(data[0]["OfflineCount"]);
                    }

                    dataSource = data1;

                    init();

                    setInterval(function () { getKanbanData(); }, 1000 * 5 * 60);
                }


                function appendHtml1(data) {
                  
                    $('.StatusDesc').empty();
                    let obj = {}
                    data.forEach(item => {

                        str = `<div class="_h_c_ctr_flex" style="margin:0 5px;">
                            <span class="iconfont _h_c_ctr_all" style="color: ` + (item.StatusDesc == '生产' ? "background-color: rgb(69 189 73 / 48%)" : item.StatusDesc == '新购买' ? "background-color: grey" : item.StatusDesc == '空闲中' ? "background-color: #8b92f3" : (item.StatusDesc.indexOf('故障') > -1) ? "background-color:red" :"") + `">&#xe71e;
                            </span>
                            <span>${item.StatusDesc}</span>
                            <span class="number_m" >${item.Qty}</span>
                        </div>`

                        $(".StatusDesc").append(str)
                        
                    });
                }
                /**
                * 初始化eacharts 
                * 可在后台返回数据后处理好数据在调用initEchart方法
                * @param {String} id 
                * @param {Object} options eacharts配置项 
                * @returns 
                */
                function initEchart(id, options) {
                    let echartsData = echarts.init($(id)[0])
                    window.addEventListener("resize", function () {
                        //console.log(echartsData, $(id))
                        echartsData.resize();
                    });
                    setEachartOptions(echartsData, options)
                }


                /**
                * 给eacharts赋值渲染
                * @param {Object} echartsData eacharts对象
                * @param {Object} options eacharts配置项 
                */
                function setEachartOptions(echartsData, options) {
                    echartsData.setOption(options)
                }
            })

            //初始化
            function init() {
                totalCount = dataSource.length; //内容总数

               

                pageCount = Math.ceil(totalCount / pageSize);
                $('.content_top_left2').empty();
                let str;
                let data = pagination(dataSource, pageSize, pageIndex);
                appendHtml(data);

                //if (pageIndex >= pageCount) {
                //    $('.next_page').addClass('btn_dis')
                //    $('.next_page').attr('disabled', 'disabled')
                //}
            }

            function appendHtml(data) {
                //if (data.length == 0) {
                //    $(".page_ctrl").hide();
                //} else {
                //    $(".page_ctrl").show();
                //}

                let obj = {}
                data.forEach(item => {
                  
                    str = `<div class="ifarme" style="width:calc(16% - 1px)">
	                            <div class="ifarme_t">
		                            <span style="` + (item.Status == '通讯中断' ? "background-color: #808080" : item.CurrentStatusdManger == '生产' ? "background-color: rgb(69 189 73 / 48%)" : item.CurrentStatusdManger == '新购买' ? "background-color: grey" : item.CurrentStatusdManger == '空闲中' ? "background-color: #8b92f3" : (item.CurrentStatusdManger.indexOf('故障') > -1) ? "background-color:red" : "") + `">${item.EquipmentName}</span>
		                            <span>${item.OrderNo}</span>
	                            </div>
	                            <div class="ifarme_c">
		                            <div class="ifarme_left" style="position:relative">
			                            <div class="_c_lf_img" style="width: 100%; height: 100%">
				                            `+ (item.PictureName == "未载入" ? '<img src="../../Content/images/wf_node.png" class="_c_lf_img_inner" style="object-fit: contain">' : '<img src="/ESOP/DownLoad.aspx?Action=FileUploadEquiment&amp;fileName=${item.PictureName}" class="_c_lf_img_inner" style="object-fit: contain">') + `
			                            </div>
		                            </div>
		                            <div class="ifarme_right">
			                            <div class="ifarme_right_m">
                                            <div class ="ifarme_right_m_f" style="margin-top:5px;margin-bottom:5px;">${item.ItemCode}</div>
				                            <div class ="ifarme_right_m_f" style="margin-top:5px;margin-bottom:5px;">${item.Qty_to_Build}</div>
                                             <div class ="ifarme_right_m_f" style="margin-top:5px;margin-bottom:5px;">${item.Qty_Released}</div>
				                            <div class ="ifarme_right_m_f" style="margin-top:5px;margin-bottom:5px;">${item.Status}</div>
                                            <div class ="ifarme_right_m_f" style="margin-top:5px;margin-bottom:5px;">${item.CurrentStatusdManger}</div>
			                            </div>
		                            </div>
	                            </div>
                            </div>`

                    $(".content_top_left2").append(str)
                    //if (pageIndex >= pageCount) {
                    //    $('.next_page').addClass('btn_dis')
                    //    $('.next_page').attr('disabled', 'disabled')
                    //    $('.prev_page').removeClass('btn_dis').removeAttr('disabled')
                    //}
                    //if (pageIndex <= 1) {
                    //    $('.prev_page').addClass('btn_dis')
                    //    $('.prev_page').attr('disabled', 'disabled')
                    //}
                    // console.log(item)
                });
            }
            function pageTotalInit() {
                $('.page_total').html(`当前第${pageIndex}页 共${pageCount}页 共${totalCount}条`)
            }

            /**
             * pagination 分页方法
             * @param {Array} data 数据源
             * @param {Number} pageSize 分页下拉框选中的值
             * @param {Number} pageIndex 当前页数
             * @returns {Array} result
             */
            function pagination(dataSource, pageSize, pageIndex) {
                let start = (pageIndex - 1) * pageSize;
                let end = start + pageSize;
                let result = dataSource.slice(start, end);

                pageTotalInit();

                return result;
            }

            //设置自动翻页
            function setAutoInterval() {
                if (autoPageInterval != null) {
                    clearInterval(autoPageInterval);
                }
                //3分钟自动分页（如果手动点击了上一页、下一页、则需要重置时间）              
                autoPageInterval = setInterval(function () {
                    startAutoPage();
                }, 1000 * 30);
                //}, 1000 * 60 * 3);
            }

            //启用自动分页
            function startAutoPage() {
                if (pageCount <= 1) {
                    return;
                }
                $('.content_top_left2').empty();
                if (pageIndex < pageCount) {
                    pageIndex++
                  
                    let data = pagination(dataSource, pageSize, pageIndex);
                    appendHtml(data)
                    setAutoInterval();
                    return false;
                } else {
                    //翻到第一页
                
                    pageIndex = 1;
                    $('.prev_page').removeClass('btn_dis').addClass('btn_dis').attr('disabled', 'disabled');
                    $('.next_page').removeClass('btn_dis').removeAttr('disabled');
                    let data = pagination(dataSource, pageSize, pageIndex);
                    appendHtml(data);
                    if (pageIndex == pageCount) {
                        $('.next_page').addClass('btn_dis')
                        $('.next_page').attr('disabled', 'disabled')
                    }
                }
            }
            function ResizeAll() {

                //某些浏览器不兼容div自适应高度
                //$(".gauge").height($(window).height() * 0.9 * 0.27);
                var _contentHeight = $(window).height() * 1 * 0.80;
                $(".rows").height(_contentHeight * 0.08)
                if ($(".rows").length * _contentHeight * 0.085 > _contentHeight) {
                    $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.14 * 1 - 1);
                    _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 22, 1000 * 10);
                    isScroll = true;
                }
            }
            function getQueryString(name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]); return "";
            }
        </script>
    </form>

</body>

</html>
