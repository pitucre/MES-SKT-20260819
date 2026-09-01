<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomKanBan.aspx.cs" Inherits="SKT.LeanMES.Web.CustomMenu.CustomKanBan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server" id="thead">
         <%=InitPage() %>
    </head>
    <body>
    <form id="form1" runat="server">
         <%=InitBodyPage() %>
    </form>
</body>
<script src="../Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
<script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
<script type="text/javascript">
    var InitPage = '<%=IsPreView %>';
    $(document).ready(function () {
        if (InitPage == 'True') {
            data = store.get("PreviewCookieKB");
            var data1 = decodeURI(data);
            var index = data1.indexOf("@@@@@@@@@@;");
            $("#thead").html("");
            $("#form1").html("");
            $("#thead").html(data1.substring(0, index));
            $("#form1").html(data1.substring(index + 11));
        } 
     })
    </script>
</html>
