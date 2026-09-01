<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="CreateMenus.aspx.cs" Inherits="SKT.MES.Web.Help.CreateMenus" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>生成菜单</title>
    <meta http-equiv="Content-Type" content="text/html;charset=gb2312"/>
    <script src="script/jquery.min.js" type="text/javascript"></script>
    <link href="css/help.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        a
        {
            color: #666666;
            text-decoration: none;
        }
        a:link
        {
            color: #666666;
            text-decoration: none;
        }
        a:hover
        {
            color: #666666;
            text-decoration: underline;
        }
    </style>
</head>
<body style="margin: 0px; padding: 0px; font-family: Verdana, 微软雅黑,黑体, 宋体; background: #faf9f9;">
    <form id="form1" runat="server">
    <div style="height: 50px; background: #0b82c6; position: relative;">
        <div style="position: absolute; left: 10px; top: 0px; line-height: 50px; font-size: 22px;
            font-weight: bold; color: #ffffff;">
            生成菜单
        </div>
    </div>
    <div style=" height:23px; background:#eeeeee; padding:7px 3px 3px 20px;">
        <div style="line-height:19px; margin-left:5px; border:1px solid #faf9f9; width:75px; text-align:center; background:#f1f9f9; float:left;"><a href="#">生成菜单</a></div>
        <div style="line-height:19px; margin-left:5px; border:1px solid #faf9f9; width:75px; text-align:center; background:#faf9f9; float:left;"><a href="ImportHelp.aspx" target="_self">导入帮助</a></div>
    </div>
    <div style="padding: 10px 20px 20px 20px;">
        <div style="border-left: 5px solid #0b82c6; height: 20px; padding: 10px; border-right: 1px solid #eeeeee;
            border-top: 1px solid #eeeeee; border-bottom: 1px solid #eeeeee; background: #ffffff;">
            上传XML文件生成菜单
        </div>
        <div style="clear: both; height: 10px;">
        </div>
        <div style="border-left: 5px solid #0b82c6; min-height: 120px; height:auto; padding: 10px; border-right: 1px solid #eeeeee;
            border-top: 1px solid #eeeeee; border-bottom: 1px solid #eeeeee; background: #ffffff;">
            <div style="position: relative; height:80px;">
                <div style="position: absolute; left: 10px; top: 20px;">
                    <asp:FileUpload ID="flupload" runat="server"  CssClass="fileupload" 
                        Height="46px" Width="596px"/>
                </div>
                <div style="position: absolute; left: 610px; top: 20px;">
                    <asp:Button ID="btnUpload" runat="server" Text="上传XML文件" 
                          CssClass="button" Height="46px" onclick="btnUpload_Click"/>
                </div>
            </div>
            <div >
                <asp:Label ID="lblMessages" runat="server" Text="" ForeColor="Red" Font-Size="12px"  CssClass="message"></asp:Label>
            </div>
            <div >
                 
            </div>
        </div>
    </div>
    <script language="javascript" type="text/javascript">
        $(function () {
            $("#<%=this.btnUpload.ClientID %>").click(function () {
                var fileName = $("#<%=this.flupload.ClientID %>").val();
                if (fileName == "") {
                    $("#<%=this.lblMessages.ClientID %>").text("请选择要上传的XML文件！");
                    return false;
                }
                var fileExt = fileName.substring(fileName.lastIndexOf(".") + 1);

                if (fileExt.toLowerCase() != "xml") {
                    $("#<%=this.lblMessages.ClientID %>").text("文件格式不正确，只能上传XML文件！");
                    return false;
                }
                $("#<%=this.lblMessages.ClientID %>").text("请稍后，文件正在上传...");
                return true;
            });
        });
    </script>
    </form>
</body>
</html>
