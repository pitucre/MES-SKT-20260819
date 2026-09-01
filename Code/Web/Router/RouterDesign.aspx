<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="RouterDesign.aspx.cs" Inherits="SKT.LeanMES.Web.Router.RouterDesign" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div id="noRouterObject" style="display: none; text-align: center; margin: auto auto;
        border: 1px solid #d3d3d3; padding: 20px; background: yellow;">
        <table cellpadding="3" cellspacing="3" border="0" align="center">
            <tr>
                <td align="left">
                    <div>
                        <%=Resources.Messages.NoRouterDesignerPlugin%></div>
                    <div>
                        <a href="../Content/Component/skt.zip" title="下载证书" target="_blank">下载证书</a></div>
                    <div>
                        <a href="../Help/安全证书导入帮助手册.pdf" title="如何导入证书？" target="_blank">如何导入证书？</a></div>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <%=Resources.Messages.UsingRouterDesignerCondition%>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <%=Resources.Messages.RorterDesignerConditionOne%>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <%=Resources.Messages.RorterDesignerConditionTwo%>
                </td>
            </tr>
        </table>
    </div>
    <div id="divMsg" class="ListTableTitle" style="color: Gray; font-size: 12px; font-weight: bold;
        text-align: left; border-bottom: 0;">
        <%=Resources.lang.CurrentObject %><span id="spanMsg" style="color: Green"></span>&nbsp;&nbsp;
    </div>
    <div id="routerObject" style="width: 100%;">
        <table id="tblContent" class="EditeContentTable" cellpadding="0" cellspacing="2"
            style="width: 100%; height: 100%;">
            <tr>
                <td style="width: 150px; vertical-align: top; border-left: none;" valign="top">
                    <div class="divHeader" style="border-top: none; border-left: none;">
                        工序类型</div>
                    <div style="overflow: auto;" id="operationTypeList">
                        <table class="ListTable" cellspacing="0" cellpadding="5" style="border-width: 0px;
                            width: 100%; border-collapse: collapse;" id="tblOperationType">
                            <%=InitOperationType() %>
                        </table>
                    </div>
                </td>
                <td style="width: 2px;">
                </td>
                <td style="" valign="top">
                    <div style="border-left: 1px solid #d3d3d3;">
                        <object classid="clsid:04FC9F6D-E691-4B53-9085-0C762524725D" id="routerActiveX" codebase="../Content/Component/RouterDesigner/RouterDesigner.cab#version=2,1,2,0">
                        </object>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        var r_id = -1;
        var r_name = "";
        var ROUTER_LINE_STATUS = [];
        var ROUTER_VERSION = "2.1";
        $(document).ready(function () {
            r_id = '<%=Request.QueryString["R_Id"] %>';

            if (r_id == -1) {
                r_name = "<%=Resources.lang.SelectNullRouter %>";
            }
            else {
                r_name = decodeURI('<%= Request.QueryString["R_Name"] %>');
            }
            window.parent.showLeftMenu();
        });

        var routerDesigner = document.getElementById("routerActiveX");

        $(function () {
            //check designer is ok.
            checkRouterDesigner();
            //set designer display size.
            setRouterDesignerSize();
            //init designer language
            initDesignerLanguage();
            //init data : layout, baseinfo..
            initValue(r_name);

            //bind resize event
            $("#tblContent").resize(function () {
                setRouterDesignerSize();
            });
            $(window).resize(function () {
                setRouterDesignerSize();
            });

            //set operationType onmousehover style
            var color, size;
            $("#tblOperationType td").hover(function () {
                color = $(this).css("color");
                size = $(this).css("font-size");
                $(this).css({ "cursor": "pointer", "color": "Green", "font-size": "13px", "text-decoration": "underline" });
            }, function () {
                $(this).css({ "color": color, "font-size": size, "text-decoration": "" });
            });
            keepSessionAlive();
        });

        //get operation by operationTypeId when clicked operationType link
        function initOperation(opeTypeId) {
            if (opeTypeId != 0) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStation.GetOperationByTypeId(opeTypeId);
                if (ajax.error == null) {
                    var rows = ajax.value.Rows;
                    var jsonString = "", seq = "^";
                    for (var i = 0; i < rows.length; i++) {
                        jsonString += "" + rows[i].StationId + "," + rows[i].Station + "," + rows[i].StationDesc + "";
                        if (i != rows.length - 1) {
                            jsonString += seq;
                        }
                    }
                    routerDesigner.LoadOperations(jsonString);
                }
                else { alert(ajax.error.Message); }
            } else {
                routerDesigner.loadOperations("-10,Start,Start^-20,End,End");
            }
        }

        //check broswer whether support activeX.
        function checkRouterDesigner() {
            if (document.all.routerActiveX.object == null) {
                $("#noRouterObject").show();
                $("#itemRouter,#toolbar,#routerObject,#divMsg").hide();
            }
            else {
                $("#noRouterObject").hide();
                $("#itemRouter,#toolbar,#routerObject,#divMsg").show();
            }
        }

        //init designer size style
        function setRouterDesignerSize() {
            $("#routerActiveX").css({ "width": "100%", "height": $(window).height() - 70 });
            $("#routerObject").css({ "margin-top": "0px" });
            $("#operationTypeList").height($(window).height() - 90);
        }

        //open a router and display it.
        function LoadRouter() {
            $("#routerObject").toggle();
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=22&Multiple=false&rnd=" + Math.random(), width: 600, height: 350, onClosed: "toggleObject" });
        }

        function getChooseValue(list) {
            if (parseInt(list[0][0]) == -1) {
                toggleObject();
                return;
            }

            //init data
            r_id = parseInt(list[0][0]);
            r_name = list[0][1];
            initValue(r_name);
            setTabtext(r_name);

            //getDataSource
            initLayout(r_id);

            toggleObject();
        }

        //bind item for router
        function BindRouter() {
            if (r_id == -1) {
                alert("<%=Resources.lang.SelectNullRouter %>");
                return;
            }

            $("#routerObject").toggle();
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Router/RouterEdit.aspx?name=Router_RouterEdit&ID=" + r_id + "&From=other";
            dialog({ title: "<%=Resources.Pages.Router_RouterEdit %>", src: openWinUrl, width: 650, height: 350, onClosed: "toggleObject" });
        }

        //display router design
        function initLayout(rid) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.GetLayout(rid);
            if (ajax.error == null) {
                var source = ajax.value.R_JSON;
                if (source != "") {
                    routerDesigner.LoadRouterInfo(source);
                } else {
                    routerDesigner.LoadRouterInfo("{'OperationNode':[],'Link':[]}");
                } 
            } else {
                alert(ajax.error.Message);
            }
        }

        function Save() {
            var data = routerDesigner.GetRouterInfo();
            if (data == "") {
                return;
            }
            if (r_id == -1) {
                alert("<%=Resources.Messages.SaveRouterBaseInfoFirst %>");

                $("#routerObject").toggle();
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Router/RouterEdit.aspx?name=Router_RouterAdd&ID=-1&From=other";
                dialog({ title: "<%=Resources.Pages.Router_RouterAdd %>", src: openWinUrl, width: 650, height: 350, onClosed: "toggleObject" });
                return;
            }

            toggleObject();
            showWaiting();

            setTimeout(function () {
                saveCore();
            }, 10);
        }

        function saveCore() {
            var data = routerDesigner.GetRouterInfo();

            var entity = strJson2Object(data);
            var link = entity.Link;
            var objLink = null;
            var linkString = "", seq1 = ",", seq2 = "^", linkStatus = "";
            for (var i = 0; i < link.length; i++) {
                objLink = link[i];
                linkStatus = formatIsPass(objLink.IsPass);
                if (linkStatus == 255) {
                    alert("路由连接线状态值不正确，请确定您本地计算机已安装最新版本的路由设计器，路由设计器当前最新版本为：" + ROUTER_VERSION.toString());
                    return false;
                }

                linkString += objLink.FromNode + seq1 + objLink.ToNode + seq1 + formatIsPass(objLink.IsPass) + seq1;
                linkString += seq2;
            }
            //alert(linkString);
            /*Save Event*/
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.UpdateLayout(r_id, data, linkString);
            if (ajax.error == null) {
                alert("<%=Resources.Messages.SaveInSuccess %>");
            } else {
                alert(ajax.error.Message);
            }
            toggleObject();
            closeWaiting();
        }

        //hide or show router designer
        function toggleObject() {
            $("#routerObject").show();
        }

        function setBaseValue(rid, rname) {
            r_id = rid;
            r_name = rname;
            $("#spanMsg").html(rname);
            setTabtext(rname);
        }

        function initValue(str) {
            if (document.all.routerActiveX.object != null) {
                routerDesigner.loadOperations("-10,Start,Start^-20,End,End");
                if (r_id != -1) {
                    initLayout(r_id);
                }

                ROUTER_LINE_STATUS = routerDesigner.GetRouterLineStatus().split(",");
            }
            $("#spanMsg").html(str);
        }

        function formatIsPass(isPass) {
            var a = 255; /*数据库中默认为tinyint，从0~255，如果状态不在内置的范围内，则默认为255，即是一个非法的状态或手动输入的状态*/
            for (var i = 0, j = ROUTER_LINE_STATUS.length; i < j; i++) {
                if (isPass.toLowerCase() == ROUTER_LINE_STATUS[i].toLowerCase()) {
                    a = i;
                    break;
                }
            }
            return a;
        }

        function initDesignerLanguage() {
            routerDesigner.ClearScreen = "<%=Resources.lang.ClearScreen %>";
            routerDesigner.AddPort = "<%=Resources.lang.AddPort %>";
            routerDesigner.Layer = "<%=Resources.lang.Layer %>";
            routerDesigner.ConfirmClearScreen = "<%=Resources.Messages.ConfirmClearScreen %>";
            routerDesigner.RouterNoLink = "<%=Resources.Messages.RouterNoLink %>";
            routerDesigner.IsBlankRouter = "<%=Resources.Messages.IsBlankRouter %>";
            routerDesigner.SystemMessage = "<%=Resources.Messages.SystemMessage %>";
            routerDesigner.NeedStartEndOperation = "<%=Resources.Messages.NeedStartEndOperation %>";
            routerDesigner.DoubleOperation = "<%=Resources.Messages.DoubleOperation %>";

            routerDesigner.SetLang();
        }
        function setTabtext(rname) {
            window.parent.getCurrentTab().text(rname + " [<%=Resources.Pages.Router_RouterDesign %>]");
        }

        function ConfigOperation(operationId, operationName) {
            /*判断站位是否保存到路由中*/
            var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxRouter.OperationIsInRouter(operationId, r_id);
            if (ajax1.error != null) {
                alert(ajax1.error.Message);
                return false;
            }
            var _operationIsInRouter = ajax1.value;
            if (!_operationIsInRouter) {
                alert("请先保存路由！");
                return false;
            }

            var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxSDP.CheckStationHasModel(operationId);
            if (ajax2.error != null) {
                alert(ajax2.error.Message);
                return false;
            }
            var operationhasmodel = ajax2.value;
            if (operationhasmodel == "False") {
                alert("工序上没有绑定绑定新模板或者绑定的是系统模板,如果需要设置,请使用'系统管理->客户端管理->站位权限配置'功能进行绑定自定义模板！");
                return false;
            }

            $("#routerObject").toggle();
            if (operationhasmodel == "Defualt") {
                /*打开Activity配置窗口*/
                var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Router/RouterActivity.aspx?name=Router_RouterActivity&RouterID=" + r_id + "&OperationID=" + operationId + "&RouterName=" + r_name + "&OperationName=" + operationName;
                dialog({ title: "<%=Resources.Pages.Router_RouterActivity %>", src: (openWinUrl), width: 650, height: 470, onClosed: "toggleObject" });
            }
            else {                 
                var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SDP/RouteFunctionSetting.aspx?RouterID=" + r_id + "&OperationID=" + operationId;
                dialog({ title: "<%=Resources.Pages.Router_RouterActivity %>", src: (openWinUrl), width: 850, height: 550, onClosed: "toggleObject" });
            }
        }
        function keepSessionAlive() {
            setInterval(function () {
                $.post("../Framework/Expired.aspx?x=" + Math.random() * 1000);
            }, 180000);
        }

    </script>
</asp:Content>
