<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Preview.aspx.cs" Inherits="SKT.LeanMES.Web.SDP.Preview" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>表单预览</title>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js" type="text/javascript"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/Formdesign/css/bootstrap/css/bootstrap.css?2023" rel="stylesheet"
            type="text/css" />
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/Formdesign/css/site.css?2023" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
        /*
            表单预览是在预览已经创建的表单现在的样式；所以没有内容，数据来源是在from内
        */
        $(document).ready(function () {
            document.write(window.opener.GetPreiewData());
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
    </div>
    </form>
</body>
</html>
