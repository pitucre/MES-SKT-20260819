<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="OChartTree.aspx.cs" Inherits="SKT.LeanMES.Web.Organization.OChartTree" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <link href="../Content/plugin/jqTree/img/mask.css" rel="stylesheet" type="text/css" />
    <link href="../Content/plugin/jqTree/img/saas.css?v=20210810" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/jqTree/Js/saas.js" type="text/javascript"></script>
    <script src="../Content/plugin/jqTree/Js/jqDnR.js" type="text/javascript"></script>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td align="left" valign="top" width="245px">
                <div style="width: 98%; border: 1px solid #ccc;"> 
                    <div class="divHeader" style="border: none;">
                        <img src="../Content/images/icon/openrouter.png" style="vertical-align: middle;" />部门<span
                            id="cellToolbar" style="float: right"></span></div>
                    <ul id="browser" class="treeview filetree" style="overflow: auto;">
                    </ul>
                </div>
            </td>
            <td align="left" valign="top">
                <div id="depUserList" style="overflow: auto;">
                    <table class="ListTable" width="100%" id="userList">
                        <tr class="ListTableHeader">
                            <th>
                                中文名
                            </th>
                            <th>
                                英文名
                            </th>
                            <th style="width:40px;">
                                性别
                            </th>
                            <th>
                                电话
                            </th>
                            <th>
                                邮箱
                            </th>
                            <th>
                                工号
                            </th>
                            <th>
                                部门
                            </th>
                             <th>
                                修改人
                            </th>
                            <th>
                                修改时间
                            </th>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <asp:HiddenField runat="server" ID="hdnOrganizationId" />
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        var RequireOnlyOneRecord = "<%=Resources.Messages.RequireOnlyOneRecord %>";
        var RequireOperateRecord = "<%=Resources.Messages.RequireOperateRecord %>";
        var ConfirmDelete = "<%=Resources.Messages.ConfirmDelete %>";
        var isMultiple = false;

        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        $(function () {
            setSize();
            $(window).resize(function () { setSize(); });
            if (buttons) {
                var tlb = "";
                for (var i = 0, j = buttons.length; i < j; i++) {
                    tlb += "<div class=\"toolbar-btn\" onclick=\"" + InitHander(buttons[i].Handler) + "\" title=\"" + buttons[i].Tooltip + "\"><div class=\"icon-16-" + buttons[i].Icon + "\"></div></div>";
                }
                $("#cellToolbar").html(tlb);
                $("#toolbar").html("");
                $("#toolbar").hide();
            }
        });
        function setSize() {
            $("#browser").height($(window).height() - 65);
            $("#depUserList").height($(window).height() - 35);
        }

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Organization/OrganizationEdit.aspx?name=Account_OrganizationAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Account_OrganizationAdd %>", src: openWinUrl, width: 750, height: 500 });
        }
        function View() {
            var idStr = "";
            $(".treeview  input[type='checkbox']").each(function () {
                if ($(this)[0].checked) {
                    idStr = $(this).val();
                    return;
                }
            });
            if (idStr == "") {
                alert("请选择一个部门");
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Organization/OrganizationView.aspx?name=Account_OrganizationView&ID=" + idStr;
            dialog({ title: "查看部门", src: openWinUrl, width: 750, height: 500 });
        }
        function Edit() {
            var idStr = "";
            $(".treeview  input[type='checkbox']").each(function () {
                if ($(this)[0].checked) {
                    idStr = $(this).val();
                    return;
                }
            });
            if (idStr == "") {
                alert("请选择一个部门");
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Organization/OrganizationEdit.aspx?name=Account_OrganizationEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Account_OrganizationEdit %>", src: openWinUrl, width: 750, height: 500 });
        }

        function Delete() {
            var idStr = "";
            $(".treeview  input[type='checkbox']").each(function () {
                if ($(this)[0].checked) {
                    idStr += $(this).val() + ",";
                }
            });
            var idStr = idStr.substring(0, idStr.length - 1);

            if (idStr == "") {
                alert("请选择一个部门");
                return false;
            }
            if (!confirm("是否确定要删除选中的部门，如果该部门下面还有子部门也会一起删除？")) {
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxOrganization.Delete(idStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("删除部门成功！");
            initOrganization(-1);
        }

        function Refresh(id) {
            initOrganization(id);
            closeDialog();
        }

        $(document).ready(function () {
            initOrganization(-1);
            GetDepartmentMemeber(-1, "");
        });

        function ShowDetail(t) {
        }
        var parentIdArr;
        var expands;
        function initOrganization(id) {
            $('#browser').html("");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxOrganization.GetAll();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            parentIdArr = new Array();
            expands = true;
            var data = AjaxPro.toJSON(ajax.value);
            var orgjsonObj = $.parseJSON(data);
            $('#browser').showTree({ data: orgjsonObj });
            //expandTree(id, orgjsonObj);
        }

        function expandTree(id, data) {
            getParentId(id, data);
            try {
                expandSelectedNodes($(".treeview  input[type='checkbox']"))
            }
            catch (e) { }
        }

        /*展开选中的节点*/
        function expandSelectedNodes(obj) {
            for (var i = 0; i < parentIdArr.length; i++) {
                if (obj != null) {
                    obj.each(function () {
                        if ($(this).val() == parentIdArr[i]) {
                            $(this).next().click();
                            if (expands && i == 0) { $(this)[0].checked = true; expands = false; }
                            expandSelectedNodes($(".treeview  input[type='checkbox']"))
                        }
                    });
                }
            }
        }
         
        function getParentId(id, data) {
            var pId = -1;
            for (var i = 0; i < data.length; i++) {
                pId = -1;
                if (data[i].OrganizationId == id) {
                    parentIdArr.push(id);
                    pId = data[i].ParentId;
                    data.splice(data[i]);
                    alert(0);
                    getParentId(pId, data);
                }
                else {
                    break ;
                }
            }
        }

        function GetDepartmentMemeber(orgId, departNo) {
            console.log(orgId + " " + departNo);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxOrganization.GetUserByOrganizationId(orgId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var userList = "";
            var list = ajax.value;
            var rowclass = "ListTableEvenRow";
            for (var i = 0; i < list.length; i++) {
                if (i % 2 == 0) {
                    rowclass = "ListTableOddRow";
                }
                else {
                    rowclass = "ListTableEvenRow";
                }
                userList += "<tr class='" + rowclass + "'>";
                userList += "<td>" + list[i].EmployeeCName + "</td>";
                userList += "<td>" + list[i].EmployeeEName + "</td>";
                userList += "<td>" + ((list[i].Sex == 0) ? "女" : "男") + "</td>";
                userList += "<td>" + list[i].Phone + "</td>";
                userList += "<td>" + list[i].Email + "</td>";
                userList += "<td>" + list[i].EmployeeNo + "</td>";
                userList += "<td>" + list[i].DepartName + "</td>";
                userList += "<td>" + list[i].ModifyBy + "</td>";
                userList += "<td>" + (list[i].ModifyBy.length > 0 ? list[i].ModifyDateTimeStr : "") + "</td>";
                userList += "</tr>";
            }

            $("#userList tr:gt(0)").remove();
            if (list.length == 0) {
                userList = "<tr class='ListTableEmptyDataRow'><td colspan='7'>该部门没有任务人员</td></tr>";
            }
            $(userList).appendTo($("#userList"));
            moEvent();
        }

        /*鼠标经过时*/
        var oldBg;
        function moEvent() {
            $("#userList .ListTableOddRow,#userList .ListTableEvenRow").hover(
            function () {
                oldBg = $(this).attr("class");
                $(this).removeClass(oldBg);
                $(this).addClass("ListTableHoverRow");
            },
            function () {
                /*debug: 修正当本行被选中时鼠标移开后行颜色不能恢复的问题*/
                $(this).removeClass("ListTableHoverRow");
                $(this).addClass(oldBg);
            });
        }
    </script>
</asp:Content>
