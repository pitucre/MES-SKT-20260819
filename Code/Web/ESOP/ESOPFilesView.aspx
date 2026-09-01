<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.master" AutoEventWireup="true"
    CodeBehind="ESOPFilesView.aspx.cs" Inherits="SKT.LeanMES.Web.ESOP.ESOPFilesView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- 轮播图片 -->
    <div id="banner_tabs" class="pic">
    </div>
    <div id="disappare" style="display: none;">
        <p id="updatediv">
        </p>
    </div>
    <input id="hdnItemID" type="hidden" />
    <style type="text/css">
        *, body
        {
            padding: 0px;
            margin: 0px;
        }
        a
        {
            text-description: none;
        }
        .pic
        {
            width: 100%;
            height: 600px;
            overflow: hidden;
        }
        .pic ul li
        {
            width: 100%;
            height: 600px;
            position: relative; /*background:url(../images/bg1.jpg) center; */
        }
        .pic ul li img
        {
            position: absolute;
            left:-1180px;
            top: 0px;
        }
        /*导航条*/
        .nav
        {
            width: 100%;
            height: 10px; /*background:rgba(255,255,255,0.5);*/
            background: #fff;
            opacity: 0.75; /*透明度*/
            position: absolute;
            left: 0px;
            bottom: 0px;
        }
        /*进度条*/
        .bar
        {
            width: 1180px;
            height: 3px;
            left: 50%;
            position: absolute;
            bottom: 0px;
            margin-left: -590px;
            background: url(../Content/images/bar.png);
        }
        .bar p
        {
            width: 0px;
            height: 3px;
            background: #00925f;
            margin-left: 3px;
        }
        #disappare
        {
            left: 50%;
            top: 50%;
            border: 3px solid #ccc;
            border-radius: 5px;
            background: #fff;
            font-size: 20px;
            z-index: 9999;
            width: 500px;
            height: 200px;
            margin-left:-250px;
            margin-top:-100px; 
            position: absolute;
            text-align:center;
            line-height:40px;
             
        }
        #disappare p
        {
            padding: 50px;
            font-size: 24px;
        }
    </style>
 
    <script type="text/javascript">
        var stationid = getQueryString("stationid");
        var resourceid = getQueryString("resourceid");
         
        var cutTime = 0;
        var imgCount = 0;
        var width = 0;
        var hegith = 0;
        var CreateDate;
        var ModifyDate;
        var i = 0;
        var esopInterval;
        //#region 界面初始化
        $(function () {
            setTimeout(
                function () {
                    //加载按钮
                    loadClientButton('ESOP_ProCollectionUI');
                    load();
                    jummper();

                    if (cutTime == 0) {
                        esopInterval = setInterval(function () { setLoad() }, 2);
                    }
                },
                10
            );

            self.moveTo(0, 0);
            self.resizeTo(screen.availWidth, screen.availHeight);
            self.focus();

            width = $(window).width();
            hegith = $(window).height() - 10;

            $("#leftmenu,#slider").hide();
            $("#leftmenu").parent().css("width", "1px");
                        
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
        //定时查询，当扫描的产品 产品图片有改变，替换轮播的图片
        function setLoad() {             
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.GetEsopListByField(stationid, resourceid);
            if (ajax.value[0] != undefined) {
                if (ajax.value[0].ItemId != $("#hdnItemID").val()) {
                    $("#banner_tabs").html("");
                    i = 0;
                    load();
                }
            }
            jummper();         
        }

        function load() {            
            //加载文件列表
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.GetEsopListByField(stationid, resourceid);

            if (ajax.error == null) {
              
                var itemlist = ajax.value;
                if (itemlist.length > 0) {
                    imgCount = itemlist.length;
                    CreateDate = itemlist[0].CreateDate;
                    ModifyDate = itemlist[0].ModifyDate;
                    cutTime = itemlist[0].CutTime * 1000;
                    $("#hdnItemID").val(itemlist[0].ItemId);
                    $("#ProductModel").text(itemlist[0].ItemSpec);

                    $("#updatediv").html("该作业已变更,变更时间：<br/>" + ModifyDate.Format("yyyy-MM-dd hh:mm:ss"));
                    $("#disappare").show().delay(2000).hide(100);

                    var htmlImg = "<ul>";
                    for (var i = 0; i < itemlist.length; i++) {
                        //                        var imgurl = itemlist[i].EsopFileUrl;
                        var filename = itemlist[i].EsopFileName;
                        //                        var arr = [];
                        //                        arr = imgurl.split("//");
                        //                        var ipurl = arr[1].split("/");
                        //                        var ftppdf = "http://" + ipurl[0] + "/ESOP";
                        //                        for (var j = 1; j < ipurl.length; j++) {
                        //                            ftppdf = ftppdf + "/" + ipurl[j];
                        //                        }

                        //有端口号的情况 ftp端口2121 http端口号8090
                        //                        ftppdf = ftppdf.replace(":2121", ":8090");

                        ftppdf = GetFilePath("", filename);
                      
                        //图片不需要加用户名，密码
                        //判断是否是图片还是pdf文件
                        if (itemlist[i].FileType == "jpg" || itemlist[i].FileType == "jpge" || itemlist[i].FileType == "png" || itemlist[i].FileType == "gif") {
                            //$("#banner_tabs").append('<li><img  height="' + hegith + '" alt="" src="' + ftppdf + '"><div class="nav"></div><div class="bar"><p></p></div></li>');
                            //$("#bannerCtrl").append('<li><a>"' + i + 1 + '"</a></li>');
                            htmlImg += '<li><img  height="' + hegith + '" width="' + width + '" alt="" src="' + ftppdf + '"><div class="nav"></div><div class="bar"><p></p></div></li>';
                        }
                    }
                    htmlImg += "</ul>"
                    $("#banner_tabs").append(htmlImg);
                   
                    clearInterval(esopInterval);
                    esopInterval = setInterval(function () { setLoad() }, cutTime+100);
                   
                                 
                }
                else {
                    $("#updatediv").html("未找到工序关联的ESOP文件！<br/>" + currentTime);
                    $("#disappare").show();
                    return false;
                }
            } else {
             
                alert(ajax.error.Message);

            }
        }

        function jummper() {
            $(".pic ul li").eq(i).find("img").css("left", "-1180px");
            $(".pic ul li").eq(i).find("p").css("width", "0px");
            $(".pic ul li").eq(i).find("img").animate({ left: "0px" }, cutTime*0.05, function () {
                //当图片移动完成后再加载进度条
                //alert("当图片移动完成后再做操作");
                $(".pic ul li").eq(i).find("p").animate({ width: "1174px" }, cutTime*0.9, function () {
                    $(".pic ul li").eq(i).find("img").animate({ left: "1180px" }, cutTime*0.05, function () {
                        i++;
                        if (i >= imgCount)
                            i = 0;
                        $(".pic ul li").eq(i).fadeIn(100).siblings().fadeOut(100);
                    });
                });
            });
        }

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
    *   获取URL参数值
    **/
    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    }
    </script>
      
</asp:Content>
