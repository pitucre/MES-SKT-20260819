<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChooseLineAndRes.aspx.cs"
    Inherits="SKT.LeanMES.Web.MobileApp.ChooseLineAndRes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
    <title>选择线别和资源</title>
</head>
<body>
    <!--选择工序-->
    <div data-role="page" id="chooseStation">
        <div data-role="header" id="header" data-position="fixed">
            <h3 style="padding: 10px; margin: 0px;">
                选择生产线
            </h3>
            <a href="" data-rel="back" class="ui-btn-left" data-icon="back" data-transition="none"
                data-ajax="false">返回</a>
        </div>
        <div data-role="content" id="main">
            <ul data-role="listview" data-inset="false" data-filter="true" data-filter-placeholder="搜索"
                data-theme="c" class="listview" id="line-data">
            </ul>
        </div>
    </div>
    <!--选择资源-->
    <div data-role="page" id="chooseResource">
        <div data-role="header" data-position="fixed">
            <h3 style="padding: 10px; margin: 0px;">
                选择资源
            </h3>
            <a href="" data-rel="back" class="ui-btn-left" data-icon="back" data-transition="none"
                data-ajax="false">返回</a>
        </div>
        <div data-role="content" id="resMain">
            <ul data-role="listview" data-inset="false" data-filter="true" data-filter-placeholder="搜索"
                data-theme="c" class="listview" id="resName">
            </ul>
        </div>
    </div>
    <script type="text/javascript">
        var checkMType = -1; //物料检验类型： 1.SMT上料  2.线别设置 3.前置加工
        $(document).bind("mobileinit", function () {
            $.mobile.ajaxEnabled = false;
        });

        $(function () {
            $(".ui-body-c").css("background", "#fff");
            $("body>[data-role='listview']").listview();
        });

        $(document).on("pageinit", function () {
            checkMType = GetQueryString("checkMType");
            bindLine();
        });

        function bindLine() {
            $("#line-data").html("");
            $.ajax({
                type: "POST",
                url: "../Handler/ChooseLineAndRes.ashx?type=Line",
                async: false,
                dataType: "json",
                success: function (data) {
                    var obj = eval(data);
                    $(obj).each(function (index) {
                        var val = obj[index];
                        $("#line-data").append("<li   onclick ='bindResName(" + val.LineId + ")'><a href='#chooseResource'  data-transition='none' >" + val.LineName + "</a></li>")
                    });
                },
                error: function (err) {
                    return;
                }
            });
            $("#line-data").listview("refresh");
        }


        function bindResName(lineId) {
            //获取选中的线别id
            $("#resName").html("");
            $.ajax({
                type: "POST",
                url: "../Handler/ChooseLineAndRes.ashx?type=ResName",
                async: false,
                dataType: "json",
                data: { "lineId": lineId },
                success: function (data) {
                    var obj = eval(data);
                    $(obj).each(function (index) {
                        var val = obj[index];
                        if (checkMType == 2) {
                            $("#resName").append("<li><a  href='HandCheckMaterial.aspx?" + encodeURI("lineId=" + val.LineId + "&resId=" + val.ResourceId + "&lineName=" + val.LineName + "&resName=" + val.ResName + "") + "'   data-ajax=\"false\"  data-transition=\"none\" >" + val.ResName + "</a></li>");
                        } else if (checkMType == 1) {
                            $("#resName").append("<li><a  href='SMTCheckMaterial.aspx?" + encodeURI("lineId=" + val.LineId + "&resId=" + val.ResourceId + "&lineName=" + val.LineName + "&resName=" + val.ResName + "") + "'   data-ajax=\"false\"  data-transition=\"none\" >" + val.ResName + "</a></li>");
                        }
                    });
                    $("#resName").listview("refresh");
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
