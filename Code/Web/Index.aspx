<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SKT.LeanMES.Web.Index"
    EnableViewState="false" EnableViewStateMac="true" ViewStateEncryptionMode="Always" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <title>LEAN MES - 用户登录</title>
    <script src="Content/js/jquery.min.js" type="text/javascript"></script>
    <script src="Content/js/skt.utility.checkmobile.js" type="text/javascript"></script>
    <script type="text/javascript">
        checkMobile();
        function checkMobile() {
            if (isMobile.any()) {
                location.href = "MobileApp/Login.aspx";
            }
        }
    </script>
    <style type="text/css">
        <!--
        body {
            background-image: URL(Content/login/img/login_bg_1920.jpg);
            filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
            -moz-background-size: 100%;
            background-size: 100%;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            margin: 0px;
            padding: 0px;
            width: 100%;
            min-width: 1100px;
            margin: auto auto;
            color: #333;
            font-family: 微软雅黑;
        }

        ::-webkit-input-placeholder {
            /* WebKit browsers */
            color: #ddd;
        }

        　　 :-moz-placeholder {
            /* Mozilla Firefox 4 to 18 */
            color: #ddd;
        }

        　　 ::-moz-placeholder {
            /* Mozilla Firefox 19+ */
            color: #ddd;
        }

        　　 :-ms-input-placeholder {
            /* Internet Explorer 10+ */
            color: #ddd;
        }

        .login-form {
            width: 1028px;
            height: 488px;
            background-image: URL(Content/login/login2/login_form.png);
            background-repeat: no-repeat;
            margin: auto auto;
        }

        .login-form-content {
        }

        .wrap {
            width: 448px;
            height: 360px;
            padding: 0 12px;
        }

        .corp-logo {
            float: left;
            margin-top: 33px;
            margin-left: 65px;
            text-align: center;
        }

        .login-input-group {
            float: left;
            margin: 33px 0;
            padding: 10px;
            width: 380px;
            position: relative;
        }

        .logo {
            height: 36px;
            margin-top: 23px;
        }

            .logo img {
                width: 230px;
                height: 36px;
            }

        .corp-text {
            height: 54px;
            font-size: 24px;
            margin-top: 23px;
            color: #333;
            letter-spacing: 2px;
            margin-left: -20px;
        }

        .app-qrcode {
            height: 134px;
            margin-top: 10px;
        }

            .app-qrcode .qrcode {
                background: URL(Content/login/login2/qrcode.png) no-repeat;
                width: 133px;
                height: 134px;
                margin: auto auto;
                padding: 10px;
                color: #666;
                vertical-align: middle;
                line-height: 134px;
                text-align: center;
            }

        .qrcode-text {
            margin-top: 20px;
            font-size: 16px;
            text-align: center;
            margin-left: -20px;
        }

        .login-input-group .leanme-text {
            color: #2fa5ff; /*1781ef*/
            font-size: 22px;
            font-family: 微软雅黑,Arial Verdana, Geneva, Tahoma, sans-serif;
            margin-top: 10px;
            text-align: center;
        }

        .login-input-group .leanmes-ver {
            clear: both;
            width: 100%;
            color: #1781ef;
            font-size: 12px;
            font-family: Arial Verdana, Geneva, Tahoma, sans-serif;
            text-align: center;
            border-bottom: 1px solid #2fa5ff;
        }

        .login-input-group .multiple-language {
            width: 41px;
            height: 25px;
            position: absolute;
            top: 25px;
            color: #ffffff;
            font-family: 微软雅黑,Arial Verdana, Geneva, Tahoma, sans-serif;
            font-size: 12px;
            line-height: 25px;
            cursor: pointer;
            padding-left: 12px;
            padding-right: 12px;
        }

        .login-input-group .zh-cn {
            background: url(Content/login/login2/zh_cn.png) left top no-repeat;
            right: 5px;
            text-align: left;
        }

        .login-input-group .en {
            background: url(Content/login/login2/en.png) left top no-repeat;
            right: 8px;
            text-align: right;
        }

        .form-group {
            margin-top: 5px;
        }

            .form-group .input {
                width: 360px;
                height: 54px;
                border: none;
                background: url(Content/login/login2/input_bg.png) no-repeat;
                font-size: 18px;
                font-family: 'Microsoft YaHei UI', Verdana;
                padding: 0px 10px;
                line-height: 50px;
            }

        .checkbox {
            vertical-align: middle;
        }

        .btn {
            width: 380px;
            height: 54px;
            margin-top: 12px;
            background: url(Content/login/login2/btn.png) no-repeat;
            border: none;
            font-size: 22px;
            font-family: 微软雅黑;
            color: #ffffff;
            cursor: pointer;
        }

            .btn:hover {
                width: 380px;
                height: 54px;
                margin-top: 12px;
                background: url(Content/login/login2/btn_active.png) no-repeat;
                border: none;
                font-size: 22px;
                font-family: 微软雅黑;
                color: #ffffff;
                cursor: pointer;
            }

        .input-group {
            margin-top: 12px;
            font-size: 14px;
            font-family: 微软雅黑;
        }

        .checkbox-btn {
            cursor: pointer;
            font-style: normal;
            color: #333;
        }

            .checkbox-btn:hover {
                cursor: pointer;
                font-style: normal;
                color: #1781ef;
            }

        .copyright {
            clear: both;
            font-size: 14px;
            color: #ddd;
            font-family: 微软雅黑;
            text-align: center;
        }

        .qrcode {
            cursor: pointer;
        }

        .error-msg {
            height: 35px;
            line-height: 32px;
            margin-top: 5px;
            text-align: center;
            font-size: 14px;
            padding-left: 5px;
            padding-right: 5px;
            color: rgba(207, 40, 37, 1);
            overflow: hidden;
        }

        .clear {
            clear: both;
        }

        .ver {
            color: #909090;
            font-size: 12px;
            font-family: Verdana, Arial,Geneva, Tahoma, sans-serif,'微软雅黑';
            text-align: right;
            margin-top: 10px;
            width: 380px;
            line-height: 16px;
        }

        .multiplant-drp {
            display: none;
            position: absolute;
            top: 65px;
            width: 380px;
            padding: 0px;
            margin: 0px;
            text-align: center;
            border: 0;
        }

        .multiplant-drp-arrow {
            float: right;
            margin-right: 10px;
            display: block;
            margin-top: 10px;
            width: 14px;
            height: 8px;
            background: url(Content/login/login2/drp.png) left top no-repeat;
        }

        .multiplant-drp-top {
            height: 4px;
            width: 380px;
            background: url(Content/login/login2/multiplant_top.png) left top no-repeat;
        }

        .multiplant-drp .multiplant-drp-item {
            height: 30px;
            width: 380px;
            padding: 0px;
            line-height: 30px;
            background: url(Content/login/login2/drp_bg.png) repeat-y;
            margin: 0;
            font-family: '微软雅黑', Verdana, Arial;
        }

        .multiplant-drp .multiplant-drp-item-active {
            height: 30px;
            width: 380px;
            background: url(Content/login/login2/drp_bg_active.png) repeat-y;
            cursor: pointer;
            padding: 0px;
            line-height: 30px;
            color: #1781ef;
            font-family: '微软雅黑', Verdana, Arial;
        }

        .multiplant-drp-btm {
            height: 4px;
            width: 380px;
            background: url(Content/login/login2/multiplant_btm.png) left top no-repeat;
        }

        #codeico {
            position: absolute; /*生成绝对定位的元素，相对于浏览器窗口进行定位。元素的位置通过 "left", "top", "right" 以及 "bottom" */
            z-index: 9999999;
            width: 32px;
            height: 32px;
            background: url(Content/login/login2/qrcode_ico.png) no-repeat;
            margin: 39px;
        }

        -->
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="login_margin" style="height: 130px;"></div>
        <div id="login_form" class="login-form">
            <div class="login-form-content">
                <!--login left-->
                <div class="wrap corp-logo">
                    <div class="logo">
                        <img src="Content/login/login2/lean_mes.png" alt="Lean MES" />
                    </div>
                    <div class="corp-text" id="dvHeadLogin">智能制造一站式解决方案</div>
                    <div class="app-qrcode">
                        <div class="qrcode" id="qrcode" title="点击打开PDA界面">
                            <div id="codeico"></div>
                        </div>
                    </div>
                    <div class="qrcode-text" id="dvPdaLogIn">扫描二维码登录PDA客户端</div>
                </div>
                <!--//login left-->
                <div class="line"></div>
                <div class="wrap login-input-group">
                    <div class="leanme-text" id="dvUserLogIn">用户登录</div>
                    <div class="multiple-language zh-cn" id="multiple_language" data="zh-cn">中文</div>
                    <div class="leanmes-ver">
                        <div style="text-align: right; padding-right: 80px; padding-bottom: 10px;"></div>
                    </div>
                    <div class="split error-msg" id="msg"></div>
                    <div class="clear form-group">
                        <div class="form-control">
                            <input type="text" id="userName" name="userName" value="" placeholder="请输入帐号" class="input" title="请输入帐号" />
                        </div>
                        <div style="height: 15px;"></div>
                        <div class="form-control">
                            <input type="password" id="passwd" name="passwd" autocomplete="off" value="" placeholder="请输入密码" class="input" title="请输入密码" />
                        </div>
                        <div class="form-control">
                            <div class="input-group">
                                <i class="checkbox-btn">
                                    <input type="checkbox" id="rmbme" name="rmbme" class="checkbox" />
                                    <span style="vertical-align: middle;" id="spMemory">记住我</span>
                                </i>

                                <i class="checkbox-btn">
                                    <input type="checkbox" id="zhusuInput" name="rmbme" class="checkbox" />
                                    <span style="vertical-align: middle;" id="zhusuSpan">注塑机台</span>
                                </i>
                            </div>
                        </div>
                        <div class="form-control" id="login_button" style="position: relative;">
                            <button type="button" id="loginbtn" class="btn btn-primary" onclick="login()">登&nbsp;&nbsp;录</button>
                        </div>
                        <div class="ver"><span id="spVersions">产品版本：</span><%=SKT.LeanMES.Web.AppCode.Utility.GetAssemblyInfo.GetApplicationChannelVersionName() %><%=SKT.LeanMES.Web.AppCode.Utility.GetAssemblyInfo.GetApplicationVersion() %><span id="version_name"><%=SKT.LeanMES.Web.AppCode.Utility.GetAssemblyInfo.GetApplicationVersionName() %></span></div>
                    </div>
                </div>
                <div class="copyright">Copyright © <%=DateTime.Now.Year.ToString() %> 深圳市深科特信息技术有限公司 版权所有</div>
            </div>
        </div>
        <asp:HiddenField ID="hdnLang" Value="zh-cn" runat="server" />
        <asp:HiddenField ID="hdnCsrfToken" runat="server" ClientIDMode="Static" />
        <input type="hidden" id="<%=SKT.LeanMES.Web.AppCode.Utility.AntiXSRFHelper.AntiXsrfTokenKey %>" name ="<%=SKT.LeanMES.Web.AppCode.Utility.AntiXSRFHelper.AntiXsrfTokenKey %>" value="<%=hdnCsrfToken.Value %>" />
        <script src="Content/login/js/jquery.cookie.js"></script>
        <script src="Content/js/skt.utility.qrcode.js" type="text/javascript"></script>
        <script src="Content/login/js/login.2.0.js?v=4"></script>
        <script src="Content/js/jsencrypt.js?v=20210913"></script>
        <script type="text/javascript">
            var _WEB_ROOT = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/";/*虚拟目录访问问题   2017-11-11 */
            var _webRoot = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
            var _root = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
            var _LANGUAGE = $("#<%=this.hdnLang.ClientID%>").val();
            var _msg = '<%=Request.QueryString["msg"]%>';
            var _VersionName = "<%=SKT.LeanMES.Web.AppCode.Utility.GetAssemblyInfo.GetApplicationVersionName() %>";
            if (_msg != '') {
                setLoginInfo(_msg);
            }
            /*Modify by wenshun， 页面防止被嵌套*/
            if (window != top) {
                top.location.href = location.href;
            }
        </script>
    </form>
</body>
</html>
