<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Kanban.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Kanban" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title></title>
    <style type="text/css">
        html, body {
            width: 100%;
            height: 100%;
            margin: 0px;
            padding: 0px;
            border: 0px;
            overflow: hidden;
        }

        #disappare {
            left: 50%;
            top: 50%;
            border: 3px solid #ccc;
            border-radius: 5px;
            background: #fff;
            z-index: 9999;
            width: 500px;
            height: 200px;
            margin-left: -250px;
            margin-top: -100px;
            position: absolute;
            text-align: center;
            line-height: 40px;
        }

            #disappare p {
                padding: 50px;
                font-size: 24px;
            }
    </style>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="noInstallPrintPlugin" id="msg" style="padding-left: 20px; border: 1px solid #FFEC8B; display: none; background: yellow url(../Content/Images/icon/help.png) no-repeat; color: red;"></div>
        <div id="disappare" style="display: none;">
            <p id="updatediv">
            </p>
        </div>
        <input type="button" id="btnChangeMac" value="配置MAC地址" style="position: absolute; bottom: 5px; right: 10px; margin-top: 2px; cursor: pointer; display: none;"
            onclick="changeMac()" />
        <iframe id="c_iframe" frameborder="0" scrolling="no" current="1" src="" style="width: 100%;"></iframe>

        <asp:HiddenField ID="hidMachineMac" runat="server" ClientIDMode="Static" />

        <script type="text/javascript">
            var c_iframe = $("#c_iframe");
            var machineMac = "";
            var url = "";
            var wsUrl = window.location.hostname + ":2018";//服务端
            //wsUrl = "172.16.0.37:2018";//先使用测试打印服务，后期注释
            var ws = new WebSocket('ws://' + wsUrl);

            $().ready(function () {

                autoHeight();
                getKanbanUrl();

                setTimeout(function () {
                    openStock();
                },1000)
            });

            function getKanbanUrl() {
                machineMac = $("#hidMachineMac").val();

                if (machineMac == "00-00-00-00-00-00") {
                    if (store.get("ESOP-MAC") == null || store.get("ESOP-MAC") == "") {
                        $("#updatediv").html('<span style="margin-top: -32px; margin-left: -60px; display: block;">请输入本台设备MAC地址：</span><br><span style="margin: -31px 0px 0px 12px; display: block;"><input id="txtMAC" class="TextBox" style="width: 230px; height: 30px;" type="text" onkeypress=" return getKey();"/>&nbsp;<input style="border: 1px solid rgb(170, 170, 170); border-image: none; height: 32px;cursor: pointer;" onclick=" return setMAC()" type="button" value=" 确 定 "></span><br>');
                        $("#disappare").show();
                        $("#txtMAC").select()
                        return false;
                    }
                    else {
                        machineMac = store.get("ESOP-MAC");
                        $("#btnChangeMac").show();
                        setTimeout(function () {
                            $("#btnChangeMac").hide();
                        }, 3000);
                    }
                }
                else {
                    if (store.get("ESOP-MAC") == null || store.get("ESOP-MAC") == "") {
                        $("#btnChangeMac").hide();
                    }
                }

                //通过MAC地址获取设备配置的看板地址
                //  var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetKanbanURL(machineMac);
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanbanManage.GetSendInfo(machineMac, 2);

                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                if (ajax.value == null) {
                    $("#updatediv").html("请先配置机器相关的看板地址！<br/>MAC:[" + machineMac + "]<br/>");
                    $("#disappare").show();
                    return false;
                }
                else {
                    url = ajax.value.LinkUrl;
                }


                c_iframe.attr("src", url);
            }

            /**
            *设置当前MAC地址
            **/
            function setMAC() {
                var temp = /^[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}$/;
                if (!temp.test($.trim($("#txtMAC").val()))) {
                    alert("请输入正确的MAC地址！");
                    $("#txtMAC").select();
                    return false;
                }

                $("#hidMachineMac").val($.trim($("#txtMAC").val()));
                store.set('ESOP-MAC', $.trim($("#txtMAC").val()));
                $("#btnChangeMac").show();

                $("#disappare").hide();

                getKanbanUrl();

                return true;
            }

            function getKey() {
                if (event.keyCode == 13) {
                    setMAC();
                }
            }

            function changeMac() {
                var mac = store.get('ESOP-MAC');
                $("#updatediv").html('<span style="margin-top: -32px; margin-left: -60px; display: block;">请输入本台设备MAC地址：</span><br><span style="margin: -31px 0px 0px 12px; display: block;"><input id="txtMAC" class="TextBox" style="width: 230px; height: 30px;" type="text" value="' + mac + '" onkeypress=" return getKey();"/>&nbsp;<input style="border: 1px solid rgb(170, 170, 170); border-image: none; height: 32px;cursor: pointer;" onclick="setMAC()" type="button" value=" 确 定 ">&nbsp;<input style="border: 1px solid rgb(170, 170, 170); border-image: none; height: 32px;cursor: pointer;" onclick="cancel()" type="button" value=" 取 消 "></span><br>');
                $("#banner,#disappare").show();
                $("#txtMAC").select()
                //store.remove('ESOP-MAC');
            }

            function cancel() {
                $("#disappare").hide();
                getKanbanUrl();
            }

            $(window).resize(function () {
                autoHeight();
            });

            function autoHeight() {
                var height = $(window).height() - 5;
                c_iframe.height(height);
            };

            /**
           ** 打开服务
           **/
            function openStock() {
                ws.onopen = function () {
                    $('#msg').hide();
                }
                ws.onmessage = function (evt) {
                    var entity = JSON.parse(evt.data);
                    if (entity.ClientId == machineMac) {
                        if (entity.Key == "NG") {
                            $('#msg').html("<span style='margin-left:15px;'>NG:" + entity.Value1 + '</span>').show();
                        }
                        else {
                            $('#msg').hide();
                            $("#disappare").hide();
                            c_iframe.attr("src", entity.Value1);
                        }
                    }
                }
                ws.onerror = function (evt) {
                    $('#msg').html("<span style='margin-left:15px;'>服务连接失败，请检查是否已开启服务！</span>").show();
                    connection();
                }
                ws.onclose = function () {
                    $('#msg').html("<span style='margin-left:15px;'>服务连接失败，请检查是否已开启服务！</span>").show();
                    connection();
                }
            }

            /**
            ** 服务断线重连
            **/
            function connection() {
                var connect = setInterval(function () {
                    if (ws.readyState == "1") {
                        $('#msg').html("").hide();
                        openStock();                      
                        clearInterval(connect);
                    }
                    try {
                        ws = new WebSocket('ws://' + wsUrl);
                    } catch (e) {
                    }
                                  
                }, 5000);
            }
        </script>
    </form>
</body>
</html>
