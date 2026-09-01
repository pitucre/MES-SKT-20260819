<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="ImportMenu.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.ImportMenu" %>


<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server" ViewStateMode="Enabled">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">系统模块</td>
            <td class="Field2" colspan="3">
                <asp:DropDownList runat="server" ID="ddlSearch">
                    <asp:ListItem Value="-1">全部</asp:ListItem>
                    <asp:ListItem Value="SYS_SystemInfo">系统管理</asp:ListItem>
                    <asp:ListItem Value="LeanMES_BasalInfo">基础管理</asp:ListItem>
                    <asp:ListItem Value="LeanMES_Production">生产管理</asp:ListItem>
                    <asp:ListItem Value="LeanMES_Store">仓库管理</asp:ListItem>
                    <asp:ListItem Value="LeanMES_Quality">品质管理</asp:ListItem>
                    <asp:ListItem Value="LeanMES_Equipment">设备管理</asp:ListItem>
                    <asp:ListItem Value="LeanMES_Report">BI中心</asp:ListItem>
                    <asp:ListItem Value="LeanMES_Kanban">看板管理</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="center">
                <input type="button" id="searchSubmit" value="查询" onclick="doSearch()"
                    class="SearchButton" title="<%=Resources.lang.Search %>" />
                <input type="button" id="Button1" value="导出" onclick="Import()" class="SearchButton"
                    title="导出" />
            </td>
        </tr>
    </table>

    <div id="MenuList" runat="server">
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function doSearch() {
            $("#hdnOperate").val("search");
            document.forms[0].submit();
        }
        //导出
        function Import() {
            ImportTable('table1');
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
