<%@ Page Language="C#" AutoEventWireup="true" Inherits="SKT.LeanMES.Web.Framework.ChoosePage"
    ViewStateMode="Disabled" CodeBehind="ChoosePage.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js" type="text/javascript"></script>
    <link href="../Content/Main.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.tablelist.js?v=20211209"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/tabSize.js"   type="text/javascript"></script>

    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/Language.ashx?cmd=GetLanguageRes&lang=<%=hfMESLang.Value %>" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/lang/lang.menu.js?v=1.0" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/lang/lang.button.js?v=1.0" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/lang/lang.label.js?v=1.0" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/lang/skt.utility.lang.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/crypto-js.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.aes.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        var _root = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
    </script>
    <title>
        <%=Resources.Common.ChooseWindow %></title>
        <style>
        .thead th {
            position: sticky;
            top: -1px;
            z-index: 999;
        }
    </style>
</head>
   
<body>
    <form id="form1" runat="server">
        <div id="divListPageHeader">
                        <table border="0" width="100%">
                            <tr>
                                <td align="right" width="40px">
                                    <select id="ddlSearch" name="ddlSearch" class="TextBox" style="width: 100px"></select>
                                </td>
                                <td>
                                    <input type="text" id="txtFindText" class="TextBox" <%--onkeypress="onFindText();"--%> /><input
                                        type="button" class="ButtonBox" value="..." onclick="searchText();" />
                                </td>
                                <td align="right">
                                    <a href="javascript:void(0);" onclick="try{ok(1);}catch(e){}" style="text-decoration: underline;">
                                        <%=Resources.Buttons.COM_Clear %></a>&nbsp;&nbsp;
                                <input id="Button1" type="button" class="SearchButton" value="<%=Resources.Buttons.COM_Select %>"
                                    onclick="try { ok(0); } catch (e) { }" />
                                </td>
                            </tr>
                        </table>
                    </div>
        <div class="ListTableTitle">
                        <asp:Localize ID="llListTitle" runat="server"></asp:Localize>
                    </div>
        <div style="overflow: auto;max-height:100%;" id="gridviewcontainer">
        <asp:GridView ID="gridView" runat="server" DataSourceID="objectDataSource">
                            </asp:GridView>
                            <asp:ObjectDataSource ID="objectDataSource" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
                                MaximumRowsParameterName="maxRows" SortParameterName="sortExpression">
                                <SelectParameters>
                                    <asp:Parameter Name="searchSettings" Type="Object" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
        </div>
        
        <asp:HiddenField ID="hdnPageCount" runat="server" Value="0" />
        <asp:HiddenField ID="hdnPageId" runat="server" Value="0" />
        <asp:HiddenField ID="hdnMultiple" runat="server" Value="1" />
        <asp:HiddenField ID="hdnReturnFields" runat="server" Value="1" />
        <asp:HiddenField ID="hdnSearchFields" runat="server" Value="" />
        <asp:HiddenField ID="hdnSearchFieldsText" runat="server" Value="" />
        <input type="hidden" value="" name="commandname" id="commandname" />
        <asp:HiddenField ID="hfMESLang" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnCsrfToken" runat="server" />
        <input type="hidden" id="<%=SKT.LeanMES.Web.AppCode.Utility.AntiXSRFHelper.AntiXsrfTokenKey %>" name ="<%=SKT.LeanMES.Web.AppCode.Utility.AntiXSRFHelper.AntiXsrfTokenKey %>" value="<%=hdnCsrfToken.Value %>" />
    </form>
    <script type="text/javascript">
        var lstTable = $("#<%=this.gridView.ClientID %> tr");
        var isMultiple = ($("#<%=this.hdnMultiple.ClientID %>").val() == "1") ? false : true;
        var pageId = $("#<%=this.hdnPageId.ClientID %>").val();
        //Sperkey.Zhong 20200108 修复选中记录后，有时仍然提示"请选择记录。"bug
        //var rowCount = $("#<%=this.gridView.ClientID %> .ListTableOddRow").length + $("#<%=this.gridView.ClientID %> .ListTableEvenRow").length;
        var rowCount = $("#<%=this.gridView.ClientID %> tr:not(.ListTableHeader)").length;
        var pageCondition = "<%= Request.QueryString["PageCondition"] %>";
        var callBackFunc = '<%= Request.QueryString["CallBackFunc"] %>';
        var hdnSearchFields = $("#<%=this.hdnSearchFields.ClientID %>").val();
        var hdnSearchFieldsText = $("#<%=this.hdnSearchFieldsText.ClientID %>").val();
        var hdnReturnFields = $("#<%=this.hdnReturnFields.ClientID %>").val();
        var RequireOperateRecord = "<%=Resources.Messages.RequireOperateRecord %>";

        function addTableHeader() {
            $("#gridviewcontainer>div").eq(0).css({ maxHeight: '100%', overflow: 'auto' }).attr('id', 'gridviewcontainer')
            /*start  表格表头拖拽*/
            var ListTableObj = $(".ListTable");
            let str = ''

            for (let i = 0; i < ListTableObj.length; i++) {
                if ($(ListTableObj[i]).find('thead').length) {
                    $(ListTableObj[i]).find('thead').addClass('ListTableHeader thead')
                    return
                }
                if ($(ListTableObj[i]).find("tr").length <= 1) {
                    $(".ListTable").addClass('gridviewcontainer')
                    return
                }

                var objTH = $(ListTableObj[i]).find("tr").eq(0);
                str = objTH.html()
                $(ListTableObj[i]).prepend(
                    '<thead class="ListTableHeader thead">' +
                    '<tr>' +
                    str
                    + '</tr>' +
                    '</thead > '
                )
                str = ''
                $(".ListTable tbody").eq(i).find("tr").eq(0).remove()
            }
        }



        $(document).ready(function () {
            var options = "";
            if (hdnSearchFieldsText != "") {
                var searchFields = JSON.parse(hdnSearchFieldsText);
                for (i = 0; i < searchFields.length; i++) {
                    options += "<option value=" + searchFields[i].Value + ">" + searchFields[i].Text + "</option>";
                }
                $("#ddlSearch").html(options);
            }

            //modify by Sperkey.Zhong 20180704 修复IE浏览器下，页总数小于1，回车查询时，无法查询的bug
            //将onkeypress="onFindText();"注释掉，改为通过Jquery来绑定keypress事件
            $("#txtFindText").bind("keypress", function (event) {
                if (event.keyCode == 13) {
                    event.preventDefault();//阻止默认行为
                    event.stopPropagation();
                    searchText();
                }
            });

            /*start  表格表头拖拽*/
            addTableHeader()

            //for (var i = 0; i < ListTableObj.length; i++) {
            //    var objTH = $(ListTableObj[i]).find("th");
            //    for (var j = 0; j < objTH.length; j++) {
            //        $(objTH[j]).attr('width', $(objTH[j]).css('width').replace("px", ""));
            //        $(objTH[j]).css('width', '');

            //    }
            //    var tableId = $(ListTableObj[i]).attr("id");
            //    if ("undefined" != typeof (tableId)) {
            //        /*$("#" + tableId).fixedHeader();*/
            //        tabSize.init(tableId);
            //    }
            //}

            /*end  表格表头拖拽*/

            /*start  表格表头固定*/
            var table = $(".ListTable:eq(0)");
            if (table == null || table == undefined) {
                return false;
            }
            var tableId = table.attr("id");

            if ("undefined" == typeof (tableId)) {
                return false;
            }
            var objTH = table.find("th");
            for (var j = 0; j < objTH.length; j++) {
                $(objTH[j]).attr('width', $(objTH[j]).css('width').replace("px", ""));
                $(objTH[j]).css('width', '');
            }
            $("#" + tableId).fixedHeader();

            /*end  表格表头固定*/

            initListHeight();
        });

        $(window).resize(function () {
            initListHeight();
            setTimeout(function () {
                $(".ListTable:eq(0) tr:first th").each(function (i, obj) {
                    if (!window.ActiveXObject && !("ActiveXObject" in window)) {
                        $("#footerTR th:eq(" + i + ")").width($(obj).width() + 1);
                    }
                    else {
                        $("#footerTR th:eq(" + i + ")").width($(obj).width());
                    }
                });
                $("#footerTR").width($(".ListTable").width());
            }, 100);
        });

        function initListHeight() {
            var h = $(window).height() - 60;
            $("#gridviewcontainer").css("height", h + "px");
            $("#footerTR").css("top", 55);
        }

        function goPage() {
            $("#commandname").val("go");
            document.forms[0].submit();
        }
    </script>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.choosepage.js?v=1"></script>
</body>
</html>
