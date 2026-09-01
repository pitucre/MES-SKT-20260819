<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KanbanCarouselConfigOpen.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.KanbanCarouselConfigOpen" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="width: 100%; height: 100%;">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
   <%-- <meta name="referrer" content="unsafe-url"/>--%>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <title></title>
    <style type="text/css">
        html,body, form, div, iframe { margin: 0px; padding: 0px; border:0px; }
    </style>
    <script>
        var carouselConfigId = "<%=Request.QueryString["carouselConfigId"]%>";
        var carouselList;
        var index = 0;
        var intervalCarousel = null; //定时获取轮播配置
        var carouselTime = 60;//轮播时间
        var intervalChange = null; //根据轮播配置，定时更换显示的看板

        $(function () {

            //获取看板轮播配置
            getCarouselConfigDetail();
            if (intervalCarousel) {
                clearInterval(intervalCarousel);
            }
            intervalCarousel = setInterval(getCarouselConfigDetail, carouselTime * 1000);
        });

        //获取轮播内容
        function getCarouselConfigDetail() {
            $.ajax({
                type: "post",
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/Kanban.ashx',
                data: { "api": "GetKanbanCarouselConfigDetail", "carouselConfigId": carouselConfigId },
                dataType: "json",
                async: false,
                success: function (data) {
                    carouselList = data;
                    if (carouselList) {
                        changeKanban();

                        if (intervalChange) {
                            clearInterval(intervalChange);
                        }
                        if (carouselList[0].CarouselTime > carouselTime) {
                            carouselTime = carouselList[0].CarouselTime;
                        }                        
                        intervalChange = setInterval(changeKanban, carouselList[0].CarouselTime * 1000);
                    }
                }
            });
        }

        //更换看板
        function changeKanban() {
            if (carouselList) {
                $("#frame-carousel").attr("src", decodeURIComponent(carouselList[index].KanBanURL));
                index++;
                if (index >= carouselList.length) {
                    index = 0;
                }
            }
        }
    </script>
</head>
<body style="width: 100%; height: 100%;">
    <form id="form1" runat="server" style="width: 100%; height: 100%; overflow-y:hidden;">
        <iframe id="frame-carousel" style="width: 100%; height:100%; " frameborder="0" scrolling="no"></iframe>
    </form>
</body>
</html>
