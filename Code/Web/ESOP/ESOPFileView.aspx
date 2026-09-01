<%@ Page Language="C#" AutoEventWireup="true" Inherits="SKT.LeanMES.Web.Product.ESOPFileView"
    CodeBehind="ESOPFileView.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title> <%= Resources.Common.AppName%></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <script src="../Content/js/jquery.min.js" type="text/javascript"></script>
    <script src="../Content/js/jquery.media.js" type="text/javascript"></script> 
    <link href="../Content/Video/css/video-js.min.css" rel="stylesheet" />
    <script src="../Content/Video/js/video.min.js" type="text/javascript"></script>

    <style type="text/css">
        .video-js{
           position: absolute;
            top:0;
            left: 0;
            width: 100%;
            height: 95%
        }
        .videobox {
          width: 100%;
          height: 100%;
          position: absolute;
          left: 0;
          top: 0;
          overflow: hidden;
        }
        video {width: 1px;display: blcok;}
 
        #banner
        {
            position: relative;
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-size: 16px;
            margin: 5px auto;
        }
        #banner_list img
        {
            border: 0px;
        }
        #banner_bg
        {
            width: 705px;
            position: absolute;
            color: #fff;
            bottom: 0;
        }
        #banner_info
        {
            position: absolute;
            bottom: 0px;
            left: 5px;
            height: 38px;
            line-height: 38px;
            color: #fff;
            z-index: 1001;
            cursor: pointer;
        }
        #banner ul
        {
            position: absolute;
            list-style-type: none;
            z-index: 1002;
            margin: 0;
            padding: 0;
            bottom: 8px;
            right: 5px;
        }
        #banner ul li
        {
            width: 40px;
            border: 1px #ccc solid;
            height: 40px;
            float: left;
            display: block;
            cursor: pointer;
            margin: 1px auto;
            background: url(../v2_images/scropoint.png) no-repeat;
            overflow: hidden;
            color: #a3a1a2;
            font-size: 22px;
            line-height: 40px;
            text-align: center;
        }
        #banner ul li.on
        {
            border: 1px yellow solid;
            background: url(../v2_images/scropoint_on.png) no-repeat;
            background-color:black;
            color: white;
        }
        #banner_list a
        {
            /*position: absolute;*/
            display: block;
        }
        body
        {
            margin: 0px;
            padding: 0px;
        }
        #disappare
        {
            left: 50%;
            top: 50%;
            border: 3px solid #ccc;
            border-radius: 5px;
            background: #fff;
            z-index: 9999;
            width: 500px;
            height: 200px;
            margin-left: -250px;
            margin-top: -100px;
            position: absolute;
            text-align: center;
            line-height: 40px;
        }
        #disappare p
        {
            padding: 50px;
            font-size: 24px;
        }
        select
        {
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 12px;
            border: 1px solid #aaaaaa;
            padding: 1px 1px 1px 2px;
            height: 22px;
            line-height: 22px;
            margin: 3px;
            -moz-border-radius-topleft: 4px;
            -moz-border-radius-topright: 4px;
            -moz-border-radius-bottomleft: 4px;
            -moz-border-radius-bottomright: 4px;
            -webkit-border-top-left-radius: 4px;
            -webkit-border-top-right-radius: 4px;
            -webkit-border-bottom-left-radius: 4px;
            -webkit-border-bottom-right-radius: 4px;
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
            border-bottom-right-radius: 4px;
            border-bottom-left-radius: 4px;
        }
        input.TextBox {
        border: solid 1px #aaaaaa;
        font-family: Verdana, 微软雅黑,黑体, 宋体;
        font-size: 16px;
        font-weight:bold;
        height: 22px;
        outline: none;
        line-height: 22px;
        vertical-align: middle;
        padding-left: 2px;
        padding-right: 2px;
        -moz-border-radius-topleft: 4px;
        -moz-border-radius-topright: 4px;
        -moz-border-radius-bottomleft: 4px;
        -moz-border-radius-bottomright: 4px;
        -webkit-border-top-left-radius: 4px;
        -webkit-border-top-right-radius: 4px;
        -webkit-border-bottom-left-radius: 4px;
        -webkit-border-bottom-right-radius: 4px;
        border-top-left-radius: 4px;
        border-top-right-radius: 4px;
        border-bottom-right-radius: 4px;
        border-bottom-left-radius: 4px;
    }

   
   html { height:100%;}
   body { height:100%; text-align:center;}
  
/* 分页按钮的样式 */
.pagination input {
     margin: 0 10px;
     padding: 8px 16px;
     font-size: 16px;
     background-color: #333;
     color: #fff;
     border: none;
     cursor: pointer;
     flex-shrink: 0; /* 防止按钮收缩 */
     transition: background-color 0.3s;
     border-radius: 5px; /* 按钮圆角 */
 }

    </style>
</head>
<body style="overflow-x: hidden; font-family: Verdana, 微软雅黑,黑体, 宋体;">
    <form id="form1" runat="server" onsubmit="return false;">
    <div id="banner">
    </div>
    <div id="mediaEsop">
    </div>
    <div id="disappare" style="display: none;">
        <p id="updatediv">
        </p>
    </div>       
    <div id="divStation" style="position: absolute; bottom: 2px; width: 100%;">
        <div id="station" style=" float:left; font-size:13px;">
            &nbsp;<b>
                <%=Resources.lang.Station %></b>
            <select  id="ddlOperations" name="ddlOperations" class="select">
                <option value="-1">
                    <%=Resources.lang.Choose %><%=Resources.lang.Station %></option>
            </select>
            <b>
                <%=Resources.lang.Resource %></b>
            <select id="ddlResources" name="ddlResources" class="select">
                <option value="-1">
                    <%=Resources.lang.Choose %><%=Resources.lang.Resource %></option>
            </select>
            <asp:HiddenField ID="hidMachineMac" runat="server" ClientIDMode="Static"/>
        </div>
        <div class="pagination" id="pageButtons">
            <input type="button" id="btnChangeMac" class="wide"  value="配置MAC地址"  onclick="changeMac()" />
            <input type="button" id="btnShang"  class="wide" value="上一页" />
            <span id="myPagespan">
            </span>
            <input type="button" id="btnXia"  class="wide" value="下一页" />
            <input type="button" id="btnBig"  class="wide" value="放大" />
            <input type="button" id="btnMin"  class="wide" value="缩小"  />
            <input type="button" id="btnFull2"  class="wide" value="暂停轮播"  />
            <input type="button" id="btnFull" class="wide"  value="全屏"  />
            <input type="button" id="btnExit" class="wide" style="display:none;" value="退出"  />
            <input type="button" id="btnHidePage"  class="wide" style="display:none;" value="隐藏页码"  />
            <input type="button" id="btnBack" class="wide"  value="返回注塑机台"  />
        </div>
    </div>
    <input id="hdnItemID" type="hidden" />
    </form>
      <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script type="text/javascript">
        var n = 0;
        var t;
        var pdfInterval;
        var count=0; //定义所需变量
        var intervalTime = 0;
        var currentTime = '<%=DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") %>';
        var esopInterval;
        var refreshTime = 3 * 1000;
        var stationid = -1;
        var resourceid = -1;
        var fileType = "";
        var isPaused = true;
        var clientHeight = document.documentElement.clientHeight - 40;
        var clientWidth = document.documentElement.clientWidth;
        var zoomFactor = 1.1;
        var zoomFactor2 = 0.9;
        $().ready(function () {      
            /*隐藏页码*/
            var $btnHidePage = document.getElementById("btnHidePage");//隐藏页码 
            if ($btnHidePage) {
                $btnHidePage.addEventListener("click", function () {
                    if ($btnHidePage.value == "显示页码") {
                        $("#MyyeMa").show();
                        $btnHidePage.value = "隐藏页码"
                    }
                    else {
                        $("#MyyeMa").hide();
                        $btnHidePage.value = "显示页码"
                    }
                }, false);
            }
            /*上一页*/
            var $btnShang = document.getElementById("btnShang");//上一页 
            if ($btnShang) {
                $btnShang.addEventListener("click", function () {
                    if (fileType == "pdf") {
                        var i = $(".media").length;
                        if (i > 1) {
                            $(".media").each(function (k) {
                                $(this).hide();
                            });
                            count = count == 0 ? (i -1): --count;
                            $($(".media")[count]).show();
                        }

                    } else {
                        $("#banner_list a").stop(true, true);
                        n = n = 0 ? count : --n; //如果n>=图片总个数的话重新赋值为0，也就是从头算起，达到自动切换到第一张的效果 
                        $("#banner li").eq(n).trigger('click');
                        LoadPageBtn();
                    }
                   
                }, false);
            }
            /*下一页*/
            var $btnXia = document.getElementById("btnXia");//下一页 
            if ($btnXia) {
                $btnXia.addEventListener("click", function () {
                    if (fileType == "pdf") {
                        var i = $(".media").length;
                        if (i > 1) {
                            $(".media").each(function (k) {
                                $(this).hide();
                            });
                            count = count >= (i - 1) ? 0 : ++count;
                            $($(".media")[count]).show();
                        }

                    } else {
                        $("#banner_list a").stop(true, true);
                        n = n >= count ? 0 : ++n; //如果n>=图片总个数的话重新赋值为0，也就是从头算起，达到自动切换到第一张的效果 
                        $("#banner li").eq(n).trigger('click');
                        LoadPageBtn();
                    }
                   
                }, false);
            }
            /*放大*/
            var $btnBig = document.getElementById("btnBig");//放大 
            if ($btnBig) {
                $btnBig.addEventListener("click", function () {
                    $('.myimg').css('width', function (index, value) {
                        return parseFloat(value) * zoomFactor;
                    });
                    $('.myimg').css('height', function (index, value) {
                        return parseFloat(value) * zoomFactor;
                    });
                }, false);
            }
            /*缩小*/
            var btnMin = document.getElementById("btnMin");//缩小 
            if (btnMin) {
                btnMin.addEventListener("click", function () {
                    $('.myimg').css('width', function (index, value) {
                        return parseFloat(value) * zoomFactor2;
                    });
                    $('.myimg').css('height', function (index, value) {
                        return parseFloat(value) * zoomFactor2;
                    });
                }, false);
            }
            /*暂停轮播*/
            var $fullScreen2 = document.getElementById("btnFull2");//暂停轮播 
            if ($fullScreen2) {
                $fullScreen2.addEventListener("click", function () {
                    if (!isPaused) {
                        t = setInterval("showAuto()", intervalTime);
                        isPaused = true;
                        $fullScreen2.value = '暂停轮播';
                        if (fileType == "pdf") {

                            var pdfQty = $(".media").length;
                            pdfInterval = setInterval(function () {
                                count++;
                                if (count >= pdfQty) {
                                    count = 0;
                                }
                                $(".media").hide();
                                $(".media").eq(count).show();
                                var iframeObj = $(".media").eq(count).children("iframe");
                                $(iframeObj).attr("src", $(iframeObj).attr("src"));

                            }, intervalTime);
                        } else {
                            if (myi) {
                                clearInterval(myi);
                            }


                            updateCountdown();
                        }
                      
                        console.log('轮播恢复');
                    } else {
                        if (t) {
                            clearInterval(t);
                        }
                        if (pdfInterval) {
                            clearInterval(pdfInterval);
                        }
                        if (esopInterval) {
                            clearInterval(esopInterval);
                        }
                        isPaused = false;
                        $fullScreen2.value = '启动轮播';
                        console.log('轮播暂停');
                        if (myi) {
                            clearInterval(myi);
                        }
                        updateCountdown();
                    }
                }, false);
            }
             /**
             *全屏显示
             **/
            var $fullScreen = document.getElementById("btnFull");//按钮 
            
            if ($fullScreen) {
                $fullScreen.addEventListener("click", function () {                    
                    var docElm = document.documentElement;
                    if (docElm.requestFullscreen) {
                        docElm.requestFullscreen();
                    }
                    else if (docElm.msRequestFullscreen) {
                        docElm.msRequestFullscreen();
                    }
                    else if (docElm.mozRequestFullScreen) {
                        docElm.mozRequestFullScreen();
                    }
                    else if (docElm.webkitRequestFullScreen) {
                        docElm.webkitRequestFullScreen();
                    }
                    $("#btnFull").hide();
                    $("#btnExit").show();
                    $("#divStation").css("position", "");
                }, false);
            }
            /**
            *退出全屏显示
            **/
            var $cancelFullScreen = document.getElementById("btnExit");
            if ($cancelFullScreen) {
                $cancelFullScreen.addEventListener("click", function () {                   
                    if (document.exitFullscreen) {
                        document.exitFullscreen();
                    }
                    else if (document.msExitFullscreen) {
                        document.msExitFullscreen();
                    }
                    else if (document.mozCancelFullScreen) {
                        document.mozCancelFullScreen();
                    }
                    else if (document.webkitCancelFullScreen) {
                        document.webkitCancelFullScreen();
                    }
                    $("#btnFull").show();
                    $("#btnExit").hide();
                    $("#divStation").css("position", "absolute");
                }, false);
            }

            //绑定操作工序、资源信息
            bindOperation();
           
            //根据MAC加载工序、资源信息
            if (! getEsopStation()) {
                return false;
            }
           
            if (intervalTime != 0) {
                refreshTime = 10 * 1000;
            }
            if (esopInterval) {
                clearInterval(esopInterval);
            }
            esopInterval = setInterval(function () { setLoad() }, refreshTime);

            /*操作站位改变时绑定相应的资源*/
            $("#ddlOperations").change(function () {
                var operationId = $("#ddlOperations").val();
                bindResourcesByOprId(operationId);
            });

            $("#ddlResources").change(function () {
                resourceid = $("#ddlResources").val();
                stationid = $("#ddlOperations").val();
                loadEsopFiles(); 
            }); 
        });

        $("#btnBack").click(function () {
            location.href = "/Client/MachinedInjectionMolding.aspx";
        })
         //获取文件
        function GetFilePath(action,fileName) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.LocalFileExists(fileName, action);
            var fileUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/ESOP/DownLoad.aspx?Action=" + action+"&fileName=" + escape(fileName);
              if(ajax.value!=""){
                 return ajax.value;
              }
              return fileUrl;
        }
        /**
        *定时查询，当扫描的产品 产品图片有改变，替换轮播的图片
        **/
        function setLoad() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.GetEsopListByField(stationid, resourceid);
            if (ajax.value !=null && ajax.value[0] != undefined) {
                if (ajax.value[0].ItemId != $("#hdnItemID").val()) {
                    $("#banner,#mediaEsop").html("");
                    n = 0;
                    loadEsopFiles();

                    if (refreshTime == 3 * 1000) {
                        if (esopInterval) {
                            clearInterval(esopInterval);
                        }
                        refreshTime = 10 * 1000;
                        esopInterval = setInterval(function () { setLoad() }, refreshTime);
                    }
                }
            }
        }
        
        /**
        *加载ESOP文件
        **/
        function loadEsopFiles() {
            if (!isPaused) {
                return;
            }
            

            //加载文件列表
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.GetEsopListByField(stationid, resourceid);

            if (ajax.error == null) {
                var itemlist = ajax.value;
                if (itemlist.length > 0) {//   

                 
                    var ModifyDate = itemlist[0].ModifyDate;
                    fileType = getFileType(itemlist[0].FileType.toLowerCase());
                    intervalTime = itemlist[0].CutTime * 1000;
                  
                    $("#hdnItemID").val(itemlist[0].ItemId);

                    $("#updatediv").html("该作业已变更,变更时间：<br/>" + ModifyDate.Format("yyyy-MM-dd hh:mm:ss"));
                    $("#disappare").show().delay(1000).hide(100);

                    var fileUrl = "";
                    
                    if (fileType == "img") {
                        $("#banner").show();
                        $('#mediaEsop').empty();
                        var imgHtml = "<div id='banner_bg'></div><div id='banner_info'></div><ul id='MyyeMa'>";
                        var liHtml = "";
                        var aHtml = "";

                        for (var i = 0; i < itemlist.length; i++) {
                            liHtml += "<li>" + (i + 1) + "</li>";
                            fileUrl = GetFilePath("", itemlist[i].EsopFileName);
                            aHtml += "<a href='#'><img src='" + fileUrl + "' class='myimg' width='" + clientWidth + "' height='" + clientHeight + "' /></a>";
                        }
                        
                        imgHtml += (liHtml + "</ul><div style='float: right;color:red;'>轮播倒计时：<label id='lblLBDJS'></label>&nbsp;&nbsp;</div><div id='banner_list'>" + aHtml + "</div>");
                        $("#banner").html(imgHtml);
                        $("#banner").width(clientWidth).height(clientHeight);
                        $("#MyyeMa").hide();
                        LoadPageBtn();
                        setImgEsop();
                    }
                    else if (fileType == "pdf") {
                        $("#banner").empty().hide();
                        clientWidth = clientWidth - 0;   
                        var fileUrl = "";
                        var pdfHtml = "";
                        var fileName = "";
                        for (var j = 0; j < itemlist.length; j++) {
                            fileName = itemlist[j].EsopFileName;
                            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.GetFtpConfigInfo(fileName);
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            return false;
                        }
                      
                          fileUrl = encodeURI("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/UploadFiles/ESOP/" + (fileName));

                            pdfHtml += "<a class='media' href='" + fileUrl + "' ></a>";
                        }

                        $("#mediaEsop").html(pdfHtml);
                        $('a.media').media({ width: clientWidth, height: clientHeight });

                        var pdfQty = 0;
                        var pdfCurrentQty = 0;
                        $(".media").each(function (k) {
                            if (k != 0) {
                                $(this).hide();
                            }
                            pdfQty++;
                        });

                        if (pdfInterval) {
                            clearInterval(pdfInterval);
                        }
                        pdfInterval = setInterval(function () {
                            pdfCurrentQty++;
                            count++;
                            if (pdfCurrentQty >= pdfQty) {
                                pdfCurrentQty = 0;
                                count = 0;
                            }
                            $(".media").hide();
                            $(".media").eq(pdfCurrentQty).show();
                            var iframeObj = $(".media").eq(pdfCurrentQty).children("iframe");
                            $(iframeObj).attr("src", $(iframeObj).attr("src"));

                        }, intervalTime);
                    }
                    else if (fileType == "video") {
                        $("#banner").remove();
                        var fileName = itemlist[0].EsopFileName;
                        var fileUrl = GetFilePath("", fileName);

                        var browser = navigator.appName;
                        if (browser == "Microsoft Internet Explorer") {
                            alert("您的IE版本过低，请升级IE版本，视频播放功能只支持IE10+以及Chrome最新版本。");
                        } else {
                            var videoHtml = ' <div class="videobox"><video id="my-video" class="video-js vjs-default-skin" webkit-playsinline="true" controls autoplay="autoplay" loop >';
                            videoHtml += '<source src=' + fileUrl + ' type="video/mp4">';
                            videoHtml += '<source src=' + fileUrl + ' type="video/webm"></video></div>';
                            document.addEventListener("plusready", function () {
                                document.getElementById("my-video").play();
                            }, false);
                        }


                        $("#mediaEsop").html(videoHtml);

                    }
                    else {
                        alert("无法识别的ESOP文件！");
                        return false;
                    }

                    //更新默认工序
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.SetDefaultEsopStation($("#hidMachineMac").val(), $("#ddlOperations").val(), $("#ddlResources").val());
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }

                    //删除缓存文件

                    setTimeout(function () {
                        loadEsopFiles();
                    }, 60000);
                }
                else {
                    $("#updatediv").html("未找到工序关联的ESOP文件！<br/>" + currentTime);
                    $("#disappare").show();
                    $("#banner,#mediaEsop").html("");
                    return false;
                }
            }
            else {
                alert(ajax.error.Message);
            }
        }
        var myi;
        var countdownStart = 0;
        // 更新轮播倒计时
        function updateCountdown() {
            if (isPaused) {
                if (countdownStart >= 0) {
                    $("#lblLBDJS").text(countdownStart);
                    countdownStart = countdownStart - 1;
                    if (countdownStart == 0) {
                        countdownStart = intervalTime / 1000;
                    }
                }
            }
            else {
                countdownStart = intervalTime / 1000;
                $("#lblLBDJS").text(countdownStart);
            }
            if (myi) {
                clearInterval(myi);
            }
            myi = setInterval("updateCountdown()", 1000);
            //setTimeout("updateCountdown()", 1000);
        }

        function changePage(obj, mypage) {
            $(obj).css('background-color', 'forestgreen');
            $(obj).siblings().css('background-color', 'black');
            n = mypage;
            $("#banner_list a").stop(true, true);
            $("#banner li").eq(n).trigger('click');
        }

        /*动态加载页码*/
        function LoadPageBtn() {
            $("#myPagespan").html("");
            var myimglength = $("#banner_list a").length - 1;
            /*根据图片数量加载页码，小于等于4个图片，直接现在1234，大于4个取中间4个按钮*/
            var myPageHtml = "";
            if (myimglength >= 4) {
                /*如果当前页+4大于图片*/
                if (n + 4 > myimglength && n > 4) {
                    myPageHtml += "<input type='button' class='wide' value='" + parseInt(n - 2) + "' onclick='changePage(this," + parseInt(n - 3) + ")' />";
                    myPageHtml += "<input type='button' class='wide' value='" + parseInt(n - 1) + "' onclick='changePage(this," + parseInt(n - 2) + ")' />";
                    myPageHtml += "<input type='button' class='wide' value='" + parseInt(n) + "' onclick='changePage(this," + parseInt(n - 1) + ")' />";
                    myPageHtml += "<input type='button' class='wide' value='" + parseInt(n + 1) + "' style='background-color: forestgreen;' onclick='changePage(this," + n + ")' />";
                    $("#myPagespan").html(myPageHtml);
                }
                if (n + 4 > myimglength && n <= 4) {
                    for (var j = 0; j < 4; j++) {
                        var tmpbtn = j + 1;
                        /*当前页选中*/
                        if (tmpbtn == n) {
                            myPageHtml += "<input type='button' class='wide' value='" + parseInt(tmpbtn + 1) + "' style='background-color: forestgreen;' onclick='changePage(this," + n + ")' />";
                        }
                        else {
                            myPageHtml += "<input type='button' class='wide' value='" + parseInt(tmpbtn + 1) + "'  onclick='changePage(" + tmpbtn + ")' />";
                        }
                    }
                    $("#myPagespan").html(myPageHtml);
                }
                if (n + 4 <= myimglength) {
                    myPageHtml += "<input type='button' class='wide' value='" + parseInt(n + 1) + "' style='background-color: forestgreen;' onclick='changePage(this," + n + ")' />";
                    myPageHtml += "<input type='button' class='wide' value='" + parseInt(n + 2) + "' onclick='changePage(this," + parseInt(n + 1) + ")' />";
                    myPageHtml += "<input type='button' class='wide' value='" + parseInt(n + 3) + "' onclick='changePage(this," + parseInt(n + 2) + ")' />";
                    myPageHtml += "<input type='button' class='wide' value='" + parseInt(n + 4) + "' onclick='changePage(this," + parseInt(n + 3) + ")' />";
                    $("#myPagespan").html(myPageHtml);
                }
            }
            else {
                for (var j = 0; j <= myimglength; j++) {
                    /*当前页选中*/
                    if (j == n) {
                        myPageHtml += "<input type='button' class='wide' value='" + parseInt(j + 1) + "' style='background-color: forestgreen;' onclick='changePage(this," + n + ")' />";
                    }
                    else {
                        myPageHtml += "<input type='button' class='wide' value='" + parseInt(j + 1) + "'  onclick='changePage(this," + parseInt(j - 1) + ")' />";
                    }
                }
                $("#myPagespan").html(myPageHtml);
            }
        }
        /**
        *设置图片轮播方式的ESOP
        **/
        function setImgEsop() {
            $("#banner li:first").addClass("on");  //给第一个按钮加上选中样式 
            count = $("#banner_list a").length - 1; //为了让HTML上的代码可自动循环就必须定义banner_list下所含图片的长度           
            $("#banner_list a:not(:first-child)").hide(); //让除了不是第一张图的隐藏掉 
            $("#banner_info").html($("#banner_list a:first-child").find("img").attr('alt')); //把图片的alt属性的值添加到标题栏上去 
            // $("#banner_info").click(function () { window.open($("#banner_list a:first-child").attr('href'), "_blank") }); //点击标题另开新窗口打开对应链接 
            var bli = $("#banner li");
            bli.each(function (i) { //利用JQuery的遍历实现点击li的时候自动切换到下一张 
                bli.eq(i).click(function () {
                    n = i;
                    $("#banner_info").html($("#banner_list a").eq(i).find("img").attr('alt'));
                    $("#banner_list a").filter(":visible").fadeOut(500).parent().children().eq(i).fadeIn(500); //筛选出所有可见元素，然后取当前点击的fadeOut，其他的fadeIn 
                    $(this).addClass("on"); //给所点击的li加上样式 
                    $(this).siblings().removeAttr("class");
                }); //移除同级li的样式 
            });

            if (t) {
                clearInterval(t);
            }
            t = setInterval("showAuto()", intervalTime);
            countdownStart = intervalTime / 1000;
            updateCountdown();
            //$("#banner").hover(function () { clearInterval(t) }, function () { t = setInterval("showAuto()", interval); });
        } //设置自动执行时间为3s，利用setInterval自动无限延时加载，同时鼠标放上去后移除自动加载效果，鼠标移开后再继续执行轮播方法。 

        function showAuto() {
            $("#banner_list a").stop(true, true);
            n = n >= count ? 0 : ++n; //如果n>=图片总个数的话重新赋值为0，也就是从头算起，达到自动切换到第一张的效果 
            $("#banner li").eq(n).trigger('click');
            LoadPageBtn();
        } //在每一个匹配的li上绑定触发click事件

        /**
        *获取ESOP文件类型
        **/
        function getFileType(type) {
            if (type == "jpg" || type == "jpeg" || type == "png" || type == "gif") {
                return "img";
            }
            else if (type == "pdf") {
                return "pdf";
            }
            else {
                return "video";
            }
        }

        /**
        *窗口改变时更新宽度和高度
        **/
        $(window).resize(function () {
            setTimeout(function () {
                var clientHeigth = document.documentElement.clientHeight - 40;
                var clientWidth = document.documentElement.clientWidth;
                $("#banner").width(clientWidth).height(clientHeigth);
                $("#banner_list").children().find("img").width(clientWidth).height(clientHeigth);

                $(".media").find("iframe").width(clientWidth).height(clientHeigth);
            }
                , 100);
        });

        //#region 日期格式化
        // 对Date的扩展，将 Date 转化为指定格式的String   
        // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
        // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
        // 例子：   
        // (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
        // (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
        Date.prototype.Format = function (fmt) { //author: meizz   
            var o = {
                "M+": this.getMonth() + 1,                 //月份   
                "d+": this.getDate(),                    //日   
                "h+": this.getHours(),                   //小时   
                "m+": this.getMinutes(),                 //分   
                "s+": this.getSeconds(),                 //秒   
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
                "S": this.getMilliseconds()             //毫秒   
            };
            if (/(y+)/.test(fmt))
                fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(fmt))
                    fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        }
        //#endregion

        /**
        *根据用户绑定工位
        **/
        function bindOperation() {
            $("#ddlOperations").html("<option value='-1'>没有合适的工位</option>");
            $("#ddlResources").html("<option value='-1'>没有合适的资源</option>");

            /*根据用户获取所有的工位类型*/
            var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxEsop.GetESOPStationInfo();
            if (ajax1.error != null) {
                return false;
            }
            var list1 = ajax1.value; /*所有的有权限的站位*/
            var list2 = list1;
            if (list1.length == 0) {
                $("#ddlOperations").html("<option value='-1'>没有合适的工位</option>");
                return false;
            }
            var oprType = "<option value='-1'>选择工位</option>";
            var stationTypeIdStr = ";" + list1[0].StationTypeId + ";";
            var arr1 = new Array();
            var arr2 = new Array();
            arr1[0] = list1[0].StationTypeId;;
            arr1[1] = list1[0].OpeType;
            arr2.push(arr1);

            for (var i = 0, j = list1.length; i < j; i++) {
                if ($.trim(stationTypeIdStr) != "") {
                    if (stationTypeIdStr.indexOf(";" + list1[i].StationTypeId + ";") == -1) {
                        arr1 = new Array();
                        arr1[0] = list1[i].StationTypeId;;
                        arr1[1] = list1[i].OpeType;
                        arr2.push(arr1);
                        stationTypeIdStr += list1[i].StationTypeId + ";";
                    }
                }
            }

            for (var i = 0, j = arr2.length; i < j; i++) {
                oprType += "<optgroup label='" + arr2[i][1] + "'>";
                for (var k = 0, m = list2.length; k < m; k++) {
                    if (list2[k].StationTypeId == arr2[i][0]) {
                        if ($.trim(list2[k].Station) != "") {
                            oprType += "<option value='" + list2[k].StationId + "'>" + list2[k].Station + "</option>";
                        }
                    }
                }
            }

            $("#ddlOperations").html(oprType);
        }

        /**
        *根据工位ID绑定资源
        **/
        function bindResourcesByOprId(oprId) {
            var r = "";
            var noResources = "没有合适的资源";
            $("#ddlResources").html("<option value='-1'>没有合适的资源</option>");

            if (oprId == -1) {
                r = "<option value='-1'>" + noResources + "</option>";
            }
            else {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.GetEsopResourceByOpeId(oprId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var list = ajax.value;

                if (list.length == 0) {
                    r = "<option value='-1'>" + noResources + "</option>";
                }
                else {
                    r = "<option value='-1'>选择资源</option>";
                }

                for (var i = 0; i < list.length; i++) {
                    r += "<option value='" + list[i].ResourceId + "'>" + list[i].ResName + "</option>";
                }
            }
            $("#ddlResources").html(r);

            if (list.length == 1) {
                $("#ddlResources ").get(0).selectedIndex = 1
                $("#ddlResources ").change();
            }
        }

        /**
        *根据机器访问的MAC地址查询ESOP工序资源信息
        **/
        function getEsopStation() {
            var machineMac = $("#hidMachineMac").val();

            if (machineMac == "00-00-00-00-00-00") {
                if (store.get("ESOP-MAC") == null || store.get("ESOP-MAC") == "") {
                    $("#updatediv").html('<span style="margin-top: -32px; margin-left: -60px; display: block;">请输入本台设备MAC地址：</span><br><span style="margin: -31px 0px 0px 12px; display: block;"><input id="txtMAC" class="TextBox" style="width: 230px; height: 30px;" type="text" onkeypress=" return getKey();"/>&nbsp;<input style="border: 1px solid rgb(170, 170, 170); border-image: none; height: 32px;cursor: pointer;" onclick=" return setMAC()" type="button" value=" 确 定 "></span><br>');
                    $("#disappare").show();
                    $("#txtMAC").select()
                    return false;
                }
                else {
                    machineMac = store.get("ESOP-MAC");
                    $("#btnChangeMac").show();
                }
            }
            else {
                if (store.get("ESOP-MAC") == null || store.get("ESOP-MAC") == "") {
                    $("#btnChangeMac").hide();
                }
            }

            var isChange = true;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.GetMacInfo(machineMac);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var entity = ajax.value;
            if (entity.ESOPMacId > 0) {
                stationid = entity.StationId;
                resourceid = entity.ResourceId;
                isChange = entity.IsSwitch;

                $("#ddlOperations").val(stationid);

                bindResourcesByOprId(stationid);

                $("#ddlResources").val(resourceid);

                //如果不允许修改工序信息
                if (!isChange) {
                    $("#ddlOperations,#ddlResources").attr("disabled", "disabled");
                }

                loadEsopFiles();
            }
            else {
                $("#updatediv").html("请先配置机器相关的工序和资源！<br/>MAC:[" + machineMac + "]<br/>");
                $("#disappare").show();
                $("#banner,#mediaEsop").html("");
                $("#ddlOperations,#ddlResources").attr("disabled", "disabled");
                return false;
            }
        }

        /**
        *设置当前MAC地址
        **/
        function setMAC() {
            var temp = /^[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}$/;
            if (!temp.test($.trim($("#txtMAC").val()))) {
                alert("请输入正确的MAC地址！");
                $("#txtMAC").select();
                return false;
            }

            $("#hidMachineMac").val($.trim($("#txtMAC").val()));
            store.set('ESOP-MAC', $.trim($("#txtMAC").val()));
            $("#btnChangeMac").show();
            getEsopStation();
            $("#mediaEsop").show();
            if (intervalTime != 0) {
                refreshTime = 10 * 1000;
            }
            if (esopInterval) {
                clearInterval(esopInterval);
            }
            esopInterval = setInterval(function () { setLoad() }, refreshTime);

            /*操作站位改变时绑定相应的资源*/
            $("#ddlOperations").change(function () {
                var operationId = $("#ddlOperations").val();
                bindResourcesByOprId(operationId);
            });

            $("#ddlResources").change(function () {
                resourceid = $("#ddlResources").val();
                stationid = $("#ddlOperations").val();
                loadEsopFiles();
            });

            return true;
        }

        function getKey() {
            if (event.keyCode == 13) {
                setMAC();
            }
        }

        function changeMac() {
            $("#mediaEsop").hide();
            var mac = store.get('ESOP-MAC');
            $("#updatediv").html('<span style="margin-top: -32px; margin-left: -60px; display: block;">请输入本台设备MAC地址：</span><br><span style="margin: -31px 0px 0px 12px; display: block;"><input id="txtMAC" class="TextBox" style="width: 230px; height: 30px;" type="text" value="' + mac + '" onkeypress=" return getKey();"/>&nbsp;<input style="border: 1px solid rgb(170, 170, 170); border-image: none; height: 32px;cursor: pointer;" onclick="setMAC()" type="button" value=" 确 定 ">&nbsp;<input style="border: 1px solid rgb(170, 170, 170); border-image: none; height: 32px;cursor: pointer;" onclick="cancel()" type="button" value=" 取 消 "></span><br>');
            $("#banner,#disappare").show();
            $("#txtMAC").select()
            //store.remove('ESOP-MAC');
        }

        function cancel() {
            $("#mediaEsop").show();
            $("#disappare").hide();
            if (fileType != "img") {
                $("#banner").hide();
            }

        }
    </script>
</body>
</html>
