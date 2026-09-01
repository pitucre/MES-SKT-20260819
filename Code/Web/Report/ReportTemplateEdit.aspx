<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="ReportTemplateEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Report.ReportTemplateEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current">报表信息</li>
            <li id="tabCodeDesign">设计报表</li>
            <li id="tabEasyDesign">设计报表</li>
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
                        <asp:TextBox ID="txtReportENName" runat="server"  IsRequired="1"  MaxLength="20" CssClass="TextBox"></asp:TextBox>
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
                        <SKTControl:ReportDDL runat="server" ID="ddlReport"  IsRequired="1"  ClientIDMode="Static">
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
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label" align="left" id="spCodeMes" colspan="2">
                        <input type="button"  class="AdaptButton"  style="float: right; color: #cccccc;margin:2px;width:80px;border:1px;" value="预览" onclick="preview()" />   
                    </td>
                </tr>
                <tr>
                    <td class="Label" align="left" colspan="2">
                        <span style="float: left; font-weight: bold; padding-left: 10px;">设计报表&nbsp;&nbsp;</span>
                        
                        <span style="float: right; color: #cccccc">编辑器版本 1.0.1</span>
                    </td>
                </tr>
                <tr>
                    <td class="Field" align="left" colspan="2" style="padding: 0px;">
                        <div id="loadingmsg" class="loadingmessage">
                            <%=Resources.Messages.LoadingData %></div>
                        <iframe id="ifCtrl" name="ifCtrl" frameborder="0" width="100%" height="195px" marginheight="0"
                            marginwidth="0" scrolling="auto" src=""></iframe>
                        <asp:HiddenField ID="hdnValue" runat="server" Value="" />
                    </td>
                </tr>
            </table>
        </div>
        <!--简易设计编辑-->
        <div>
            <table width="100%" class="EditeContentTable" id="tbDataSource">
                <tr>
                    <td class="Label1" align="left">
                        数据源：
                    </td>
                    <td class="Field1" align="left">
                        <%--                        <asp:TextBox ID="txtTable" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                            Width="25%">
                        </asp:TextBox>--%>
                        <input type="text" style="display: none" id="txtTable" />
                        <%--                        <input type="button" id="btnSelect" class="ButtonBox" value="..." title="Select"
                            onclick="openChoosePage(this);" />--%>
                        <%--                        <asp:HiddenField ID="hfDsTableID" runat="server" Value="-1" ClientIDMode="Static" />
                        <input class="SearchButton" id="btnPreview" type="button" value="预览" onclick="rptPreView()" />
                        <span id="divHideEdit" style="display: none"><a href="#" onclick="ShowTable()">折起/展开</a></span>--%>
                    </td>
                </tr>
            </table>
            <div class="clear5">
            </div>
            <div id="divEdit" align="center">
            </div>
        </div>
    </div>
    <asp:HiddenField runat="server" ID="hfDesignJson" Value="" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfUpdateDJ" Value="0" ClientIDMode="Static" />
     <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script type="text/javascript">
        var reportId = '<%=Request.QueryString["ID"] %>';

        $(function () {
            $(document).keydown(function (e) {
                if (e.which == 83 && e.ctrlKey) {
                    Save();
                }
            });
            //高级报表设计，隐藏简易设计器
            if (reportId === '-1') {
                $("#tabEasyDesign").hide();
            }
            if ($("#hfDesignJson").val() !== "" && reportId !== '-1') {
                //EasyDesign
                $("#tabCodeDesign").hide();
                ShowDesignEdit();
            } else {
                $("#tabEasyDesign").hide();
            }
            var iframes = document.getElementById("ifCtrl");
            iframes.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/highlight/htmlmixededitor.aspx?rnd=" + Math.random();
            var values = $("#<%=this.hdnValue.ClientID %>").val();
            if (iframes.attachEvent) {
                iframes.attachEvent("onload", function () {
                    $("#loadingmsg").hide();
                
                    if (values != "") {
                        iframes.contentWindow.setData(values);
                    }
                    else {
                        iframes.contentWindow.setData("<div>你可以在此编辑您的HTML代码</div>\n<script type='text/javascript'>/*您可以在此写入您的js代码*/<\/script>");
                    }
                    setCodeHeight();
                });
            }
            else {
                iframes.onload = function () {
                    $("#loadingmsg").hide();
                    if (values != "") {
                        iframes.contentWindow.setData(values);
                    }
                    else {
                        iframes.contentWindow.setData("<div>你可以在此编辑您的HTML代码</div><script type='text/javascript'>/*您可以在此写入您的js代码*/<\/script>");
                    }
                    setCodeHeight();
                };
            }


            $("#chkShowAll").live("click", function () {
                if ($("#chkShowAll").is(":checked")) {
                    $(".colShow").attr('checked', 'checked');

                } else {
                    $(".colShow").removeAttr('checked');
                }
            });
        });
        //构造简易报表编辑器
        function ShowDesignEdit() {
            var strJsonArr = [];
            if ($("#hfDesignJson").val() !== "" && reportId !== '-1') {
                $("#hfUpdateDJ").val(1); //有简易设计记录，并且不是新增报表，设置更新标识为1
                eval("strJsonArr = " + $("#hfDesignJson").val());
                //$("#spCodeMes").html("<span class='infoTips' style='font-size:larger;'>此报表代码通过简易设计器生成，无需编辑</span>");
                $("#tabCodeDesign").hide();
                var rowEntity = $.parseJSON(strJsonArr[0]);
                var sorting = strJsonArr[1];
                var dataSource = strJsonArr[2];
                $("#txtTable").val(dataSource);
                $("#txtTable").after(dataSource);
                var strHtml = '';
                strHtml += ' ' +
                    '<table id="tbEdit" class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;min-width: 760px; width: 100%; border-collapse: collapse;">' +
                    '<thead class="ListTableHeader"><tr><th align=center style="width: auto">字段名</th>' +
                //'<th style="width: auto">字段描述</th>' +
                    '<th align=center style="width:15%">报表列名</th>' +
                    '<th align=center style="width:8%">显示<span align=right><input type="checkbox" checked="checked" id="chkShowAll"/></span></th>' +
                    '<th align=center style="width:8%">查询条件</th>' +
                    '<th align=center style="width:20%; display:none">过滤条件</th>' +
                    '<th align=center style="width:10%">列宽(px)</th>' +
                    '<th style="width:20%; display:none">查询类型</th>' +
                    '<th align=center style="width:5%">排序</th>' +
                    '<th align=center style="width:15%">文本框样式</th>' +               
                    '</tr></thead><tbody>';
                for (var i = 0; i < rowEntity.length; i++) {
                    strHtml += "<tr class='ListTableOddRow'>" +
                        "<td align=center class='colSort'>" +
                        rowEntity[i].colName +
                        "</td>";
                    //strHtml += "<td align=center>" + rowEntity[i].ItemName + "</td>";
                    strHtml += "<td align=center><input type='text' class='colText' maxlength='50' value='" +
                        rowEntity[i].colText + "'/></td>";
                    if (rowEntity[i].colShow * 1 === 1) {
                        strHtml += "<td align=center><input type='checkbox' checked='checked' class='colShow'/></td>";
                    } else {
                        strHtml += "<td align=center><input type='checkbox' class='colShow'/></td>";
                    }
                    if (rowEntity[i].colSelect * 1 === 1) {
                        strHtml += "<td align=center><input type='checkbox' checked='checked' class='colSelWhere'/><input type='text' value='"+rowEntity[i].dataType +"' style='display:none' class='dataType'/></td>";
                    } else {                      
                        strHtml+="<td align=center><input type='checkbox' class='colSelWhere'/><input type='text' value='"+rowEntity[i].dataType +"' style='display:none' class='dataType'/></td>";
                    }
                    strHtml += "<td align=center style='display:none'><input type='text' value='" +
                        rowEntity[i].colCondition +
                        " class='colWhere'/></td>";
                    strHtml += "<td align=center><input type='text' maxlength='5' class='colWidth' " +
                        " onkeyup=\"this.value=this.value.replace(\/\\D/g,'')\" " +
                        " onafterpaste=\"this.value=this.value.replace(\/\\D/g,'')\" " +
                        "value='" + rowEntity[i].colWidth +"'/></td>";
                    strHtml += "<td align=center style='display:none'><input type='text' class='colClass'/></td>";
                    strHtml +=
                        "<td align=center><a href='#' onclick='up(this)'><img src='../Content/images/arrowUp.gif' /></a>" +
                        "<a href='#' onclick='down(this)'><img src='../Content/images/arrowDown.gif'/></td></a>";
                    strHtml += "<td align=center><input type='text' maxlength='20' class='colCssClass' value='" + (rowEntity[i].colCssClass || "") + "'/></td>";
                    strHtml +=  "</tr>";
                }
                strHtml += "</tbody></table>";
                $("#divEdit").html(strHtml);

            } else {
                $("#divEdit").html("<div class='infoTips'>此报表不能通过简易生成器编辑</div>");
                $("#tabEasyDesign,#spCodeMes").hide();
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

        //获取编辑数据
        var getEdit = function () {
            var arrList = [];
            var entity = {};
            var sorting = '';
            var dataSource = $("#txtTable").val();
            $("#tbEdit tbody tr")
                .each(function () {
                    entity = {};
                    entity.colName = $(this).find(".colSort").html();
                    entity.colText = $(this).find(".colText").val();
                    entity.colShow = $(this).find(".colShow").is(":checked") ? '1' : '0';
                    entity.colSelect = $(this).find(".colSelWhere").is(":checked") ? '1' : '0';
                    entity.colCondition = $(this).find(".colWhere").val();
                    entity.colWidth = $(this).find(".colWidth").val() * 1 > 0 ? $(this).find(".colWidth").val() * 1 : 200;
                    entity.colCssClass = $(this).find(".colCssClass").val();
                    entity.dataType=$(this).find(".dataType").val();
                    
                    arrList.push(entity);
                    sorting += entity.colName + ',';
                });
            sorting = sorting.slice(0, -1);
            return [JSON.stringify(arrList), sorting, dataSource];
        }

        //保存
        function Save() {
            debugger;
            var _rtId = reportId;
            var _reportCNName = $("#<%=this.txtReportCNName.ClientID %>").val();
            var _reportENName = $("#<%=this.txtReportENName.ClientID %>").val();
            var _reportIcon = $("#<%=this.hdnIcon.ClientID %>").val();
            var _reportSequence = $("#<%=this.txtSequence.ClientID %>").val();
            var _rtName = $("#<%=this.hdnReportName.ClientID %>").val();
            var _rtDescription = $("#<%=this.txtTmplDesc.ClientID %>").val();
            var _rtContent = document.getElementById("ifCtrl").contentWindow.getData();
            if ($("#hfUpdateDJ").val() * 1 === 1) {
                _rtContent = newReportHtml();
            }
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

            var entity = {};
            entity.TemplateId = _rtId;
            entity.ReportCNName = _reportCNName;
            entity.ReportENName = _reportENName;
            entity.ReportIcon = _reportIcon;
            entity.ReportSequence = _reportSequence;
            entity.TemplateName = _rtName !== '' ? _rtName : '0';
            entity.TemplateDesc = _rtDescription;
            entity.TemplateContent = _rtContent;
            entity.ReportType = _reportType;
            entity.CreateBy = _currentUser;
            entity.ModifyBy = _currentUser;
            entity.DesignJson = getEdit();
         
            if (reportId === '-1') {
                entity.DesignJson = '';//新增高级报表的情况
                entity.TemplateCategory = 2;
            }
            if ($("#hfDesignJson").val() == "" && reportId !== '-1') {
                entity.DesignJson = '';  //高级报表编辑,DesignJson保持为空
            }
          
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxReport.EditReportTemplate(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("<%=Resources.Messages.SaveInSuccess %>");
            window.parent.UpdateList(_reportCNName);
        }

        //自动生成报表代码
        var newReportHtml = function () {
            var title = $("#<%=this.txtReportCNName.ClientID %>").val();
            var data = getEdit();
            var entity = $.parseJSON(data[0]);                      //userEdit object
            var cols = [];
            var rptTable = data[2];                                 //Report dataSource
            var sorting = data[1];                                  //Report sorting    
            var strCode = '<p style="height:20px;background-color:#f1f1f1; padding:5px; text-align:center; font-weight:bold; font-size:16px; border-top:1px solid #d3d3d3; border-left:1px solid #d3d3d3; border-right:1px solid #d3d3d3; ">' + title + '</p>' +
                '<div class="EditeContentTable" style="line-height:22px; height:auto;">';            //HTML for InputSearch
            var strJS_Con = '';
            var strJS_Bind = '';
            var strJS_Excel = '';
            var strScript = '<script type="text/javascript">';         // JavaScript
            strScript += '$("#bnView").click(function () {' +
                            'var conds = "";var conds2 = "";';
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
                       var typeStr="";
                    if (entity[i].dataType == "时间类型") {
                           typeStr = '<input type="text" id="S'+entity[i].colName+'" style="width: 100px" class="DateTimeBox" /> --- <input type="text" id="E'+entity[i].colName+'" style="width: 100px" class="DateTimeBox" />';
                           strCode=strCode.replace("{0}", typeStr);
                           
                            strJS_Con += ' if( $("#S'+entity[i].colName+'").val() !="")' +
                       '{ conds +=" AND ' + entity[i].colName + '>= N\'" + $("#S'+entity[i].colName+'").val()+"\'";}';

                            strJS_Con += ' if($("#E'+entity[i].colName+'").val() !="")' +
                       '{ conds +=" AND ' + entity[i].colName + '<= N\'" + $("#E'+entity[i].colName+'").val()+"\'";}';
                    
                 } else {

                        typeStr = '<input type="text" class="TextBox ' + entity[i].colCssClass + '" value="" id="' + entity[i].colName + '" />  ';
                        strCode=strCode.replace('{0}', typeStr);

                        strJS_Con += ' if(' + entity[i].colName + ' !=="")' +
                            '{ conds2 +=" AND ' + entity[i].colName + '=N\'" + $.trim($("#' + entity[i].colName + '").val()) +"\'";' +
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
                    col.width = isNaN(entity[i].colWidth) ? 200 : entity[i].colWidth;
                    col.minWidth = 60;
                    cols.push(col);
                    selecteFields += col.name + ",";
                }
            }
              
            strCode += '<div style="text-align: center;padding:5px; float:left; width:auto;">' +
            '<span style="margin-right:15px;"><input type="checkbox" id="chkEqul" name="chkEqul"/>全字匹配</span>' +
                '<span id="bnView" style="font-size: 12px; font-weight:bold;  cursor: pointer;">' +
               '<img src="../Content/images/search.png" class="imgText" style="margin-right:5px;"\/><span class="imgText">查询</span></span> ' +
                '<span id="bnImport"  style="font-size: 12px; font-weight:bold; margin-left:10px;cursor: pointer;" title="导出报表到Excel"><img src="../Content/images/icon/Import.png" class="imgText" style="margin-right:5px;"/><span class="imgText">导出</span></span>' +
                '</div>' +
                 '<div class="clear5"></div>' +
                '</div>' +           //EditeContentTable结束标签
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
            return (encodeURI(finalHtml));
        }

        function resizeContent() {
            var iframes = document.getElementById("ifCtrl");
            //$(".ReportInfo").toggle();
            var h = $(window).height() - 130;
            //            if ($("#ifCtrl").css("height").replace("px", "") == "195") {
            //                $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("height", "390px");
            //                $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("overflow", "auto");
            //                $("#ifCtrl").css("height", "390px");
            //            }
            //            else {
            $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("height", h);
            $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("overflow", "auto");
            $("#ifCtrl").css("height", h);
            //            }
        }

        //设置代码编辑器的高度
        function setCodeHeight() {
            var iframes = document.getElementById("ifCtrl");
            var h = $(window).height() - 130;
            $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("height", h);
            $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("overflow", "auto");
            $("#ifCtrl").css("height", h);
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

       function preview(){
       var content = document.getElementById("ifCtrl").contentWindow.getData();
         if (content == "") {
                alert("请输入代码！");
                return false;
            }
         store.set("PreviewCookie", content);
          window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Report/ReportTemplatePreview.aspx");
        }
    </script>
</asp:Content>
