<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProdOrderList.aspx.cs"
    Inherits="SKT.LeanMES.Web.MobileApp.ProdOrderList" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
    <link href="theme/flatui/jquery.mobile.flatui.min.css?v=11" rel="stylesheet" type="text/css" />
    <link href="css/common.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="js/skt.mobile.material.js" type="text/javascript"></script>
    <title>选择工单</title>
    <style type="text/css">
        .center
        {
            text-align: center;
        }
    </style>
</head>
<body>
    <div data-role="page" id="chooseStation">
        <div data-role="header" id="header" data-position="fixed">
            <h3 style="padding: 10px; margin: 0px;">
                选择工单
            </h3>
            <a href="" data-rel="back" class="ui-btn-left" data-icon="back" data-transition="none"
                data-ajax="false">返回</a>
        </div>
        <div data-role="content" id="main">
            <ul data-role="listview" data-inset="false" data-filter="true" data-filter-placeholder="搜索"
                data-theme="c" class="listview" id="listOrderNo">
            </ul>
        </div>
        <div class="center">
            <div id="message">
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var checkMType = -1; //物料检验类型： 1.SMT上料  2.线别设置 3.前置加工
        var lineId = -1;
        var resId = -1;
        var lineName = "";
        var resName = "";
        $(document).bind("mobileinit", function () {
            $.mobile.ajaxEnabled = false;
        });

        $(function () {
            $(".ui-body-c").css("background", "#fff");
            $("body>[data-role='listview']").listview();
        });

        $(document).on("pageinit", function () {
            checkMType = GetQueryString("checkMType");
            lineId = GetQueryString("lineId");
            resId = GetQueryString("resId");
            lineName = decodeURI(GetQueryString("lineName"));
            resName = decodeURI(GetQueryString("resName"));
            bindOrder();
        });


        function bindOrder() {
            //获取选中的线别id
            $("#listOrderNo").html("");
            $.ajax({
                type: "POST",
                url: "../Handler/ChooseLineAndRes.ashx?type=chooseOrder",
                async: false,
                dataType: "json",
                beforeSend: function () {
                    $("#message").html("<img src='../Content/images/gif/loading.gif' style='vertical-align:middle; margin-right:5px;'/>正在加载，请稍后...");
                },
                success: function (data) {
                    var obj = eval(data);
                    $(obj).each(function (index) {
                        var val = obj[index];
                        //SMT上料
                        if (checkMType == 1) {
                            $("#listOrderNo").append("<li  ><a href='SMTCheckMaterial.aspx?" + encodeURI("checkType=3&lineId=" + lineId + "&resId=" + resId + "&lineName=" + lineName + "&resName=" + resName + "&prodOrderId=" + val.ProdOrderID + "&orderNo=" + val.OrderNO + "") + "'  data-transition='none'  data-ajax='false'>" + val.OrderNO + "</a></li>");

                        } else if (checkMType == 2) {
                            //手插上料
                            $("#listOrderNo").append("<li  ><a href='HandCheckMaterial.aspx?" + encodeURI("checkType=3&lineId=" + lineId + "&resId=" + resId + "&lineName=" + lineName + "&resName=" + resName + "&prodOrderId=" + val.ProdOrderID + "&orderNo=" + val.OrderNO + "") + "'  data-transition='none'  data-ajax='false'>" + val.OrderNO + "</a></li>");
                        }
                    });
                    $("#listOrderNo").listview("refresh");
                },
                complete: function () {
                    $("#message").html("");
                },
                error: function (err) {
                    return;
                }
            });

        }
        //跳转到检验工序
        function linkCheckMaterial(lineId, ResId, lineName, ResName) {
            $.mobile.changePage("HandCheckMaterial.aspx?" + encodeURI("lineId=" + lineId + "&resId=" + ResId + "&lineName=" + lineName + "&resName=" + ResName), { transition: 'none' });
        }

        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return r[2]; return null;
        }
    </script>
</body>
</html>
