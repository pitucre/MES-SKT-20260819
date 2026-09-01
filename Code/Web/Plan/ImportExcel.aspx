<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImportExcel.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.ImportExcel" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="/Content/js/jquery.min.js" type="text/javascript"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <%--记录上传的成品还是半成品1为成品 2为半成品由后台页面初始化时赋值--%>
         <asp:HiddenField ID="hfPlanTypeID" runat="server" />


         <%--成品计划需要验证不为NULL的数据写在里--%>
        <asp:HiddenField ID="hfRequiredField" runat="server" Value="工单号" />
         <%--半成品计划需要验证不为NULL的数据写在里--%>
        <asp:HiddenField ID="hfRequiredField_Semi_Finished" runat="server" Value="订单号" />

        <asp:HiddenField ID="hfSheetName" runat="server" Value="生产订单" />
        

        <asp:FileUpload ID="FileUpload1" runat="server" Width="350" />
        <asp:Button ID="Button1" runat="server" Text="上传" onclick="Button1_Click" />
    </form>
</body>
</html>
