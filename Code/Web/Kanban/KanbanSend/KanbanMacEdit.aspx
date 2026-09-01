<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="KanbanMacEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.KanbanManage.KanbanMacEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="noInstallPrintPlugin" id="msg" style="padding-left: 20px; border: 1px solid #FFEC8B; display: none; background: yellow url(../Content/Images/icon/help.png) no-repeat; color: red;"></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td colspan="2" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td>
        </tr>
        <tr>
            <td class="Label2">看板终端<em>*</em></td>
            <td class="Field2">
                <input id="txtSendName" class="TextBox" isrequired="1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">看板名称<em>*</em></td>
            <td class="Field1">
                <select id="selKanban">
                </select>
            </td>
        </tr>

        <tr>
            <td class="Label2">位置<em>*</em></td>
            <td class="Field2">
                <input id="txtLocation" class="TextBox" isrequired="1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">MAC<em>*</em></td>
            <td class="Field2">
                <input id="txtMAC" class="TextBox" isrequired="1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">备注</td>
            <td class="Field2">
                <textarea id="Remark" class="TextArea"></textarea>
            </td>

        </tr>
    </table>

    <script type="text/javascript">
        var sendId = '<%=Request.QueryString["ID"]%>';
        var kanbanId = -1; //看板id

        $(document).ready(function () {
            ShowKanban();
            if (sendId != -1) {
                //mac只读
                $("#txtMAC").attr({ "readonly": "readonly", "disabled": true });
                //显示信息
                var tagEntity = SKT.LeanMES.Web.AjaxServices.AjaxKanbanManage.GetSendInfo(sendId, 1);
                if (tagEntity.error != null) {
                    alert(tagEntity.error.Message);
                    return false;
                }
                else {
                    var entity = tagEntity.value;
                    $("#selKanban").find("option[value=" + entity.KanbanId + "]").attr("selected", true);
                    $("#txtLocation").val(entity.Location);
                    $("#txtMAC").val(entity.MAC);
                    $("#Remark").val(entity.Remark);
                    $("#txtSendName").val(entity.SendName);
                }
            }
        })

        //显示看板列表
        function ShowKanban() {
            var kanbanList = SKT.LeanMES.Web.AjaxServices.AjaxKanbanManage.GetAll();
            if (kanbanList.error != null) {
                alert(kanbanList.error.Message);
                return false;
            } else {
                var kanbanOption = "<option value='-1'>请选择</option>";
                for (var i = 0; i < kanbanList.value.length; i++) {
                    var entity = kanbanList.value[i];
                    kanbanOption += "<option value=" + entity.KanbanId + ">" + entity.KanbanName + "</option>"
                }
                $("#selKanban").append(kanbanOption);
            }
        }


        /*保存数据*/
        function Save() {
            var kanbanId = $("#selKanban").find("option:selected").val();
            if (kanbanId == -1) {
                alert("请选择对应的看板名称!");
                return false;
            }
            var txtLocation = $("#txtLocation").val();
            var temp = /^[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}-[A-Fa-f0-9]{2}$/;
            if (!temp.test($.trim($("#txtMAC").val()))) {
                alert("请输入正确的MAC地址！");
                $("#txtMAC").select();
                return false;
            }
            var txtMac = $("#txtMAC").val();
            var txtRemark = $("#Remark").val();
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>'
            var sendName = $("#txtSendName").val();
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};

            entity.KanbanSendId = sendId;
            entity.KanbanId = kanbanId;
            entity.Location = txtLocation;
            entity.MAC = txtMac;
            entity.Remark = txtRemark;
            entity.CreateBy = userName;
            entity.SendName = sendName;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanbanManage.SendEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                alert("保存成功!");
                //执行发送方法
                sendControl();
                parent.window.Refresh();
            }
        }

        //执行socket发送方法
        var machineMac = "";
        //var wsUrl = window.location.hostname + ":2018";//服务端
       wsUrl = "172.16.0.37:2018";//先使用测试打印服务，后期注释
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
            var tagId = $("#selKanban").find("option:selected").val();
            var tagEntity = SKT.LeanMES.Web.AjaxServices.AjaxKanbanManage.GetInfo(tagId);
            if (tagEntity.error != null) {
                alert(tagEntity.error.Message);
                return false;
            }
            else {
                var entity = tagEntity.value;
                var url = entity.LinkUrl;
            }
            //var url = $("#txtUrl").val();
            machineMac = $.trim($("#txtMAC").val());
            var entity = {};
            entity.ClientId = machineMac;
            entity.Key = "changeKanban";
            entity.Value1 = url;
            if (ws && ws.readyState==1) 
                ws.send(JSON.stringify(entity));
        }
    </script>

</asp:Content>
