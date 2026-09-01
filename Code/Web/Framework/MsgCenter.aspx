<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Masters.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.Framework.MsgCenter" ViewStateMode="Disabled" CodeBehind="MsgCenter.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .plnDetail-wrap
        {
            position: relative;
            height: 120px;
        }
        .plnDetail-wrap .plnImg
        {
            position: absolute;
            top: 15px;
            /*left: 15px;*/
            border: 1px solid #d3d3d3;
            width: 95px;
            height: 95px;
        }
        .plnDetail-wrap .plnImg img
        {
            margin: auto auto;
            display: block;
            margin-top: 10px;
        }
        .plnDetail-wrap .plnDetail
        {
            position: absolute;
            top: 15px;
            left: 120px;
        }
        .plnDetail-wrap .plnDetail ul
        {
            padding: 0px;
            margin: 0px;
        }
        .plnDetail-wrap .plnDetail ul li
        {
            line-height: 25px;
            list-style: none;
        }
        .plnDetail-wrap .downloadPln
        {
            width: 60px;
            height: 24px;
            background: #e3e3e3 url(../Content/images/download.png) 5px center no-repeat;
            position: absolute;
            right: 50px;
            bottom: 10px;
            padding: 3px;
            padding-left: 30px;
            line-height: 24px;
            border: 1px solid #d3d3d3;
        }
        .plnDetail-wrap .downloadPln:hover
        {
            cursor: pointer;
            background: #f1f1f1 url(../Content/images/download.png) 5px bottom no-repeat;
        }

        body,div { margin:0 auto; padding:0px; }
        #navigation-content { overflow:auto; min-width:855px; }
        .divEmpty { width:50px; height:200px; float:left;    }
        .divDirRight { float:left; background-image:url('../Content/images/process/right.png'); background-repeat:no-repeat;  width:50px;  min-height:100px; margin-top:70px;}
        .divDirLeft { float:left; background-image:url('../Content/images/process/left.png'); background-repeat:no-repeat;  width:50px; min-height:100px;margin-top:70px;}
        .divDirRightDown {float:left; background-image:url('../Content/images/process/rightdown.png'); background-repeat:no-repeat;  width:50px; min-height:85px;margin-top:70px;}
        .divDirDownLeft { float:left; background-image:url('../Content/images/process/downleft.png'); background-repeat:no-repeat;  width:50px; min-height:150px; margin-top:-30px; }
        .divDirLeftDown { float:left; background-image:url('../Content/images/process/leftdown.png'); background-repeat:no-repeat;  width:50px; min-height:85px;margin-top:70px; }
        .divDirDownRight { float:left; background-image:url('../Content/images/process/downright.png'); background-repeat:no-repeat;  width:50px; min-height:150px;  margin-top:-30px; }
        .divDirDown { background-image:url('../Content/images/process/down.png'); background-repeat:no-repeat; margin-top:60px; width:15px; min-height:85px; margin-top:70px; }
            
        .box  { overflow:hidden; min-width:813px;  margin:0px auto;}
        .box  .item{ overflow:hidden; float:left; min-width:140px; margin-top:30px; }
        .box .item .biimg { margin:0px auto; width:100px; height:114px;background-position:center center; }
        .box .item .biimg span { text-align:center; color:#ffffff; display:block;  padding-top:98px; }
        .box .item  table { margin:0px auto; }
        .box .item  table tr td { background-image:url('../Content/images/process/point.png'); background-position-y:7px;  background-repeat:no-repeat; font-size:12px; padding-left:15px; padding-top:3px; }
        .box .item  table tr td  a { text-decoration:none; color:#3f8bfd }
        .box .item  table tr td  a:hover {  color:#3f8bfd }

        #box2  .idiv { overflow:hidden; float:right; }
        #box4  .idiv { overflow:hidden; float:right; }
        #box6  .idiv { overflow:hidden; float:right; }
    </style>
    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/tabs/jPlugin-tabs.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="height: 35px; line-height: 35px; background: #f5f5f5; margin: 5px 5px 2px 5px; border: 1px solid #d3d3d3;">
        <asp:Label runat="server" ID="lblUserName" Text=""></asp:Label>              
        <div style="height: 35px; line-height: 35px; background: #f5f5f5; width:28%; float:right; border: 0px; ">  
             <div class="divHeader" style="width:65%;height: 35px; line-height: 35px; background:  #f5f5f5;float:left; border: 0px;position:relative;z-index:2;">                    
               <a style="margin-right: 10px; position: absolute; top: 0px; right: 0px; font-weight: normal;"
                   href="javascript:void(0)" onclick="ModifyUserInfo()">修改资料</a>
            </div>                                 
             <div id="favorite" class="divHeader" style="height: 35px; line-height: 35px;background: #f5f5f5; border: 0px;">
                  <div style="height: 35px; line-height: 35px; float:right;margin: 0px 15px 0px 0px;border: 0px;">
                      <div class="icon-16-favorite" style="margin: 8px 2px 0px 0px;border: 0px;">
                      </div>
                      <%=Resources.lang.Download %>
                  </div>
                  <div class="divContent" id="favorite-content" style="display:none;border: 0px;">
                      <table width="100%" cellpadding="3" cellspacing="0" border="0" id="pluginDownloadList">
                      </table> 
                  </div>
             </div>
                             
       </div>         
    </div>
    <table width="100%" cellpadding="0" cellspacing="5" border="0" style=" display:none; ">
        <tr>
            <td colspan="2" valign="top">
                <table width="100%" class="EditeContentTable">
                    <tr>
                        <td class="Label2">
                            软件名称
                        </td>
                        <td class="Field2" style="color: #2a85d8">
                            <b class="mesLang">LeanMES 8.5专业版</b>
                        </td>
                        <td class="Label2">
                            当前版本
                        </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblAppVersion" Text=""></asp:Label>
                        </td>
                    </tr>
                    
                    <%if (Request.Cookies["DBLink"] != null)
                      {%>
                      <tr>
                        <td class="Label2">
                            工厂
                        </td>
                        <td class="Field2">
                            <%=Request.Cookies["DBLink"]["site"] %>
                        </td>
                        <td class="Label2">
                            数据库信息
                        </td>
                        <td class="Field2">
                            <%=Request.Cookies["DBLink"]["dbserver"]%>
                        </td>
                      </tr>
                    <%} %>
                    <%--<tr>
                        <td class="Label2">
                            技术支持
                        </td>
                        <td class="Field2" colspan="3">
                            深科特信息技术有限公司
                        </td>
                    </tr>--%>
                    <tr>
                       <td class="Label2">
                           工号
                       </td>
                       <td class="Field2">
                           <asp:Label runat="server" ID="lblEmployeeNo" Text=""></asp:Label>
                       </td>
                       <td class="Label2">
                           姓名
                       </td>
                       <td class="Field2">
                           <asp:Label runat="server" ID="lblName" Text=""></asp:Label>
                       </td>
                  </tr>
                </table>
            </td>
        </tr>
       <%-- <tr>
            <td colspan="2" valign="top">
                <div id="userInformation" class="informationContainer">
                    <div class="divHeader">
                        <div style="line-height: 20px; margin-top: 2px;">
                            <div class="icon-16-user">
                            </div>
                            <span>
                                <%=Resources.lang.UserProfile %></span>
                        </div>
                        <a style="margin-right: 10px; position: absolute; top: 0px; right: 0px; font-weight: normal;"
                            href="javascript:void(0)" onclick="ModifyUserInfo()">修改资料</a>
                    </div>
                    <div class="divContent" id="userInfoContent">
                        <table class="EditeContentTable" width="100%">
                            <tr>
                                <td class="Label2">
                                    上次登录时间
                                </td>
                                <td class="Field2" colspan="3">
                                    <asp:Label runat="server" ID="lblLastLoginTime" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Label2">
                                    工号
                                </td>
                                <td class="Field2">
                                    <asp:Label runat="server" ID="lblEmployeeNo" Text=""></asp:Label>
                                </td>
                                <td class="Label2">
                                    姓名
                                </td>
                                <td class="Field2">
                                    <asp:Label runat="server" ID="lblName" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="Label2">
                                    电话
                                </td>
                                <td class="Field2">
                                    <asp:Label runat="server" ID="lblTel" Text=""></asp:Label>
                                </td>
                                <td class="Label2">
                                    邮箱
                                </td>
                                <td class="Field2">
                                    <asp:Label runat="server" ID="lblEmail" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>--%>
        <tr>
            <%--  <td valign="top" width="50%">
                <div id="historyVisited" class="informationContainer">
                    <div class="divHeader">
                        <div style="line-height: 20px; margin-top: 2px;">
                            <div class="icon-16-history">
                            </div>
                            登录历史
                        </div>
                    </div>
                    <div class="divContent" id="historyVisited-content">
                        <table width="100%" cellpadding="3" cellspacing="0" border="0">
                            <tr class="eventRow">
                                <td width="70%" align="left">
                                    &nbsp;&nbsp;用户列表
                                </td>
                                <td width="30%" align="right">
                                    <%=DateTime.Now.ToString("yyyy-MM-dd") %>
                                </td>
                            </tr>
                            <tr class="oddRow">
                                <td width="70%" align="left">
                                    &nbsp;&nbsp;角色列表
                                </td>
                                <td width="30%" align="right">
                                    <%=DateTime.Now.ToString("yyyy-MM-dd") %>
                                </td>
                            </tr>
                            <tr class="eventRow">
                                <td width="70%" align="left">
                                    &nbsp;&nbsp;新增用户
                                </td>
                                <td width="30%" align="right">
                                    <%=DateTime.Now.ToString("yyyy-MM-dd") %>
                                </td>
                            </tr>
                            <tr class="oddRow">
                                <td width="70%" align="left">
                                    &nbsp;&nbsp;修改密码
                                </td>
                                <td width="30%" align="right">
                                    <%=DateTime.Now.ToString("yyyy-MM-dd") %>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>--%>
<%--            <td valign="top" width="50%">
                <div id="favorite" class="informationContainer" style="width:25%">
                    <div class="divHeader">
                        <div style="line-height: 20px; margin-top: 2px; width:20%;">
                            <div class="icon-16-favorite">
                            </div>
                            下载
                        </div>
                    </div>
                    <div class="divContent" id="favorite-content">
                        <table width="100%" cellpadding="3" cellspacing="0" border="0" id="pluginDownloadList">
                        </table> 
                    </div>
                </div>
           <--%>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div style="text-align: center; display: none;">
        <div style="padding: 5px; display: inline-block;">
            <a href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Component/App/PDAApp.rar"
                class="Download_Pda" target="_blank" title="PDA App下载">PDA App下载</a> &nbsp;&nbsp;&nbsp;
            <a href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Component/NetFramework/dotNetFx40_Full_x86.exe"
                class="Download_Router" target="_blank" title=".Net Framwork4.0下载">&nbsp; .Net4.0
                下载</a> &nbsp;&nbsp;&nbsp; <a href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Component/PrintingPlugin/LabelPrintPlugin.cab"
                    class="Download_Print" target="_blank" title="打印插件下载">打印插件下载</a> &nbsp;&nbsp;&nbsp;
            <a href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Component/RouterDesigner/RouterDesigner.cab"
                class="Download_Router" target="_blank" title="流程设计器下载">流程设计器下载</a>
        </div>
        
    </div>
    <div id="navigation-content">
      <div id="content" class="box" >
        </div>
      
        <div id="box1" class="box" style=" clear:both; " >
            
        </div>
        <div id="box2" class="box" style=" clear:both; " >
            
        </div>
        <div id="box3" class="box" style=" clear:both; " >
            
        </div> 
        <div id="box4" class="box" style=" clear:both; " >
            
        </div>
        <div id="box5" class="box" style=" clear:both; " >
            
        </div>
        <div id="box6" class="box" style=" clear:both; " >
            
        </div>
  </div>

    <script language="javascript" type="text/javascript">

        var boxFlag = 1;
        var array = null;
        var itemObj = null;
        var divWidth = 0;

        /*加载导航数据*/
        function LoadNavigation() {
            var Navigation = SKT.LeanMES.Web.AjaxServices.AjaxNavigation.GetNavigationALL();
            if (Navigation.error != null) {
                alert(Navigation.error.Message);
                return false;
            }
            var NavigationList = Navigation.value;

            var NavigationItem = SKT.LeanMES.Web.AjaxServices.AjaxNavigation.GetNavigationItemALL();
            if (NavigationItem.error != null) {
                alert(NavigationItem.error.Message);
                return false;
            }
            var NavigationItemList = NavigationItem.value;

            for (var i = 0; i < NavigationList.length; i++) {
                var html = '<div class="item"><div class="biimg" style=" background-image:url(\'<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Theme/Metro/Images/Icon/' + NavigationList[i].Icon + '\')" ><span>' + (i + 1) + '</span></div><div><table>';
                for (var j = 0; j < NavigationItemList.length; j++) {
                    if (NavigationList[i].ID == NavigationItemList[j].NavigationId) {
                        html += '<tr><td><a href="javascript:void(0)" onclick="openNavigationUrl(\'' + NavigationItemList[j].NavigationName +'\',\'<%=SKT.LeanMES.Web.WebHelper.WebRoot %>' + NavigationItemList[j].Url + '\',' + NavigationItemList[j].Target + ')" >' + NavigationItemList[j].NavigationName + '</a></td></tr>';
                    }
                }
                html = html + '</table></div></div>';
                $("#content").append(html);
            }
            /*多语初始化*/
            initPageLang();
        }

        /*打开导连接*/
        function openNavigationUrl(NavigationName, url, target) {
            var index = url.indexOf("name=");
            var icon = "page.png";
            if (index != -1) {
                var declareUrl = url.substring(index);
                if (declareUrl.indexOf("&") > -1) {
                    var tem = declareUrl.substring(declareUrl.indexOf("&"));
                    declareUrl = declareUrl.replace(tem, "");
                }
                var PopedomName = declareUrl.replace("name=", "");

                /*权限验证*/
                var entity = {};
                entity.PopedomName = PopedomName;
                entity.UserId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
                var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspPopedomInRole", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                else {
                    var data = $.parseJSON(ajax.value).data;
                    if (data.length == 0) {
                        alert("<%=Resources.Messages.NoAccessPermission %>");
                        return false;
                    }
                    else {
                        icon = data[0].Icon;
                    }
                }
            }

            if (target == 1) {
                window.open(url);
            }
            else {
                window.parent.openTab(this, NavigationName, url, PopedomName, '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/icon/' + icon);
            }
        }

        /*判断是否可以再放进一个导航组*/
        function WidthEnough(flag, j) {
            var boxObj = $("#box" + flag).find(".idiv");
            var widthT = 0;
            for (var i = 0; i < boxObj.length; i++) {
                widthT += parseInt($(boxObj[i]).css("width").replace("px", ""));
            }

            if (divWidth - widthT >= 140 + 100) {
                return true;
            }
            boxFlag = boxFlag + 1;
            return false;
        }

        /*导航组布局*/
        function ResetLayout() {

            divWidth = parseInt($("#box1").css("width").replace("px", ""));

            var boxObj = $(".box");
            for (var i = 0; i < boxObj.length; i++) {
                var idStr = $(boxObj[i]).attr("id");
                if (idStr.indexOf("box") > -1) {
                    $(boxObj[i]).html("");
                }
            }
            $("#content").css("display", "none");
            itemObj = $("#content").find(".item");
            array = new Array(itemObj.length);

            var isAppend = true;
            var isLast = 0;
            boxFlag = 1;
            for (var i = 0; i < itemObj.length; i++) {
                array[i] = parseInt($(itemObj[i]).css("width").replace("px", ""));
            }


            for (var i = 0; i < itemObj.length; i++) {
                if (i + 1 == itemObj.length) {
                    isLast = 1;
                }

                BoxAppendItem(boxFlag, isLast, i);
                isChangeBox = 0;
            }

        }

        /*添加导航组*/
        function BoxAppendItem(flag, isLast, i) {
            if (flag % 2 == 1) {
                if ($("#box" + flag).find(".idiv").length == 0) {
                    if (flag == 1) {
                        $("#box" + flag).append('<div class="divEmpty idiv"></div>');
                    }
                    else {
                        $("#box" + flag).append('<div class="divDirDownRight idiv"></div>');
                    }
                }

                $("#box" + flag).append('<div class="item idiv">' + $(itemObj[i]).html() + '</div>');
                if (isLast == 0) {
                    var WidthEnoughFlag = WidthEnough(flag, isLast, i + 1);
                    if (WidthEnoughFlag == true) {
                        $("#box" + flag).append('<div class="divDirRight idiv"></div>');
                    }
                    else {
                        $("#box" + flag).append('<div class="divDirRightDown idiv"></div>');
                    }
                }
            } else {
                if ($("#box" + flag).find(".idiv").length == 0) {
                    $("#box" + flag).append('<div class="divDirDownLeft idiv"></div>');
                }
                $("#box" + flag).append('<div class="item idiv">' + $(itemObj[i]).html() + '</div>');
                if (isLast == 0) {
                    var WidthEnoughFlag = WidthEnough(flag, isLast, i + 1);
                    if (WidthEnoughFlag == true) {
                        $("#box" + flag).append('<div class="divDirLeft idiv"></div>');
                    }
                    else {
                        $("#box" + flag).append('<div class="divDirLeftDown idiv"></div>');
                    }
                }
            }
            return true;
        }

        $(document).ready(function () {
            $(".divContent table tr").hover(function () {
                $(this).toggleClass("hoverRow");
            });
            $("#leanmescontent").height($(window).height() - 5);
            $(window).resize(function () {
                $("#leanmescontent").height($(window).height() - 5);
                ResetLayout();
                SetBoxWidth();
            });

            initPluginList();

            $("#pluginDownloadList").find("tr").each(function (i) {
                if (i % 2 == 0) {
                    $(this).addClass("eventRow");
                }
                else {
                    $(this).addClass("oddRow");
                }
            });
            LoadNavigation();
            ResetLayout();
            SetBoxWidth();
            /*SetBoxWidth();*/
        });


        function ModifyUserInfo() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/EditProfile.aspx?name=Account_EditProfile&rnd=" + Math.random();
            dialog({ title: "修改个人资料", src: openWinUrl, width: 500, height: 400 });
        }

        function UpdateList() {
            closeDialog();
        }

        /*
        如果有插件需要用户手动下载，请将插件压缩成zip格式，否则当用户点击下载时可能无法下载而是直接打开
        createRow(plnId, plnName, plnPath)方法说明： 
        plnId:      插件的ID，不能重复
        plnName:    插件名字，在插件下载列表中显示的名字
        plnPath:    插件路径，如： Content/Component/PrintPlugin/LeanMES print plugin.zip
        */
        function initPluginList() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPlugins.GetPluginList();
            if (handleAjaxError(ajax.error)) {
                var list = ajax.value;
                for (var i = 0, j = list.length; i < j; i++) {
                    $(createRow(list[i].PlnId, list[i].PlnName, list[i].PlnPath)).appendTo($("#pluginDownloadList"));
                }
            }
        }

        function createRow(plnId, plnName, plnPath) {
            var plnHtml = '';
            plnHtml += '<tr>';
            plnHtml += '<td align="left" width="90%" style=" padding-left:10px;">';
            plnHtml += '<a href="javascript:void(0)" onclick="showPlnDetail(' + plnId + ')" title="' + plnName + '">' + plnName + '</a>';
            plnHtml += '</td>';
            plnHtml += '<td width="10%" align="center">';
            plnHtml += '<a href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/' + plnPath + '" target="_blank" title="下载">下载</a>';
            plnHtml += '</td>';
            plnHtml += '</tr>';
            return plnHtml;
        }

        function showPlnDetail(plnId) {
            var dtlHtml = "";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPlugins.GetPluginById(plnId);
            if (handleAjaxError(ajax.error)) {
                var entity = ajax.value;
                dtlHtml += '<div class="plnDetail-wrap">';
                dtlHtml += '<div class="plnImg">';
                var str = ".apk.cab.exe.ipa.rar.zip";
                entity.Ext = (entity.Ext.indexOf(".") == -1) ? ("." + entity.Ext) : entity.Ext;
                if (str.indexOf(entity.Ext) == -1) {
                    dtlHtml += '<img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/extIcon/.app.png"/>';
                }
                else {
                    dtlHtml += '<img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/extIcon/' + entity.Ext + '.png"/>';
                }
                dtlHtml += '</div>'; /*左侧图标*/
                dtlHtml += '<div class="plnDetail">';
                /*插件信息*/
                dtlHtml += '<ul>';
                dtlHtml += '<li><%=Resources.lang.PluginName %>：<b>' + entity.PlnName + '</b></li>';
                dtlHtml += '<li><%=Resources.lang.Revision %>：' + entity.Ver + '</li>';
                dtlHtml += '<li><%=Resources.lang.Format %>：' + entity.Ext + '</li>';
                dtlHtml += '<li><%=Resources.lang.PublishDate %>：' + entity.PublishDate + '</li>';
                dtlHtml += '</ul>';
                dtlHtml += '</div>';
                /*下载图标*/
                dtlHtml += '<div id="downloadPln" class="downloadPln" title="<%=Resources.lang.DownloadPlugin %>">';

                dtlHtml +='<a href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/' + entity.PlnPath + '" target="_blank"><%=Resources.lang.DownloadPlugin %></a></div>';
                dtlHtml += '</div>';
                dtlHtml += '<div class="clear5"></div>';
                /*更新历史*/
                dtlHtml += '<div style="padding:15px;">';
                dtlHtml += '<div class="wrap_tb"><ul class="tb"><li class="current"><%=Resources.lang.UpdateRecord %></li><li><%=Resources.lang.PuginIntroduction %></li></ul>';
                dtlHtml += '<div class="tb_c">';
                if (isNull(entity.UpdateLog)) {
                    dtlHtml += '<div style="padding:5px;"><%=Resources.lang.NoData %></div>';
                }
                else {
                    dtlHtml += '<div style="padding:5px; line-height:22px; height:165px; overflow:auto;">' + entity.UpdateLog.replace(/#/g, "<br/>") + '</div>';
                }
                dtlHtml += '</div>';
                dtlHtml += '<div style="padding:5px; line-height:22px; height:165px;overflow:auto;">' + entity.Description.replace(/#/g, "<br/>") + '</div>';
                dtlHtml += '</div>';
                dtlHtml += '</div>';

                dialog({
                    title: "<%=Resources.lang.PluginInfo %>",
                    width: 450,
                    height: 350,
                    content: dtlHtml,
                    resizeable: false
                });

                /*APK下载二维码*/
                if (entity.Ext.toLowerCase() == ".apk") {
                    $("#downloadPln").before('<div id="qrcode" style="position:absolute; right:55px; top:10px;"></div>');
                    $("#downloadPln").css("bottom", "-20px");
                    $("#qrcode").qrcode({
                        render: "table",
                        width: 85,
                        height: 85,
                        text: utf16to8("http://" + window.location.host + "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/" + entity.PlnPath),
                        correctLevel: 3
                    });
                }

            }
        }







        function SetBoxWidth() {

            var len = $("#box1").find(".idiv").length;
            var boxObj = $(".box");

            var w = "";
            if (len == 9) {
                w = "813px";

            }
            else if (len == 11) {
                w = "1003px";
            }
            else if (len == 13) {
                w = "1190px";
            }
            else if (len == 15) {
                w = "1390px";
            }
            else if (len == 17) {
                w = "1573px";
            }
            for (var i = 0; i < boxObj.length; i++) {
                $(boxObj[i]).css("width", w);
            }

            var screenHeight = parseInt($(window).height());
            var screenWidth = $(window).width();
            $("#navigation-content").css("height", (screenHeight - 55) + "px");

            console.log(screenHeight);
        }





        $(function () {
            $("#favorite").hover(
                function () { $("#favorite-content").show(); },
                function () { $("#favorite-content").hide(300); }
            );
        });


    </script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.qrcode.js" type="text/javascript"></script>
</asp:Content>
