<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="NCGroupEdit.aspx.cs" Inherits="SKT.LeanMES.Web.NCCode.NCGroupEdit"
    Title="Edit NCGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current">基本信息</li>
            <li>不良代码</li>
            <li>使用工位</li>
        </ul>
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label1">不良代码类型名<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtGroupName" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">绑定所有工位
                    </td>
                    <td class="Field1">
                        <asp:CheckBox ID="cbkBindAllStation" runat="server" Text="<%$Resources:Common,Yes %>" />
                        <br />
                        <span class="Tips">在此类不良代码类型中的不良代码是否可以在所有工序上都使用?</span>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        <%= Resources.lang.Description%>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" MaxLength="50"
                            TextMode="MultiLine" Width="250px" Height="60px"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <!--不良代码-->
        <div>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td align="center" valign="top">
                        <div style="width: 253px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                                <%=Resources.lang.NCCodeOptional%>
                            </div>
                            <div id="aviNCCodeList" style="display: block; margin-top: -7px; margin-left: -3px;">
                                <asp:ListBox ID="NCCodeList" runat="server" Height="280px" Width="253px" SelectionMode="Multiple"
                                    CssClass="Padd7"></asp:ListBox>
                            </div>
                        </div>
                    </td>
                    <td align="center" valign="middle">
                        <div style="width: 90px; text-align: center">
                            <input type="button" onclick="btnChooseNCCode(0);" class="rightButton"
                                title="<%=Resources.lang.AssignNCCode %>" />
                            <br />
                            <br />
                            <br />
                            <input type="button" onclick="btnChooseNCCode(1);" class="leftButton"
                                title="<%=Resources.lang.DeleteNCCode %>" />
                        </div>
                    </td>
                    <td align="center" valign="top">
                        <div style="width: 253px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                                <%=Resources.lang.NCCodeSelected%>
                            </div>
                            <div id="assignNCGroupList" style="display: block; margin-top: -7px; margin-left: -3px;">
                                <asp:ListBox ID="NCGroupList" runat="server" Height="280px" Width="253px" SelectionMode="Multiple"
                                    CssClass="Padd7"></asp:ListBox>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <!--选择工位-->
        <div>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td align="center" valign="top">
                        <div style="width: 253px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                                可选工位
                            </div>
                            <div id="divOperationList" style="display: block; margin-top: -7px; margin-left: -3px;">
                                <asp:ListBox ID="OperationList" runat="server" Height="280px" Width="253px" SelectionMode="Multiple"
                                    CssClass="Padd7"></asp:ListBox>
                            </div>
                        </div>
                    </td>
                    <td align="center" valign="middle">
                        <div style="width: 90px; text-align: center">
                            <input type="button" class="rightButton" onclick="btnChooseOperation(0);"
                                title="<%=Resources.lang.AssignOperation %>" />
                            <br />
                            <br />
                            <br />
                            <input type="button" class="leftButton" onclick="btnChooseOperation(1);"
                                title="<%=Resources.lang.DeleteOperation %>" />
                        </div>
                    </td>
                    <td align="center" valign="top">
                        <div style="width: 253px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                                <%=Resources.lang.SelectedLocation%>
                            </div>
                            <div id="divassOperation" style="display: block; margin-top: -7px; margin-left: -3px;">
                                <asp:ListBox ID="assOperationsList" runat="server" Height="280px" Width="253px" SelectionMode="Multiple"
                                    CssClass="Padd7"></asp:ListBox>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        var nCGroupId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var errStr = "";
            txtNCGroupName = $.trim($("#<%=this.txtGroupName.ClientID%>").val());
            txtDescription = $("#<%=this.txtDescription.ClientID%>").val();
            txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            txtCreateBy = txtModifyBy;
            bindAllStation = $("#<%=this.cbkBindAllStation.ClientID %>")[0].checked;
            /*表单验证*/
            if (txtNCGroupName.length <= 0) {
                errStr += "<%= Resources.Messages.GroupNameEmpty %>";
            }
            if (errStr != "") {
                alert(errStr);
                return false;
            }
            var entity = {};
            var action = '<%=Request.QueryString["Action"] %>';
            if (action == "Copy") {
                entity.NCGroupId = -2;
            }
            else {
                entity.NCGroupId = nCGroupId;
            }
            entity.NCGroupName = txtNCGroupName;
            entity.IsAllOperations = bindAllStation;
            entity.Description = txtDescription;
            entity.ModifyBy = txtModifyBy;
            entity.CreateBy = txtCreateBy;
            //左边
            var nccodeStr = [];
            var sl = {};
            //右边
            var operationStr = [];
            var sr = {};
            $("#<%=this.NCGroupList.ClientID%> option").each(function () {
                nccodeStr.push($(this).val());
            });
            $("#<%=this.assOperationsList.ClientID%> option").each(function () {
                operationStr.push($(this).val());
            });
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxNCCode.EditNCGroup(entity, nccodeStr.join(","), operationStr.join(","));
            if (ajax.error == null) {
                alert('<%=Resources.Messages.SaveInSuccess%>')
                parent.window.UpdateList(txtNCGroupName);
            } else {
                alert(ajax.error.Message);
                return false;
            }
        }
        /*不良编码分配到组*/
        function btnChooseNCCode(index) {
            if (index == 0) {
                var selectedCode = $("#<%=this.NCCodeList.ClientID %> option:selected").length;
                if (selectedCode <= 0) {
                    alert("<%=Resources.Messages.QualificationNCCodeIsRequired %>");
                    return false;
                }
                $("#<%=this.NCCodeList.ClientID %> option").each(function () {
                    if ($(this).attr("selected")) {
                        $("#<%=this.NCGroupList.ClientID %>").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                        $(this).remove();
                    }
                });
            }
            else {
                /*从组里面删除不良代码*/
                var selectedCode = $("#<%=this.NCGroupList.ClientID %> option:selected").length;
                if (selectedCode <= 0) {
                    alert("<%=Resources.Messages.QualificationNCCodeIsRequired %>");
                    return false;
                }
                $("#<%=this.NCGroupList.ClientID %> option").each(function () {
                    if ($(this).attr("selected")) {
                        $("#<%=this.NCCodeList.ClientID %>").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                        $(this).remove();
                    }
                });
            }
        }
        /*不工位分配到组*/
        function btnChooseOperation(index) {
            if (index == 0) {
                var selectedCode = $("#<%=this.OperationList.ClientID %> option:selected").length;
                if (selectedCode <= 0) {
                    alert("<%=Resources.Messages.QualificationOperationIsRequired %>");
                    return false;
                }
                $("#<%=this.OperationList.ClientID %> option").each(function () {
                    if ($(this).attr("selected")) {
                        $("#<%=this.assOperationsList.ClientID %>").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                        $(this).remove();
                    }
                });
            }
            else {
                /*从组里面删除工位*/
                var selectedCode = $("#<%=this.assOperationsList.ClientID %> option:selected").length;
                if (selectedCode <= 0) {
                    alert("<%=Resources.Messages.QualificationOperationIsRequired %>");
                    return false;
                }
                $("#<%=this.assOperationsList.ClientID %> option").each(function () {
                    if ($(this).attr("selected")) {
                        $("#<%=this.OperationList.ClientID %>").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                        $(this).remove();
                    }
                });
            }
        }
        /**绑定所有工序**/
        $("#<%=this.cbkBindAllStation.ClientID%>").click(function () {            
            if ($("#<%=this.cbkBindAllStation.ClientID%>:checked").length == 1) {
                //全选
                //console.log(0);
                $("#<%=this.OperationList.ClientID %> option").each(function (i, j) {
                    $(j).prop("selected", "selected")
                });
                btnChooseOperation(0);
                $("#<%=this.cbkBindAllStation.ClientID%>").prop("checked", "checked");
            } else {
                //全删
                //console.log(2);
                $("#<%=this.assOperationsList.ClientID %> option").each(function (i, j) {
                    $(j).prop("selected", "selected")
                });
                btnChooseOperation(1);
                $("#<%=this.cbkBindAllStation.ClientID%>").prop("checked", null);
            }
        });
    </script>
</asp:Content>
