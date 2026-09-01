<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MachinedInjectionMolding.aspx.cs" Inherits="SKT.LeanMES.Web.Client.MachinedInjectionMolding" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon" />

    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/jquery-ui-1.10.4/jquery-1.10.2.js"></script>
    <link href="../Content/plugin/dialog/skin/default/dialog-1.0.3.css" rel="stylesheet" type="text/css" />
    <link href="../Content/plugin/bootstrap/css/bootstrap.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/echarts/echarts.min.js"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.client.InjectionMolding.js"></script>
    <script src="../Content/plugin/layui/layui.all.js" type="text/javascript"></script>
    <link href="../Content/plugin/layui/css/layui.css" type="text/css" rel="stylesheet" />


    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/crypto-js.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.aes.js" type="text/javascript"></script>
    <title>注塑</title>
    <script lang="javascript" type="text/javascript">

        /*dialog info*/
        var _close = "<%=Resources.Common.Close %>";
        var _resizewin = "<%=Resources.lang.ResizeWin %>";
        var _dialogwin = "<%=Resources.lang.PopWin %>";
        var _help = "<%=Resources.Common.Help %>";
        var _dataLoading = "<%=Resources.Messages.DataLoading %>";
        var _enlarged = "<%=Resources.Common.Enlarged %>";
        /*base info*/
        var webroot = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
        var _webRoot = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
        var _root = webroot;
        var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var employeeCName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName %>";
        var currentTime = '<%=DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") %>';
        var lang = '<%=this.Request.Cookies["lang"].Value %>';
        var _lang = lang;
    </script>
    <style>
        .col-sm-3 {
            margin-right: 20px;
        }

        .pendingContent {
            display: flex;
            justify-content: space-around;
            align-items: center;
            border-bottom: 1px solid #ddd;
            height: 70px;
        }

        .pendingContent1 {
            display: flex;
            justify-content: space-around;
            align-items: center;
            height: 70px;
        }

            .pendingContent1 .panel-heading, .pendingContent .panel-heading {
                width: 33%;
                text-align: center;
            }

        .group-padding {
            padding: 4px 7px 2px 4px;
            width: 45%;
        }

        .group-padding2 {
            padding: 20px 7px 2px 4px;
            width: 33%;
        }

        .group-padding3 {
            padding: 10px 7px 2px 45px;
            width: 45%;
        }

        body {
            font-size: 15px
        }

        .panel-heading {
            /*height:30px*/
        }

        .panel-heading {
            /*height:30px*/
        }

        .panel-body {
            /*padding:15px*/
        }

        th {
            text-align: center
        }

        h4 {
            font-size: 20px;
            font-weight: bold;
        }

        .btn-Width {
            min-width: 40%
        }

        .tableNoLine {
            border-left: 0px;
            border-right: 0px
        }

            .tableNoLine th {
                border-left: 0px;
                border-right: 0px
            }

            .tableNoLine td {
                border-left: 0px;
                border-right: 0px
            }

        .panel-default > .panel-heading {
            background-color: white;
        }

        .FieldName {
            font-size: 18px;
            font-weight: bold;
            width: 150px;
            float: left;
            text-align: right;
        }

        #isShow {
            display: none;
        }

        .col-md-12 {
            width: 102%;
        }

        .btn {
            border: 1px solid transparent;
            margin: 10px 0px;
        }

        #divOrderInfo .row {
            margin: 3.5px 0px;
        }

        .table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
            padding: 2px;
            line-height: 1.42857143;
            vertical-align: top;
            border-top: 1px solid #ddd;
        }

        p {
            margin: 0px 0 0px;
        }
        /* 按钮样式 */
        .custom-button {
            background-color: #4CAF50; /* 设置背景颜色 */
            color: white; /* 设置文字颜色 */
            padding: 0px 9px; /* 设置内边距 */
            border: none; /* 去掉边框 */
            border-radius: 5px; /* 设置圆角 */
            cursor: pointer; /* 鼠标悬停样式为手型 */
        }

            /* 鼠标悬停时的样式 */
            .custom-button:hover {
                background-color: #45a049;
            }

        .StauesRow {
            display: flex;
            margin-top: 20px;
            width: 100%;
            align-items: center;
            justify-content: space-between;
        }

        .blue-lamp {
            width: 20px;
            height: 20px;
            border-radius: 20px;
            cursor: pointer;
            background-image: -webkit-gradient(linear,left top,left bottom,from(#02f948), to(#50c4eb));
        }

        .red-lamp {
            width: 20px;
            height: 20px;
            border: 2px solid #f52b2b;
            border-radius: 50px;
            cursor: pointer;
            background-image: -webkit-gradient(linear,left top,left bottom,from(#f52b2b),to(#f14d44));
            -webkit-animation-timing-function: ease-in-out;
            -webkit-animation-name: _red;
            -webkit-animation-duration: 500ms;
            -webkit-animation-iteration-count: infinite;
            /* -webkit-animation-direction:alternate; */
        }

        @-webkit-keyframes _red {

            0% {
                opacity: .2;
                /*box-shadow: 0 0 100px rgba(255,255,255,0.1);*/
            }

            100% {
                opacity: 1;
                border: 1px solid #f52b2b;
                /*box-shadow: 0 0 100px 20px #f52b2b;*/
            }
        }

        .popup {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .popup-content {
            background: white;
            padding: 80px;
            border-radius: 5px;
        }

        .close-btn {
            cursor: pointer;
            float: right;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="form-inline">
        <div class="panel panel-default">
            <table class="table" style="vertical-align: central; width: 100%; background-color: cornflowerblue; padding: 5px 20px 5px 20px">
                <tr>
                    <td style="width: 200px; min-width: 100px; text-align: right; vertical-align: middle;">
                        <h4>机台号：</h4>
                    </td>
                    <td style="width: 200px; min-width: 100px; text-align: right; vertical-align: middle;">
                        <h4 id="lblMachineNO"></h4>
                    </td>
                    <td style="width: 150px; min-width: 100px; justify-content: center">
                        <button type="button" class="btn btn-primary btn-large" id="btSwitchOrder">切换工单</button></td>
                    <td style="width: 150px; min-width: 100px; justify-content: center">
                        <button type="button" class="btn btn-primary btn-large" onclick="SwitchEquipment();">切换机台</button></td>
                    <td style="width: 100%; align-content: flex-end"></td>
                    <td>
                        <button type="button" class="btn btn-primary btn-large" id="getEquiConfig">设备配置信息</button></td>
                    <td <%--style="align-content: flex-end"--%>>
                        <td>
                            <button type="button" class="btn btn-danger btn-large" id="OpenEmergencyFile">应急管理</button></td>
                        <td <%--style="align-content: flex-end"--%>>
                            <button type="button" class="btn btn-green btn-large" onclick="Fullscreen()">全屏</button></td>
                        <td <%--style="align-content: flex-end"--%>>
                            <button type="button" class="btn btn-danger layui-btn-normal" onclick="ESOPMouldFileView()">ESOP</button></td>
                        <td <%--style="align-content: flex-end"--%>>
                            <button type="button" class="btn btn-warning btn-large" onclick="rollBackToMenu()">退出工序</button></td>
                </tr>
            </table>
        </div>
        <div class="container-fluid">
            <div class="row" style="height: 100%">
                <div class="col-md-9" style="margin-top: -1%; width: calc(70% - 1%)">
                    <div class="row">
                        <div class="col-md-12" style="height: 100%">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <p style="font-size: 15px; font-weight: bold;">
                                        工单信息<label id="lblOrderNO"></label>
                                    </p>
                                </div>
                                <div>
                                </div>
                                <div style="display: flex; justify-content: space-around; align-items: center; height: 300px">
                                    <div id="divOrderInfo" class="panel-body row" style="height: 296px; width: 700px; margin-left: 15px">
                                    </div>
                                    <div class="panel-body" style="margin-right: 15px;">
                                        <div id="main" style="width: 130px; min-height: 210px;"></div>
                                    </div>
                                    <div class="panel-body" style="margin-right: 15px; height: 236px; width: 250px; color: #808080; display: flex; flex-direction: column">
                                        <div style="display: flex; width: 100%; align-items: center; justify-content: space-between;">
                                            <div>产品模具关联校验</div>
                                            <div id="模具关联产品校验" class="blue-lamp"></div>
                                        </div>
                                        <div class="StauesRow">
                                            <div>模具出库到产线</div>
                                            <div id="模具出库到产线" class="blue-lamp"></div>
                                        </div>
                                        <div class="StauesRow">
                                            <div>模具上线</div>
                                            <div id="模具上线" class="blue-lamp"></div>
                                        </div>
                                        <div class="StauesRow">
                                            <div>最小包装数量</div>
                                            <div>
                                                <label id="最小包装数量" style="color: #333; font-size: 15px;">待获取</label>
                                            </div>
                                        </div>
                                        <div class="StauesRow">
                                            <div>整托数量</div>
                                            <div>
                                                <label id="整托数量" style="color: #333; font-size: 15px;">待获取</label>
                                            </div>
                                        </div>
                                        <div class="StauesRow">
                                            <div>模具CAVE</div>
                                            <div>
                                                <label id="模具CAVE" style="color: #333; font-size: 15px;">待获取</label>
                                            </div>
                                        </div>
                                        <%--<div id="main1" style="width: 130px; min-height: 210px;"></div>--%>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>

                    <div class="row" style="height: 0px;">
                    </div>
                    <div class="row">
                        <div class="col-md-12" style="margin-top: -1%">
                            <div class="panel panel-default">
                                <div class="panel-heading" style="font-size: 15px; font-weight: bold; display: flex; align-items: center;">
                                    <p style="margin-right: auto;">
                                        生产状态  
                                    </p>
                                    <p id="pMoldSeet" style="color: grey;">模具上下线</p>
                                    &nbsp;&nbsp;>&nbsp;&nbsp;
                                    <p id="pDebugging" style="color: grey;">调试</p>
                                    &nbsp;&nbsp;>&nbsp;&nbsp;
                                    <p id="pOrderStart" style="color: grey;">工单开始</p>
                                    &nbsp;&nbsp;>&nbsp;&nbsp;
                                    <p id="pOrderStop" style="color: grey;">工单结束</p>
                                    <label id="lblPromptMsg" style="margin-left: auto; margin-right: auto; color: red;"></label>
                                </div>
                                <div id="divProStatus" class="panel-body row" style="">
                                    <div class="panel-heading" style="display: none; align-items: center; justify-content: center; flex-direction: column; border-bottom: 1px solid #ddd">
                                        <%-- <p class="FieldName">
                                            机台状况 
                                             
                                        </p>
                                        <div style="display: flex; align-items: center; justify-content: center;">
                                            <label id="lblWorkingState" style="font-size: 20px;"></label>
                                        </div>--%>
                                    </div>

                                    <div class="pendingContent">
                                        <div class="panel-heading">
                                            <div class="FieldName">
                                                机台状况：  
                                            </div>
                                            <div <%--style="border:1px solid #000"--%> style="font-size: 18px; font-weight: bold; margin-top: 3.5px; color: rgb(0,0,255); text-align: left;" id="lblWorkingState">
                                            </div>

                                        </div>

                                    </div>

                                    <div class="pendingContent">

                                        <div class="panel-heading">
                                            <div class="FieldName">
                                                模具总合模数：  
                                            </div>
                                            <div <%--style="border:1px solid #000"--%> style="font-size: 18px; font-weight: bold; margin-top: 3.5px; color: rgb(0,0,255); text-align: left;" id="MouldCodeTotal">
                                            </div>
                                        </div>
                                        <div class="panel-heading">

                                            <div class="FieldName">
                                                模具寿命：  
                                            </div>
                                            <div <%--style="border:1px solid #000"--%> style="font-size: 18px; font-weight: bold; margin-top: 3.5px; color: rgb(0,0,255); text-align: left;" id="MouldLife">
                                            </div>
                                        </div>

                                        <div class="panel-heading">
                                            <div class="FieldName">
                                                模穴数：
                                            </div>
                                            <div <%--style="border:1px solid #000"--%> style="font-size: 18px; font-weight: bold; margin-top: 3.5px; color: rgb(0,0,255); text-align: left;" id="Cavity">
                                            </div>
                                        </div>

                                    </div>
                                    <div class="pendingContent">
                                        <div class="panel-heading">

                                            <div class="FieldName">
                                                不良数量： 
                                            </div>
                                            <div <%--style="border:1px solid #000"--%> style="font-size: 18px; font-weight: bold; margin-top: 3.5px; color: rgb(0,0,255); text-align: left;" id="NgQty">
                                            </div>
                                        </div>
                                        <div class="panel-heading">
                                            <div class="FieldName">
                                                已加工：  
                                            </div>
                                            <div <%--style="border:1px solid #000"--%> style="font-size: 18px; font-weight: bold; margin-top: 3.5px; color: rgb(0,0,255); text-align: left;" id="ProdQty">
                                            </div>
                                        </div>

                                        <div class="panel-heading">
                                            <div class="FieldName">
                                                待加工：  
                                            </div>
                                            <div <%--style="border:1px solid #000"--%> style="font-size: 18px; font-weight: bold; margin-top: 3.5px; color: rgb(0,0,255); text-align: left;" id="UnPordQty">
                                            </div>
                                        </div>

                                    </div>
                                    <div class="pendingContent1">
                                        <div class="panel-heading">

                                            <div class="FieldName">
                                                OEE：  
                                            </div>
                                            <div <%--style="border:1px solid #000"--%> style="font-size: 18px; font-weight: bold; margin-top: 3.5px; color: rgb(0,0,255); text-align: left;" id="OEE">
                                            </div>
                                        </div>
                                        <div class="panel-heading">
                                            <div class="FieldName">
                                                已检验数量：  
                                            </div>
                                            <div <%--style="border:1px solid #000"--%> style="font-size: 18px; font-weight: bold; margin-top: 3.5px; color: rgb(0,0,255); text-align: left;" id="CheckQty">
                                            </div>
                                        </div>

                                        <div class="panel-heading">
                                            <div class="FieldName">
                                                待检验数量：                                           
                                            </div>
                                            <div <%--style="border:1px solid #000"--%> style="font-size: 18px; font-weight: bold; margin-top: 3.5px; color: rgb(0,0,255); text-align: left;" id="UnCheckQty">
                                            </div>
                                        </div>

                                    </div>
                                    <%--<div class="pendingContent1"></div>
                                    <div class="pendingContent1"></div>
                                    <div class="pendingContent1"></div>--%>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="col-md-3" style="margin-top: -1%; height: 100%; width: 30%">
                    <div class="row">
                        <div class="col-md-12" style="height: 100%;">
                            <div class="panel panel-default" style="margin-bottom: 7px;">
                                <div class="panel-heading">
                                    <p style="font-size: 15px; font-weight: bold;">
                                        生产负责<label></label>
                                    </p>
                                </div>
                                <div id="divResponsible" class="panel-body" style="height: 255px;">
                                    <table id="tabResponsible" class="tableNoLine" style="width: 100%; height: 100%;">
                                        <%--<tr> <p style="font-weight:bold;font-size:11px;margin-top:-1%;margin-left:40%">工单二维码</p></tr>--%>
                                        <tr style="text-align: center;">

                                            <td align="center" style="width: 50%">
                                                <img alt="技术员" style="width: 120px; height: 135px;" id="images2" class="img-thumbnail" src="" />
                                            </td>
                                            <%--<td align="center" style="width:33%">
                                        <img alt="品质" style="width: 114px; height: 140px;" id="images3" class="img-thumbnail" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIwAAACMCAYAAACuwEE+AAAEt0lEQVR4Xu3YS0tbURhG4V1FEC8oOFFQUHCgiBPB//8DBCciThQUB14QQbwgiLZ8G7+wPU0a16QksjJq65uL6zw5Oemv+/v738WbBb5Z4JdgvlnKWS0gGCGgAoJBuRwLRgOogGBQLseC0QAqIBiUy7FgNIAKCAblciwYDaACgkG5HAtGA6iAYFAux4LRACogGJTLsWA0gAoIBuVyLBgNoAKCQbkcC0YDqIBgUC7HgtEAKiAYlMuxYDSACggG5XIsGA2gAoJBuRwLRgOogGBQLseC0QAqIBiUy7FgNIAKCAblciwYDaACgkG5HAtGA6iAYFAux4LRACogGJTLsWA0gAoIBuVyLBgNoAKCQbkcC0YDqIBgUC7HgtEAKiAYlMuxYDSACggG5XIsGA2gAoJBuRwLRgOogGBQLseC0QAqIBiUy7FgNIAKCAblciwYDaACgkG5HAtGA6iAYFAux4LRACogGJTL8ViCOT8/L6enp/XoTU5Olu3t7bK8vPzX0czdzMxM2dvbK9PT0+Xx8bEcHh6Wt7e3ul9ZWSk7OztDJVxfX5eTk5Py/v5et5ubm2V9ff2v++VuYmKiPuf8/HzdHBwclIeHh/rn9vUMfeIRG4wlmDb+IDAtjDxA0T6wvLy8fDkMgw5+Ozo+Pi5XV1e9f+p3n9fX197jT01N9cB07xsPsrCwUPb390eMw/CXM5Zg8tcKOE9PT33PMPGzOIB5Fop3e7z748yUgPLvcfDW1tbqGSRuccZaXFzsHfwWRx78fmDiZ3d3dyWwxBksnjORfnx81MednZ2tjxu39gw0/FCNxuJHgsmPotXV1XJzc1MPYBycs7OzepbIg51noe7PA1Cgim33I2sQmPwoWlpaqogTzPPzc4U4NzfXO6P8C/posBj8Kn4cmEQQB3xra6u+m4eByXd77NqPrH7XGv3A5EdRPM7u7m45OjoaCiauZ77zUThqgH4cmHj3xjVK+3EwDEz+PC6K2wvqQR877VkqDmggur29/fJR5hlm1Kh/fvNor2G634Dalxwo4pvU5eVl74IzceQFaHvRGvdtL1zzsbpnmO592ueMC/KNjY1ycXHRu2bJaxqvYf4jqH7fOvp9W+peo8S7vv1KnS85zyT5uHHdErf2GqY987S/avcslIDyDBNfq9tvdXlfvyWNAZj4yBn0/ykJIs8qeSaIAx8o4pb/90PBdM9C44olfu+xvob5j0Z9qs8CgpECKiAYlMuxYDSACggG5XIsGA2gAoJBuRwLRgOogGBQLseC0QAqIBiUy7FgNIAKCAblciwYDaACgkG5HAtGA6iAYFAux4LRACogGJTLsWA0gAoIBuVyLBgNoAKCQbkcC0YDqIBgUC7HgtEAKiAYlMuxYDSACggG5XIsGA2gAoJBuRwLRgOogGBQLseC0QAqIBiUy7FgNIAKCAblciwYDaACgkG5HAtGA6iAYFAux4LRACogGJTLsWA0gAoIBuVyLBgNoAKCQbkcC0YDqIBgUC7HgtEAKiAYlMuxYDSACggG5XIsGA2gAoJBuRwLRgOogGBQLseC0QAqIBiUy7FgNIAKCAblciwYDaACgkG5HAtGA6iAYFAux4LRACogGJTL8R/k/v6mUVUOxAAAAABJRU5ErkJggg==" />
                                    </td>--%>

                                            <td align="center" style="width: 50%;">
                                                <img alt="工单二维码" style="width: 135px; height: 135px;" id="images1" class="img-thumbnail" src="" />
                                            </td>
                                        </tr>

                                    </table>
                                </div>
                                <div class="panel-heading" style="text-align: center">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <p style="font-weight: bold; font-size: 18px; /*margin-top: -1%; */color: #808080;">用户：<span id="userName"></span></p>
                                        </div>

                                        <div class="col-md-6">
                                            <p style="font-weight: bold; font-size: 18px; /*margin-top: -1%; */color: #808080;">工单</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-default">
                                <div class="panel-heading" style="display: flex; justify-content: space-between; align-items: center;">
                                    <p id="pActionText" style="font-size: 15px; font-weight: bold;">操作台</p>
                                    <input type="button" class="custom-button" onclick="CloseRole()" value="返回" />
                                </div>
                                <div id="divHeadRoleButton" class="panel-body row">
                                </div>
                                <div id="divUserAndAction" class="panel-body row">
                                </div>
                                <%-- <div id="divHeadRoleButton2" class="panel-body row">
                                </div>
                                <div id="divHeadRoleButton3" class="panel-body row">
                                </div>
                                <div id="divHeadRoleButton4" class="panel-body row">
                                </div>
                                <div id="divHeadRoleButton5" class="panel-body row">
                                </div>
                                <div id="divHeadRoleButton6" class="panel-body row">
                                </div>--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div>
        </div>
        <div id="popup" class="popup">
            <div class="popup-content">
                <%-- <span class="close-btn">&times;</span>--%>
                <table>
                    <tr>
                        <td style="font-weight: bold; text-align: right;">变更状态：
                        </td>
                        <td>
                            <select id="sltStatus" style="height: 28px; width: 100px">
                                <option value="-1">--请选择--</option>
                              <%--  <option value="1">生产</option>
                                <option value="2">换模</option>
                                <option value="3">调试</option>
                                <option value="4">设备故障</option>
                                <option value="5">模具故障</option>
                                <option value="6">计划停机</option>
                                <option value="7">原材料缺料</option>
                                <option value="8">辅材缺料</option>
                                <option value="9">保养</option>
                                <option value="10">待换模</option>
                                <option value="11">试模</option>
                                <option value="12">人力不足</option>
                                <option value="13">烘料</option>
                                <option value="14">试料</option>
                                <option value="15">模具厂试模</option>--%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button style="width: 100px; height: 40px; margin-left: 30px;" class="btn btn-lg btn-rounded btn-info" type="button" onclick="CommitStatus()">确认</button>
                        </td>
                        <td>
                            <button style="width: 100px; height: 40px; margin-left: 30px;" class="btn btn-lg btn-rounded btn-info" type="button" onclick="CloseDiv()">关闭</button>
                        </td>
                    </tr>
                </table>

            </div>
        </div>

           <div id="semail" class="popup">
    <div class="popup-content">
        <%-- <span class="close-btn">&times;</span>--%>
        <table>
            <tr>
                <td style="font-weight: bold; text-align: right;">应急发送部门：
                </td>
                <td>
                    <select id="sendDpt" style="height: 28px; width: 100px">
                        <option value="-1">--请选择--</option>
                      <option value="10">生产部</option>
                        <option value="11">项目部</option>
                        <option value="12">品质部</option>
                        <option value="13">资材部</option>
                        <option value="14">综合管理部</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <button style="width: 100px; height: 40px; margin-left: 30px;" class="btn btn-lg btn-rounded btn-info" type="button" onclick="SendEmail()">确认</button>
                </td>
                <td>
                    <button style="width: 100px; height: 40px; margin-left: 30px;" class="btn btn-lg btn-rounded btn-info" type="button" onclick="CloseSend()">关闭</button>
                </td>
            </tr>
        </table>

    </div>
</div>
        <asp:HiddenField ID="hdnOrderID" runat="server" Value="" />
        <asp:HiddenField ID="hdnOrderNO" runat="server" Value="" />
        <asp:HiddenField ID="hdnMachineID" runat="server" Value="" />
        <asp:HiddenField ID="hdnMachineNO" runat="server" Value="" />
        <asp:HiddenField ID="hdnEquimentExtNo" runat="server" Value="" />
        <asp:HiddenField ID="hdnLinePlanCode" runat="server" Value="" />
        <asp:HiddenField ID="hdnUseOrAction" runat="server" Value="0" />
    </form>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/jquery-ui-1.10.4/jquery-ui.min.js"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/dialog/js/jPlugin-dialog-2.0.js"
        type="text/javascript"></script>
    <%-- <div id="digLog" style="position:absolute;left: 0;right: 0;bottom: 0;background: rgba(0, 0, 0, 0.5);z-index: 1000;width:100%;height:100%;"></div>--%>
</body>
<script lang="javascript" type="text/javascript">

    var ProdOrderId = 0
    var LineId = 0
    var LinePlanCode = "";
    var webroot = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
    var IsTime = false;
    var intervalId1 = "";
    var jt = "";
    var timerDate = 10;
    var RoleId = -1;
    // 定义好看的颜色数组
    var niceColors = ['#FFFFE0', '#98FB98', '#E6E6FA', '#ADD8E6', '#FF7F50'];

    var audioElement = document.createElement('audio');
    audioElement.setAttribute('src', '../Content/sound/warn.mp3');
    audioElement.setAttribute('id', 'player');
    $(document).ready(function () {
        $('body').attr('style', 'position:relative')
        let div1 = '<div id="isShow" style="background-color: rgba(255, 0, 0, 0.2);position: absolute;width: 100%;height: 100%;top: 0;left: 0; "></div>'
        $('body').append(div1)
        //切换工单单击事件
        $("#btSwitchOrder").click(function () {
            SwitchOrder(jt);
        })

        debugger;
        GetEquipmentStatusList();
        $("#userName").text(userName)

        function adjustFontSize() {
            var btnWidth = $('.btn-RoleWidth').width();
            var fontSize = btnWidth / 10; // 根据需要调整比例
            $('.btn-RoleWidth').css('font-size', fontSize + 'px');
        }

        $(window).resize(function () {
            adjustFontSize();
        });

        adjustFontSize();

        jt = getCookie('jt'); // 从cookie中读取机台
        if (jt == "" || jt == null) {
            var condition = " EquipmentTypeName='注塑机' ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=838&PageCondition= " + condition + "&Multiple=false&rnd=" + Math.random(), width: 450, height: 300 });
            return;
        }


        var result = GetEquimentInOrder(jt);
        if (result.length > 0) {
            if ($("#hdnOrderNO").val() != "" && $("#hdnOrderNO").val() != result[0].OrderNO) {
                gd = $("#hdnOrderNO").val();
            } else {
                gd = result[0].OrderNO;
            }
          
            setCookie('gd', result[0].OrderNO);
            setCookie('ExtNo', result[0].EquimentExtNo);
        } else {
            var gd = getCookie('gd'); // 从cookie中读取机台
        }

      
        if (gd == "" || gd == null ) {
            $("#lblMachineNO").text(jt)
            $("#hdnEquimentExtNo").val(getCookie('ExtNo'));
            getMainInfo();
            GetMachineUser(-1, -1, '', -1, '');
            SwitchOrder(jt);
            return;
        }

        debugger
        //根据机台和工单查询数据
        var entity = {};
        entity.LinePlanCode = gd;
        entity.EquipmentCode = jt;
        entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetDeviceList", JSON.stringify(entity));
        if (ajax.error != null) {
            alert(ajax.error.Message)
            return;
        } else {
            if (ajax.value.length > 0) {
                $("#hdnOrderID").val(JSON.parse(ajax.value)[0].ProdOrderID);
                //$("#hdnMachineID").val(JSON.parse(ajax.value)[0].LineId);
                $("#hdnOrderNO").val(JSON.parse(ajax.value)[0].OrderNO);
                $("#hdnMachineNO").val(JSON.parse(ajax.value)[0].MachineNumber);
                $("#hdnEquimentExtNo").val(JSON.parse(ajax.value)[0].EquimentExtNo);
                //$("#hdnLinePlanCode").val(entity.LinePlanCode);
                BindSatues(JSON.parse(ajax.value)[0]);
            } else {
                alert("排产单:" + gd + "未查询到工单线体相关数据");
                return false;
            }

        }


        $("#lblMachineNO").text($("#hdnMachineNO").val());
        var OrderID = $("#hdnOrderID").val();
        var MachineID = $("#hdnMachineID").val();
        var LinePlan = $("#hdnLinePlanCode").val();
        ProdOrderId = OrderID;
        LineId = MachineID;
        LinePlanCode = LinePlan;


        var ResourceId = JSON.parse(ajax.value)[0].ResourceId;
        var StationId = JSON.parse(ajax.value)[0].StationId;
        var LineName = JSON.parse(ajax.value)[0].LineName;
        var PackStation = JSON.parse(ajax.value)[0].PackStationId;
        var ProjectStationId = JSON.parse(ajax.value)[0].ProjectStationId;

        if (StationId != "-1" && PackStation != "-1" && ProjectStationId != "-1") {
            GetMachineUser(ResourceId, StationId, PackStation, ProjectStationId, LineName);
        }

        var entity = {};
        entity.EquipmentCode = jt;
        entity.ProdOrderId = OrderID;
        entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";;

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspProdESOPLineCollection", JSON.stringify(entity));
        if (ajax.error != null) {
            alert(ajax.error.Message)
            return;
        }


        //获取工单信息
        GetOrderInfo();
        //获取提示信息
        //GetPromptInfo();
        //GerNextInfo()

        //loadQRCoder($("#hdnLinePlanCode").val()) //加载二维码
        loadQRCoder($("#hdnOrderNO").val());

        GetImages(MachineID)
        //获取图形
        getMainInfo();
        //获取图形
        //SetGoodThroughRateChar();

        ResizeAll();
        //bulidDataTb();
        //GetRoleInjectioMoldingButton();
    });

    function showError() {
        $('#isShow').show('slow')
    }
    function notShowError() {
        $('#isShow').hide('slow')
    }

    //校验状态
    function BindSatues(data) {
        if (data) {
            data.MoudleItem == "0" ? $("#模具关联产品校验")[0].className = 'red-lamp' : $("#模具关联产品校验")[0].className = 'blue-lamp';
            data.MoudleInOrOut == "0" ? $("#模具出库到产线")[0].className = 'red-lamp' : $("#模具出库到产线")[0].className = 'blue-lamp';
            data.MouldInLine == "0" ? $("#模具上线")[0].className = 'red-lamp' : $("#模具上线")[0].className = 'blue-lamp'
            data.MinPackQty == "0" ? $("#最小包装数量").text(data.MinPackQty).css({ 'color': 'red' }) : $("#最小包装数量").text(data.MinPackQty);
            data.MaxQty == "0" ? $("#整托数量").text(data.MaxQty).css({ 'color': 'red' }) : $("#整托数量").text(data.MaxQty);
            data.Cavity == "0" ? $("#模具CAVE").text(data.Cavity).css({ 'color': 'red' }) : $("#模具CAVE").text(data.Cavity);
        }
    }

    function CheckValue() {
        $("#digLog").css("display", "none");
        var entity = {};
        entity.EquipmentCode = jt;
        entity.MoudlCode = $.trim($("#模具编码").text());
        entity.LinePlanCode = LinePlanCode;
        if (!entity.EquipmentCode) {
            return false;
        }
        if (!entity.MoudlCode) {
            return false;
        }
        if (!entity.LinePlanCode) {
            return false;
        }
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspMachinedInjectionMoldingCheck", JSON.stringify(entity));
        if (ajax.error != null) {
            alert(ajax.error.Message)
            return;
        } else {
            var IsLimit = JSON.parse(ajax.value)[0].IsLimit;

            if (IsLimit == 1) {
                $("#digLog").css("display", "block");
            }
            else {
                $("#digLog").css("display", "none");
            }
        }
    }
    function getMainInfo() {


        var entity = {};
        entity.OrderNo = $("#生产工单").text();;
        entity.MouldName = $("#模具名称").text();
        entity.EquipmentCode = $("#lblMachineNO").text();
        //通用过站验证SN      
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetInjectionMouldAndOrderInfo", JSON.stringify(entity));
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return;
        }

        if (ajax.value.length > 0) {
            var data = JSON.parse(ajax.value);
            $("#MouldCodeTotal").text(data[0].MouldCodeTotal);
            $("#Cavity").text(data[0].Cavity);
            $("#MouldLife").text(data[0].MouldLife);
            $("#NgQty").text(data[0].NgQty);
            $("#ProdQty").text(data[0].ProdQty);
            $("#UnPordQty").text(data[0].UnPordQty);
            $("#OEE").text(data[0].OEE);
            $("#CheckQty").text(data[0].CheckQty);
            $("#UnCheckQty").text(data[0].UnCheckQty);


            $("#lblWorkingState").text(data[0].StateName)
            if (data[0].State == '2') {
                $("#lblWorkingState").css("color", "#32E0E7");
                $('#pMoldSeet').css('color', 'grey');
                $('#pDebugging').css('color', 'grey');
                $('#pOrderStart').css('color', '#32E0E7');
                $('#pOrderStop').css('color', 'grey');
            } else if (data[0].State == '0') {
                $("#lblWorkingState").css("color", "#FF00FF");
                $('#pMoldSeet').css('color', '#FF00FF');
                $('#pDebugging').css('color', 'grey');
                $('#pOrderStart').css('color', 'grey');
                $('#pOrderStop').css('color', 'grey');
            }
            else if (data[0].State == '1') {
                $("#lblWorkingState").css("color", "#5470c6");
                $('#pMoldSeet').css('color', 'grey');
                $('#pDebugging').css('color', '#5470c6');
                $('#pOrderStart').css('color', 'grey');
                $('#pOrderStop').css('color', 'grey');
            }
            else if (data[0].State == '3') {
                $("#lblWorkingState").css("color", "#DB6200");
            }
            else if (data[0].State == '4') {
                $("#lblWorkingState").css("color", "#C80404");
                $('#pMoldSeet').css('color', 'grey');
                $('#pDebugging').css('color', 'grey');
                $('#pOrderStart').css('color', 'grey');
                $('#pOrderStop').css('color', '#C80404');
            }

        }

        setTimeout(getMainInfo, 10000 * 60)
    }
    function loadQRCoder(orderNum) {
        $.ajax({
            type: "GET",
            url: "../Handler/QRCoderHandler.ashx",
            data: { code: orderNum },
            success: function (result) {
                $("#images1").attr("src", result)
            }
        });
    }


    var isScroll = false;

    function ResizeAll() {

        //某些浏览器不兼容div自适应高度
        //$(".gauge").height($(window).height() * 0.9 * 0.27);
        var _contentHeight = $(window).height() * 1 * 0.2;
        $(".rows").height(_contentHeight * 0.08)

        if ($(".rows").length * _contentHeight * 0.085 > _contentHeight) {
            $("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.14 * 1 - 1);
            _InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", $("#_layout_left_data_div2_tbody").width(), 22, 1000 * 10);
            isScroll = true;
        }
    }

    function GetEquipmentStatusList() {
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentStatus();
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return;
        }
        var list = ajax.value;
        if (list.Rows.length > 0) {
            $("#sltStatus").empty().append('<option value="-1">--请选择--</option>');
            for (var i = 0; i < list.Rows.length; i++) {
                $("#sltStatus").append('<option value="' + list.Rows[i].StatusId + '">' + list.Rows[i].StatusDesc + '</option>');
            }
        }

    }


    function _InitScroll(_S1, _S2, _W, _H, _T) {
        if (isScroll) { return false; }
        marqueesHeight = _H;
        stopScroll = false;
        scrollElem = document.getElementById(_S1);
        scrollTable = document.getElementById('data_tbody');
        if (scrollTable.offsetHeight < marqueesHeight) {
            return;
        }
        with (scrollElem) {
            style.width = _W;
            style.height = marqueesHeight;
            style.overflow = 'hidden';
            noWrap = true;
        }
        scrollElem.onmouseover = new Function('stopScroll = true');
        scrollElem.onmouseout = new Function('stopScroll = false');
        preTop = 0;
        //currentTop = 0;
        //stopTime = 0;
        var leftElem = document.getElementById(_S2);
        var childElems = $(scrollElem).children();
        if (childElems.length > 1) {
            $(childElems[0]).nextAll().remove();
        }
        scrollElem.appendChild(leftElem.cloneNode(true));
        pauseTime = _T;
        setTimeout('init_srolltext()', 1000);
        init_srolltext();
    }
    function init_srolltext() {
        scrollElem.scrollTop = 0;
        scrollIntervalId = setInterval('scrollUp()', 50);
    }

    function scrollUp() {
        if (stopScroll) {
            return;
        }
        preTop = scrollElem.scrollTop;

        scrollElem.scrollTop += 1;
        if (preTop == scrollElem.scrollTop) {
            $("#data_tbody tbody").html("");
            $("#data_tbody2 tbody").html("");
            bulidDataTb();
            scrollElem.scrollTop = 0;
            scrollElem.scrollTop += 1;
        }
    }


    function bulidDataTb() {

        var entity = {};
        entity.OrderID = ProdOrderId;
        //通用过站验证SN      
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetOrderItem", JSON.stringify(entity));
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return;
        }
        var html = "";
        if (ajax.value.length > 0) {
            var dataList = JSON.parse(ajax.value[0])
            for (var i = 0; i < dataList.length; i++) {
                html += "<tr class=\"rows\">" +
                    "<td style=\"width:5%\">" + (i + 1) + "</td>" +
                    "<td style=\"width:15%\">" + dataList[i].ItemCode + "</td>" +
                    "<td style=\"width:18%\">" + dataList[i].ItemName + "</td>" +
                    "<td style=\"width:18%\">" + dataList[i].ItemSpec + "</td>" +
                    "<td style=\"width:14%\">" + dataList[i].Units + "</td>" +
                    "<td style=\"width:15%\">" + dataList[i].CompCount + "</td>" +
                    "<td style=\"width:15%\">" + dataList[i].StockQty + "</td>" +
                    "</tr>";
            }

        }

        var entity = {};
        entity.OrderID = ProdOrderId;
        entity.LineId = LineId
        var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetOrderItemNext", JSON.stringify(entity));
        if (ajax2.error != null) {
            alert(ajax2.error.Message);
            return;
        }

        var html2 = "";
        if (ajax2.value.length > 0) {
            var dataList = JSON.parse(ajax2.value[0])
            for (var i = 0; i < dataList.length; i++) {
                html2 += "<tr class=\"rows\">" +
                    "<td style=\"width:5%\">" + (i + 1) + "</td>" +
                    "<td style=\"width:20%\">" + dataList[i].ItemCode + "</td>" +
                    "<td style=\"width:15%\">" + dataList[i].Quantity + "</td>" +
                    "<td style=\"width:20%\">" + dataList[i].AllQty + "</td>" +
                    "<td style=\"width:20%\">" + dataList[i].UnderCount + "</td>" +
                    "</tr>";
            }
        }
        $(html2).appendTo($("#data_tbody2 tbody"));
        $(html).appendTo($("#data_tbody tbody"));
        ResizeAll();
    }



    function GerNextInfo() {
        var entity = {};
        entity.OrderID = ProdOrderId;
        entity.MachineID = LineId;
        //通用过站验证SN      
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetNextOrder", JSON.stringify(entity));
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return;
        }

        if (ajax.value.length > 0) {

            var data = JSON.parse(ajax.value[0])
            $("#nextPlan").text(data[0].FBILLNO)
            $("#orderNo").text(data[0].OrderNO)
            $("#num").text(data[0].Qty)
            $("#mouldCode").text(data[0].MouldCode)
            $("#color").text(data[0].Colour)
            $("#materialName").text(data[0].RawMaterial)
        }
        setTimeout(GerNextInfo, 1000 * 10)
    }


    function GetImages(LineId) {

        $.ajax({
            type: 'GET',
            url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadPortraits.ashx',
            data: { 'Type': 'RefreshUser', 'UserId': userName },
            dataType: 'text',
            success: function (data) {
                $("#images2").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/UserImg/" + data + "?rnd=" + Math.random());
            },
            error: function () {
                return false;
            }
        });


        <%--var entity = {};
        entity.LineId = LineId;
        //通用过站验证SN      
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetImages", JSON.stringify(entity));
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return;
        }

        if (ajax.value.length > 0) {
            var imageList = JSON.parse(ajax.value[0])
            var Principal = imageList[0].Principal;

            $.ajax({
                type: 'GET',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadPortraits.ashx',
                data: { 'Type': 'RefreshUser', 'UserId': userName },
                dataType: 'text',
                success: function (data) {
                    $("#images2").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/UserImg/" + data + "?rnd=" + Math.random());
                },
                error: function () {
                    return false;
                }
            });
        }--%>

    }

    //获取工单信息
    function GetOrderInfo() {

        //获取工单信息

        var entity = {};
        entity.OrderNo = $("#hdnOrderNO").val();
        //通用过站验证SN      
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetProdOrderByMachinedInjectionMolding", JSON.stringify(entity));
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return;
        }

        var AllQty = "";
        var DoQty = "";
        $("#divOrderInfo").html("");
        var data = JSON.parse(ajax.value);
        var orderHtmlInfo = "";
        var oneRow = false;
        for (var i = 0; i < data.length; i++) {
            var start = ""
            var end = ""
            if (i % 2 == 0) {
                start = "<div class=\"row\" style=\"margin-top:1px\">"
            }
            if (((i + 1) % 2 == 0 && i != 0) || i == data.length - 1) {
                end = "</div>"
            }

            if (oneRow) {
                debugger
                start = "<div class=\"row\" style=\"margin-top:1px\">";
                end = "</div>";
                oneRow = false;
            }

            if (data[i].ShowKey == "共模工单") {
                start = "<div class=\"row\" style=\"margin-top:1px\">";
                end = "</div>";
                oneRow = true;
            }


            if (data[i].ShowKey == "共模工单") {
                orderHtmlInfo = orderHtmlInfo + start + "<div class=\" col-sm-12\" style=\"margin-right:50px;\"><div class=\"row\" style=\"white-space:nowrap\">" +
                    "<label for=" + data[i].ShowKey + " class=\"col-sm-2 control-label\" style=\"color: #808080\" >" + data[i].ShowKey + ":</label>" +
                    "<div class=\"col-sm-10\">" +
                    "<label  style=\"font-size:15px;vertical-align:-webkit-baseline-middle;margin-left:-23px\" id=" + data[i].ShowKey + ">" + data[i].ShowValue + "</label>" +
                    "</div>" +
                    "</div></div>" + end;

            } else {
                orderHtmlInfo = orderHtmlInfo + start + "<div class=\" col-sm-4\"  style=\"margin-right:50px;\"><div class=\"row\" style=\"white-space:nowrap\">" +
                    "<label for=" + data[i].ShowKey + " class=\"col-sm-5 control-label\" style=\"color: #808080\" >" + data[i].ShowKey + ":</label>" +
                    "<div class=\"col-sm-7\">" +
                    "<label  style=\"font-size:15px;vertical-align:-webkit-baseline-middle;margin-left:" + (data[i].ShowKey.length - 4) * 10 + 5 + "px\" id=" + data[i].ShowKey + ">" + data[i].ShowValue + "</label>" +
                    "</div>" +
                    "</div></div>" + end;
            }

            if (data[i].ShowKey == "订单数量") {
                AllQty = data[i].ShowValue;
            }
            if (data[i].ShowKey == "已生产数量") {
                DoQty = data[i].ShowValue;
            }
        }

        $("#divOrderInfo").html(orderHtmlInfo);
        var CompletedSum = (parseFloat(DoQty) / parseFloat(AllQty) * 100).toFixed(2);
        SetGoodThroughRateChar(CompletedSum, DoQty, AllQty)


        //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.GetMoldingOrderInfo(ProdOrderId, LineId, LinePlanCode);
        //if (ajax.error != null) {
        //    alert(ajax.error.Message);
        //    return false;
        //}

        //$("#divOrderInfo").html("");
        //var data = ajax.value;
        //var orderHtmlInfo = "";
        //for (var i = 0; i < data.Rows.length; i++) {
        //    var start = ""
        //    var end = ""
        //    if (i % 2 == 0) {
        //        start = "<div class=\"row\" style=\"margin-top:5px\">"
        //    }
        //    if (((i + 1) % 2 == 0 && i != 0) || i == data.Rows.length - 1) {
        //        end = "</div>"
        //    }

        //    orderHtmlInfo = orderHtmlInfo + start + "<div class=\" col-sm-4\"  style=\"margin-right:50px;\"><div class=\"row\" style=\"white-space:nowrap\">" +
        //        "<label for=" + data.Rows[i].ShowKey + " class=\"col-sm-5 control-label\" style=\"color: #808080\" >" + data.Rows[i].ShowKey + ":</label>" +
        //        "<div class=\"col-sm-7\">" +
        //        "<label  style=\"font-size:15px\" id=" + data.Rows[i].ShowKey + ">" + data.Rows[i].ShowValue + "</label>" +
        //        "</div>" +
        //        "</div></div>" + end;
        //}

        //$("#divOrderInfo").html(orderHtmlInfo);

        //setTimeout(GetOrderInfo, 1000 * 30)
    }

    //获取生产信息
    function GetProductionInfo() {
        //获取工单信息
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.GetMoldingProductInfo(ProdOrderId, LineId);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }

        $("#divProduct").html("");
        var data = ajax.value;
        var orderHtmlInfo = "";
        var value1 = 0
        var value2 = 0
        for (var i = 0; i < data.Rows.length; i++) {
            var classInfo = "label label-info"

            if (data.Rows[i].ShowKey == "实际周期") {
                value1 = data.Rows[i].ShowValue
                value1 = parseInt(value1)
                value2 = parseInt(value2)

                if (value1 < value2) {
                    classInfo = "label label-danger"
                }

            }
            if (data.Rows[i].ShowKey == "标准周期") {
                value2 = data.Rows[i].ShowValue
            }
            orderHtmlInfo = orderHtmlInfo + "<div class=\"form-group group-padding\" style=\"width:16%;white-space:nowrap\"><div class=\"row\">" +
                "<label for=" + data.Rows[i].ShowKey + " class=\"col-sm-7 control-label\">" + data.Rows[i].ShowKey + ":</label>" +
                "<div class=\"col-sm-5\">" +
                "<label style =\"margin-left:-27%;\" class='" + classInfo + "' style=\"font-size:12px;\" id=" + data.Rows[i].ShowKey + ">" + data.Rows[i].ShowValue + "</label>" +
                "</div></div>" +
                "</div>";
        }

        $("#divProduct").html(orderHtmlInfo);

        setTimeout(GetProductionInfo, 1000 * 10)
    }


    function ShowUserAction(OrderID, MachineID, UserActionKey) {
        if (UserActionKey == "start") {
            var entity = {};
            entity.OrderId = OrderID;
            entity.LineId = MachineID;
            entity.UserName = userName;
            entity.LinePlanCode = LinePlanCode;
            if ($("#模具编码").text() == "") {
                alert("模具未上线,禁止开始工单");
                return;
            }
            entity.EquipmentCode = $("#模具编码").text();
            //通用过站验证SN      
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspOrderStart", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            //刷新工单信息
            GetOrderInfo();
            alert("工单开始成功")
        } else if (UserActionKey == 'login') {
            dialog({ title: "开线登陆", src: webroot + "/Client/LoginDevice.aspx?DeviceId=" + MachineID + "&rnd=" + Math.random(), width: 550, height: 400 });

        } else if (UserActionKey == "AnormalList") {
            dialog({ title: "异常列表", src: webroot + "/SDP/InjectionAnormalList.aspx?name=InjectionAnormalList&LineName=" + $("#hdnMachineNO").val() + "&rnd=" + Math.random(), width: 550, height: 400 });

        } else if (UserActionKey == "AnormalAdd") {
            dialog({ title: "异常登记", src: webroot + "/Anormal/AnormalEdit.aspx?name=Anormal_Add&ID=-1&LinePlanCode=" + LinePlanCode + "&rnd=" + Math.random(), width: 950, height: 650 });

        } else if (UserActionKey == "stop" || UserActionKey == "finish") {
            var entity = {};
            entity.OrderId = OrderID;
            entity.LineId = MachineID;
            entity.StateInfo = UserActionKey
            entity.UserName = userName;

            entity.EquipmentCode = $("#模具编码").text();
            entity.LinePlanCode = LinePlanCode;
            //通用过站验证SN      
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspUpdateOrderState", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }

            alert("操作成功！")
        } else if (UserActionKey == "TechnologyParam") {
            // 工艺参数
            dialog({
                title: "工艺参数", src: webroot + "/Equipment/TechnologyParam.aspx?LinePlanCode=" + LinePlanCode + "&rnd=" + Math.random(), width: 800, height: 550
            });
        }
        else if (UserActionKey == "ColourItemCodeInfo") {
            // 内件信息
            dialog({
                title: "色粉编码", src: webroot + "/SDP/ColourItemCodeList.aspx?ProdOrderId=" + ProdOrderId + "&rnd=" + Math.random(), width: 450, height: 300
            });
        }
        else if (UserActionKey == "InjectionEquipmentMaintenance") {
            var equipmentCOde = $.trim($("#lblMachineNO").text());
            if (!equipmentCOde) {
                alert("未选定设备！！");
                return;
            }
            dialog({ title: "设备保养", src: webroot + "/MobileApp/EquipmentMaintenance.aspx?name=PDA_EquipmentMaintenance&equipmentCode=" + equipmentCOde + "&rnd=" + Math.random(), width: 1000, height: 800 });

        } else if (UserActionKey == "MouldInfo") {
            var EquipmentCode = $("#模具编码").text();
            // 模具原料信息
            dialog({
                title: "内件信息", src: webroot + "/SDP/MouldInfo.aspx?MouldCode=" + EquipmentCode + "&rnd=" + Math.random(), width: 900, height: 400
            });
        }
        else {
            alert("功能待开放！敬请期待");
        }
    }

    //获取设备用户按钮
    function GetMachineUser(ResourceId, StationId, PackStation, ProjectStationId, LineName) {
        //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMachinedInjection.GetMachineUser(OrderID, MachineID, UserName);
        //if (ajax.error != null) {
        //    alert(ajax.error.Message);
        //    return false;
        //}
        $("#pActionText").html("");
        $("#pActionText").html("操作台");
        $("#divUserAndAction").html("");
        var data = [{
            ButtonType: "info",
            ShowName: "注塑报工",
            Url: "../Client/InjectionMoldingBatchPrintCollection.aspx?name=ProdBatchPrintProCollection&prodline=" + LineName + "&stationid=" + StationId + "&station=注塑&resourceid=" + ResourceId + "&ProdOrderId=" + ProdOrderId + "&OrderNo=" + $("#hdnOrderNO").val() + "&rnd=" + Math.random(),
            visibility: "show"
        }, {
            ButtonType: "info",
            ShowName: "注塑包装",
            Url: "../Client/PackingProCollection.aspx?name=Packing_ProCollectionUI&prodline=" + LineName + "&stationid=" + PackStation + "&station=注塑件包装&resourceid=" + ResourceId + "&rnd=" + Math.random(),
            visibility: "show"
        },
        {
            ButtonType: "warning",
            ShowName: "首件检验",
            Url: "../Client/IPQCInspectionProject.aspx?name=IPQCInspection_ProCollectionUIProject&prodline=" + LineName + "&stationid=" + ProjectStationId + "&station=首件/末件/工程检验&resourceid=" + ResourceId + "&coming=首件检验&rnd=" + Math.random(),
            visibility: "show"
        }, {
            ButtonType: "warning",
            ShowName: "末件检验",
            Url: "../Client/IPQCInspectionProject.aspx?name=IPQCInspection_ProCollectionUIProject&prodline=" + LineName + "&stationid=" + ProjectStationId + "&station=首件/末件/工程检验&resourceid=" + ResourceId + "&coming=末件检验&rnd=" + Math.random(),
            visibility: "show"
        }, {
            ButtonType: "danger",
            ShowName: "应急发送",
            Url: "",
            visibility: "show"
        }, {
            ButtonType: "primary",
            ShowName: "切换状态",
            Url: "",
            visibility: "show"
        }, {
            ButtonType: "info",
            ShowName: "",
            Url: "",
            visibility: "hidden"
        }, {
            ButtonType: "info",
            ShowName: "",
            Url: "",
            visibility: "hidden"
        }, {
            ButtonType: "info",
            ShowName: "",
            Url: "",
            visibility: "hidden"
        }]
        var orderHtmlInfo = "";

        for (var i = 0; i < data.length; i++) {
            var buttonclass = "";
            if (data[i].ButtonType != "") {
                buttonclass = "btn-" + data[i].ButtonType;
            }

            if (data[i].ButtonType == "danger" && ProdOrderId > 0) {
                orderHtmlInfo = orderHtmlInfo + "<div class=\"form-group group-padding2\">" +
                    "<button style=\"width:120px; height:52px; margin-left:30px;" + (data[i].visibility === 'hidden' ? 'visibility:hidden' : '') + " \" class=\"btn btn-lg btn-rounded " + buttonclass + "\" type=\"button\" onclick=\"DangerClick()\">" + data[i].ShowName + "</button>" +
                    "</div>";
            }
            else if (data[i].ButtonType == "primary") {
                orderHtmlInfo = orderHtmlInfo + "<div class=\"form-group group-padding2\">" +
                    "<button style=\"width:120px; height:52px; margin-left:30px;" + (data[i].visibility === 'hidden' ? 'visibility:hidden' : '') + " \" class=\"btn btn-lg btn-rounded " + buttonclass + "\" type=\"button\" onclick=\"ChangeStatus()\">" + data[i].ShowName + "</button>" +
                    "</div>";
            }
            else if (ProdOrderId > 0) {

                orderHtmlInfo = orderHtmlInfo + "<div class=\"form-group group-padding2\">" +
                    "<button style=\"width:120px; height:52px; margin-left:30px;" + (data[i].visibility === 'hidden' ? 'visibility:hidden' : '') + " \" class=\"btn btn-lg btn-rounded " + buttonclass + "\" type=\"button\" onclick=\"ShowAction('" + data[i].Url + "')\">" + data[i].ShowName + "</button>" +
                    "</div>";
            }

        }
        $("#divUserAndAction").html(orderHtmlInfo);
    }


    function ShowAction(url) {
        window.open(url);
        //alert(url);
    }

    function CloseDiv() {
        document.getElementById('popup').style.display = 'none';
    }

    function ChangeStatus() {
        document.getElementById('popup').style.display = 'flex';
    }

    function CommitStatus() {
        var status = $("#sltStatus").val();
        if (status == "-1") {
            alert("请选择变更状态！");
            return;
        }

        var entity = {}
        entity.EquipmentCode = $("#lblMachineNO").text();
        entity.Status = status;
        entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspEquipmentStatusEdit", JSON.stringify(entity));
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return;
        }
        alert("变更完成！");
        getMainInfo();
        setTimeout(function () {
            CloseDiv();
        }, 1000)


    }




    function DangerClick() {

        document.getElementById('semail').style.display = 'flex';
    }


    function CloseSend() {
        document.getElementById('semail').style.display = 'none';

    }


    function SendEmail() {
        if (confirm("确认发送应急信息？")) {
            var sendDpt = $("#sendDpt").val();
            if (sendDpt == "-1") {
                alert("请选择应急发送部门！");
                return;
            }

            var entity = {}
            entity.EquipmentCode = $("#lblMachineNO").text();
            entity.OrderNo = $("#生产工单").text()
            entity.ModelName = $("#模具名称").text();
            entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.SendDpt = sendDpt;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspInjectionMoldingProductionSendEmail", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("发送成功！");
            setTimeout(function () {
                CloseSend();
            }, 1000)
        }
    }


    //设置良品数
    function SetGoodThroughRateChar(CompletedSum, DoQty, AllQty) {

        //var MoudlCode = $("#模具编码").text();
        //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.GetOrderGoodRate(LinePlanCode, MoudlCode);
        //if (ajax.error != null) {
        //    alert(ajax.error.Message);
        //    return false;
        //}

        //var data = JSON.parse(ajax.value);
        var dataList = [];
        var entity = {};
        var CompletedSum = CompletedSum;


        entity.name = ""
        entity.value = CompletedSum;
        dataList.push(entity)
        entity = {}
        entity.name = ""
        entity.value = 100 - CompletedSum;
        dataList.push(entity)

        //entity.name = ""
        //entity.value = (DoQty / CompletedSum) * 100;
        //dataList.push(entity)
        //entity = {}
        //entity.name = ""
        //entity.value = DoQty;
        //dataList.push(entity)

        //var data1 = { name: "", value: data[2].value }
        //var data2 = { name: "", value: data[0].value }
        //var data3 = { name: "", value: data[1].value }
        // 基于准备好的dom，初始化echarts实例
        var myChart1 = echarts.init(document.getElementById('main'));

        // 使用刚指定的配置项和数据显示图表。
        myChart1.setOption({
            tooltip: {
                trigger: 'item'
            },
            legend: {
                top: '5%',
                left: 'center'
            },
            series: [
                {
                    name: '工单生产进度',
                    type: 'pie',
                    radius: ['70%', '100%'],
                    avoidLabelOverlap: false,
                    label: {
                        show: true,
                        position: 'center'
                    },
                    emphasis: {
                        label: {
                            show: false,
                            position: 'center'

                        }
                    },
                    labelLine: {
                        show: false
                    },
                    data: dataList,
                    itemStyle: {
                        color: function (params) {
                            // 根据数据项的索引返回对应的颜色
                            var colorList = ['#99D13E', '#FFF5EE'];
                            return colorList[params.dataIndex];
                        }
                    }
                }
            ],
            graphic: [
                {
                    type: 'text',
                    left: 'center',
                    top: 'center',
                    style: {
                        text: '生产进度\n' + CompletedSum + '%',
                        textAlign: 'center',
                        fill: '#666',
                        fontSize: 18
                    }
                }
            ]
        });
        window.addEventListener('resize', () => {
            myChart1.resize();
        })


        //计算
        //var dataList = [];
        //var entity = {};

        //var OrderQty = parseInt($("#订单数量").text());
        //var NgQty = parseInt($("#NgQty").text() != "" ? $("#NgQty").text() : 0);
        //var Cavity = parseInt($("#Cavity").text() != "" ? $("#Cavity").text() : 1);
        //if (Cavity == 0) {
        //    Cavity = 1;
        //}
        //var MinQty = ((NgQty * Cavity) / OrderQty) * 100;
        //// 保留两位小数
        //var MinQty = MinQty.toFixed(2);

        //entity.name = ""
        //entity.value = MinQty;
        //CompletedSum = MinQty;
        //dataList.push(entity)
        //entity = {}
        //entity.name = ""
        //entity.value = 100 - MinQty;
        //dataList.push(entity)

        //// 基于准备好的dom，初始化echarts实例
        //var myChart2 = echarts.init(document.getElementById('main1'));

        //// 使用刚指定的配置项和数据显示图表。
        //myChart2.setOption({
        //    tooltip: {
        //        trigger: 'item'
        //    },
        //    legend: {
        //        top: '5%',
        //        left: 'center'
        //    },
        //    series: [
        //        {
        //            name: '机器进度',
        //            type: 'pie',
        //            radius: ['70%', '100%'],
        //            avoidLabelOverlap: false,
        //            label: {
        //                show: true,
        //                position: 'center'
        //            },
        //            emphasis: {
        //                label: {
        //                    show: false,
        //                    position: 'center'

        //                }
        //            },
        //            labelLine: {
        //                show: false
        //            },
        //            data: dataList,
        //            itemStyle: {
        //                color: function (params) {
        //                    // 根据数据项的索引返回对应的颜色
        //                    var colorList = ['#99D13E', '#FFF5EE'];
        //                    return colorList[params.dataIndex];
        //                }
        //            }
        //        }
        //    ],
        //    graphic: [
        //        {
        //            type: 'text',
        //            left: 'center',
        //            top: 'center',
        //            style: {
        //                text: '机器进度\n' + CompletedSum + '%',
        //                textAlign: 'center',
        //                fill: '#666',
        //                fontSize: 18
        //            }
        //        }
        //    ]
        //});
        //window.addEventListener('resize', () => {
        //    myChart2.resize();
        //})
    }

    function SwitchOrder(EquimetCode) {
        dialog({ title: "选择工单机台", src: webroot + "/Client/SwitchOrderMachine.aspx?name=Switch_OrderAndMachine&EquimetCode=" + EquimetCode + "&rnd=" + Math.random(), width: 1200, height: 420 });
    }

    function rollBackToMenu() {
        window.location.href = "../Framework/Console1.aspx?rnd=" + Math.random();
    }
    function ESOPMouldFileView() {
        var url = "../ESOP/ESOPFileView.aspx";
        window.open(url, '_blank')
    }
    //function BackActionUser(OrderID, MachineID) {
    //    //获取机器的操作用户
    //    GetMachineUser(OrderID, MachineID);
    //}

    function ajaxPull() {
        $.ajax({
            type: 'get',
            url: "<%=SKT.LeanMES.Web.WebHelper.WebRoot%>/ajax.html?rnd=" + Math.random(),
            async: true,
            success: function (data) {

            },
            complete: function (XMLHttpRequest, str) {

            },
            datatype: 'text',
            error: function (xhr, status, error) {

            }
        });
    }

    // 保存数据到cookie
    function setCookie(name, value, days) {
        var expires = "";
        var d = new Date("2038-01-01"); // 设置为2038年的某个日期
        var expires = " ; expires=" + d.toUTCString();
        document.cookie = name + "=" + (value || "") + expires + "; path=/";
    }

    // 读取cookie中的数据
    function getCookie(name) {
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1, c.length);
            }
            if (c.indexOf(nameEQ) == 0) {
                return c.substring(nameEQ.length, c.length);
            }
        }
        return null;

    }

    function getChooseValue(list) {
       
        setCookie('gd', null);
        setCookie('ExtNo', list[0][4]);
        setCookie('jt', list[0][1], 30); // 将用户名保存到cookie，有效期30天
        // 保存数据到cookie
       
        parent.window.location.href = '../Client/MachinedInjectionMolding.aspx'
    }

    //切换机台
    function SwitchEquipment() {
        var condition = " EquipmentTypeName='注塑机' ";
        dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=838&PageCondition= " + condition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
    }

    function GetEquimentInOrder(equipmentCode) {
        var entity = {};
        entity.EquipmentCode = equipmentCode;
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetEquimentInOrder", JSON.stringify(entity));
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return;
        }
        if (ajax.value.length > 0) {
            return $.parseJSON(ajax.value);
        }
        return "";
        
    }

    function GetPromptInfo() {
        //通用过站验证SN      
        var entity = {};
        entity.FBILLNO = LinePlanCode;
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetOpdataParameter", JSON.stringify(entity));
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return;
        }
        if (ajax.value.length > 0) {
            var data = JSON.parse(ajax.value);
            if (data.length > 0) {
                $("#lblPromptMsg").text(data[0].Opdata)
                if (data[0].Grade == "0") {
                    //关闭背景色闪烁
                    notShowError();
                    //关闭报警音频
                    stopAudio();
                }

                if (data[0].Grade == "1") {
                    //关闭报警音频
                    stopAudio();
                    //打开背景色闪烁
                    showError();

                    var isRed = true; // 初始为红色

                    //判断定时器是否开启，开启则先清除
                    if (IsTime) {
                        clearInterval(intervalId1);
                    }

                    intervalId1 = setInterval(function () {
                        if (isRed) {
                            document.getElementById('isShow').style.backgroundColor = 'transparent';
                        } else {
                            document.getElementById('isShow').style.backgroundColor = 'rgba(255, 0, 0, 0.2)'; // 使用半透明的红色
                        }
                        isRed = !isRed;
                    }, 500); // 每隔500毫秒切换一次颜色
                    IsTime = true;

                }
                if (data[0].Grade == "2") {

                    //启用闪烁背景色
                    showError()

                    var isRed = true; // 初始为红色

                    //调用警报音频
                    playAudio();

                    //判断定时器是否开启，开启则先清除
                    if (IsTime) {
                        clearInterval(intervalId1);
                    }

                    intervalId1 = setInterval(function () {
                        if (isRed) {
                            document.getElementById('isShow').style.backgroundColor = 'transparent';
                        } else {
                            document.getElementById('isShow').style.backgroundColor = 'rgba(255, 0, 0, 0.2)'; // 使用半透明的红色
                        }
                        isRed = !isRed;
                    }, 500); // 每隔500毫秒切换一次颜色
                    IsTime = true;
                }
            }
        }
        else {
            //关闭背景色闪烁
            notShowError();
            //关闭报警音频
            stopAudio();
        }

        setTimeout(GetPromptInfo, 1000 * 3)
    }

    function playAudio() {

        audioElement.play();
    }

    function stopAudio() {
        audioElement.pause();
        audioElement.currentTime = 0;
    }

    //网页进入全屏和取消全屏
    function Fullscreen() {
        if (document.fullscreenElement || document.webkitFullscreenElement || document.mozFullScreenElement || document.msFullscreenElement) {
            // 如果已经是全屏状态，退出全屏
            if (document.exitFullscreen) {
                document.exitFullscreen();
            } else if (document.mozCancelFullScreen) { /* Firefox */
                document.mozCancelFullScreen();
            } else if (document.webkitExitFullscreen) { /* Chrome, Safari and Opera */
                document.webkitExitFullscreen();
            } else if (document.msExitFullscreen) { /* IE/Edge */
                document.msExitFullscreen();
            }
        } else {
            // 否则进入全屏
            var elem = document.documentElement;
            if (elem.requestFullscreen) {
                elem.requestFullscreen();
            } else if (elem.mozRequestFullScreen) { /* Firefox */
                elem.mozRequestFullScreen();
            } else if (elem.webkitRequestFullscreen) { /* Chrome, Safari and Opera */
                elem.webkitRequestFullscreen();
            } else if (elem.msRequestFullscreen) { /* IE/Edge */
                elem.msRequestFullscreen();
            }
        }
    }

    //打开PDF
    $('#OpenEmergencyFile').click(function (e) {
        e.preventDefault(); // 阻止默认的点击行为，即不跟随链接
        var fileUrl = encodeURI("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/UploadFiles/EmergencyFile/升级应急管理计划.pdf");
        dialog({ title: "应急文件", src: fileUrl, width: 1200, height: 820 });
        //window.open(fileUrl, '_blank'); // 在新标签页中打开URL
    });

    //打开PDF
    $('#getEquiConfig').click(function (e) {

        var equcode = $("#lblMachineNO").text();
        if (equcode == "") {
            alert("请先选择机台!");
            return;
        }

        var hdnEquimentExtNo = $("#hdnEquimentExtNo").val();
        if (hdnEquimentExtNo == "") {
            alert("该机台未维护扩展ID值!");
            return;
        }
        e.preventDefault(); // 阻止默认的点击行为，即不跟随链接
        var fileUrl = encodeURI("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Client/EquipmentConfigView.aspx?equipmentCode=" + hdnEquimentExtNo + "");
        dialog({ title: "设备配置信息列表", src: fileUrl, width: 1200, height: 820 });
        //window.open(fileUrl, '_blank'); // 在新标签页中打开URL
    });

    function GetRoleInjectioMoldingButton() {
        var entity = {}
        entity.Name = '';
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetRoleInjectioMoldingButton", JSON.stringify(entity));
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return;
        }
        var data = JSON.parse(ajax.value);
        $("#pActionText").html("");
        $("#pActionText").html("操作台");
        $("#divHeadRoleButton").html("");
        var orderHtmlInfo = "";

        for (var i = 0; i < data.length; i++) {

            const randomColor = generateRandomColor();

            orderHtmlInfo = orderHtmlInfo + "<div class=\"form-group group-padding3\" onclick=\"ShowButton(" + data[i].RoleID + ")\">" +
                "<button style=\"width: 100%;height: 80px;font-weight: bold;background-color:" + randomColor + ";font-size:15px\"class=\"btn-RoleWidth\" type=\"button\" >" + data[i].RoleName + "</button>" +
                "</div>";
        }

        $("#divHeadRoleButton").html(orderHtmlInfo);
    }

    function ShowButton(id) {
        RoleId = id;
        let IsRoleButton = false;
        var OrderID = $("#hdnOrderID").val();
        var MachineID = $("#hdnMachineID").val();
        if (userId == "-1") {
            IsRoleButton = true;
        }
        else {
            //查询用户角色是否与按钮一致
            var entity = {}
            entity.UserName = userName;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("MI_GetUserRole", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var data = JSON.parse(ajax.value);

            for (var i = 0; i < data.length; i++) {
                if (data[i].RoleId == RoleId) {
                    IsRoleButton = true;
                    break;
                }
            }
        }
        if (IsRoleButton) {
            $("#divHeadRoleButton").hide();
            $("#divUserAndAction").show();
            GetMachineUser(OrderID, MachineID, userName)
        } else {
            layer.open({
                type: 1,
                area: ["360px", "240px"],
                title: "用户登录",
                content: "<br/>"
                    + "<div class='layui-form-item' style='margin-bottom: -30px;'>"
                    + "<div class='layui-inline'>"
                    + "<label class='layui-form-label'>工号：</label>"
                    + "<div class='layui-input-inline'><input type='text' "
                    + " style='margin-top:8px' id='txtUserName'  class='layui-input'></div>"
                    + "</div>"
                    + "<div class='layui-inline'>"
                    + "<label class='layui-form-label'>密码：</label>"
                    + "<div class='layui-input-inline'><input type='password'"
                    + " style='margin-top:6px'  id='txtPassWord' class='layui-input'></div>"
                    + "</div>"
                    + "<div style='text-align: center; margin-top: 20px;'>"
                    + "<button type='button' class='layui-btn layui-btn-normal' onclick='btnAffirm()' id='btnSchedulingQty'>确认</button> "
                    + "<button type='button' class='layui-btn layui-btn-xs' onclick='btnClose()' id='btnClose'>取消</button> "
                    + "</div>"
                    + "</div>",
            });
        }
    }

    function btnAffirm() {
        let IsRoleButton = false;
        // $("#btnAffirm").attr("disabled", "disabled");
        var OrderID = $("#hdnOrderID").val();
        var MachineID = $("#hdnMachineID").val();
        var LayUserName = $("#txtUserName").val();
        var LayPassWord = $("#txtPassWord").val();

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMachinedInjection.WS_UserPassValid(LayUserName, LayPassWord);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        } else {
            if (ajax.value != "") {
                alert(ajax.value);
            }
            else {
                var entity = {}
                entity.UserName = LayUserName;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("MI_GetUserRole", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                var data = JSON.parse(ajax.value);

                for (var i = 0; i < data.length; i++) {
                    if (data[i].RoleId == RoleId) {
                        IsRoleButton = true;
                        break;
                    }
                }
                if (IsRoleButton) {
                    layer.closeAll();
                    $("#divHeadRoleButton").hide();
                    $("#divUserAndAction").show();
                    GetMachineUser(OrderID, MachineID, LayUserName)
                } else {
                    alert("用户角色与按钮不一致!")
                }
            }
        }
    }
    //取消按钮
    function btnClose() {
        layer.closeAll();
    }

    function CloseRole() {
        $("#divHeadRoleButton").show();
        $("#divUserAndAction").hide();
    }

    // 生成随机数
    function generateRandomNumber(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    // 从颜色数组中随机选择颜色
    function generateRandomColor() {
        var randomIndex = generateRandomNumber(0, niceColors.length - 1);
        return niceColors[randomIndex];
    }
</script>
</html>
