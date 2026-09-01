<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="AnormalProcessConfigEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Anormal.AnormalProcessConfigEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">线别<em>*</em></td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="LineName" LineId="-1" CssClass="TextBox" ClientIDMode="Static" Enabled="false"></asp:TextBox><input type="button" class="ButtonBox" onclick="openChoosePage(21)" value="..." />
            </td>
        </tr>
        <tr>
            <td class="Label1">异常类型<em>*</em></td>
            <td class="Field1">
                <asp:TextBox ID="AnormalGroupName" runat="server" AnormalGroupId="-1" CssClass="TextBox" ClientIDMode="Static" Enabled="false"></asp:TextBox><input type="button" class="ButtonBox" onclick="openChoosePage(831)" value="..." />
            </td>
        </tr>
        <tr>
            <td class="Label4">异常处理人<em>*</em></td>
            <td class="Field4">
                <asp:TextBox runat="server" ID="ProcessByName" UserName="" CssClass="TextBox choose-user" Style="width: 90%" ClientIDMode="Static" Enabled="false"></asp:TextBox><input type="button" class="ButtonBox" onclick="openChoosePage('12_1',this)" value="..." />
            </td>
        </tr>
        <tr>
            <td class="Label4">异常完结人<em>*</em></td>
            <td class="Field4">
                <asp:TextBox runat="server" ID="CompleteByName" UserName="" CssClass="TextBox choose-user" Style="width: 90%" ClientIDMode="Static" Enabled="false"></asp:TextBox><input type="button" class="ButtonBox" onclick="openChoosePage('12_2',this)" value="..." />
            </td>
        </tr>
        <tr>
            <td class="Label1">处理时长(分钟)</td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="ExpirationTime" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var anormalProcessConfigId = "<%=Request.QueryString["AnormalProcessConfigId"]%>";
        var flag = -1;
        var chooseObj = null;
        _isHms = false;

        $(document).ready(function () {
            if (anormalProcessConfigId == "") {
                anormalProcessConfigId = -1;
            }

            if (anormalProcessConfigId > -1) {
                //获取数据
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAnormal.GetAnormalProcessConfig({ AnormalProcessConfigId: anormalProcessConfigId });
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var entity = ajax.value;
                if (entity) {
                    $("#LineName").val(entity.LineName).attr("LineId", entity.LineId);
                    if (entity.AnormalGroupId == -1) {
                        $("#AnormalGroupName").val("ALL");
                    } else {
                        $("#AnormalGroupName").val(entity.AnormalGroupName).attr("AnormalGroupId", entity.AnormalGroupId);
                    }
                    $("#ProcessByName").val(entity.ProcessByName).attr("UserName", entity.ProcessBy);
                    $("#CompleteByName").val(entity.CompleteByName).attr("UserName", entity.CompleteBy);
                    $("#ExpirationTime").val(entity.ExpirationTime);
                }
            }

        });

        //保存数据
        function Save() {
            var lineId = $.trim($("#LineName").attr("LineId"));
            var lineName = $.trim($("#LineName").val());
            var anormalGroupId;
            var anormalGroupName = $.trim($("#AnormalGroupName").val());
            var processByName = $.trim($("#ProcessByName").val());
            var processBy = $.trim($("#ProcessByName").attr("UserName"));
            var completeByName = $.trim($("#CompleteByName").val());
            var completeBy = $.trim($("#CompleteByName").attr("UserName"));

            if (lineName == "") {
                alert("请选择线别");
                return false;
            }

            if (anormalGroupName == "ALL" || anormalGroupName == "") {
                anormalGroupId = -1
            } else {
                anormalGroupId = $.trim($("#AnormalGroupName").attr("AnormalGroupId"));
            }

            if (processBy == "") {
                alert("请先选择异常处理人");
                return false;
            }
            if (completeBy == "") {
                alert("请先选择异常完结人");
                return false;
            }
            var expirationTime = parseInt($.trim($("#ExpirationTime").val()));

            var entity = {};
            entity.AnormalProcessConfigId = parseInt(anormalProcessConfigId);
            entity.LineId = lineId;
            entity.AnormalGroupId = anormalGroupId;
            entity.ProcessBy = processBy;
            entity.ProcessByName = processByName;
            entity.CompleteBy = completeBy;
            entity.CompleteByName = completeByName;
            entity.ExpirationTime = expirationTime;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAnormal.AnormalProcessConfigEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();
        }

        var chooseObj = null;//选择的对象
        function openChoosePage(flags, obj) {
            flag = flags;
            chooseObj = obj;
            var multiple = "false";
            if (flags == "12_1" || flags == "12_2") {
                multiple = "true";
                flags = 12;
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=" + multiple + "&rnd=" + Math.random(), width: 600, height: 350 });
        }

        function getChooseValue(list) {
            if (flag == 21) {	//选择线体
                $("#LineName").val(list[0][1]).attr("LineId", list[0][0]);
            }
            else if (flag == 831) {	//选择异常类型
                $("#AnormalGroupName").val(list[0][1]).attr("AnormalGroupId", list[0][0]);
            } else if (flag == "12_1" || flag == "12_2") {
                var receiver = $(chooseObj).siblings(".choose-user").attr("UserName");
                var receiverName = $(chooseObj).siblings(".choose-user").val();

                var listReceiver = [];
                if (receiver != "") {
                    listReceiver = receiver.split(",");
                }
                //清空选择项
                if (list.length > 0 && list[0][0] == "-1") {
                    receiver = "";
                    receiverName = "";
                } else {

                    for (var i = 0; i < list.length; i++) {
                        if (listReceiver.indexOf(list[i][2]) == -1) {
                            receiver += "," + list[i][2];
                            receiverName += "," + list[i][3];
                            //if (!list[i][7] || $.trim(list[i][7]) == "") {
                            //    alert("请先在【用户列表】维护好当前用户的手机号！");
                            //    return false;
                            //}
                            //if (!list[i][9] || $.trim(list[i][9]) == "" ) {
                            //    alert("请先在【用户列表】维护好当前用户的钉钉用户ID！");
                            //    return false;
                            //}
                        }
                    }
                    if (receiver.indexOf(",") == 0) {
                        receiver = receiver.substring(1)
                        receiverName = receiverName.substring(1);
                    }
                }
                $(chooseObj).siblings(".choose-user").val(receiverName).attr("UserName", receiver);
                chooseObj = null;
            }
            flag = -1;
        }

    </script>
</asp:Content>

