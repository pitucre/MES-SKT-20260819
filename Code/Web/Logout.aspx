<%@ Page Language="C#" AutoEventWireup="true" Inherits="SKT.LeanMES.Web.Logout" CodeBehind="Logout.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title><%=Resources.Messages.InProcessOfLogout%></title>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jsencrypt.js?v=20210913" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center; color: Red; font-size: 12px; font-family: Verdana, 微软雅黑,黑体, 宋体;">
            <%=Resources.Messages.InProcessOfLogout%>
        </div>
    </form>
    <script type="text/javascript" language="javascript">
        var _root = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
        $(function myfunction() { 
            try {
                var ajax = SKT.LeanMES.Web.AccountController.Logout();
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var oname = window.localStorage.getItem("OrganizationName");
                if (oname) {
                    oname = 1;
                } else {
                    oname = 0;
                }
                window.localStorage.removeItem("OrganizationName");
                window.location.href = "<%= SKT.LeanMES.Web.WebHelper.WebRoot %>/Login.aspx?org=" + oname;
            }
            catch (ex) {
            }
        });
    </script>
</body>
</html>
