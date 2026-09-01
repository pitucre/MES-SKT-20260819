<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportDesign.aspx.cs" MasterPageFile="~/Masters/EditMaster.master"
    Inherits="SKT.LeanMES.Web.Report.ReportDesign" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <link href="../Content/plugin/JGrid/skins/Silvery/css/Jgrid.css" rel="stylesheet"
        type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/JGrid/js/plugins/JGrid.min.js"
        type="text/javascript"></script>
    <style type="text/css">
        .leftmenu-group-item-toggle
        {
            width: 9px;
            height: 10px;
            background: url(../Content/theme/Metro/images/ico_bg.png) -154px -286px no-repeat;
            right: 17px;
            cursor: pointer;
            top: 10px;
            position: absolute;
        }
        .leftmenu-group-item-toggle-selected
        {
            width: 9px;
            height: 10px;
            background: url(../Content/theme/Metro/images/ico_bg.png) -154px -275px no-repeat;
            right: 17px;
            cursor: pointer;
            top: 10px;
            position: absolute;
        }
        .divHeader-bottom-border
        {
            border-bottom: 1px solid #d3d3d3;
        }
        #divPreView
        {
            border-left: 1px solid #d3d3d3;
            border-right: 1px solid #d3d3d3;
        }
    </style>
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current">报表信息</li>
            <li>设计报表</li>
        </ul>
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <table width="100%" class="EditeContentTable">
                <tr class="ReportInfo">
                    <td class="Label1">
                        报表名称(中文)<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtReportCNName" runat="server" IsRequired="1" MaxLength="20" CssClass="TextBox"></asp:TextBox>
                        <asp:HiddenField ID="hdnReportName" runat="server" />
                    </td>
                </tr>
                <tr class="ReportInfo">
                    <td class="Label1">
                        报表名称(英文)<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtReportENName" runat="server" IsRequired="1" MaxLength="20" CssClass="TextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr class="ReportInfo">
                    <td class="Label1">
                        报表图标
                    </td>
                    <td class="Field1">
                        <span id="reportIcon" style="vertical-align: middle">无</span><span style="margin-left: 5px;"><a
                            href="javascript:void(0)" onclick="chooseIcon();">选择图标</a></span>
                        <asp:HiddenField ID="hdnIcon" runat="server" />
                    </td>
                </tr>
                <tr class="ReportInfo">
                    <td class="Label1">
                        <%=Resources.lang.Sequence %>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtSequence" runat="server" CssClass="NumericBox50" Text="0" onkeyup="this.value=this.value.replace(/\D/g,'')"
                            onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
                    </td>
                </tr>
                <tr class="ReportInfo">
                    <td class="Label1">
                        报表类型<em>*</em>
                    </td>
                    <td class="Field1">
                        <SKTControl:ReportDDL runat="server" ID="ddlReport" IsRequired="1" ClientIDMode="Static">
                        </SKTControl:ReportDDL>
                    </td>
                </tr>
                <tr class="ReportInfo">
                    <td class="Label1">
                        <%=Resources.lang.Description %>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtTmplDesc" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
            </table>
             </div>
        <!--设计报表-->
        <div>
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label1" align="left">
                        请选择报表数据源：<em>*</em>
                    </td>
                    <td class="Field1" align="left">
                        <asp:TextBox ID="txtTable" runat="server"  IsRequired="1" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                            Width="250px">
                        </asp:TextBox><input type="button" id="btnSelect" class="ButtonBox" style="width: 65px;
                            line-height: 12px; background: #ccc; font-size: 12px;" value="选择数据源" title="点击选择报表数据源"
                            onclick="openChoosePage(this);" />
                        <asp:HiddenField ID="hfDsTableID" runat="server" Value="-1" ClientIDMode="Static" />
                        <span id="divHideEdit" style="display: none">
                            <input class="SearchButton" id="btnPreview" type="button" value="预览" onclick="rptPreView()" /></span>
                    </td>
                </tr>
            </table>
            <div class="clear5">
            </div>
            <div id="divEdit" align="center">
            </div>
            <div class="clear5">
            </div>
            <div id="divPreView" align="center">
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var reportId = '<%=Request.QueryString["ID"] %>';
        var rowJson = '';
        var rowObj;
        var userPageSize = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().Linage %>';
        $(function () {
            $(document).keydown(function (e) {
                if (e.which == 83 && e.ctrlKey) {
                      Saved();

                }
            });

            $("#chkShowAll").live("click", function () {
                if ($("#chkShowAll").is(":checked")) {
                    $(".colShow").attr('checked', 'checked');

                } else {
                    $(".colShow").removeAttr('checked');
                }
            });
        });
        function ShowTable(obj) {
            $("#tbEdit").toggle();  //BirongLiang  bugfix 2017-01-10 隐藏列表的动画效果比JGrid生成慢会导致JGrid高度太小
            if ($(obj).hasClass("leftmenu-group-item-toggle-selected")) {
                $(obj).attr("title", "展开");
                $(obj).removeClass("leftmenu-group-item-toggle-selected");
                $(obj).parent().parent().addClass("divHeader-bottom-border");
            }
            else {
                $(obj).attr("title", "折叠");
                $(obj).addClass("leftmenu-group-item-toggle-selected");
                $(obj).parent().parent().removeClass("divHeader-bottom-border");
            }
        }
        function Saved() {
            var _rtId = reportId;
            var _reportCNName = $("#<%=this.txtReportCNName.ClientID %>").val();
            var _reportENName = $("#<%=this.txtReportENName.ClientID %>").val();
            var _reportIcon = $("#<%=this.hdnIcon.ClientID %>").val();
            var _reportSequence = $("#<%=this.txtSequence.ClientID %>").val();
            var _rtName = $("#<%=this.hdnReportName.ClientID %>").val();
            var _rtDescription = $("#<%=this.txtTmplDesc.ClientID %>").val();
            //保存代码
            //var _rtContent = document.getElementById("ifCtrl").contentWindow.getData();
            var _rtContent = newReportHtml();
            var _reportType = $("#ddlReport").val();
            var _currentUser = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

            //报表中文名不能为空
            if ($.trim(_reportCNName) == "") {
                alert("<%=Resources.Messages.ReportCNNameIsNull %>");
                $("#<%=this.txtReportCNName.ClientID %>").focus();
                return false;
            }
            //报表英文名不能为空
            if ($.trim(_reportENName) == "") {
                alert("<%=Resources.Messages.ReportENNameIsNull %>");
                $("#<%=this.txtReportENName.ClientID %>").focus();
                return false;
            }
            //报表类型不能为空
            if ($.trim(_reportType) == "") {
                alert("<%=Resources.Messages.ReportTypeIsNull %>");
                return false;
            }
            if ($("#txtTable").val() === '') {
                alert("请选择数据源");
                return false;
            }
            var entity = {};
            entity.TemplateId = _rtId;
            entity.ReportCNName = _reportCNName;
            entity.ReportENName = _reportENName;
            entity.ReportIcon = _reportIcon;
            entity.ReportSequence = _reportSequence;
            entity.TemplateName = _rtName;
            entity.TemplateDesc = _rtDescription;
            entity.TemplateContent = _rtContent;
            entity.ReportType = _reportType;
            entity.CreateBy = _currentUser;
            entity.ModifyBy = _currentUser;
            entity.DesignJson = getEdit();
            entity.TemplateCategory = 1;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxReport.EditReportTemplate(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
              
                return false;
            }

            alert("<%=Resources.Messages.SaveInSuccess %>");
            window.parent.UpdateList(_reportCNName);
        }


        //选择图标
        function chooseIcon() {
            dialog({ title: '<%=Resources.lang.ChooseIcon %>', src: 'ChooseIcon.aspx', width: 400, height: 300 });
        }

        //显示选中的图标
        function setIcon(icon, iconname) {
            $("#reportIcon").html("<img src='" + icon + "'/>");
            $("#<%=this.hdnIcon.ClientID %>").val(iconname);
            closeDialog();
        }

        function openChoosePage(obj) {
            //BirongLiang 2017-1-10 使用系统通用数据源维护
            var searchSettings = escape(" UseTypeID IN (N'Report')");
            dialog({ title: "<%=Resources.Common.ChooseWindow %>"
//            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=68&Multiple=false&CallBackFunc=getChooseValue&PageCondition=" + searchSettings + "&rnd=" + Math.random()
            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=115&Multiple=false&CallBackFunc=getChooseValue&PageCondition=" + searchSettings + "&rnd=" + Math.random()
            , width: 600, height: 300
            });
        }
        function getChooseValue(list) {
            //$("#<%=this.txtTable.ClientID %>").val(list[0][2]);
            $("#<%=this.txtTable.ClientID %>").val(list[0][5]);
            $("#<%=this.hfDsTableID.ClientID %>").val(list[0][0]);
            if (list[0][0] * 1 > 0) {
                showEdit(list[0][5]);
                $("#divHideEdit").css("display", "");
            }
        }

        function showEdit(table) {
            var ajxService = SKT.LeanMES.Web.AjaxServices.AjaxReport.GetDsTableCol(table);
            var strHtml = '';
            if (ajxService.error != null) {
                alert(ajxService.error.Message);
                return false;
            } else {
                rowJson = ajxService.value;
                rowObj = $.parseJSON(rowJson);

                strHtml += '<table id="tbEdit" class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;min-width: 760px; width: 100%; border-collapse: collapse;">' +
                    '<thead class="ListTableHeader"><tr><th align=center style="width: auto">字段名</th>' +
                    '<th align=center style="width: auto">字段描述</th>' +
                    '<th align=center style="width:15%">报表列名</th>' +
                    '<th align=center style="width:8%">显示<span align=right><input type="checkbox" checked="checked" id="chkShowAll"/></span></th>' +
                    '<th align=center style="width:8%">查询条件</th>' +
                    '<th align=center style="width:20%; display:none">过滤条件</th>' +
                    '<th align=center style="width:10%">列宽(px)</th>' +
                    '<th align=center style="width:20%; display:none">查询类型</th>' +
                    '<th align=center style="width:5%">排序</th>' +
                    '<th align=center style="width:15%">文本框样式</th>' +
                    '<th align=center style="width:20%; display:none">字段名类型</th>' +
                    '</tr></thead><tbody>';
                for (var i = 0; i < rowObj.length; i++) {
                    var tj="";
                    if(rowObj[i].DataType=="时间类型"){
                        tj="<input type='text' id='txtStartTime' style='width: 140px' class='DateTimeBox' /> -- <input type='text' id='txtEndTime' style='width: 140px' class='DateTimeBox' />";
                    }else{
                        tj="<input type='text' class='colWhere'/>"
                    }             

                    strHtml += "<tr class='ListTableOddRow'>" +
                        "<td align=center class='colSort'>" + rowObj[i].ItemValue + "</td>";
                    strHtml += "<td align=center>" + rowObj[i].ItemName + "</td>";
                    strHtml += "<td align=center><input type='text' maxlength='20' class='colText' value='" + rowObj[i].ItemValue + "'/></td>";
                    strHtml += "<td align=center><input type='checkbox' checked='checked' class='colShow'/></td>";
                    strHtml += "<td align=center><input type='checkbox' class='colSelWhere'/></td>";
                    strHtml += "<td align=center style='display:none' class='DataType'>" + rowObj[i].DataType + "</td>";
                    strHtml += "<td align=center><input type='text' maxlength='5' " +
                        " onkeyup=\"this.value=this.value.replace(\/\\D/g,'')\" " +
                        " onafterpaste=\"this.value=this.value.replace(\/\\D/g,'')\" " +
                        "class='colWidth' value='180'/></td>";
                    strHtml += "<td align=center style='display:none'><input type='text' class='colClass'/></td>";
                    strHtml +=
                        "<td align=center><a href='#' onclick='up(this)'><img src='../Content/images/arrowUp.gif' /></a>" +
                        "<a href='#' onclick='down(this)'><img src='../Content/images/arrowDown.gif'/></td></a>";
                    strHtml += "<td align=center><input type='text' maxlength='20' class='colCssClass' value='" + (rowObj[i].colCssClass || "") + "'/></td>";
                    strHtml +=  "</tr>";
                }
                strHtml += "</tbody></table>";
                var tbHeader = '<div class="divHeader" id="divHeader" style="text-align:left;">配置数据源<span style="float:right; margin-right:10px;"><span class="leftmenu-group-item-toggle leftmenu-group-item-toggle-selected" id="collapseBtn" onclick="ShowTable(this)" title="折叠"></span></span></div>';
                $("#divEdit").html(tbHeader + strHtml);
                //Output for test
                getEdit();
            }
        }
        function up(obj) {
            var objParentTR = $(obj).parent().parent();
            var prevTR = objParentTR.prev();
            if (prevTR.length > 0) {
                prevTR.insertAfter(objParentTR);
            }
        }
        function down(obj) {
            var objParentTR = $(obj).parent().parent();
            var nextTR = objParentTR.next();
            if (nextTR.length > 0) {
                nextTR.insertBefore(objParentTR);
            }
        }
        var getEdit = function () {
            var arrList = [];
            var entity = {};
            var sorting = '';
            var dataSource = $("#<%=this.txtTable.ClientID %>").val();
            $("#tbEdit tbody tr")
                .each(function () {
                    entity = {};
                    entity.colName = $(this).find(".colSort").html();
                    entity.colText = $(this).find(".colText").val();
                    entity.colShow = $(this).find(".colShow").is(":checked") ? '1' : '0';
                    entity.colSelect = $(this).find(".colSelWhere").is(":checked") ? '1' : '0';
                    entity.colCondition = $(this).find(".colWhere").val();
                    entity.colWidth = $(this).find(".colWidth").val() * 1 > 0 ? $(this).find(".colWidth").val() * 1 : 180;
                    entity.colCssClass = $(this).find(".colCssClass").val();
                    entity.dataType = $(this).find(".DataType").html();

                    arrList.push(entity);
                    sorting += entity.colName + ',';
                });
            sorting = sorting.slice(0, -1);
            return [JSON.stringify(arrList), sorting, dataSource];
        }

        function rptPreView() {
            var data = getEdit();
            var entity = $.parseJSON(data[0]);
            var sorting = data[1];
            var rptTable = $("#<%=this.txtTable.ClientID %>").val();
            var cols = [];
            for (var i = 0; i < entity.length; i++) {
                if (entity[i].colShow * 1 === 1) {
                    var col = {};
                    col.display = entity[i].colText;
                    col.name = entity[i].colName;
                    col.align = 'center';
                    col.width = isNaN(entity[i].colWidth) ? 150 : entity[i].colWidth;
                    col.minWidth = 60;
                    cols.push(col);
                }
            }
            if (cols.length === 0) {
                alert("请勾选需显示列内容");
                return false;
            }
            //$("#divEdit").hide();
            ShowTable($("#collapseBtn"));
            //console.log(JSON.stringify(cols));
            //Must Replace Html to Clear Table First

            var tbHeader = '<div class="divHeader" id="preDivHeader" style="text-align:left;">预览报表</div>';
            $("#divPreView").replaceWith("<div id='divPreView'></div>");
            $("#preDivHeader").remove();
            $("#divPreView").before(tbHeader);
            var grid = $("#divPreView")
                .SktMesGrid({
                    columns: cols,
                    width: '99.8%',
                    height: '98%',
                    dataAction: 'Preview', 
                    dataSource: rptTable,
                    conditions: "",
                    rowNumbers: true,
                    //conditions: " AND OrderTypeID ='2' ",    
                    paramters: '',
                    pageSize: userPageSize,
                    sortName: sorting
                });
            newReportHtml();
        }

        function newReportHtml() {
            var title = $("#<%=this.txtReportCNName.ClientID %>").val();
            var data = getEdit();
            var entity = $.parseJSON(data[0]);                      //userEdit object
            var cols = [];
            var rptTable = $("#<%=this.txtTable.ClientID %>").val();
            var sorting = data[1];                                  //Report sorting
            var strCode = '<p style="height:30px;background-color:#f1f1f1; padding:5px; text-align:center; ' +
                'font-weight:bold; font-size:16px; border-top:1px solid #d3d3d3; ' +
                'border-left:1px solid #d3d3d3; border-right:1px solid #d3d3d3; ">' + title + '</p>' +
                '<div class="EditContentTable" style="line-height:22px;">';            //HTML for InputSearch
            var strJS_Con = '';
            var strJS_Bind = '';
            var strJS_Excel = '';
            var strScript = '<script type="text/javascript">';         // JavaScript
            strScript += '$("#bnView").click(function () {' +
                            'var conds = ""; var conds2 = ""; ';
            var selecteFields = ""; //Add By Alen 2016-08-17 报表查询的列字符串
            for (var i = 0; i < entity.length; i++) {
                //构造查询选项HTML，获取选项值JS
                if (entity[i].colSelect * 1 === 1) {
                    strCode += '<div style="width:auto; float:left; padding:3px;"><div style="width:65px; line-height:24px; float:left; text-align:right; overflow:hidden;white-space: nowrap; padding:0px 5px 0px 0px;" title="' + entity[i].colText + '">';
                    strCode += entity[i].colText + '：</div><div style=" float:left; overflow:hidden;padding:0px 0px 0px 0px;" title="' + entity[i].colText + '">'; //查询字段名                   
                    strCode += '{0}</div>'; //查询条件输入框
                    strCode += '</div>';
                    //-----------------------------
                    strJS_Bind += 'var ' + entity[i].colName + ' = $("#' + entity[i].colName + '").val();';

                    //----------------------------- var orderid =$("#orderid").val()
                    //2018-1-6 hufang 简易报表字段名如果是时间类型，则查询具体某一区间的数据
                    var typeStr = "";
                    if (entity[i].dataType == "时间类型") {
                        typeStr = '<input type="text" id="start' + entity[i].colName + '" style="width: 100px" class="DateTimeBox" /> --- <input type="text" id="end' + entity[i].colName + '" style="width: 100px" class="DateTimeBox" />';
                        strCode=strCode.replace('{0}', typeStr);

                        strJS_Con += ' if(start' + entity[i].colName + ' !="")' +
                   '{ conds +=" AND ' + entity[i].colName + '>= $("#start' + entity[i].colName + '").val(); }';

                        strJS_Con += ' if(end' + entity[i].colName + ' !="")' +
                   '{ conds +=" AND ' + entity[i].colName + '<= $("#end' + entity[i].colName + '").val();}';
                                          
                    } else {

                        typeStr = '<input type="text" class="TextBox ' + entity[i].colCssClass + '" value="" id="' + entity[i].colName + '" />  ';
                        strCode=strCode.replace('{0}', typeStr);

                            strJS_Con += ' if(' + entity[i].colName + ' !=="")' +
                      '{ conds2 +=" AND ' + entity[i].colName + '= N\'" + $.trim($("#' + entity[i].colName + '").val()) +"\'";' +
                      ' conds +=" AND ' + entity[i].colName + ' LIKE N\'%" + $.trim($("#' + entity[i].colName + '").val()) +"%\'";}';
                    }

                  

                }
                //=========================================
                //构造column
                if (entity[i].colShow * 1 === 1) {
                    var col = {};
                    col.display = entity[i].colText;
                    col.name = entity[i].colName;
                    col.align = 'left';
                    col.width = isNaN(entity[i].colWidth) ? 180 : entity[i].colWidth;
                    col.minWidth = 60;
                    cols.push(col);
                    selecteFields += col.name + ",";
                }
            }

            strCode += '<div style="clear: both;text-align: center;padding:5px; float:left; width:auto;">' +
               '<span style="margin-right:15px;"><input type="checkbox" id="chkEqul" name="chkEqul"/>全字匹配</span>' +
                '<span id="bnView" style="font-size: 12px; font-weight:bold; cursor: pointer; ">' +
                '<img src="../Content/images/search.png" class="imgText" style="margin-right:5px;"\/><span class="imgText">查询</span></span> ' +
                '<span id="bnImport" style="font-size: 12px; font-weight:bold; margin-left:10px;cursor: pointer;" title="导出报表到Excel"><img src="../Content/images/icon/Import.png" class="imgText" style="margin-right:5px;"/><span class="imgText">导出</span></span>' +
                '</div>' +
                '<div class="clear5"></div>' +
                '</div>' +           //EditContentTable结束标签
                '<input type="hidden" value="" id="hdnPararms" name="hdnPararms" />' +
                '<input type="hidden" value="" id="hdnPararmValue" name="hdnPararmValue" />' +
                '<input type="hidden" value="" id="hdnOperation" name="hdnOperation" />' +
                '<input type="hidden" value="" id="hdnFileName" name="hdnFileName" />' +
                '<div class="clear5"></div>' +
                '<div id="ReportList"><div class="ListTableEmptyDataRow">请输入查询条件查看报表</div></div>';
            strScript += strJS_Bind;
            strScript += strJS_Con;
            strScript += 'if($("#chkEqul").is(":checked")){conds=conds2;} ';
            //---------------------查询报表
            strScript += ' $("#ReportList").replaceWith("<div id=ReportList ></div>");';
            strScript += 'var grid = $("#ReportList").SktMesGrid({ ' +
                'columns: ' + JSON.stringify(cols) +
                ',width: "100%" ,height: "98%"' +
                ',dataAction: "TABLE" ' +
                ',dataSource: "' + rptTable + '"' +
                ',conditions: conds' +
                ',sortName: "' + sorting + '"' +
                ',selectFields:"' + selecteFields.substring(0, selecteFields.length - 1) + '"' +
                '});';
            strScript += "});";
            //---------------------
            //---------------------导出EXCEL 
            strJS_Excel += '$("#bnImport").click(function () { var conds ="";var conds2 ="";';
            strJS_Excel += strJS_Bind;
            strJS_Excel += strJS_Con;                                             //控件值获取
            strJS_Excel += '$("#hdnPararms").val("' + rptTable + '");';                   //DbTable
            strJS_Excel += '$("#hdnOperation").val("TABLE");';
            strJS_Excel += '$("#hdnPararmValue").val(conds);';
            strJS_Excel += '$("#hdnFileName").val("' + title + '");';

            strJS_Excel += 'document.forms[0].submit();' +
    '});';
            strScript += strJS_Excel;
            //---------------------
            strScript += "<\/script>";
            var finalHtml = strCode + strScript;
            //console.log(finalHtml);
            return (encodeURI(finalHtml));
            
        }

    </script>
</asp:Content>
