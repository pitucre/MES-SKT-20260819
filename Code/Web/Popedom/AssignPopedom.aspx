<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.Popedom.AssignPopedom" CodeBehind="AssignPopedom.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div id="alertMsg" class="Tips">
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                角色名
            </td>
            <td class="Field1">
                <asp:Label ID="lblRoleName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                描述
            </td>
            <td class="Field1">
                <asp:Label ID="lblDescription" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <table class="EditeContentTable" style="width: 100%;">
        <tr>
            <td class="Label1" style="width: 25%; text-align: left;">
                <input type="checkbox" id="chkSelectAllSubSystems" onclick="selectAll(this, 0)" />&nbsp;&nbsp;<asp:Label
                    ID="lblSubSystems" runat="server" Text="子系统"></asp:Label>
            </td>
            <td class="Label1" style="width: 25%; text-align: left;">
                <input type="checkbox" id="chkSelectAllModules" onclick="selectAll(this, 1)" />&nbsp;&nbsp;<asp:Label
                    ID="lblModules" runat="server" Text="模块"></asp:Label>
            </td>
            <td class="Label1" style="width: 25%; text-align: left;">
                <input type="checkbox" id="chkSelectAllPopedoms" onclick="selectAll(this, 2)" />&nbsp;&nbsp;<asp:Label
                    ID="lblPopedoms" runat="server" Text="权限"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: #FFFFFF;">
            <td style="padding: 1px; width: 30%; vertical-align: top;" class="Field">
                <table cellspacing="1" cellpadding="0" runat="server" id="tblSubSystems" style="font-family: 宋体, Verdana, Arial;
                    font-size: 9pt; width: 100%;">
                </table>
            </td>
            <td style="padding: 1px; width: 30%; vertical-align: top;" class="Field">
                <table cellspacing="1" cellpadding="0" runat="server" id="tblModules" style="font-family: 宋体, Verdana, Arial;
                    font-size: 9pt; width: 100%;">
                </table>
            </td>
            <td style="padding: 1px; width: 40%; vertical-align: top;" class="Field">
                <table cellspacing="1" cellpadding="0" runat="server" id="tblPopedoms" style="font-family: 宋体, Verdana, Arial;
                    font-size: 9pt; width: 100%;">
                </table>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var tblSubSystems = document.getElementById("<%= this.tblSubSystems.ClientID %>");
        var tblModules = document.getElementById("<%= this.tblModules.ClientID %>");
        var tblPopedoms = document.getElementById("<%= this.tblPopedoms.ClientID %>");
        var roleId = '<%= Request.QueryString["ID"] %>';
        var roleName = document.getElementById("<%= this.lblRoleName.ClientID %>");
        var IsGroup = parseInt('<%=Request.QueryString["IsGroup"]%>') == 1 ? "1" : "0";
        function Save() {
            var popedomString = "";
            var poplen = document.getElementsByName("popedom");

            for (var idx = 0; idx < poplen.length; idx++) {
                if (poplen[idx].checked) {
                    popedomString = popedomString + poplen[idx].value + ",";
                }
            }



            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.AssignPopodomToRole(roleId, popedomString, IsGroup);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%= Resources.Messages.AssignSuccess %>");
            parent.window.Refresh();
        }

        $(function () {
            $("#<%=this.tblSubSystems.ClientID %> input[type=checkbox][name=popedom]").change(function () {
                if (!this.checked) {
                    var parent1 = $(this).parent().parent().attr("name");
                    if (confirm("取消选择，该子系统下的所有权限都将取消，是否确定？")) {
                        $("#<%=this.tblModules.ClientID %> input[type=checkbox][name=popedom]").each(function () {

                            if ($(this).parent().parent().attr("parent") == parent1) {
                                this.checked = false;
                                var parent2 = $(this).parent().parent().attr("name");
                                $("#<%=this.tblPopedoms.ClientID %> input[type=checkbox][name=popedom]").each(function () {

                                    if ($(this).parent().parent().attr("parent") == parent2) {
                                        this.checked = false;
                                    }
                                });
                            }
                        });
                    }
                    else {
                        this.checked = true;
                    }
                }
            });

            $("#<%=this.tblModules.ClientID %> input[type=checkbox][name=popedom]").change(function () {
                if (!this.checked) {
                    var parent1 = $(this).parent().parent().attr("name");
                    if (confirm("取消选择，该模块下的所有权限都将取消，是否确定？")) {
                        $("#<%=this.tblPopedoms.ClientID %> input[type=checkbox][name=popedom]").each(function () {

                            if ($(this).parent().parent().attr("parent") == parent1) {
                                this.checked = false;
                            }
                        });
                    }
                    else {
                        this.checked = true;
                    }
                }
            });
        });

        /**
        * 展开子系统下的模块。
        */
        function switchSubSystem(subSystem) {
            setRowBgColor(tblSubSystems, subSystem);
            setRowDisplay(tblModules, subSystem);
            setRowNoneBgColor(tblModules, "#FFFFFF");
            setNoneDisplay(tblPopedoms);

            $("#chkSelectAllModules").attr("checked", false);
            $("#chkSelectAllPopedoms").attr("checked", false);
        }

        /**
        * 展开模块下的权限。
        */
        function switchModule(module) {
            setRowBgColor(tblModules, module);
            setRowDisplay(tblPopedoms, module);

            $("#chkSelectAllPopedoms").attr("checked", false);
        }

        /**
        * 设置选中行的背景色。
        */
        function setRowBgColor(obj, rowName) {
            for (var idx = 0; idx < obj.rows.length; idx++) {
                if ($(obj.rows[idx]).attr("name") == rowName) {
                    obj.rows[idx].style.backgroundColor = "#ececec";
                }
                else {
                    obj.rows[idx].style.backgroundColor = "#FFFFFF";
                }
            }
        }

        /**
        * 设置所有行背景色。
        */
        function setRowNoneBgColor(obj, pColor) {
            for (var idx = 0; idx < obj.rows.length; idx++) {
                obj.rows[idx].style.backgroundColor = pColor;
            }
        }

        /**
        * 设置行显示。
        */
        function setRowDisplay(obj, rowName) {

            for (var idx = 0; idx < obj.rows.length; idx++) {
                if ($(obj.rows[idx]).attr("parent") == rowName)//obj.rows[idx].parent
                {
                    obj.rows[idx].style.display = "";
                }
                else {
                    obj.rows[idx].style.display = "none";
                }
            }
        }

        /**
        * 设置所有行都不显示。
        */
        function setNoneDisplay(obj) {
            for (var idx = 0; idx < obj.rows.length; idx++) {
                obj.rows[idx].style.display = "none";
                obj.rows[idx].style.backgroundColor = "#FFFFFF";
            }
        }

        function selectAll(obj, index) {
            switch (index) {
                case 0:
                    commonSelectAll(tblSubSystems, obj.checked);
                    break;
                case 1:
                    commonSelectAll(tblModules, obj.checked);

                    for (var idx = 0; idx < tblSubSystems.rows.length; idx++) {
                        if (tblSubSystems.rows[idx].style.backgroundColor == "#ececec") {
                            commonSetPopedom(tblSubSystems, tblSubSystems.rows[idx].name);
                            break;
                        }
                    }
                    break;
                case 2:
                    commonSelectAll(tblPopedoms, obj.checked);

                    for (var idx = 0; idx < tblSubSystems.rows.length; idx++) {
                        if (tblSubSystems.rows[idx].style.backgroundColor == "#ececec") {
                            commonSetPopedom(tblSubSystems, tblSubSystems.rows[idx].name);
                            break;
                        }
                    }

                    for (var idx = 0; idx < tblModules.rows.length; idx++) {

                        if (tblModules.rows[idx].style.backgroundColor == "#ececec") {
                            commonSetPopedom(tblModules, tblModules.rows[idx].name);
                            break;
                        }
                    }
                    break;
            }
        }

        function commonSelectAll(obj, isChecked) {
            for (var idx = 0; idx < obj.rows.length; idx++) {
                if (obj.rows[idx].style.display == "") {
                    obj.rows[idx].cells[0].children[0].checked = isChecked;
                }
            }
        }

        /**
        * 默认选择上级模块或子系统。
        */
        function setPopedom(obj, index) {

            if (obj.checked) {
                switch (index) {
                    case 0:
                        commonSetPopedom(tblSubSystems, $(obj.parentElement.parentElement).attr("parent")); //obj.parentElement.parentElement.subSystem
                        break;
                    case 1:
                        var subSystem = commonSetPopedom(tblModules, $(obj.parentElement.parentElement).attr("parent"));

                        commonSetPopedom(tblSubSystems, subSystem);
                        break;
                }
            }
        }

        function commonSetPopedom(obj, parentName) {

            var parentString = "";
            for (var idx = 0; idx < obj.rows.length; idx++) {

                if ($(obj.rows[idx]).attr("name") == parentName && !obj.rows[idx].cells[0].checked) {
                    obj.rows[idx].cells[0].children[0].checked = true;
                    parentString = $(obj.rows[idx]).attr("parent");
                    break;
                }
            }

            return parentString;
        }

        function showPopedomUsers(popedom) {
            var url = "<%= SKT.LeanMES.Web.WebHelper.WebRoot %>/User/PopedomUsersList.aspx?name=PopedomUsersList&amp;Popedom=" + popedom + "&rnd=" + Math.random() + "&IsGroup=" + IsGroup;
            //window.open(url, false, 700, 450);
            dialog({ title: "权限用户", src: url, width: 550, height: 300 });
        }

        function exportPopedomUsers(popedomText, popedom) {
            setStatusMessage("<%=Resources.Common.MsgCaption %>:", "<div class=\"icon-16-loading\"></div><%=Resources.Messages.ExportingDataWaiting %>");
            setTimeout(function () {
                var xlsPath = "http://<%= Request.Url.Authority + SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot%>/Popedom.xls";
                var xlsAlert = "<%= Resources.Messages.ExcelActiveXObjectError %>";

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.ExportPopedomUser(popedom, IsGroup);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var reportSource = ajax.value;
                var rowCount = parseInt(reportSource[1]);
                var colCount = parseInt(reportSource[2]);
                var startRow = 2;
                var endRow = startRow + rowCount;

                var xls, xlBook, xlSheet;
                try {
                    xls = new ActiveXObject("Excel.Application");
                }
                catch (exp) {
                    alert(xlsAlert);
                    setStatusMessage("", "");
                    return false;
                }

                xlBook = xls.Workbooks.Open(xlsPath);
                xlSheet = xlBook.Worksheets(1);

                with (xlSheet) {
                    Cells(1, 1).value = popedomText;

                    window.clipboardData.setData("Text", reportSource[0]);
                    Paste(Cells(startRow, 1));
                    window.clipboardData.clearData("Text");
                }

                setRangeBorders(xlSheet, startRow, endRow - 1, 1, colCount);

                xls.Visible = true;
                setStatusMessage("", "");
            }, 300);
        }

        function setStatusMessage(mtitle, msg) {
            $("#alertMsg").html("<b>" + mtitle + "</b>" + msg);
        }

        $(function () {
            $(".Field table tr").hover(function () {
                $(this).children("td:eq(1)").css("color", "steelblue");
                $(this).children("td:eq(1)").css("text-decoration", "underline");
            },
            function () {
                $(this).children("td:eq(1)").css("color", "");
                $(this).children("td:eq(1)").css("text-decoration", "none");
            }
            );
        });
    </script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.excel.js"
        type="text/javascript"></script>
</asp:Content>
