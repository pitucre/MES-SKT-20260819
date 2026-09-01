<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="KanbanEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.KanbanManage.KanbanEdit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="noInstallPrintPlugin" id="msg" style="padding-left: 20px; border: 1px solid #FFEC8B; display: none; background: yellow url(../Content/Images/icon/help.png) no-repeat; color: red;"></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td colspan="2" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td>
        </tr>
        <tr>
            <td class="Label1">看板名称<em>*</em></td>
            <td class="Field1">
                <input id="KanbanName" class="TextBox" isrequired="1" />
            </td>

        </tr>
        <tr>
            <td class="Label2">网址<em>*</em></td>
            <td class="Field2">
                <textarea id="LinkUrl" class="TextArea" style="width: 300px;" isrequired="1" ></textarea>
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
        var tagId = '<%=Request.QueryString["ID"]%>';

        $(document).ready(function () {
            if (tagId != -1) {
                //显示信息
                var tagEntity = SKT.LeanMES.Web.AjaxServices.AjaxKanbanManage.GetInfo(tagId);
                if (tagEntity.error != null) {
                    alert(tagEntity.error.Message);
                    return false;
                }
                else {
                    var entity = tagEntity.value;
                    $("#KanbanName").val(entity.KanbanName);
                    $("#LinkUrl").val(entity.LinkUrl);
                    $("#Remark").val(entity.Remark);
                }
            }
        })

        /*保存数据*/
        function Save() {
            var txtKanbanName = $("#KanbanName").val();
            var txtLinkUrl = $("#LinkUrl").val();
            var txtRemark = $("#Remark").val();
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>'

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.KanbanId = tagId;
            entity.KanbanName = txtKanbanName;
            entity.LinkUrl = txtLinkUrl;
            entity.Remark = txtRemark;
            entity.CreateBy = userName;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanbanManage.TagEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (tagId == -1) {
                if (!confirm('看板新增成功,是否继续新增?')) {
                    parent.window.Refresh();
                }
            } else {
                //修改的时候，查询该看板id有被哪些看板终端引用
                var entityMac = SKT.LeanMES.Web.AjaxServices.AjaxKanbanManage.GetKanbanMACById(tagId);
                if (entityMac.error != null) {
                    return false;
                } else {
                    var macList = entityMac.value;
                    for (var i = 0; i < macList.length; i++) {
                        var mac = macList[i].MAC;
                        //执行发送方法
                        sendControl(mac, txtLinkUrl);
                    }
                }
                alert("看板编辑成功!");
                parent.window.Refresh();
            }
        }

        //执行socket发送方法
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

        function sendControl(machineMac, linkUrl) {
            var entity = {};
            entity.ClientId = machineMac;
            entity.Key = "changeKanban";
            entity.Value1 = linkUrl;
            ws.send(JSON.stringify(entity));
        }
    </script>

</asp:Content>
