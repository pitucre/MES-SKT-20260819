<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="Popedom.aspx.cs" Inherits="SKT.LeanMES.Web.Popedom.Popedom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <link href="../Content/Main.css" rel="stylesheet" type="text/css" />
    <script src="../Content/js/skt.utility.tablelist.js?v=20211209" type="text/javascript"></script>
    <table width="100%" cellpadding="2" cellspacing="3" border="0">
        <tr>
            <td valign="top" align="left" width="20%">
                <%--角色列表--%>
                <table class="ListTable" width="250" id="roleList">
                    <tr class="ListTableHeader">
                        <th>
                        </th>
                        <th>
                            角色
                        </th>
                    </tr>
                    <tr class="ListTableEmptyDataRow">
                        <td>
                            角色
                        </td>
                        <td>
                            <input type="text" value="" class="TextBox" /><input class="SearchButton" type="button"
                                onclick="searchRole(this)" value="查询" />
                        </td>
                    </tr>
                </table>
            </td>
            <td valign="top" align="left">
                <%--权限列表--%>
                <table class="ListTable" width="100%" id="popedomList">
                    <tr class="ListTableHeader">
                        <th>
                            功能模块
                        </th>
                        <th>
                            操作权限
                        </th>
                        <th>
                            按钮权限
                        </th>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        isMultiple = false;

        $(function () {
            getRoleList("");
            getPermissionList();
        });

        function getRoleList(strWhere) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetRoleList(strWhere,"");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var roleList = ajax.value;
            var tblRole = "";
            for (var i = 0; i < roleList.length; i++) {
                if (i % 2 == 0) {
                    tblRole += "<tr class=\"ListTableOddRow\" onmouseover=\"{try{mi(this);}catch (ex){}}\" onmouseout=\"{try{mo(this);}catch (ex){}}\" onclick=\"{try{clk(this);}catch (ex){}}\" ondblclick=\"{try{dblClk(this);}catch (ex){}}\">";
                }
                else {
                    tblRole += "<tr class=\"ListTableEvenRow\" onmouseover=\"{try{mi(this);}catch (ex){}}\" onmouseout=\"{try{mo(this);}catch (ex){}}\" onclick=\"{try{clk(this);}catch (ex){}}\" ondblclick=\"{try{dblClk(this);}catch (ex){}}\">";
                }
                tblRole += "<td><input type=\"checkbox\" name=\"chkSelect\" value=\"" + roleList[i].RoleId + "\" onclick=\"chkClk(this)\" /></td>";
                tblRole += "<td title=\"" + roleList[i].Description + "\">" + roleList[i].RoleName + "</td>";
                tblRole += "<tr>";
            }
            $("#roleList tr:gt(1)").remove();
            if (tblRole == "") {
                tblRole = "<tr class=\"ListTableEmptyDataRow\"><td colspan=\"3\">没有记录</td></tr>";
            }
            $(tblRole).appendTo($("#roleList"));
        }

        function searchRole(obj) {
            getRoleList($(obj).prev().val());
        }

        function getPermissionList() {
            var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetSubSystemAll();
            if (ajax1.error != null) {
                alert(ajax1.error.Message);
                return false;
            }

            var subSystemList = ajax1.value;
            var tblPermission = "";
            
            for (var i = 0; i < subSystemList.length; i++) {
                tblPermission += "<tr><td>" + subSystemList[i].Name + "</td><td><input type=\"checkbox\" value=\"" + subSystemList[i].Popedom + "\" name=\"chbPopedom\"/></td><td></td></tr>";
                var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetModuleBySubSystem(subSystemList[i].Name);
                if (ajax2.error != null) {
                    alert(ajax2.error.Message);
                    return false;
                }
                var moduleList = ajax2.value;

                for (var j = 0; j < moduleList.length; j++);
                { 
                    tblPermission += "<tr><td>" + moduleList[j].Name + "</td><td><input type=\"checkbox\" value=\"" + moduleList[j].Popedom + "\" name=\"chbPopedom\"/></td><td></td></tr>";
                    var ajax3 = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetPagesByModule(moduleList[j].Name);
                    if (ajax3.error != null) {
                        alert(ajax3.error.Message);
                        return false;
                    }
                    var pageList = ajax3.value;
                    if (pageList == null) return false;
                    for (var k = 0; k < pageList.length; k++) {
                        tblPermission += "<tr><td>" + pageList[k].Name + "</td><td><input type=\"checkbox\" value=\"" + pageList[k].Popedom + "\" name=\"chbPopedom\"/></td><td>";
                        var ajax4 = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetButtonsByPage(pageList[k].Name);
                        if (ajax4.error != null) {
                            alert(ajax4.error.Message);
                            return false;
                        }
                        var buttonList = ajax4.value;
                        var tblButton = "";
                        if (buttonList == null) return false;
                        for (var l = 0; l < buttonList.length; l++) {
                            tblButton += "<input type=\"checkbox\" value=\"" + buttonList[l].Popedom + "\" name=\"chbPopedom\"/>" + tblButton[l].Text.toString();
                        }
                        tblPermission += tblButton + "</td></tr>";
                    }
                }
            }
            $("#popedomList tr:gt(1)").remove();
            $(tblPermission).appendTo($("#popedomList"));
        }
    </script>
</asp:Content>
