<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Prompt_Semi_Finished.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.Prompt_Semi_Finished" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:HiddenField ID="hfRequiredField" runat="server" Value="状态" />
        <asp:FileUpload ID="FileUpload1" runat="server" Width="350" />
        <asp:Button ID="Button1" runat="server" Text="上传" onclick="Button1_Click" />
    </div>
    </form>
</body>
</html>
