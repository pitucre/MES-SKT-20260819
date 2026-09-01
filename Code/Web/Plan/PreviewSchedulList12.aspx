<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="PreviewSchedulList12.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.PreviewSchedulList12" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">项目名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.Line %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>


        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.ResName %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtResName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>

            <td class="Label2">设置时间
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSetDate" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery-1.9.1.js"></script>
    <%--<script src="/Content/tableJs/jquery-1.js"></script>--%>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/tableJs/jquery.js"></script>
    <%--<script src="/Content/tableJs/moment.js"></script>--%>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/tableJs/bootstrap.css" rel="stylesheet">
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/tableJs/bootstrap.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/tableJs/bootstrap-editable.css" rel="stylesheet">
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/tableJs/bootstrap-editable.js" charset="utf-8" type="text/javascript"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/dialog/skin/default/dialog-1.0.3.css" rel="stylesheet"
        type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/dialog/js/jPlugin-dialog-2.0.js?v=160624"
        type="text/javascript"></script>

    <style type="text/css">
        #comments:hover {
            background-color: #FFFFC0;
            cursor: text;
        }
    </style>
    <script>
        var f = 'bootstrap3';
    </script>
    <script>
        var c = window.location.href.match(/c=inline/i) ? 'inline' : 'popup';
        $.fn.editable.defaults.mode = c === 'inline' ? 'inline' : 'popup';

        $(function () {
            $('#f').val(f);
            $('#c').val(c);
        });
    </script>

    <style type="text/css">
        body {
            padding-top: 50px;
            padding-bottom: 30px;
        }

        table.table > tbody > tr > td {
            height: 30px;
            vertical-align: middle;
        }

        td {
            min-width: 80px;
        }
    </style>
    <div>
        <table id="user" class="table table-bordered table-striped" style="width: 2400px">
            <tbody id="tby1">
                <tr>
                    <th>工单号</th>
                    <th>面别</th>
                    <th>工单剩余总数</th>
                    <th>已排产总数</th>
                    <th>生产线别</th>
                    <th>日产能</th>
                    <th>2019-04-21</th>
                    <th>2019-04-22</th>
                    <th>2019-04-23</th>
                    <th>2019-04-24</th>
                    <th>2019-04-25</th>
                    <th>2019-04-26</th>
                    <th>2019-04-27</th>

                </tr>
                <tr>
                    <td style="width: 100px" rowspan="7">PO20200925</td>
                    <td style="width: 50px" rowspan="7">T</td>
                    <td style="width: 100px" rowspan="7">10000</td>
                    <td style="width: 100px" rowspan="7">6000</td>
                    <tr>

                        <td style="width: 200px">
                            <input type="checkbox" />S1贴片线 </td>
                        <td style="width: 100px">2000</td>
                        <td style="width: 100px" colspan=""><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-22" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-23" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-24" data-title="Enter username" class="username editable editable-click">2000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-25" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-26" data-title="Enter username" class="username editable editable-click">0</a></td>

                    </tr>
                    <tr>

                        <td style="width: 200px">
                            <input type="checkbox" />S1贴片线 </td>
                        <td style="width: 100px">2000</td>
                        <td style="width: 100px" colspan=""><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-22" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-23" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-24" data-title="Enter username" class="username editable editable-click">2000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-25" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-26" data-title="Enter username" class="username editable editable-click">0</a></td>

                    </tr>
                    <tr>

                        <td style="width: 200px">
                            <input type="checkbox" />S2贴片线 </td>
                        <td style="width: 100px">2000</td>
                        <td style="width: 100px" colspan=""><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-22" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-23" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-24" data-title="Enter username" class="username editable editable-click">2000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-25" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-26" data-title="Enter username" class="username editable editable-click">0</a></td>

                    </tr>
                    <tr>

                        <td style="width: 200px">
                            <input type="checkbox" />S1贴片线 </td>
                        <td style="width: 100px">2000</td>
                        <td style="width: 100px" colspan=""><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-22" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-23" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-24" data-title="Enter username" class="username editable editable-click">2000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-25" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-26" data-title="Enter username" class="username editable editable-click">0</a></td>

                    </tr>
                    <tr>

                        <td style="width: 200px">
                            <input type="checkbox" />S1贴片线 </td>
                        <td style="width: 100px">2000</td>
                        <td style="width: 100px" colspan=""><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-22" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-23" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-24" data-title="Enter username" class="username editable editable-click">2000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-25" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-26" data-title="Enter username" class="username editable editable-click">0</a></td>

                    </tr>
                    <tr>

                        <td style="width: 200px">
                            <input type="checkbox" />S1贴片线 </td>
                        <td style="width: 100px">2000</td>
                        <td style="width: 100px" colspan=""><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-22" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-23" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-24" data-title="Enter username" class="username editable editable-click">2000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-25" data-title="Enter username" class="username editable editable-click">0</a></td>
                        <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-26" data-title="Enter username" class="username editable editable-click">0</a></td>

                    </tr>
                    <tr>
                        <td style="width: 100px" rowspan="4">PO20200925</td>
                        <td style="width: 50px" rowspan="4">B</td>
                        <td style="width: 100px" rowspan="4">10000</td>
                        <td style="width: 100px" rowspan="4">6000</td>
                        <tr>

                            <td style="width: 200px">
                                <input type="checkbox" />S1贴片线 </td>
                            <td style="width: 100px">2000</td>
                            <td style="width: 100px" colspan=""><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-22" data-title="Enter username" class="username editable editable-click">0</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-23" data-title="Enter username" class="username editable editable-click">0</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-24" data-title="Enter username" class="username editable editable-click">2000</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-25" data-title="Enter username" class="username editable editable-click">0</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-26" data-title="Enter username" class="username editable editable-click">0</a></td>

                        </tr>
                        <tr>

                            <td style="width: 200px">
                                <input type="checkbox" />S1贴片线 </td>
                            <td style="width: 100px">2000</td>
                            <td style="width: 100px" colspan=""><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-22" data-title="Enter username" class="username editable editable-click">0</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-23" data-title="Enter username" class="username editable editable-click">0</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-24" data-title="Enter username" class="username editable editable-click">2000</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-25" data-title="Enter username" class="username editable editable-click">0</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-26" data-title="Enter username" class="username editable editable-click">0</a></td>

                        </tr>
                        <tr>

                            <td style="width: 200px">
                                <input type="checkbox" />S1贴片线 </td>
                            <td style="width: 100px">2000</td>
                            <td style="width: 100px" colspan=""><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-22" data-title="Enter username" class="username editable editable-click">0</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-23" data-title="Enter username" class="username editable editable-click">0</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-24" data-title="Enter username" class="username editable editable-click">2000</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-21" data-title="设置排产数" class="username editable editable-click">1000</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-25" data-title="Enter username" class="username editable editable-click">0</a></td>
                            <td style="width: 100px"><a href="#" data-type="text" data-pk="25,12370,2019-04-26" data-title="Enter username" class="username editable editable-click">0</a></td>

                        </tr>
            </tbody>
        </table>
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/WorkTimeSetEdit.aspx?name=WorkTimeSetAdd&ID=-1";
            dialog({ title: "<%=Resources.lang.Add %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Plan/WorkTimeSetEdit.aspx?name=WorkTimeSetEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.lang.Edit %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function openChoosePage(flags) {
            var condition = "";
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                flags +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&rnd=" +
                Math.random(),
                width: 600,
                height: 300
            });
        }

        function getChooseValue(list) {
            $("#txtItemName").val(list[0][2]);
            $("#hdnItemId").val(list[0][0]);
        }
    </script>
</asp:Content>
