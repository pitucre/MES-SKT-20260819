<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1">
    <link href="theme/flatui/jquery.mobile.flatui.min.two.css" rel="stylesheet" type="text/css" />
    <%--<link href="theme/flatui/jquery.mobile.flatui.min.css" rel="stylesheet" type="text/css" />--%>
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="js/Common.js" type="text/javascript"></script>
    <script src="../Content/js/jsencrypt.js?v=20210913" type="text/javascript"></script>
    <title>深科特LeanMES移动客户端</title>
    <style type="text/css">
        html, body {
            font-family: Arial, Verdana, "微软雅黑", "宋体";
        }


        #logo {
            text-align: center;
            margin: 0 10px 20px 10px;
        }

        .loginTitle {
            margin-top: 10px;
            color: #cccccc;
        }

        .btn-login {
            margin-top: 30px;
        }

        .clear {
            clear: both;
            height: 5px;
        }

        .center {
            text-align: center;
        }

        #message {
            font-size: 12px;
            color: #333;
            vertical-align: middle;
        }

        .ismultiplant {
            display: none;
        }

        .text {
            height: 49px;
            width: 100%;
            outline: none;
            display: inline-block;
            border:1px solid;

            font: 14px "microsoft yahei",Helvetica,Tahoma,Arial,"Microsoft jhengHei";
            /*border-style: groove none;*/
            border-style:  none;
            /*margin-left: 50px;*/
            background: none;
            line-height: 46px;
        }

        .input_outer {
            height: 65px;
            padding: 0 5px;
            margin-bottom: 20px;
            border-radius: 50px;
            position: relative;
            border: rgba(255,255,255,0.2) 2px solid !important;
        }
          .input_outer div { 
                float:left;width:calc(100% - 120px)
            }
        .us_uer {
            width: 25px;
            height: 25px;
            /*background-image: url(images\NEW\images\请输入密码-左.png);*/
            background-position: -125px -34px;
            position: absolute;
            margin: 10px -305px;
        }

        .u_user {
            width: 60px;
            height: 76px;
            float:left;
            /*background-image: url(images/NEW/images/输入用户名--左.png);*/
            background-position: -125px 0;
            /*position: absolute;
            margin: 0px -161px;*/
        }
        c_user { float:left;
        }
        .r_user {
            width: 25px;
            height: 25px;
            background-position: -125px -34px;
            float:left;
            /*position: absolute;
            margin: -54px 108px;*/
        }

        .mb2 {
            margin-bottom: 20px;
        }

            .mb2 a {
                text-decoration: none;
                outline: none;
            }

        .submit {
            padding: 15px;
            margin-top: 20px;
            display: block;
        }

        .act-but {
            line-height: 18px;
            text-align: center;
            font-size: 20px;
            border-radius: 50px;
            background: #0096e6;
        }

        .bz {
            font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
            font-size: 14px;
            color: #333;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" >
    <div data-role="page" id="login" style="color: #2fa5ff">
        <div data-role="header" style="display: none">
            <h1>LeanMES移动客户端</h1>
        </div>
        <div data-role="content" style="color: #2fa5ff">
            <div id="logo">
                <div id="pdaset" style="text-align:right;display:none;"> <img alt="" src="../Content/images/icon/Run.png" style="height:25px;height:25px;" onclick="gotoConfig()"/></div>
                <div style="width:60%; margin:0 auto;">
                    <img alt="" src="images/NEW/images/logo.png" style="width:100%" />
                </div>
                <div class="clear" style="width:80%; margin:26px auto 0 auto;">
                    <img src="images/NEW/images/智能制造一站式解决方案.png" style="width:100%" />
                </div>
           
                <div class="clear" id="clear" style="margin-bottom: 60px;">
                </div>
                <div style=" width:100%; margin:0 auto; ">
                    <div class="input_outer">
                    <span class="u_user">
                        <img src="images/NEW/images/输入用户名--左.png" style="height:51px"/>
                    </span>
                    <input name="logname" id="userName" class="text" type="text" placeholder="请输入用户名" style="background-image:url(images/NEW/images/1px.png); background-size: 150px 51px;" />
                    <span class="r_user">
                        <img src="images/NEW/images/右(1).png"style="height:51px" />
                    </span>
                </div>
                <div class="input_outer">
                    <span class="u_user">
                        <img src="images/NEW/images/输入密码-左.png" style="height:51px"/>
                    </span>
                    <input name="logpass" class="c_user  text" id="pwd" type="password" placeholder="请输入密码" style="background-image:url(images/NEW/images/1px.png);background-size:150px 51px"/>
                    <span class="r_user">
                        <img src="images/NEW/images/右(1).png" style="height:51px"/>
                    </span>
                </div>
                     <div class="input_outer" >
                         
                               <input type="checkbox" id="repass" style="" /> 
                     
                       
                     </div>
                </div>
                

                <div class="mb2" style="margin-top: 26px">
                    <a class="act-but submit" href="javascript:login();;" style="color: #FFFFFF">登 录</a>
                </div>
                <div class="center">
                    <div id="message">
                    </div>
                </div>
                <div class="foot" style="margin-top: 40px">
                    <span class="bz">深圳市深科特信息技术有限公司</span>
                </div>
                <div class="foot">
                    <span class="bz">Copyright © <%=DateTime.Now.Year.ToString() %>,All Rights Reserved</span>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hdnCsrfToken" runat="server" />
    <input type="hidden" id="<%=SKT.LeanMES.Web.AppCode.Utility.AntiXSRFHelper.AntiXsrfTokenKey %>" name ="<%=SKT.LeanMES.Web.AppCode.Utility.AntiXSRFHelper.AntiXsrfTokenKey %>" value="<%=hdnCsrfToken.Value %>" />
    </form>
    <script src="js/login.js?v=3" type="text/javascript"></script>
    <script src="js/skt.mobile.cookies.js" type="text/javascript"></script>
    <script type="text/javascript">
     
        var _root = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";

        $(document).on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
                login();
            
            }
        });
        $(document).ready(function () {
            $("#repass").parent().width(130)
            $("#repass").parent().append("记住密码")
            var width = document.body.clientWidth;
            if (width > 500) {
                $("#clear").removeAttr("style").attr("style", "margin-bottom:110px;");
            }
            if (typeof (android) != "undefined" && android && android.gotoConfig) {
                $("#pdaset").show();
            }

            if (getCookie("user") != null) {
                $('#repass').prop("checked", true);
                var user = JSON.parse(getCookie("user"));
                $("#userName").val(user.userName);
                $("#pwd").val(user.pwd);
            }
        });
        window.onresize = function () {
            var width = document.body.clientWidth;
            if (width > 500) {
                $("#clear").removeAttr("style").attr("style", "margin-bottom:110px;");
            } else {
                $("#clear").removeAttr("style").attr("style", "margin-bottom:60px;");
            }
        }
        function gotoConfig() {
            if (typeof (android) != "undefined" && android && android.gotoConfig) {
                android.gotoConfig();
            }
        }
    </script>
</body>
</html>

