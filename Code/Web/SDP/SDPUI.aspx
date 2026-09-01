<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ProductionCollection.Master" AutoEventWireup="true" CodeBehind="SDPUI.aspx.cs" Inherits="SKT.LeanMES.Web.SDP.SDPUI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="sdpUI" style="width:100%;"> 
        <div style="width: 100%; height: 200px; display: table;">
            <span style="width: 100%; color: rgb(33, 173, 247); margin-right: auto; margin-left: auto; vertical-align: middle; display: table-cell;">正在加载数据...<br><img src="../Content/plugin/dialog/skin/default/images/loadinga.gif"></span>
        </div>

    </div>

    <script type="text/javascript">
        var routeId = ""; //路由Id
        var proOrderId = ""; //工单Id
        var resourceId = ""; //资源Id
        var stationId = ""; //工位Id
        var userId = 0;//用户ID
        var currentTime = '';//服务器当前时间
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
            $.post("../SDPHandler/LoadPage.ashx?api=LoadPage", { "station": stationId }, function (data) {
                console.log(decodeURI(data));
                $("#sdpUI").html(decodeURI(data));

                //初始化明细表
                initCollectionList();
                setContentHeight();
                setActiveInfoHeight();
                
                //添加强制大写选择框处理
                $("#txtSN").css("text-transform", "uppercase");
                                 
                //扫描框回车事件
                $("#txtSN").keydown(
                    function (e) {
                        var curKey = 0,
                            e = e || window.event;
                        curKey = e.keyCode || e.which || e.charCode;
                        
                        if (curKey == 13) {
                            proOrderId = $("#hdnCurrProOrderId").val();//工单Id
                            afterScan();                         
                        }
                        if (curKey == 46) {
                            $("#txtSN").val("");
                        }
                    }
                );
            }).error(function () { alert('页面加载失败！'); });
        });

    </script>
</asp:Content>
