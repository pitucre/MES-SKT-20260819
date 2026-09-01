<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="UsersInRole.aspx.cs" Inherits="SKT.LeanMES.Web.Role.UsersInRole" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                角色名
            </td>
            <td class="Field2">
                <asp:Label ID="lblRoleName" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                用户类型
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlUserType" runat="server" ClientIDMode="Static">
                <asp:ListItem Value="0">所有</asp:ListItem>
                <asp:ListItem Value="-1">系统用户</asp:ListItem>
                <asp:ListItem Value="1">供应商</asp:ListItem>
                </asp:DropDownList>                
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <asp:Label ID="Label5" runat="server" Text="<%$Resources:lang,SelectUser%>"></asp:Label>
            </td>
            <td class="Label" style="width: 10%; text-align: center;">
            </td>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <asp:Label ID="Label6" runat="server" Text="<%$Resources:lang,UserInRole%>"></asp:Label>
            </td>
        </tr>
        <tr style="height: 300px; padding: 2px;" valign="top">
            <td class="Field" align="center" style="width: 45%; vertical-align: top;">
                <div id="loadingmessages1" class="Tips">
                    <%=Resources.Messages.DataLoding %></div>
                <iframe name="frmUserChooseList" id="frmUserChooseList" frameborder="0" style="width: 99%;
                    height: 300px;" src=""></iframe>
            </td>
            <td class="Field" style="width: 10%; text-align: center; vertical-align: middle;">
                <input type="button" id="btnLeftChoose" runat="server" value="" class="rightButton"
                    onclick="btnChooseOnClick(0);" />
                <br />
                <br />
                <br />
                <br />
                <input type="button" id="btnRightChoose" runat="server" value="" class="leftButton"
                    onclick="btnChooseOnClick(1);" />
            </td>
            <td class="Field" align="center" style="width: 45%; vertical-align: top;">
                <div id="loadingmessages2" class="Tips">
                    <%=Resources.Messages.DataLoding %></div>
                <iframe name="frmRoleUsersList" id="frmRoleUsersList" frameborder="0" style="width: 99%;
                    height: 300px;" src=""></iframe>
            </td>
        </tr>
    </table>
    <script type="text/javascript">

        var roleId = '<%= Request.QueryString["ID"] %>';
        var roleName = decodeURI('<%=Request.QueryString["RoleName"] %>');
        var IsGroup = parseInt('<%=Request.QueryString["IsGroup"]%>') == 1 ? "1" : "0";
        roleName = roleName.replace(/‘/g, "'");
        $(function () {
            $("#<%=this.lblRoleName.ClientID %>").text(roleName);
            var iframe1 = document.getElementById("frmUserChooseList");
            iframe1.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/User/UserChooseList.aspx?ID=<%= Request.QueryString["ID"] %>&IsGroup=' + IsGroup;
            if (iframe1.attachEvent) {
                iframe1.attachEvent("onload", function () {
                    $("#loadingmessages1").html("");
                });
            }
            else {
                iframe1.onload = function () {
                    $("#loadingmessages1").html("");
                };
            }

            var iframe2 = document.getElementById("frmRoleUsersList");
            iframe2.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/User/RoleUsersList.aspx?ID=<%= Request.QueryString["ID"] %>&IsGroup=' + IsGroup;

            if (iframe2.attachEvent) {
                iframe2.attachEvent("onload", function () {
                    $("#loadingmessages2").html("");
                });
            }
            else {
                iframe2.onload = function () {
                    $("#loadingmessages2").html("");
                };
            }

            $("#ddlUserType").bind("change",function () {
                iframe1.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/User/UserChooseList.aspx?ID=<%= Request.QueryString["ID"] %>' + '&TypeId=' + this.value + '&IsGroup=' + IsGroup;
                iframe2.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/User/RoleUsersList.aspx?ID=<%= Request.QueryString["ID"] %>' + '&TypeId=' + this.value + '&IsGroup=' + IsGroup;
            });
        });

        function loadingcompleted() {
            $("#loadingmessages1").html("");
        }

        function btnChooseOnClick(index) {
            if (roleId == null || roleId == "") {
                alert("获取角色失败");
                return false;
            }
            var userIdString;
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';

            if (index == 0) {
                /* document.frames[0]写法只有IE opera 支持 chenglong.zhu 2016-11-21 */
                //userIdString = document.frames[0].window.getSelectedValues();
                userIdString = window.frames[0].window.getSelectedValues();
            }
            else {
                /* document.frames[0]写法只有IE opera 支持 chenglong.zhu 2016-11-21 */
                //userIdString = document.frames[1].window.getSelectedValues();
                userIdString = window.frames[1].window.getSelectedValues();
            }

            if (userIdString == "") {
                alert("<%= Resources.Messages.RequireOperateRecord %>");
                return false;
            }

            /*分配用户到角色*/
            if (index == 0) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.AssignUserToRole(roleId, userIdString, IsGroup);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }

            }
            else {/*从用户中删除角色*/
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.RemoveUsersFromRole(roleId, userIdString, userName, IsGroup);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
            }
            /* document.frames[0]写法只有IE opera 支持 chenglong.zhu 2016-11-21 */
//            document.frames[0].window.document.forms[0].submit();
            //            document.frames[1].window.document.forms[0].submit();
            window.frames[0].window.document.forms[0].submit();
            window.frames[1].window.document.forms[0].submit();
        }
    </script>
</asp:Content>
