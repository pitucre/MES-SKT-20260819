<%@ Page Title="" Language="C#" MasterPageFile="~/MobileApp/MobileMaster.Master"
    AutoEventWireup="true" CodeBehind="Myprofile.aspx.cs" Inherits="SKT.LeanMES.Web.MobileApp.Myprofile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-bottom:30px;">
    <ul data-role="listview" data-inset="false" data-theme="c" class="listview">
        <li><a href="#" onclick="javascript:location.href='MyInfo.aspx'" style="background:#f2f2f2;border-color:#f2f2f2">
            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAD7SURBVCjPddGxK8RhGAfwz3suSR0yMChdEcNNZ7Iqf4JNiX/gMhgsTsqoXMouw42Gmy2yiMNkIKssdJy65HCG37m85Ds9Pd9Pz/IE4JJuC5ZN4EbJvrc8CO2aRTsyCfeiYI88Uu3VsEKnJqNgOBm/Qc6kn5mUi0FWbwR6ZWPQ73f6Y9D8A5oxuNaI6obrGFRdROBcNQY12+qd+llJ7QfII1QUPYIHxVBJtqQTd+zxY2Z34LQ1SzisnR19DLaPhTI9cqZNufvcCnVafakVIy6cuPKaNmTTnAHBe2rUBmHdvLQlTw6shfKmVV3tey23GE9eiE+7oXxrzP+5/wIX4z7mtlcpigAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxNS0wNy0yNVQyMTo0OTo0NCswODowMBAuKfMAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTQtMDktMTdUMTE6MDk6MDQrMDg6MDB+7sVdAAAATnRFWHRzb2Z0d2FyZQBJbWFnZU1hZ2ljayA2LjguOC0xMCBRMTYgeDg2XzY0IDIwMTUtMDctMTkgaHR0cDovL3d3dy5pbWFnZW1hZ2ljay5vcmcFDJw1AAAAGHRFWHRUaHVtYjo6RG9jdW1lbnQ6OlBhZ2VzADGn/7svAAAAGHRFWHRUaHVtYjo6SW1hZ2U6OkhlaWdodAA1MTKPjVOBAAAAF3RFWHRUaHVtYjo6SW1hZ2U6OldpZHRoADUxMhx8A9wAAAAZdEVYdFRodW1iOjpNaW1ldHlwZQBpbWFnZS9wbmc/slZOAAAAF3RFWHRUaHVtYjo6TVRpbWUAMTQxMDkyMzM0NM5uRXkAAAATdEVYdFRodW1iOjpTaXplADkuNjFLQkJwclwTAAAAWnRFWHRUaHVtYjo6VVJJAGZpbGU6Ly8vaG9tZS93d3dyb290L3d3dy5lYXN5aWNvbi5uZXQvY2RuLWltZy5lYXN5aWNvbi5jbi9zcmMvMTE3NTQvMTE3NTQ4NC5wbmdfDRDRAAAAAElFTkSuQmCC"
                alt="个人信息" class="ui-li-icon ui-corner-none"><span><%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %></span></a></li>    
        <li><a href="#" onclick="javascript:location.href='ModifyPwd.aspx'" style="background:#f2f2f2;border-color:#f2f2f2"
            data-transition="none">修改密码</a></li>
        
        <li class="appconfig"><a href="#" onclick="configServer()" data-transition="none" style="background:#f2f2f2;border-color:#f2f2f2">配置服务信息</a></li>
         
        <li class="lastli"><a href="#" onclick="javascript:location.href='VerInfo.aspx'" data-transition="none" style="background:#f2f2f2;border-color:#f2f2f2">版本信息</a></li>
    </ul>
        </div>
    <div style="height: 50px; clear: both;">
    </div>
    <div id="btnLgout">
        <button data-theme="d" onclick="logout();">
            退出登录</button>
    </div>
    <div data-role="footer" id="Div5" data-position="fixed">
        <div data-role="navbar">
            <ul>
                <li><a href="#" onclick="javascript:location.href='Index.aspx'" data-icon="home"
                    data-transition="none">主页</a></li>
                <li><a href="#" data-icon="user" class="ui-btn-active" data-transition="none"></a></li>
            </ul>
        </div>
    </div>
    <script type="text/javascript"> 
        $(function () {
            $(".ui-btn-left").hide();
            if (!window.nativeMethod)
            {
                $(".appconfig").hide();
            }
        });

        function configServer()
        {
            if (confirm("是否确定要更改服务信息，【确定】将会退出当前系统？")) {
                try {
                    window.nativeMethod.toActivity("configact");
                }
                catch (ex) {
                    alert("此功能只针对LEAN MES的移动APP客户端(Android版)有效。\n详细错误信息：" + ex);
                }
            }
        }
    </script>
</asp:Content>
