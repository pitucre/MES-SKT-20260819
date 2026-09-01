<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="RolesInUser.aspx.cs" Inherits="SKT.LeanMES.Web.Role.RolesInUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <asp:Label ID="Label1" runat="server" Text="用户名"></asp:Label>
            </td>
            <td class="Field2">
                <asp:Label ID="lblNameText" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <asp:Label ID="Label2" runat="server" Text="工号"></asp:Label>
            </td>
            <td class="Field2">
                <asp:Label ID="lblEmployeeNOText" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <asp:Label ID="Label3" runat="server" Text="中文名"></asp:Label>
            </td>
            <td class="Field2">
                <asp:Label ID="lblCNameText" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <asp:Label ID="Label4" runat="server" Text="英文名"></asp:Label>
            </td>
            <td class="Field2">
                <asp:Label ID="lblENameText" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <asp:Label ID="Label5" runat="server" Text="<%$Resources:lang,SelectRolse %>"></asp:Label>
            </td>
            <td class="Label" style="width: 10%; text-align: center;">
            </td>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <asp:Label ID="Label6" runat="server" Text="<%$Resources:lang,TheRoleTheUser %>"></asp:Label>
            </td>
        </tr>
        <tr style="height: 300px;" valign="top">
            <td align="center" style="width: 45%; vertical-align: top;">
                <div id="loadingmessages1" class="Tips">
                     <%=Resources.Messages.DataLoding %></div>
                <iframe name="frmRoleChooseList" id="frmRoleChooseList" frameborder="0" width="99%"
                    height="330px" style="margin: 2px 0 0 0; padding: 0px;" marginwidth="0" marginheight="0"
                    scrolling="no" src=""></iframe>
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
            <td align="center" style="width: 45%; vertical-align: top;">
                <div id="loadingmessages2" class="Tips">
                    <%=Resources.Messages.LoadingData %></div>
                <iframe name="frmUserRoleList" id="frmUserRoleList" frameborder="0" width="99%" height="330px"
                    style="margin: 2px 0 0 0; padding: 0px;" marginwidth="0" marginheight="0" scrolling="no"
                    src=""></iframe>
            </td>
        </tr>
    </table>
    <script type="text/javascript">

        var userId = '<%= Request.QueryString["ID"] %>';
        var IsGroup = parseInt('<%=Request.QueryString["IsGroup"]%>') == 1 ? "1" : "0";
        $(function () {
            var iframe1 = document.getElementById("frmRoleChooseList");
            iframe1.src = 'RoleChooseList.aspx?ID=<%= Request.QueryString["ID"] %>&IsGroup=' + IsGroup;
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

            var iframe2 = document.getElementById("frmUserRoleList");
            iframe2.src = 'UserRolesList.aspx?ID=<%= Request.QueryString["ID"] %>&IsGroup=' + IsGroup;

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
        });

        function loadingcompleted() {
            $("#loadingmessages1").html("");
        }

        function btnChooseOnClick(index) {
            if (userId == null || userId == "") {
                alert("<%=Resources.Messages.GetUserIdFailed %>");
                return false;
            }
            var roleIdString;
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';

            if (index == 0) {
                /* document.frames[0]写法只有IE opera 支持 chenglong.zhu 2016-11-21 */
                //roleIdString = document.frames[0].window.getSelectedValues();
                roleIdString = window.frames[0].window.getSelectedValues();
            }
            else {
                /* document.frames[0]写法只有IE opera 支持 chenglong.zhu 2016-11-21 */
                //roleIdString = document.frames[1].window.getSelectedValues();
                roleIdString = window.frames[1].window.getSelectedValues();
            }

            if (roleIdString == "") {
                alert("<%= Resources.Messages.RequireOperateRecord %>");
                return false;
            }

            /*分配用户到角色*/
            if (index == 0) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.AssignRolesToUser(userId, roleIdString, IsGroup);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }

            }
            else {/*从用户中删除角色*/
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.RemoveRolesFromUser(userId, roleIdString, userName, IsGroup);
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
