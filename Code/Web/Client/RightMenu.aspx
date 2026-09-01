<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RightMenu.aspx.cs" Inherits="SKT.LeanMES.Web.Client.RightMenu" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="../Content/js/jquery.min.js" type="text/javascript"></script>
    <style type="text/css">
        body
        {
            margin: 0px;
            padding: 0px;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 12px;
            background: #7aafe0;
        }
        #r-menu-item
        {
            overflow: auto;
            margin-top: 10px;
            margin-left: 0px;
            padding: 0px;
        }
        #r-menu-item li
        {
            list-style: none;
            height: 27px;
            width: 114px;
            background: url(../Content/theme/Metro/images/client/r_menu_bg.gif) no-repeat;
            padding: 8px 0px 0px 15px;
            margin-top: 10px;
        }
        #r-menu-item li:hover
        {
            list-style: none;
            height: 27px;
            width: 114px;
            background: url(../Content/theme/Metro/images/client/r_menu_bg_hover.gif) no-repeat;
            padding: 8px 0px 0px 15px;
            margin-top: 10px;
            cursor: pointer;
            text-decoration: underline;
        }
    </style>
    <script type="text/javascript" language="javascript">
        var floatButtons = null;
        /*加载按钮*/
        function loadButtons(buttons) {
            debugger
            var strButtons = "";

            for (var i = 0; i < buttons.length; i++) {
                strButtons += "<li><span onclick='try{" + buttons[i].Handler + "}catch(ex){}'>" + buttons[i].Text + "</span></li>";

            }
            $("#r-menu-item").html(strButtons);
        }
    </script>
</head>
<body>
    <ul id="r-menu-item">
    </ul>
    <form runat="server" id="form1">
    </form>
    <script type="text/javascript" language="javascript">
        function InfoCenter() {
            var w = $(window.parent).width() - 150;
            var h = $(window.parent).height() - 150;
            window.parent.dialog({ title: "<%=Resources.Pages.InfoCenter %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Production/InfoCenter.aspx?rnd=" + Math.random(), width: w, height: h });
        }

        function ChangePwd() {
            var uid = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>';
            if (uid == -1) {
                alert("<%=Resources.Messages.AdminCannotChangePassword %>");
                return false;
            }
            window.parent.dialog({ title: "<%=Resources.Pages.UserChangePwd %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/User/UserChangePwd.aspx?ID=" + uid + "&rnd=" + Math.random(), width: 450, height: 300 });
        }

        function Help() {
            window.open("../Help/Help.htm");
        }


    </script>
</body>
</html>

