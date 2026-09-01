<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true" CodeBehind="SDPUIPreview.aspx.cs" Inherits="SKT.LeanMES.Web.SDP.SDPUIPreview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="sdpUI" style="width:100%; text-align:center;"> 
        <div style="width: 100%; height: 200px; display: table;">
            <span style="width: 100%; color: rgb(33, 173, 247); margin-right: auto; margin-left: auto; vertical-align: middle; display: table-cell;">正在加载数据...<br><img src="../Content/plugin/dialog/skin/default/images/loadinga.gif"></span>
        </div>

    </div>
     <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script type="text/javascript">
        var routeId = ""; //路由Id
        var proOrderId = ""; //工单Id
        var resourceId = ""; //资源Id
        var stationId = ""; //工位Id
        var userId = 0;//用户ID
        var currentTime = '';//服务器当前时间
        var data = "";
        $(document).ready(function () {
            //1.获取当前基本信息
            routeId = $("#hdnCurrRouteId").val();//路由Id
            proOrderId = $("#hdnCurrProOrderId").val();//工单Id
            resourceId = $("#hdnCurrResourceId").val();//资源Id 
            stationId = $("#hdnCurrStationId").val();//工位Id
            userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>"; //用户Id
            currentTime = '<%=DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") %>';

            if (!stationId > 0) {
                alert("请先在操作菜单列表进行切换工位操作！");
                return;
            }

            //加载页面
            data = store.get("SDPCookie");
            $("#sdpUI").html(decodeURI(data));
                         
            setContentHeight();
            setActiveInfoHeight();

            //添加强制大写选择框处理
            $("#txtSN").css("text-transform", "uppercase");             
        });
             
    </script>
</asp:Content>
