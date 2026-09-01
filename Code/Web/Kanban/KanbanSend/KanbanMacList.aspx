<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master" CodeBehind="KanbanMacList.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.KanbanManage.KanbanMacList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">看板名称</td>
            <td class="Field2">
                <select id="selKanban">
                </select>
            </td>
            <td class="Label2">看板终端</td>
            <td>
                <input id="kanbanName" class="TextBox" name="input" /></td>
        </tr>
        <tr>
            <td colspan="4" align="center">
                <input type="button" id="searchSubmit" value="<%=Resources.lang.Search %>" onclick="doSearch()"
                    class="SearchButton" title="<%=Resources.lang.Search %>" />
                <input type="button" id="Button1" value="清空" onclick="clearSearch()" class="SearchButton"
                    title="清空查询条件" />
            </td>
        </tr>
    </table>

    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td align="left" valign="top" style="width: 35%">
                <div style="width: 98%; border: 1px solid #ccc;">
                    <div class="divHeader" style="border: none;">
                        <img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/icon/openrouter.png" style="vertical-align: middle;" />看板终端<span
                            id="cellToolbar" style="float: right"></span>
                    </div>
                    <div id="InspectionKanbanTree" class="ztree">
                        <asp:TreeView ID="TreeKanBan" runat="server" ClientIDMode="Static" ShowLines="true" Style="cursor: pointer;"></asp:TreeView>
                    </div>
                </div>
            </td>
            <td align="left" valign="top">
                <div id="depUserList" style="overflow: auto;">
                    <table class="ListTable" width="100%" id="kanbanList" border="1">
                        <tr class="ListTableHeader">
                            <th>
                                <input type="checkbox" name="chkAll" id="chkAll" onclick='checkAll(this)'>
                            </th>
                            <th>序号
                            </th>
                            <th>看板终端
                            </th>
                            <th>MAC
                            </th>
                            <th>位置</th>
                            <th>看板名称
                            </th>
                            <th>最近修改人
                            </th>
                            <th>最近修改时间
                            </th>
                            <th>备注
                            </th>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <input type="hidden" id="hdnSql" name="hdnSql" runat="server" clientidmode="Static" value="" />

    <script type="text/javascript">
        var seachSql = "";


        $(document).ready(function () {
            ShowKanban();
            showKanbanSend();
        })

        function clickOpen(sendId) {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/KanbanSend/KanbanMacEdit.aspx?name=Kanban_KanbanMacEdit&ID=" + sendId;
            dialog({ title: "<%=Resources.Pages.Kanban_KanbanMacEdit %>", src: openWinUrl, width: 600, height: 400 });
        }
        function checkAll(obj) {
            $("input[name='chkSelect']").each(function () {
                if ($(this).prop("checked")) {
                    $(this).prop("checked", false);
                    $(obj).prop("checked", false);
                } else {
                    $(this).prop("checked", true);
                    $(obj).prop("checked", true);
                }
            });
        }

        //清空
        function clearSearch() {
            $("#selKanban").find("option[value='-1']").attr("selected", true);
            $("input[name='input']").val("");
        }

        //执行查询事件
        function doSearch() {
            var seachSql = GetSearchSql();
            showKanbanSend(seachSql);
        }

        //where 条件
        function GetSearchSql() {
            var kanbanId = $("#selKanban").find("option:selected").val();
            var sendName = $("#kanbanName").val();
            seachSql = "";
            //执行查询
            if (kanbanId != -1 && sendName != "") {
                seachSql = "  KanbanId = " + kanbanId + " AND  SendName = '" + sendName + "'";
            } else if (kanbanId != -1 && sendName == "") {
                seachSql = "  KanbanId = " + kanbanId + "";
            } else if (sendName != "" && kanbanId == -1) {
                seachSql = "SendName = '" + sendName + "'";
            }
            return seachSql;
        }

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

        //显示所有数据
        function showKanbanSend() {
            //每次加载删除除了第一行的数据
            $("#kanbanList tr:gt(0)").remove();
            var kanbanList = SKT.LeanMES.Web.AjaxServices.AjaxKanbanManage.GetSendAll(seachSql);
            if (kanbanList.error != null) {
                return false;
            } else {
                var addHtmlStr = "";
                for (var i = 0; i < kanbanList.value.length; i++) {
                    var entity = kanbanList.value[i];
                    if (i % 2 == 0) {
                        addHtmlStr += "<tr class='ListTableEvenRow' Style='cursor: pointer;' ondblclick = 'clickOpen(" + entity.KanbanSendId + ")'>";
                    }
                    else {

                        addHtmlStr += "<tr class='ListTableOddRow' Style='cursor: pointer;' ondblclick = 'clickOpen(" + entity.KanbanSendId + ")' >";
                    }
                    addHtmlStr += "<td><input type='checkbox' id='checkBox'" + (entity.RowId) + "'' name='chkSelect'"
                              + " value =" + entity.KanbanSendId + " /></td>"
                              + "<td>" + entity.RowId + "</td>"
                              + "<td>" + entity.SendName + "</td>"
                              + "<td>" + entity.MAC + "</td>"
                              + "<td>" + entity.Location + "</td>"
                              + "<td>" + entity.KanbanName + "</td>"
                              + "<td>" + entity.UpdateBy + "</td>"
                              + "<td>" + entity.UpdateTime + "</td>"
                              + "<td>" + entity.Remark + "</td>"

                       + "</tr>";
                }
                $("#kanbanList").append(addHtmlStr);
            }
        }

        //查看
        function View() {
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/Kanban.aspx");
        }

        //看板终端
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/KanbanSend/KanbanMacEdit.aspx?name=Kanban_KanbanMacAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Kanban_KanbanMacAdd %>", src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var checkLength = $("input[name='chkSelect']:checked").length;
            if (checkLength > 1) {
                alert("只能选择一条记录!");
                return false;
            } else if (checkLength == 0) {
                alert("请选择记录!");
                return false;
            }
            var idStr = $("input[name='chkSelect']:checked").val();
            if (idStr == "") { alert("请选择记录!"); return false; }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/KanbanSend/KanbanMacEdit.aspx?name=Kanban_KanbanMacEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Kanban_KanbanMacEdit %>", src: openWinUrl, width: 600, height: 400 });
        }


        function Delete() {
            var sendIdstr = "";
            $("input[name='chkSelect']:checkbox:checked").each(function () {
                sendIdstr += $(this).val() + ",";
            })
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>'
            if (sendIdstr == "") {
                alert("请选择对应的记录!");
                return false;
            }
            var tagEntity = SKT.LeanMES.Web.AjaxServices.AjaxKanbanManage.DeleteSend(sendIdstr, userName);
            if (tagEntity.error != null) {
                alert(tagEntity.error.Message);
                return false;
            } else {
                alert("删除成功!");
            }
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }

        //给treeVieww增加双击事件，弹出编辑窗口
        $("#TreeKanBan span:gt(0)").dblclick(function () {
            var kanbanSendId = $(this).attr("href");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/KanbanSend/KanbanMacEdit.aspx?name=Kanban_KanbanMacEdit&ID=" + kanbanSendId;
            dialog({ title: "<%=Resources.Pages.Kanban_KanbanMacEdit %>", src: openWinUrl, width: 600, height: 400 });
        })


        //导出
        function Import() {
            $("#hdnOperate").val("ExportExcel");
            var seachSql = GetSearchSql();
            $("#hdnSql").val(seachSql);
            document.forms[0].submit();
            $("#hdnOperate").val("");
            $("#hdnSql").val("");
            //ImportTable('kanbanList');
        }

        //导出
        //第五种方法  
        var idTmr;
        function getExplorer() {
            var explorer = window.navigator.userAgent;
            //ie  
            if (explorer.indexOf("MSIE") >= 0) {
                return 'ie';
            }
                //firefox  
            else if (explorer.indexOf("Firefox") >= 0) {
                return 'Firefox';
            }
                //Chrome  
            else if (explorer.indexOf("Chrome") >= 0) {
                return 'Chrome';
            }
                //Opera  
            else if (explorer.indexOf("Opera") >= 0) {
                return 'Opera';
            }
                //Safari  
            else if (explorer.indexOf("Safari") >= 0) {
                return 'Safari';
            }
        }


        function ImportTable(tableid) {
            if (getExplorer() == 'ie') {
                var curTbl = document.getElementById(tableid);
                var oXL = new ActiveXObject("Excel.Application");
                var oWB = oXL.Workbooks.Add();
                var xlsheet = oWB.Worksheets(1);
                var sel = document.body.createTextRange();
                sel.moveToElementText(curTbl);
                sel.select();
                sel.execCommand("Copy");
                xlsheet.Paste();
                oXL.Visible = true;

                try {
                    var fname = oXL.Application.GetSaveAsFilename("Excel.xls", "Excel Spreadsheets (*.xls), *.xls");
                } catch (e) {
                    print("Nested catch caught " + e);
                } finally {
                    oWB.SaveAs(fname);
                    oWB.Close(savechanges = false);
                    oXL.Quit();
                    oXL = null;
                    idTmr = window.setInterval("Cleanup();", 1);
                }

            }
            else {
                tableToExcel(tableid)
            }
        }

        var tableToExcel = (function () {
            var uri = 'data:application/vnd.ms-excel;base64,',
                    template = '<html><head><meta charset="UTF-8"></head><body><table border="1">{table}</table></body></html>',
                    base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) },
                    format = function (s, c) {
                        return s.replace(/{(\w+)}/g,
                                function (m, p) { return c[p]; })
                    }
            return function (table, name) {
                if (!table.nodeType) table = document.getElementById(table)
                var ctx = { worksheet: name || 'Worksheet', table: table.innerHTML }
                window.location.href = uri + base64(format(template, ctx))
            }
        })()

    </script>
</asp:Content>
