<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="KanbanConsole.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.KanbanConsole" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="noInstallPrintPlugin" id="msg" style="padding-left: 20px; border: 1px solid #FFEC8B; display: none; background: yellow url(../Content/Images/icon/help.png) no-repeat; color: red;"></div>
    <div style="line-height: 50px; margin-top: 50px; width: 500px; margin: 0 auto;">
        MAC地址:<asp:TextBox ID="txtMAC" runat="server" ClientIDMode="Static" Style="width: 95%; height: 40px;">50-9A-4C-15-73-41</asp:TextBox><br />
        看板地址：<asp:TextBox ID="txtUrl" runat="server" ClientIDMode="Static" Style="width: 95%; height: 40px;"></asp:TextBox><br />
        <br />
        <asp:Button ID="btnChangeKanban" runat="server" Text=" 发 送 " CssClass="SearchButton" OnClientClick="return sendControl()" />
    </div>

    <script type="text/javascript">
        var machineMac = "";
        var wsUrl = window.location.hostname + ":2018";//服务端
       // wsUrl = "172.16.0.81:2018";//先使用测试打印服务，后期注释
        var ws = new WebSocket('ws://' + wsUrl);

        $().ready(function () {           
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
                    }
                }
            }
            ws.onerror = function (evt) {
                $('#msg').html("<span style='margin-left:15px;'>服务连接失败，请检查是否已开启服务！</span>").show();
            }
            ws.onclose = function () {
                $('#msg').html("<span style='margin-left:15px;'>服务连接失败，请检查是否已开启服务！</span>").show();
            }

        });

        function sendControl() {
            var url = $("#txtUrl").val();
            machineMac = $.trim($("#txtMAC").val());
            var entity = {};
            entity.ClientId = machineMac;
            entity.Key = "changeKanban";
            entity.Value1 = url;
            ws.send(JSON.stringify(entity));

            alert("发送成功！");

            $("#txtUrl").select();
            return false;
        }

    </script>
</asp:Content>
