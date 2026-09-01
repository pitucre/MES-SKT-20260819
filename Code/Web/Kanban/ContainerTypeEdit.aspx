<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContainerTypeEdit.aspx.cs"
    MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.Kanban.ContainerTypeEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">

    <link href="../Content/plugin/jquery-ui-1.10.4/jquery-ui.min.css" rel="stylesheet"
        type="text/css" />
    <link href="../Content/theme/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/jquery-ui-1.10.4/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../Content/plugin/jquery-ui-1.10.4/jquery-ui.min.js" type="text/javascript"></script>
    <script src="../Content/theme/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
    <script type="text/javascript" src="../Content/theme/bootstrap/js/respond.js"></script>
    <![endif]-->
    <style>
        .contUnit {
            width: 350px;
            height: 150px;
            padding: 0.5em;
            box-shadow: 5px 5px 7px #888888;
        }

        #divConM {
            margin: 0;
            padding: 3px;
            min-height: 500px;
            width: 100%;
            position: relative;
            clear: both;
        }

        p {
            font-weight: bolder;
            font-size: 16px;
            text-align: center;
        }
    </style>
<%--</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">--%>
    <div id="divInput">
        <div class="infoTips">
            <%=Resources.Messages.WithAsteriskIsRequired %>
        请先点击生成内容再保存。
        </div>
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">布局类型命名<em>*</em>
                </td>
                <td class="Field2">
                    <input type="text" id="txtConTypeName" isrequired="1" maxlength="10" class="TextBox" runat="server" ClientIDMode="Static"/>
                </td>
                <td class="Label2">控件个数<em>*</em></td>
                <td class="Field2">
                    <input type="text" id="txtUnitNum" isrequired="1" maxlength="3" isnumber='1' minvalue='0'
                        onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"  class="TextBox" runat="server" ClientIDMode="Static"/>
                    <input type="button" id="btnGenHtml" value="点击这里开始设计" />

                </td>
            </tr>
            <tr>
                <td class="Label2">备注/描述
                </td>
                <td class="Field2">
                    <textarea rows="20" cols="5" id="txtRemark" class="TextArea" style="width: 100%; height: 30px" runat="server" ClientIDMode="Static"></textarea>
                </td>
                <%--<p>暂时不用HTML编辑保存功能，如紧急需要可直接改数据库对应类型代码</p>--%>
                <td class="Label2" style="display: none">HTML
                </td>
                <td class="Field2" style="display: none">
                    <textarea rows="20" cols="5" id="txtHtml" class="TextArea" style="width: 100%; height: 30px"></textarea>
                </td>
            </tr>
        </table>
    </div>
    <div id="divHide" style="text-align: center; height: 18px; padding: 2px; padding-left: 5px; background: #f1f1f1; border: 1px solid #d3d3d3; border-bottom: none; position: relative;">
        <h3><a href="#">显示或隐藏</a></h3>
    </div>
    <div class="containerbody Container ui-widget-content" id="divConM" style="height:500px" runat="server" ClientIDMode="Static" >
        <%--           <div class="col-md-6 col-sm-6 contUnit ui-widget-content" id="card1">
                <label class="lbtext">
                </label>
            </div>
            <div class="col-md-6 col-sm-6 contUnit ui-widget-content" id="card2">
                <label>
                </label>
            </div>
            <div class="col-md-4 col-sm-4 contUnit ui-widget-content" id="card3">
                <label>
                </label>
            </div>
            <div class="col-md-4 col-sm-4 contUnit ui-widget-content" id="card4">
                <label>
                </label>
            </div>
            <div class="col-md-4 col-sm-4 contUnit ui-widget-content" id="card5">
                <label>
                </label>
            </div>--%>
    </div>

    <script type="text/javascript">
        //        var availHeight_screen = screen.availHeight;
        //        var winH = document.body.offsetHeight == 0 ? document.documentElement.clientHeight : document.body.offsetHeight;
        //        var winW = document.body.offsetWidth;
        var momHeigth = $("#divConM").height();   //母体高度
        var momWidth = $("#divConM").width();   //母体宽度
        var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        $(function () {

            $(window).resize(function () {
                momHeigth = $("#divConM").height();   //母体高度
                momWidth = $("#divConM").width();   //母体宽度
            });
        });

        function UiAction() {
            var dragging = false;
            var inx;
            var unit = $(".contUnit");

            unit.bind('mousedown',
                function () {
                    inx = $(this).index();
                });

            document.onmousemove = function (e) {
                unit.eq(inx)
                    .find('label')
                    .html(
                        'width:' + unit.eq(inx).width() + '</br>' +
                        'height:' + unit.eq(inx).height() + '</br>' +
                        '宽度：' + (unit.eq(inx).width() * 1 / (unit.eq(inx).parent().width()) * 100).toFixed(3) + '%' + '</br>' +
                        '高度：' + (unit.eq(inx).height() * 1 / momHeigth * 100).toFixed(3) + '%'
                    );
            }

            //缩放
            $(".contUnit")
                .resizable({
                    minHeight: 100
                    , minWidth: 150
                    //                    , grid: 2
                    //                    , containment: "#divConM" //限制缩放区域（母体）
                });

            //拖动
            $(".contUnit")
                .draggable({
                    //                    containment: "#divConM" //不能超过母体
                    //                    , scroll: false //不自动滚动背景div
                    //                    , grid: [2, 2]
                });
        }

        function Save() {
            var contId = '<%=Request.QueryString["ID"] %>';
            var cName = $("#txtConTypeName").val();
            var hCode = getFitCode();
            var cRemark = $("#txtRemark").val();
            if (!(cName !== '' && $("#divConM").html() !== '')) {
                alert("缺少必要信息");
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.EditContainerType(contId, cName, hCode, cRemark, user, 1);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else {
                alert("<%=Resources.Messages.SaveInSuccess %>");
                $("#txtHtml").val(getFitCode());
            }
        }

        //计算每个unit的定位百分比和高宽百分比，返回最终HTML
        //注意保存Container的高度  不要添加Container类  BirongLiang2017-1-13
        function getFitCode() {
            var unitNum = $(".contUnit").length;
            if (unitNum < 1) return false;
            var code1 = '<div class="containerbody" style="position: relative;clear:both;height: 85%">';
            var codeUnits = '';
            $('.contUnit').each(function (k) {
                var uLeft = $(this).css("left").slice(0, -2) * 100;
                var uTop = $(this).css("top").slice(0, -2) * 100;
                var uHeight = $(this).css("height").slice(0, -2) * 100;
                var uWidth = $(this).css("width").slice(0, -2) * 100;
                //console.log({momWidth,momHeigth,uLeft,uTop,uHeight,uWidth})
                codeUnits += '<div class="contUnit ui-widget-content" style="position: absolute;' +
                    'left:' + uLeft / momWidth + '%;' +
                    'top:' + uTop / momHeigth + '%;' +
                    'width:' + uWidth / momWidth + '%;' +
                    'height:' + uHeight / momHeigth + '%"></div>';

            });
            //console.log(codeUnits)
            return code1 + codeUnits + '</div>';
        }

        $("#btnGenHtml").on('click',
                function () {
                    var unitNum = $("#txtUnitNum").val() * 1;
                    if (unitNum < 1) { alert("控件个数有误"); return false; }
                    $("#divConM").html('');//清空内容
                    for (var i = 0; i < unitNum; i++) {
                        $("#divConM").append('<div class="col-sm-6 contUnit ui-widget-content" style="background: #eeeeee;">' +
                            '<label></label>' +
                            '<p>拖动并设计布局</p>' +
                            '<p>Card:' + (i + 1) + '</p>' +
//                            '<p><button type="button" onclick="setMaxHeight(this)">MaxHeight</button></p>' +
                            '</div>');
                    }
                    $(".contUnit").css("position", "absolute");
                    UiAction();
                });

        $("#divHide").on('click',
                function () {
                    $("#divInput").toggle();
                    getFitCode();
                });

        function setMaxHeight(e) {
            alert($(e).parent().parent().css("height"))
        }
    </script>
</asp:Content>

