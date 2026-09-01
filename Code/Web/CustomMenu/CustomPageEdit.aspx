<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"  EnableViewState="true" 
    AutoEventWireup="true" CodeBehind="CustomPageEdit.aspx.cs" Inherits="SKT.LeanMES.Web.CustomMenu.CustomPageEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <script src="layer/jquery.min.js"></script>
    <script src="layer/layer.js"></script>
    <script src="../Content/htmlformat/jsformat.min.js"></script>
    <script src="../Content/htmlformat/htmlformat.min.js"></script>
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current">二级菜单信息</li>
            <li id="tabUIDesign">界面设计</li>
            <li id="tabCodeDesign">代码设计</li>
        </ul>
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <table width="100%" class="EditeContentTable">
                <tr class="ReportInfo">
                    <td class="Label1">
                        二级菜单名称(中文)<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtPageCName" runat="server" IsRequired="1" MaxLength="20" CssClass="TextBox"></asp:TextBox>
                        <asp:HiddenField ID="hdnPageName" runat="server" />
                    </td>
                </tr>
                <tr class="ReportInfo">
                    <td class="Label1">
                        二级菜单名称(英文)<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtPageEName" runat="server"  IsRequired="1"  MaxLength="20" CssClass="TextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr class="ReportInfo">
                    <td class="Label1">
                        二级菜单图标
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
                        子系统名称<em>*</em>
                    </td>
                    <td class="Field1">
                        <%-- <SKTControl:ReportDDL runat="server" OnTextChanged="SubSystemChange" ID="ddlSubName" FormattingEnabled="false"   ClientIDMode="Static">
                        </SKTControl:ReportDDL>--%>
                        <asp:DropDownList ID="ddlSubName" runat="server" OnSelectedIndexChanged="SubSystemChange" ClientIDMode="Static"  AutoPostBack="true"></asp:DropDownList>
                        <input type="hidden" id="isIntoSysFrame" value="-1" runat="server" ClientIDMode="Static"/>
                    </td>
                </tr>
                <tr class="ReportInfo">
                    <td class="Label1">
                        一级菜单名称<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:ScriptManager ID="ScriptManager2" runat="server" EnablePartialRendering="true">
                        </asp:ScriptManager>
                         <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                             <ContentTemplate>
                                    <%--<SKTControl:ReportDDL runat="server" ID="ddlModule"  IsRequired="1"  ClientIDMode="Static">
                                    </SKTControl:ReportDDL>--%>
                                 <asp:DropDownList ID="ddlModule" runat="server" ClientIDMode="Static"></asp:DropDownList>
                                 </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr class="ReportInfo">
                    <td class="Label1">
                        是否启用代码设计
                    </td>
                    <td class="Field1">
                        <asp:CheckBox ID="ckIsCodeDesign" runat="server" ClientIDMode="Static"/>
                    </td>
                </tr>
                <tr class="ReportInfo">
                    <td class="Label1">
                        <%=Resources.lang.Description %>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtPageDesc" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <!--设计报表-->
        <div>
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %> &nbsp; <span id="spHelp">找不到数据源？<img src="../Content/images/icon/help.png" /></span>
            </div>
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label2" align="left">
                        列表数据源：<em>*</em>
                    </td>
                    <td class="Field2" align="left">
                        <asp:TextBox ID="txtTable" runat="server"  CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                            Width="250px">
                        </asp:TextBox><input type="button" id="btnSelect" class="ButtonBox" style="width: 65px;
                            line-height: 12px; background: #ccc; font-size: 12px;" value="选择数据源" title="点击选择数据源"
                            onclick="openChoosePage(this);" />
                        <asp:HiddenField ID="hfDsTableID" runat="server" Value="-1" ClientIDMode="Static" />
                        <span id="divHideEdit" >
                            <input class="SearchButton" id="btnPreview" type="button" value="预览" onclick="preview()" />
                        </span>
                    </td>
                    <td class="Label2" align="left">
                        业务数据保存表：<em>*</em>
                    </td>
                    <td class="Field2" align="left">
                        <asp:TextBox ID="txtTableName" runat="server"   MaxLength="200" CssClass="TextBox" ClientIDMode="Static" Width="250px"></asp:TextBox>
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
        <div>
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label" align="left" id="spCodeMes" colspan="2">
                        <input type="button"  class="AdaptButton"  style="float: left; color: #cccccc;margin:2px;width:80px;border:1px;" value="添加模版页" onclick="ListTemplate(1)" />
                        <input type="button"  class="AdaptButton"  style="float: left; color: #cccccc;margin:2px;width:80px;border:1px;" value="添加控件" onclick="ListTemplate(2)" />
                        <input type="button"  class="AdaptButton"  style="float: left; color: #cccccc;margin:2px;width:80px;border:1px;" value="预览" onclick="preview()" />   
                    </td>
                </tr>
                <tr>
                    <td class="Label" align="left" colspan="2">
                        <span style="float: left; font-weight: bold; padding-left: 10px;">代码设计&nbsp;&nbsp;</span>
                        
                        <span style="float: right; color: #cccccc">编辑器版本 1.0.1</span>
                    </td>
                </tr>
                <tr>
                    <td class="Field" align="left" colspan="2" style="padding: 0px;">
                        <div id="loadingmsg" class="loadingmessage">
                            <%=Resources.Messages.LoadingData %></div>
                        <iframe id="ifCtrl" name="ifCtrl" frameborder="0" width="100%" height="195px" marginheight="0"
                            marginwidth="0" scrolling="auto" src=""></iframe>
                        <iframe id="ifCtrl1" name="ifCtrl1" frameborder="0" width="100%" height="195px" marginheight="0"
                            marginwidth="0" scrolling="auto" src="" style="display:none;"></iframe>
                        <asp:HiddenField ID="hdnValue" runat="server" Value="" />
                        <asp:HiddenField ID="hdnValueSub" runat="server" Value="" />
                        <asp:HiddenField ID="hdnPType" runat="server" Value="0" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
     <div style="margin:-65px 450px 200px 80px;background-color:rgb(79, 147, 209);padding:10px;z-index:9999;position: fixed;border-radius:5px;width:40%;height:12%;display:none;color:white" id="templateList">
            <span class="layui-layer-setwin" onclick='HideTemplateList()'><a class="layui-layer-ico layui-layer-close layui-layer-close2" href="javascript:;"></a></span>
             <div id="listt">
                 <span>
                     List模版页<input type="checkbox" class="template"  onclick="ListTemplate1(this)"/>
                 </span>
                 <span>
                     分页页签模版<input type="checkbox" class="template"  onclick="PagingTemplate(this)"/>
                 </span>
                 <span>
                     物料标签模版打印页<input type="checkbox" class="template"  onclick="MaterialTagPrintTemplate(this)"/>
                 </span>
                 <span>
                     树形页模版<input type="checkbox" class="template"  onclick="TreeTemplate(this)"/>
                 </span>
                 <span>
                     控制图模版<input type="checkbox" class="template"  onclick="ControlPhotoTemplate(this)"/>
                 </span>
                 <span>
                     高级看板模版<input type="checkbox" class="template"  onclick="CustomKanBanTemplate(this)"/>
                 </span>
                 <span>
                     外部链接<input type="checkbox" class="template"  onclick="OuterLinkTemplate(this)"/>
                 </span>
           </div>
            <div id="controlt">
                 <span>
                     一般控件<input type="checkbox"    onclick="AddControlTemplate(this)"/>
                 </span>
                 <span>
                     打印控件<input type="checkbox"  onclick="AddPrintTemplate(this)"/>
                 </span>
                <span>
                     授权模版<input type="checkbox"  onclick="AddWarrantTemplate(this)"/>
                 </span>
                <span>
                    单据打印模版<input type="checkbox"   onclick="DanPrintTemplate(this)"/>
                </span>
           </div>
      </div>
    <asp:HiddenField runat="server" ID="hfDesignJson" Value="" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfUpdateDJ" Value="0" ClientIDMode="Static" />
    
     <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        var PageId = '<%=Request.QueryString["ID"] %>';
        var PName = $("#ContentPlaceHolder1_EditContent_hdnPageName").val();
        var PageSub = false;
        var Root = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>";
        $(function () {
            $(document).keydown(function (e) {
                if (e.which == 83 && e.ctrlKey) {
                    Save(0);
                }
            });

            ShowDesignEdit();

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
            //从属页面模版编辑框
            $("#ifCtrl1").hide();
            var iframesSub = document.getElementById("ifCtrl1");
             iframesSub.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/highlight/htmlmixededitor.aspx?rnd=" + Math.random();
            var h = $(window).height() - 130;
            $(".CodeMirror-scroll", iframesSub.contentWindow.document.body).css("height", h);
            $(".CodeMirror-scroll", iframesSub.contentWindow.document.body).css("overflow", "auto");
            $("#ifCtrl1").css("height", h);
            var valuesSub = $.trim($("#<%=this.hdnValueSub.ClientID %>").val());
            if (valuesSub != "") {
                $("#ifCtrl1").show();
            }
            if (iframesSub.attachEvent) {
                iframesSub.attachEvent("onload", function () {
                    $("#loadingmsg").hide();
                
                    if (valuesSub != "") {
                        iframesSub.contentWindow.setData(valuesSub);
                    }
                    else {
                        iframesSub.contentWindow.setData("<div>你可以在此编辑您的HTML代码</div>\n<script type='text/javascript'>/*您可以在此写入您的js代码*/<\/script>");
                    }
                    setCodeHeight();
                });
            }
            else {
                iframesSub.onload = function () {
                    $("#loadingmsg").hide();
                    if (valuesSub != "") {
                        iframesSub.contentWindow.setData(valuesSub);
                    }
                    else {
                        iframesSub.contentWindow.setData("<div>你可以在此编辑您的HTML代码</div><script type='text/javascript'>/*您可以在此写入您的js代码*/<\/script>");
                    }
                    setCodeHeight();
                };
            }

            $("#chkShowAll").on("click", function () {
                if ($("#chkShowAll").is(":checked")) {
                    $(".colShow").prop('checked', "checked");
                } else {
                    $(".colShow").removeAttr('checked');
                }
            });
            var tip_index = 0;
            $(document).on('mouseenter', '#spHelp', function () {
                tip_index = layer.tips('1.数据库表命名必须是"SKTCustom_"开头</br>2.视图命名必须是"vwSKTCustom_"开头</br>', '#spHelp', { time: 0,tips: [4, '#78BA32'] });
            }).on('mouseleave', '#spHelp', function () {
                layer.close(tip_index);
            });

        });
        //保存
        function Save(flag) {
            if (!$("#ckIsCodeDesign").is(":checked")) {
                var txtTable = $.trim($("#txtTable").val());
                var txtTableName = $.trim($("#txtTableName").val());
                if (!txtTable) {
                    alert("列表数据源不能为空！");
                    return false;
                }
                if (!txtTableName) {
                    alert("业务数据保存表不能为空！");
                    return false;
                }
                SavePage();
            }
            var PageCName = $("#<%=this.txtPageCName.ClientID %>").val();
            var PageEName = $("#<%=this.txtPageEName.ClientID %>").val();
            var Icon = $("#<%=this.hdnIcon.ClientID %>").val();
            var Sequence = $("#<%=this.txtSequence.ClientID %>").val();
            var PageName = $("#<%=this.hdnPageName.ClientID %>").val();
            var PageDesc = $("#<%=this.txtPageDesc.ClientID %>").val();
            var PageContent = document.getElementById("ifCtrl").contentWindow.getData();
            var PageContentSub = document.getElementById("ifCtrl1").contentWindow.getData();
            if (PageContentSub == "%3Cdiv%3E%E4%BD%A0%E5%8F%AF%E4%BB%A5%E5%9C%A8%E6%AD%A4%E7%BC%96%E8%BE%91%E6%82%A8%E7%9A%84HTML%E4%BB%A3%E7%A0%81%3C/div%3E%3Cscript%20type='text/javascript'%3E/*%E6%82%A8%E5%8F%AF%E4%BB%A5%E5%9C%A8%E6%AD%A4%E5%86%99%E5%85%A5%E6%82%A8%E7%9A%84js%E4%BB%A3%E7%A0%81*/%3C/script%3E") {
                PageContentSub = "";
            }
            var IsCodeDesign = $("#ckIsCodeDesign").is(":checked");

            
            var Module = $("#ddlModule").val();
            var _currentUser = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

            //界面中文名不能为空
            if ($.trim(PageCName) == "") {
                alert("界面中文名称不能为空！");
                $("#<%=this.txtPageCName.ClientID %>").focus();
                return false;
            }
            //界面英文名不能为空
            if ($.trim(PageEName) == "") {
                alert("界面英文名称不能为空！");
                $("#<%=this.txtPageEName.ClientID %>").focus();
                return false;
            }
            //模块不能为空
            if ($.trim(Module) == "") {
                alert("请选择模块！");
                return false;
            }

            var entity = {};
            entity.PageId = PageId;
            entity.PageCName = PageCName;
            entity.PageEName = PageEName;
            entity.Icon = Icon;
            entity.Sequence = Sequence;
            entity.PageName = PageName !== '' ? PageName : '0';
            entity.PageDesc = PageDesc;
            entity.PageContent = PageContent;
            entity.Module = Module;
            entity.CreateBy = _currentUser;
            entity.ModifyBy = _currentUser;
            entity.DesignJSON = getEdit();
            entity.IsCodeDesign = IsCodeDesign;
            entity.PageContentSub = PageContentSub;
            entity.PType=$.trim($("#<%=this.hdnPType.ClientID %>").val());
           
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCustomMenu.EditCustomPage(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            
            if (flag == 1) {

            } else {
                alert("<%=Resources.Messages.SaveInSuccess %>");
                window.parent.UpdateList(PageCName);
            }
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
            dialog({ title: '<%=Resources.lang.ChooseIcon %>', src: '../Report/ChooseIcon.aspx', width: 400, height: 300 });
        }

        //显示选中的图标
        function setIcon(icon, iconname) {
            $("#reportIcon").html("<img src='" + icon + "'/>");
            $("#<%=this.hdnIcon.ClientID %>").val(iconname);
            closeDialog();
        }

        function preview() {
            if (!$("#ckIsCodeDesign").is(":checked")) {
                SavePage();
            }
            var content = document.getElementById("ifCtrl").contentWindow.getData();
            if (content == "") {
                alert("请输入代码！");
                return false;
            }
            
            var ptype = $("#<%=this.hdnPType.ClientID %>").val();
            if (ptype == 1 || ptype == "1") {
                store.set("PreviewCookieKB", content);
                window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/CustomMenu/CustomKanBan.aspx?lineId=3262&lineName=S1&welcomeMsg=%u70ED%u70C8%u6B22%u8FCE%u5404%u4F4D%u9886%u5BFC%u8385%u4E34%u53C2%u89C2%u6307%u5BFC&name=CustomKanBan&PaName=" + PName + "&Flag=1");
            } else if (PName == 0 || PName == null || PName == "" || PName == undefined) {
                store.set("PreviewCookie", content);
                window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Report/ReportTemplatePreview.aspx");
            } else {
                store.set("PreviewCookieCM", content);
                window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/CustomMenu/CustomMenuPage.aspx?name=CustomMenuPage&PaName=" + PName + "&Flag=1");
            }
       }

        function openChoosePage(obj) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>"
            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=802&Multiple=false&CallBackFunc=getChooseValue&rnd=" + Math.random()
            , width: 600, height: 300
            });
        }
        function getChooseValue(list) {
            $("#<%=this.txtTable.ClientID %>").val(list[0][1]);
            if (list[0][0] * 1 > 0) {
                showEdit(list[0][1]);
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
                    '<th align=center style="width:3%">显示<span align=right><input type="checkbox" checked="checked" id="chkShowAll"/></span></th>' +
                    '<th align=center style="width:5%">是否主键</th>' +
                    '<th align=center style="width:5%">查询条件</th>' +
                    '<th align=center style="width:5%">是否编辑项</th>' +
                    '<th align=center style="width:5%">是否选择项</th>' +
                    '<th align=center style="width:20%; display:none">过滤条件</th>' +
                    '<th align=center style="width:10%">列宽(px)</th>' +
                    '<th align=center style="width:20%; display:none">查询类型</th>' +
                    '<th align=center style="width:5%">排序</th>' +
                    '<th align=center style="width:15%">文本框样式</th>' +
                    '<th align=center style="width:20%; display:none">字段名类型</th>' +
                    '</tr></thead><tbody>';
                for (var i = 0; i < rowObj.length; i++) {
                    var tj = "";
                    if (rowObj[i].DataType == "时间类型") {
                        tj = "<input type='text' id='txtStartTime' style='width: 140px' class='DateTimeBox' /> -- <input type='text' id='txtEndTime' style='width: 140px' class='DateTimeBox' />";
                    } else {
                        tj = "<input type='text' class='colWhere'/>"
                    }

                    strHtml += "<tr class='ListTableOddRow'>" +
                        "<td align=center class='colSort'>" + rowObj[i].ItemValue + "</td>";
                    strHtml += "<td align=center>" + rowObj[i].ItemName + "</td>";
                    strHtml += "<td align=center><input type='text' maxlength='20' class='colText' value='" + rowObj[i].ItemValue + "'/></td>";
                    strHtml += "<td align=center><input type='checkbox' checked='checked' class='colShow'/></td>";
                    strHtml += "<td align=center><input type='checkbox' class='colKey' onclick='setCheckbox(this);'/></td>";
                    strHtml += "<td align=center><input type='checkbox' class='colSelWhere'/></td>";
                    strHtml += "<td align=center><input type='checkbox' class='colEdit'/></td>";
                    strHtml += "<td align=center><input type='checkbox' class='colChoose'/></td>";
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
                    strHtml += "</tr>";
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
        function setCheckbox(obj) {
            $(".colKey").removeAttr('checked');
            $(obj).prop('checked', 'checked');
            
        }
        var getEdit = function () {
            var arrList = [];
            var entity = {};
            var sorting = '';
            var dataSource = $("#<%=this.txtTable.ClientID %>").val();
            var TableName = $("#<%=this.txtTableName.ClientID %>").val();
            $("#tbEdit tbody tr").each(function () {
                    entity = {};
                    entity.colName = $(this).find(".colSort").html();
                    entity.colText = $(this).find(".colText").val();
                    entity.colShow = $(this).find(".colShow").is(":checked") ? '1' : '0';
                    entity.colKey = $(this).find(".colKey").is(":checked") ? '1' : '0';
                    entity.colSelect = $(this).find(".colSelWhere").is(":checked") ? '1' : '0';
                    entity.colEdit = $(this).find(".colEdit").is(":checked") ? '1' : '0';
                    entity.colChoose = $(this).find(".colChoose").is(":checked") ? '1' : '0';
                    entity.colCondition = $(this).find(".colWhere").val();
                    entity.colWidth = $(this).find(".colWidth").val() * 1 > 0 ? $(this).find(".colWidth").val() * 1 : 180;
                    entity.colCssClass = $(this).find(".colCssClass").val();
                    entity.dataType = $(this).find(".DataType").html();

                    arrList.push(entity);
                    sorting += entity.colName + ',';
                });
            sorting = sorting.slice(0, -1);
            return [JSON.stringify(arrList), sorting, dataSource, TableName];
        }

        function newReportHtml() {
            var title = $("#<%=this.txtPageCName.ClientID %>").val();//表头信息
            var data = getEdit();                                    //数据
            var entity = $.parseJSON(data[0]);                      //格式化数据
            var cols = [];
            var rptTable = $("#<%=this.txtTable.ClientID %>").val(); //数据源（视图名称或者表名）
            var TableName = $("#<%=this.txtTableName.ClientID %>").val(); //数据源（视图名称或者表名）
            var sorting = data[1];                                  //排序字段
            var strCode = '<table class="EditeContentTable" style="width: 100%">';            //HTML
            var strJS_Con = '';
            var strJS_Bind = '';
            var strJS_Excel = '';
            var strScript = '<script type="text/javascript">';         // JavaScript
            strScript += '$("#bnView").click(function () {' + '$("#hdnKeyValue").val(""); var conds = ""; var conds2 = ""; ';
            var selecteFields = ""; 
            var strClass = "";
            var strFunction = '';//function Add(){}function Edit(){}function Delete(){}
            var strEditHtml = '<div><table class="EditeContentTable" id="tbEditInfo" width="100%">'

            var FormsHtml = '';
            var strKey = "";

            for (var i = 0; i < entity.length; i++) {
                //构造查询选项HTML，获取选项值JS
                if (entity[i].colSelect * 1 === 1) {

                    //strEditHtml += '<tr>'
                    //strEditHtml += '<td class="Label2">' + entity[i].colText + '</td>';
                    //strEditHtml += '<td class="Field' + strClass + '">';
                    //strEditHtml += '{0}</td>'; //编辑输入框
                    //strEditHtml += '</tr>'

                    //查询条件框的样式
                    if (entity.length >= 3) {
                        strClass = "3"
                    } else {
                        strClass = entity.length
                    }
                    //每一行只放3个查询条件框
                    if (i % 3 == 0) {
                        if (i == 0) {
                            strCode += '<tr>';
                        } else {
                            strCode += '</tr><tr>';
                        }
                    }
                    strCode += '<td class="Label' + strClass + '">' + entity[i].colText + '</td>';
                    strCode += '<td class="Field' + strClass + '">';
                    strCode += '{0}</td>'; //查询条件输入框
                    
                    //-----------------------------
                    strJS_Bind += 'var ' + entity[i].colName + ' = $("#' + entity[i].colName + '").val();';

                    //----------------------------- var orderid =$("#orderid").val()
                    //2018-1-6 hufang 简易报表字段名如果是时间类型，则查询具体某一区间的数据
                    var typeStr = "";
                    if (entity[i].dataType == "时间类型") {
                        typeStr = '<input type="text" id="start' + entity[i].colName + '" style="width: 100px" class="DateTimeBox" /> --- <input type="text" id="end' + entity[i].colName + '" style="width: 100px" class="DateTimeBox" />';
                        strCode=strCode.replace('{0}', typeStr);
                        strJS_Con += ' if(start' + entity[i].colName + ' !="")' + '{ conds +=" AND ' + entity[i].colName + '>= $("#start' + entity[i].colName + '").val(); }';
                        strJS_Con += ' if(end' + entity[i].colName + ' !="")' + '{ conds +=" AND ' + entity[i].colName + '<= $("#end' + entity[i].colName + '").val();}';
                                          
                    } else {
                        typeStr = '<input type="text" class="TextBox ' + entity[i].colCssClass + '" value="" id="' + entity[i].colName + '" />  ';
                        strCode=strCode.replace('{0}', typeStr);
                        strJS_Con += ' if(' + entity[i].colName + ' !=="")' +'{ conds2 +=" AND ' + entity[i].colName + '= N\'" + $.trim($("#' + entity[i].colName + '").val()) +"\'";' +' conds +=" AND ' + entity[i].colName + ' LIKE N\'%" + $.trim($("#' + entity[i].colName + '").val()) +"%\'";}';
                    }
                    //strEditHtml = strEditHtml.replace('{0}', typeStr);
                  

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
                //获取主键的字段
                if (entity[i].colKey * 1 === 1) {
                    strKey = entity[i].colName;
                }
                //获取编辑项
                if (entity[i].colEdit * 1 === 1) {

                    strEditHtml += '<tr>'
                    strEditHtml += '<td class="Label2">' + entity[i].colText + '</td>';
                    strEditHtml += '<td class="Field' + strClass + '">';
                    strEditHtml += '{0}</td>'; //编辑输入框
                    strEditHtml += '</tr>'
                    var InputClass = "TextBox"
                    if (entity[i].colCssClass != "") {
                        InputClass = entity[i].colCssClass;
                    }
                    var EditStr = '<input type="text" class="' + InputClass + '" value="" id="' + entity[i].colName + '" />  ';
                    strEditHtml = strEditHtml.replace('{0}', EditStr);
                }
            }
            strEditHtml += "</table></div>"
            
            strCode += '</tr>';
            strCode += '<tr><td class="Label' + strClass + '" colspan="' + strClass * 2 + '" align="center" style="text-align:center">' +
               '<span style="margin-right:15px;"><input type="checkbox" id="chkEqul" name="chkEqul"/>全字匹配</span>' +
                '<span id="bnView" style="font-size: 12px; font-weight:bold; cursor: pointer; ">' +
                '<img src="../Content/images/search.png" class="imgText" style="margin-right:5px;"\/><span class="imgText">查询</span></span> ' +
                '<span id="bnImport" style="font-size: 12px; font-weight:bold; margin-left:10px;cursor: pointer;" title="导出报表到Excel"><img src="../Content/images/icon/Import.png" class="imgText" style="margin-right:5px;"/><span class="imgText">导出</span></span>' +
                '</tr></table>' +
                '<input type="hidden" value="' + rptTable + '" id="hdnPararms" name="hdnPararms" />' +
                '<input type="hidden" value="" id="hdnPararmValue" name="hdnPararmValue" />' +
                '<input type="hidden" value="" id="hdnOperation" name="hdnOperation" />' +
                '<input type="hidden" value="" id="hdnFileName" name="hdnFileName" />' +
                '<input type="hidden" value="' + TableName + '" id="hdnTableName" name="hdnTableName" />' +
                '<input type="hidden" value="' + strKey + '" id="hdnKey" name="hdnKey" />' +
                '<input type="hidden" value="" id="hdnKeyValue" name="hdnKeyValue" />' +
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

                ',multiselect:true' +
                ',onSelectRow:function(rowid,status){' +
                '$("#hdnKeyValue").val(rowid[$("#hdnKey").val()]);' +
                '}' +
                
                ',sortName: "' + sorting + '"' +
                ',selectFields:"' + selecteFields.substring(0, selecteFields.length - 1) + '"' +
                '});';
            strScript += "});";
            //---------------------

            //定义弹出窗口
            //新增
            FormsHtml += 'function Add(){ layer.open({ ' +
                'type: 1,' +
                'area: ["600px", "400px"],' +
                'title: "新增' + title + '信息",' +
                'shade: 0.6,' +
                'moveType: 0,' +
                'shift: 0,' +
                'closeBtn: 2,' +
                'content:PageHtml,' +
                'btn: ["保存", "取消"],' +
                'btn1: function (index, layero) {SaveAddInfo();},' +
                'btn2: function (index, layero) {},' +
                'success: function () { }';
            FormsHtml += '});}';
            //修改
            FormsHtml += 'function Edit(){ if($("#hdnKeyValue").val()==""){alert("请选择要编辑的信息！");return false;}layer.open({ ' +
                'type: 1,' +
                'area: ["600px", "400px"],' +
                'title: "编辑' + title + '信息",' +
                'shade: 0.6,' +
                'moveType: 0,' +
                'shift: 0,' +
                'closeBtn: 2,' +
                'content:PageHtml,' +
                'btn: ["保存", "取消"],' +
                'btn1: function (index, layero) {SaveEditInfo();},' +
                'btn2: function (index, layero) {},' +
                'success: function () { }';
            FormsHtml += '}); GetInfo();}';
            //删除
            FormsHtml += 'function Delete(){ if($("#hdnKeyValue").val()==""){alert("请选择要删除的信息！");return false;} if(confirm("此操作不可逆，确定删除？")){' +
                'var strDeSql="delete "+$("#hdnTableName").val()+" ";' +
                'strDeSql=strDeSql+" where "+$("#hdnKey").val()+"=' + "'\"" + ' + $("#hdnKeyValue").val() +' + "\"'\";"+
                'var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecuteSql(strDeSql); ' +
                'if (ajax.error != null) { alert(ajax.error.Message);return false; }' +
                'alert("删除成功！");$("#bnView").trigger("click");'
            FormsHtml += '}}';

            var InputHtml = "";
            //修改方法
            FormsHtml += 'function SaveEditInfo(){' +
               'var strEditSql="update "+$("#hdnTableName").val()+" SET ";' +
               'var strFieldEdit="";' +
               '$("#tbEditInfo input").each(function () {' +
               ' strFieldEdit+=$(this).attr("id")+"=' + "'\"" + ' + $(this).val() +' + "\"',\";"+
               '});' +
               'strFieldEdit=strFieldEdit.substring(0, strFieldEdit.length - 1);' +
               'strEditSql=strEditSql+strFieldEdit+" where "+$("#hdnKey").val()+"=' + "'\"" + ' + $("#hdnKeyValue").val() +' + "\"'\";" +
               'var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecuteSql(strEditSql); ' +
               'if (ajax.error != null) { alert(ajax.error.Message);return false; }' +
               'alert("保存成功！");layer.closeAll();$("#bnView").trigger("click");' +
               '} '
            //新增方法
            FormsHtml += 'function SaveAddInfo(){' +
               'var strSql="insert into "+$("#hdnTableName").val()+"(";' +
               'var strField="";' +
               'var strValue="";' +
               '$("#tbEditInfo input").each(function () {' +
               ' strField+=$(this).attr("id")+",";' +
               ' strValue+= ' + "\"'\"" + ' + $(this).val() +' + "\"',\";" +
               '});' +
               'strField=strField.substring(0, strField.length - 1);' +
               'strValue=strValue.substring(0, strValue.length - 1);' +
               'strSql=strSql+strField+") values("+strValue+")";' +
               'var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecuteSql(strSql); ' +
               'if (ajax.error != null) { alert(ajax.error.Message);return false; }' +
               'alert("保存成功！");layer.closeAll();$("#bnView").trigger("click");' +
               '}'

            //获取信息
            FormsHtml += 'function GetInfo(){ ' +
                 'var strSelSql="select * from "+$("#hdnTableName").val()+" ";' +
                 'strSelSql=strSelSql+" where "+$("#hdnKey").val()+"=' + "'\"" + ' + $("#hdnKeyValue").val() +' + "\"'\";" +
                 'var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecuteSqlSearch(strSelSql); ' +
                 'if (ajax.error != null) { alert(ajax.error.Message);return false; }' +
                 'var rowInfo = $.parseJSON(ajax.value);' +
                 '$("#tbEditInfo input").each(function () {' +
                 '$(this).val(rowInfo[0][$(this).attr("id")])' +
                 '});' 
            FormsHtml += '}';
            //---------------------导出EXCEL 
            strJS_Excel += '$("#bnImport").click(function () { var conds ="";var conds2 ="";';
            strJS_Excel += strJS_Bind;
            strJS_Excel += strJS_Con;                                             //控件值获取
            strJS_Excel += '$("#hdnPararms").val("' + rptTable + '");';                   //DbTable
            strJS_Excel += '$("#hdnOperation").val("TABLE");';
            strJS_Excel += '$("#hdnPararmValue").val(conds);';
            strJS_Excel += '$("#hdnFileName").val("' + title + '");';

            strJS_Excel += 'document.forms[0].submit();' + '});';
            strScript += strJS_Excel;
            //---------------------
            strFunction = "var PageHtml = '" + strEditHtml + "';";
            strScript += strFunction + FormsHtml;
            
            strScript += "<\/script>";
            var finalHtml = strCode + strScript;

            js_source = finalHtml.replace(/^\s+/, '');
            tabsize = 1;
            tabchar = ' ';
            if (tabsize == 1) {
                tabchar = '\t';
            }
            if (js_source && js_source.charAt(0) === '<') {
                finalHtml = style_html(js_source, tabsize, tabchar, 80);
            } else {
                finalHtml = js_beautify(js_source, tabsize, tabchar);
            }

            //console.log(finalHtml);
            return (encodeURI(finalHtml));
            
        }

        //保存内容
        function SavePage()
        {
            var iframes = document.getElementById("ifCtrl");
            iframes.contentWindow.setData(newReportHtml());
        }

        //构造简易报表编辑器
        function ShowDesignEdit() {
            var strJsonArr = [];
            if ($("#hfDesignJson").val() !== "" && PageId !== '-1') {
                eval("strJsonArr = " + $("#hfDesignJson").val());
                var rowEntity = $.parseJSON(strJsonArr[0]);
                var sorting = strJsonArr[1];
                var dataSource = strJsonArr[2];
                $("#txtTable").val(dataSource);
                $("#txtTableName").val(strJsonArr[3]);
                
                //$("#txtTable").after(dataSource);
                var strHtml = '';
                strHtml += ' ' +
                    '<table id="tbEdit" class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;min-width: 760px; width: 100%; border-collapse: collapse;">' +
                    '<thead class="ListTableHeader"><tr><th align=center style="width: auto">字段名</th>' +
                //'<th style="width: auto">字段描述</th>' +
                    '<th align=center style="width:15%">报表列名</th>' +
                    '<th align=center style="width:8%">显示<span align=right><input type="checkbox" checked="checked" id="chkShowAll"/></span></th>' +
                    '<th align=center style="width:5%">是否主键</th>' +
                    '<th align=center style="width:8%">查询条件</th>' +
                    '<th align=center style="width:8%">是否编辑项</th>' +
                    '<th align=center style="width:8%">是否选择项</th>' +
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
                    strHtml += "<td align=center><input type='text' class='colText' maxlength='20' value='" +
                        rowEntity[i].colText + "'/></td>";
                    if (rowEntity[i].colShow * 1 === 1) {
                        strHtml += "<td align=center><input type='checkbox' checked='checked' class='colShow'/></td>";
                    } else {
                        strHtml += "<td align=center><input type='checkbox' class='colShow'/></td>";
                    }
                    if (rowEntity[i].colKey * 1 === 1) {
                        strHtml += "<td align=center><input type='checkbox' checked='checked' class='colKey' onclick='setCheckbox(this);'/></td>";
                    } else {
                        strHtml += "<td align=center><input type='checkbox' class='colKey' onclick='setCheckbox(this);'/></td>";
                    }
                    if (rowEntity[i].colSelect * 1 === 1) {
                        strHtml += "<td align=center><input type='checkbox' checked='checked' class='colSelWhere'/><input type='text' value='" + rowEntity[i].dataType + "' style='display:none' class='dataType'/></td>";
                    } else {
                        strHtml += "<td align=center><input type='checkbox' class='colSelWhere'/><input type='text' value='" + rowEntity[i].dataType + "' style='display:none' class='dataType'/></td>";
                    }
                    if (rowEntity[i].colEdit * 1 === 1) {
                        strHtml += "<td align=center><input type='checkbox' checked='checked' class='colEdit'/></td>";
                    } else {
                        strHtml += "<td align=center><input type='checkbox' class='colEdit'/></td>";
                    }
                    if (rowEntity[i].colChoose * 1 === 1) {
                        strHtml += "<td align=center><input type='checkbox' checked='checked' class='colChoose'/></td>";
                    } else {
                        strHtml += "<td align=center><input type='checkbox' class='colChoose'/></td>";
                    }
                    strHtml += "<td align=center style='display:none'><input type='text' value='" +
                        rowEntity[i].colCondition +
                        " class='colWhere'/></td>";
                    strHtml += "<td align=center><input type='text' maxlength='5' class='colWidth' " +
                        " onkeyup=\"this.value=this.value.replace(\/\\D/g,'')\" " +
                        " onafterpaste=\"this.value=this.value.replace(\/\\D/g,'')\" " +
                        "value='" + rowEntity[i].colWidth + "'/></td>";
                    strHtml += "<td align=center style='display:none'><input type='text' class='colClass'/></td>";
                    strHtml +=
                        "<td align=center><a href='#' onclick='up(this)'><img src='../Content/images/arrowUp.gif' /></a>" +
                        "<a href='#' onclick='down(this)'><img src='../Content/images/arrowDown.gif'/></td></a>";
                    strHtml += "<td align=center><input type='text' maxlength='20' class='colCssClass' value='" + (rowEntity[i].colCssClass || "") + "'/></td>";
                    strHtml += "</tr>";
                }
                strHtml += "</tbody></table>";
                $("#divEdit").html(strHtml);

            } else {
                $("#divEdit").html("<div class='infoTips'></div>");
            }
        }
        //看板模版
        function CustomKanBanTemplate(checkbox) {
            PageSub = false;
            if (checkbox.checked == true) {
                if (!confirm("此操作会覆盖之前代码设计内容,是否确认添加看板模版?")) {
                    $(checkbox).prop('checked', false);
                    return false;
                } else {
                    $(".template").prop('checked', false);
                    $(checkbox).prop('checked', true);
                }
            }
            $("#<%=this.hdnPType.ClientID %>").val("1");
            var strHTML = '<title>线体看板</title>' +
                '<meta name="viewport" content="width=device-width, initial-scale=1.0" />' +
                '<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">' +
                '<script src="../Content/js/jquery-3.1.0.min.js" type="text/javascript"><\/script>' +
                '<script src="../Content/plugin/echarts/chalk.js" type="text/javascript"><\/script>' +
                '<script src="../Content/plugin/echarts/echarts.min.js" type="text/javascript"><\/script>' +
                '<style type="text/css" runat="server">' +
                    'html, body {' +
                        'width: 100%;' +
                        'height: 100%;' +
                        'margin: 0px;' +
                        'padding: 0px;' +
                        'border: 0px;' +
                        'font-family: "Helvetica Neue", "Microsoft Yahei", Arial, sans-serif;' +
                        'color: #fff;' +
                        'background-color: #041622;' +
                        'font-size:20px;' +
                        'overflow:hidden;' +
                    '}' +
                    'ul, li {' +
                        'float: left;' +
                        'margin: 0px;' +
                        'padding: 0px;' +
                        'list-style: none;' +
                        'width: 100%;' +
                        'background-color: #0E223B;' +
                    '}' +
                    '#lineInfo li {' +
                        'margin-left: 35px;' +
                        'width: 35%;' +
                        'line-height: 40px;' +
                    '}' +
                    '.logo_cus {' +
                        'background: url(\'../../Content/images/logo/logo.png\') no-repeat center center;' +
                         'background-size: 225px,80px;' +
                        'background-color: #0D213A;' +
                    '}' +
                    '.logo_skt {' +
                        'background: url(\'../../Content/images/logo/skt-logo.png\') no-repeat center center;' +
                         'background-size: 225px,60px;' +
                        'background-color: #0D213A;' +
                    '}' +
                    '#_left_top_title {' +
                        'width: 90%;' +
                        'height: 100%;' +
                        'font-size: 1.5em;' +
                        'text-align: center;' +
                        'padding-left: 10px;' +
                    '}' +
                    '#_left_top_welcome {' +
                        'width: 75%;' +
                        'height: 100%;' +
                        'font-size: 1.6em;' +
                        'color: Red;' +
                    '}' +
                    'table {' +
                        'width: 100%;' +
                        'height: 100%;' +
                        'border-collapse: collapse;' +
                        'border-spacing: 0px;' +
                        'padding: 0px;' +
                        'margin: 0px;' +
                    '}' +
                    'table td, table th {' +
                            'padding: 0px;' +
                     '}' +
                    '#_layout {' +
                        'position: absolute;' +
                    '}' +
                    '#_layout_right_table td {' +
                        'font-size: 1em;' +
                        'text-align: center;' +
                    '}' +
                    '#data_thead th, #data_tbody td, #data_tfoot td {' +
                        'text-align: center;' +
                        'font-size: 0.8em;' +
                        'border-top: 1px solid #263C54;' +
                        'border-bottom: 1px solid #263C54;' +
                    '}' +
                    '#data_thead th {' +
                        'border-bottom: 0px;' +
                    '}' +
                    '#data_tbody td, #data_tfoot td {' +
                        'border-bottom: 0px;' +
                    '}' +
                    '#data_tfoot td {' +
                        'border-bottom: 1px solid #263C54;' +
                    '}' +
                    '.gauge {' +
                        'height: 100%;' +
                        'width: 33%;' +
                    '}' +
                '</style>' +
                '<script type="text/javascript">' +
                    'var isScroll = false;' +
                    'function _InitScroll(_S1, _S2, _W, _H, _T) {' +
                        'if (isScroll) { return false; }' +
                        'marqueesHeight = _H;' +
                        'stopScroll = false;' +
                        'scrollElem = document.getElementById(_S1);' +
                        'scrollTable = document.getElementById(\'data_tbody\');' +
                        'if (scrollTable.offsetHeight < marqueesHeight) {' +
                            'return;' +
                        '}' +
                        'with (scrollElem) {' +
                            'style.width = _W;' +
                            'style.height = marqueesHeight;' +
                            'style.overflow = \'hidden\';' +
                            'noWrap = true;' +
                        '}' +
                        'scrollElem.onmouseover = new Function(\'stopScroll = true\');' +
                        'scrollElem.onmouseout = new Function(\'stopScroll = false\');' +
                        'preTop = 0;' +
                        'var leftElem = document.getElementById(_S2);' +
                        'var childElems = $(scrollElem).children();' +
                        'if (childElems.length > 1) {' +
                            '$(childElems[0]).nextAll().remove();' +
                        '}' +
                        'scrollElem.appendChild(leftElem.cloneNode(true));' +
                        'pauseTime = _T;' +
                        'init_srolltext();' +
                    '}' +
                    'function init_srolltext() {' +
                        'scrollElem.scrollTop = 0;' +
                        'scrollIntervalId = setInterval(\'scrollUp()\', 50);' +
                    '}' +
                    'function scrollUp() {' +
                        'if (stopScroll) {' +
                            'return;' +
                        '}' +
                        'preTop = scrollElem.scrollTop;' +
                        'scrollElem.scrollTop += 1;' +
                        'if (preTop == scrollElem.scrollTop) {' +
                            'scrollElem.scrollTop = 0;' +
                            'scrollElem.scrollTop += 1;' +
                        '}' +
                    '}' +
                '<\/script>' +
                '<script type="text/javascript">' +
                    'var timeInterval = 1000 * 60 * 2;' +
                    '$(document).ready(function () {' +
                        'ResizeAll();' +
                    '});' +
                    '$(window).resize(function () {' +
                        'ResizeAll();' +
                        'if (echart1 != null) { echart1.resize(); }' +
                        'if (echart2 != null) { echart2.resize(); }' +
                        'if (echart3 != null) { echart3.resize(); }' +
                        'if (echart4 != null) { echart4.resize(); }' +
                    '});' +
                    'function ResizeAll() {' +
                        '$(".gauge").height($(window).height() * 0.9 * 0.27);' +
                        'var _contentHeight = $(window).height() * 0.9 * 0.3;' +
                        '$(".rows").height(_contentHeight * 0.13);' +
                        'if ($(".rows").length * _contentHeight * 0.16 > _contentHeight) {' +
                            '$("#_layout_left_data_div_tbody").height(_contentHeight - _contentHeight * 0.16 * 2 - 2);' +
                            '_InitScroll("_layout_left_data_div_tbody", "_layout_left_data_div2_tbody", 1000, 150, 1000 * 6);' +
                            'isScroll = true;' +
                        '}' +
                    '}' +
                '<\/script>' +
                '<script type="text/javascript">' +
                    'var option1, option2, option3, option4, echart1, echart2, echart3, echart4;' +
                    'option1 = {' +
                        'series: [' +
                        '{' +
                            'startAngle: 180,' +
                            'endAngle: 0,' +
                            'type: \'gauge\',' +
                            'center: [\'50%\',\'75%\'],' +
                            'radius: \'150%\',' +
                            'min: 0,' +
                            'max: 100,' +
                            'splitNumber: 4,' +
                            'axisLine: {' +
                                'lineStyle: {' +
                                    'color: [[0.2, \'#447DFF\'], [0.8, \'#32E0E7\'], [1, \'#447DFE\']],' +
                                    'width: 20,' +
                                    'shadowColor: \'#fff\',' +
                                    'shadowBlur: 2' +
                                '}' +
                            '},' +
                            'axisLabel: {' +
                                'show: true,' +
                                'formatter: function (value) {' +
                                    'return parseInt(value) + "%";' +
                                '}' +
                            '},' +
                            'detail: {' +
                                'formatter: "生产进度 {value}%",' +
                                'offsetCenter: [0, \'20%\'],' +
                                'textStyle: {' +
                                    'color: \'#3CA2B0\',' +
                                    'fontSize: 20' +
                                '}' +
                            '},' +
                            'data: [{ value: 0 }]' +
                        '}],' +
                        'tooltip: {' +
                            'formatter: function (p) {' +
                                'return \'（该车间工单当天实际产出数累计/当天计划数累计）*100%\';' +
                            '},' +
                            'position:[\'5%\',\'50%\']' +
                        '}' +
                    '};' +
                    'option2 = {' +
                        'series: [' +
                        '{' +
                            'startAngle: 180,' +
                            'endAngle: 0,' +
                            'type: \'gauge\',' +
                            'center: [\'50%\', \'75%\'],' +
                            'radius: \'150%\',' +
                            'min: 0,' +
                            'max: 100,' +
                            'splitNumber: 4,' +
                            'axisLine: {' +
                                'lineStyle: { ' +
                                    'color: [[0.2, \'#F14842\'], [0.8, \'#F1CB52\'], [1, \'#1EB950\']],' +
                                    'width: 20,' +
                                    'shadowColor: \'#fff\',' +
                                    'shadowBlur: 2' +
                                '}' +
                            '},' +
                            'axisLabel: {' +
                                'show: true,' +
                                'formatter: function (value) {' +
                                    'return parseInt(value) + "%";' +
                                '}' +
                            '},' +
                            'detail: {' +
                                'formatter: "IE效率 {value}%",' +
                                'offsetCenter: [0, \'20%\'],' +
                                'textStyle: {' +
                                    'color: \'#3CA2B0\',' +
                                    'fontSize: 20' +
                                '}' +
                            '},' +
                            'data: [{ value: 0 }]' +
                        '}],' +
                        'tooltip: {' +
                            'formatter: function (p) {' +
                                'return \'总装单机型IE效率取平均值：<br/>各机型IE效率＝(（各机型瓶颈时间（单位为秒）*该机型当前产出数）<br/>/（各机型最后一片板产出时间－各机型第一片板投入时间-异常时间）)*3600*100%\';' +
                            '},' +
                            'position: [\'0%\', \'30%\']' +
                        '}' +
                    '};' +
                    'option3 = {' +
                        'series: [' +
                        '{' +
                            'startAngle: 180,' +
                            'endAngle: 0,' +
                            'type: \'gauge\',' +
                            'center: [\'50%\', \'75%\'],' +
                            'radius: \'150%\',' +
                            'min: 0,' +
                            'max: 100,' +
                            'splitNumber: 4,' +
                            'axisLine: {' +
                                'lineStyle: {' +
                                    'color: [[0.2, \'#447DFF\'], [0.8, \'#32E0E7\'], [1, \'#447DFE\']],' +
                                    'width: 20,' +
                                    'shadowColor: \'#fff\',' +
                                    'shadowBlur: 2' +
                                '}' +
                            '},' +
                            'axisLabel: {' +
                                'show: true,' +
                                'formatter: function (value) {' +
                                    'return parseInt(value) + "%";' +
                                '}' +
                            '},' +
                            'detail: {' +
                                'formatter: "直通率 {value}%",' +
                                'offsetCenter: [0, \'20%\'],' +
                                'textStyle: {' +
                                    'color: \'#3CA2B0\',' +
                                    'fontSize: 20' +
                                '}' +
                            '},' +
                            'data: [{ value: 0 }]' +
                        '}],' +
                        'tooltip: {' +
                            'formatter: function (p) {' +
                                'return \'(车间当天对应工单白卡数累计/车间当天产出数累计)*100%\';' +
                            '},' +
                            'position: [\'0%\', \'50%\']' +
                        '}' +
                    '};' +
                    'option4 = {' +
                        'title: {' +
                            'text: \'UPH产能对标\',' +
                            'textStyle: {' +
                                'fontSize: 16,' +
                                'color: \'#FFFFFF\',' +
                            '},' +
                            'left: \'10\'' +
                        '},' +
                        'tooltip: {' +
                            'trigger: \'axis\'' +
                        '},' +
                        'grid: {' +
                            'left: \'7%\',' +
                            'right: \'7%\',' +
                            'bottom: \'7%\',' +
                            'containLabel: true,' +
                            'show: false,' +
                        '},' +
                        'legend: {' +
                            'selected: {' +
                                '\'达成率\': false' +
                            '},' +
                            'textStyle: {' +
                                'fontSize: 15,' +
                                'color: \'#4EC9CE\'' +
                            '},' +
                            'data: []' +
                        '},' +
                        'calculable: true,' +
                        'xAxis: [' +
                        '{' +
                            'type: \'category\',' +
                            'data: [],' +
                            'axisLabel: {' +
                                'textStyle: {' +
                                    'color: \'#4EC9CE\',' +
                                    'fontSize: 16,' +
                                '}' +
                            '},' +
                            'axisLine: {' +
                                'lineStyle: {' +
                                    'color: \'#4EC9CE\',' +
                                '}' +
                            '},' +
                            'splitLine: {' +
                                'show: false' +
                            '}' +
                        '}],' +
                        'yAxis: [' +
                        '{' +
                            'type: \'value\',' +
                            'name: \'产能\',' +
                            'position: \'left\',' +
                            'axisLabel: {' +
                                'textStyle: {' +
                                    'color: \'#4EC9CE\',' +
                                    'fontSize:15,' +
                                '}' +
                            '},' +
                            'axisLine: {' +
                                'lineStyle: {' +
                                    'color: \'#4EC9CE\',' +
                                '}' +
                            '},' +
                            'splitLine: {' +
                                'lineStyle: {' +
                                    'color: \'#45576F\',' +
                                '}' +
                            '}' +
                        '},' +
                        '{' +
                            'type: \'value\',' +
                            'axisLine: { onZero: true },' +
                            'name: \'达成率\',' +
                            'position: \'right\',' +
                            'min: 0,' +
                            'max: 100,' +
                            'splitLine: {' +
                                'show: false' +
                            '},' +
                            'axisLabel: {' +
                                'formatter: \'{value}%\',' +
                                'textStyle: {' +
                                    'color: \'#4EC9CE\',' +
                                    'fontSize: 15,' +
                                '}' +
                            '},' +
                            'axisLine: {' +
                                'lineStyle: {' +
                                    'color: \'#4EC9CE\',' +
                                '}' +
                            '}' +
                        '}],' +
                        'series: []' +
                    '};' +
                    'function getGaugeMaxVal(value) {' +
                        'value = parseFloat(value);' +
                        'var maxValue = 100;' +
                        'if (value > maxValue) {' +
                            'var temp = parseInt(value);' +
                            'if (temp > value) {' +
                                'return temp;' +
                            '}' +
                            'maxValue = value + 1;' +
                        '}' +
                        'return maxValue;' +
                    '}' +
                    'function initEcharts(data) {' +
                        'var value = 0;' +
                        'echart1 = echarts.init(document.getElementById(\'echarts_gauge1\'));' +
                        'echart2 = echarts.init(document.getElementById(\'echarts_gauge2\'));' +
                        'echart3 = echarts.init(document.getElementById(\'echarts_gauge3\'));' +
                        'value = data.Progress;' +
                        'option1.series[0].max = getGaugeMaxVal(value);' +
                        'option1.series[0].data[0].value = value;' +
                        'echart1.setOption(option1, true);' +
                        'value = data.IEEfficiency;' +
                        'option2.series[0].max = getGaugeMaxVal(value);' +
                        'option2.series[0].data[0].value = value;' +
                        'echart2.setOption(option2, true);' +
                        'value = data.FPY;' +
                        'option3.series[0].max = getGaugeMaxVal(value);' +
                        'option3.series[0].data[0].value = value;' +
                        'echart3.setOption(option3, true);' +
                    '}' +
                    'function initProductionUPH() {' +
                        'echart4 = echarts.init(document.getElementById("echarts_uph"));' +
                        '$.ajax({' +
                            'type: \'POST\',' +
                            'url: \'../Handler/SMTLineProduction.ashx\',' +
                            'data: { \'Type\': \'ProductionUPH\', \'LineId\': lineId, \'WorkshopId\': -1 },' +
                            'dataType: \'json\',' +
                            'success: function (data) {' +
                                'option4.series = [];' +
                                'option4.xAxis[0].data = data.Axis;' +
                                'option4.xAxis[0].data[data.Axis.length - 1] =' +
                                '{' +
                                    'value: data.Axis[data.Axis.length - 1],' +
                                    'textStyle: {' +
                                        'color: \'#447DFF\',' +
                                        'fontWeight: \'bold\'' +
                                    '}' +
                                '};' +
                                'option4.legend.data = data.Legen;' +
                                'option4.series.push({' +
                                    'name: \'\',' +
                                    'type: \'bar\',' +
                                    'yAxisIndex: 0,' +
                                    'data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],' +
                                    'stack: groupName,' +
                                    'label: {' +
                                        'normal: {' +
                                            'show: true,' +
                                            'position: \'inside\',' +
                                            'textStyle: {' +
                                                'color: \'#3CA2B0\',' +
                                                'fontWeight: \'lighter\',' +
                                                'fontSize: 10' +
                                            '},' +
                                            'formatter: function (p) {' +
                                                'if (p.value === 0) { return ""; }' +
                                                'return p.value;' +
                                            '}' +
                                        '}' +
                                    '}' +
                                '});' +
                                'if (data == null || data.Series == null || data.Series.length < 1) { return false; }' +
                                'if (data.Series[0].length > 0) { option4.series = []; }' +
                                'var maxUPH = 0;' +
                                'var SumOutput = 0;' +
                                '$.each(data.Series, function () {' +
                                    '$.each(this, function () {' +
                                        'if (this.StandardCapacity > maxUPH) {' +
                                            'maxUPH = this.StandardCapacity;' +
                                        '}' +
                                        'if (this.SumOutput > SumOutput) {' +
                                            'SumOutput = this.SumOutput;' +
                                        '}' +
                                    '});' +
                                '});' +
                                'var maxRate = 0;' +
                                'for (var i = 0; i < data.Series[0].length; i++) {' +
                                    'var arrUPH = new Array();' +
                                    'var arrRate = new Array();' +
                                    'var arrOutput = new Array();' +
                                    'for (var j = 0; j < data.Series.length; j++) {' +
                                        'arrOutput.push(data.Series[j][i].SumOutput);' +
                                        'arrUPH.push(data.Series[j][i].SumOutput > 0 ? (SumOutput * 0.1).toFixed(\'0\') : 0);' +
                                        'var rate = parseFloat(data.Series[j][i].SumOutput > 0 ? (data.Series[j][i].SumOutput / data.Series[j][i].StandardCapacity * 100).toFixed(2) : 0);' +
                                        'arrRate.push(rate);' +
                                        'maxRate = rate > maxRate ? rate : maxRate;' +
                                   '}' +
                                    'var groupName = "sum" + i;' +
                                    'option4.series.push({' +
                                        'name: data.Series[0][i].ItemName,' +
                                        'type: \'bar\',' +
                                        'yAxisIndex: 0,' +
                                        'data: arrOutput,' +
                                        'stack: groupName,' +
                                        'label: {' +
                                            'normal: {' +
                                                'show: true,' +
                                                'position: \'inside\',' +
                                                'textStyle: {' +
                                                    'color: \'#24244f\',' +
                                                    'fontWeight: \'lighter\',' +
                                                    'fontSize: 10' +
                                                '},' +
                                                'formatter: function (p) {' +
                                                    'if (p.value === 0) { return ""; }' +
                                                    'return p.value;' +
                                                '}' +
                                            '}' +
                                        '},' +
                                        'itemStyle: {' +
                                            'normal: {' +
                                                'color: function (p) {' +
                                                    'var colorList = [\'#32e0e7\', \'#148fe4\', \'#fbfa23\', \'#32E0E7\', \'#826A4F\', \'#51DE8A\', \'#fbfa23\', \'#447DFE\', \'#95CA13\', \'#1EB950\', \'#266CA3\', \'#CA8622\', \'#25851D\', \'#ADC7B8\'];' +
                                                    'var index = p.seriesIndex;' +
                                                    'return colorList[index / (data.Series[0].length+1)];' +
                                                '}' +
                                            '}' +
                                        '}' +
                                    '});' +
                                    'option4.series.push({' +
                                        'name: i,' +
                                        'type: \'bar\',' +
                                        'yAxisIndex: 0,' +
                                        'data: arrUPH,' +
                                        'stack: groupName,' +
                                        'label: {' +
                                            'normal: {' +
                                                'show: true,' +
                                                'position: \'inside\',' +
                                                'textStyle: {' +
                                                    'fontWeight: \'lighter\',' +
                                                    'color: \'#24244f\',' +
                                                    'fontSize: 10' +
                                                '},' +
                                                'formatter: function (p) {' +
                                                    'if (p.value === 0) { return ""; }' +
                                                    'var uph = 0;' +
                                                    'if (data.Axis.indexOf(p.name) === -1 && data.Axis[data.Axis.length - 1].value === p.name) {' +
                                                        'uph = data.Series[data.Axis.length - 1][p.seriesName].StandardCapacity;' +
                                                    '} else {' +
                                                        'uph = data.Series[data.Axis.indexOf(p.name)][p.seriesName].StandardCapacity;' +
                                                    '}' +
                                                    'return uph;' +
                                                '}' +
                                            '}' +
                                       '},' +
                                        'itemStyle: {' +
                                            'normal: {' +
                                                'color: function (p) {' +
                                                    'if (p.value === 0) { return ""; }' +
                                                    'var uph, output;' +
                                                    'if (data.Axis.indexOf(p.name) === -1 && data.Axis[data.Axis.length - 1].value === p.name) {' +
                                                        'uph = data.Series[data.Axis.length - 1][p.seriesName].StandardCapacity;' +
                                                        'ouput = data.Series[data.Axis.length - 1][p.seriesName].SumOutput;' +
                                                    '} else {' +
                                                        'uph = data.Series[data.Axis.indexOf(p.name)][p.seriesName].StandardCapacity;' +
                                                        'ouput = data.Series[data.Axis.indexOf(p.name)][p.seriesName].SumOutput;' +
                                                    '}' +
                                                       'return ouput >= uph ? "#008100" : "#e13934";' +
                                                '}' +
                                            '}' +
                                        '}' +
                                    '});' +
                                    'option4.series.push({' +
                                        'name: data.Series[0][i].ItemName,' +
                                        'type: \'line\',' +
                                        'yAxisIndex: 1,' +
                                        'data: arrRate,' +
                                        'itemStyle: {' +
                                            'normal: {' +
                                                'color: "#447DFE",' +
                                                'label: {' +
                                                    'show: true,' +
                                                    'formatter: \'{c}%\',' +
                                                    'textStyle: {' +
                                                        'color: \'#fff\'' +
                                                    '}' +
                                                '}' +
                                            '}' +
                                        '}' +
                                    '});' +
                                '}' +
                                'option4.yAxis[1].max = parseInt(maxRate);' +
                                'echart4.setOption(option4);' +
                                'clearTimeout(uphTimeout);' +
                                'var uphTimeout = setTimeout("initProductionUPH()", timeInterval);' +
                            '}' +
                        '});' +
                    '}' +
                    'var lineId, lineName, welcomeMsg;' +
                    '$(document).ready(function () {' +
                        'lineId = getQueryString("lineId");' +
                        'lineName = getQueryString("lineName");' +
                        'welcomeMsg = "";' +
                        '$("#_left_top_title").html(lineName + "生产日看板");' +
                        'getWelcome();' +
                        'getLineInfo();' +
                        'initProductionUPH();' +
                        'initProductionData();' +
                    '});' +
                    'function getWelcome() {' +
                        'var entityPrameter = {};' +
                        'entityPrameter.WorkshopId = -1;' +
                        'entityPrameter.LineId = lineId;' +
                        'entityPrameter.KanBanType = 1;' +
                        'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetKanBanWelcomeTemplate", JSON.stringify(entityPrameter), "1");' +
                        'if (ajax.error != null) {' +
                            'alert(ajax.error.Message);' +
                            'return false;' +
                        '}' +
                        'var str = JSON.parse(ajax.value).data;' +
                        'welcomeMsg = str[0].WelcomeStr;' +
                        '$("#dateAndWeek").html(SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetServerDateAndWeek().value);' +
                        '$("#_left_top_welcome_text").html(welcomeMsg);' +
                        'clearTimeout(gwTimeout);' +
                        'var gwTimeout = setTimeout("getWelcome()", 1000 * 60 * 1);' +
                    '}' +
                    'function getLineInfo() {' +
                        'var entityPrameter = {};' +
                        'entityPrameter.FieldValue = lineId;' +
                        'entityPrameter.IsByID = true;' +
                        'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("Basal_Line_GetInfo", JSON.stringify(entityPrameter), "1");' +
                        'if (ajax.error != null) {' +
                            'alert(ajax.error.Message);' +
                            'return false;' +
                        '}' +
                        'var ajaxResult = JSON.parse(ajax.value).data;' +
                        '$("#tdLineName").html(ajaxResult[0].LineName);' +
                        '$("#tdPrincipal").html(ajaxResult[0].PrincipalName);' +
                        '$("#tdStandardHuman").html(ajaxResult[0].StandardHuman);' +
                        '$("#tdActualNumber").html(ajaxResult[0].ActualNumber);' +
                        '$.ajax({' +
                            'type: \'GET\',' +
                            'url: \'../Handler/UploadPortraits.ashx\',' +
                            'data: { \'Type\':\'Refresh\', \'UserId\': ajaxResult[0].Principal },' +
                            'dataType: \'text\',' +
                            'success: function (data) {' +
                                '$("#imgPortraits").attr("src", "../Content/Images/Portraits/" + data + "?rnd=" + Math.random());' +
                                'clearTimeout(lineInfoTimeout);' +
                                'var lineInfoTimeout = setTimeout("getLineInfo()", timeInterval);' +
                            '},' +
                            'error: function () {' +
                                'return false;' +
                            '}' +
                        '});' +
                        '}' +
                        'function initProductionData() {' +
                            '$("#data_tbody tbody").html("");' +
                            '$.ajax({' +
                                'type: \'POST\',' +
                                'url: \'../Handler/SMTLineProduction.ashx\',' +
                                'data: { \'Type\': \'ProductionData\', \'LineId\': lineId, \'WorkshopId\': -1 },' +
                                'dataType: \'json\',' +
                                'success: function (data) {' +
                                    'if (data == null) { return false; }' +
                                    '$.each(data.List, function () {' +
                                        '$("<tr class=\'rows\'>" +' +
                                        '"<td width=\'6%\'>" + this.LineName + "</td>" +' +
                                        '"<td width=\'12%\'>" + this.CustomerOrder + "</td>" +' +
                                        '"<td width=\'15%\'>" + this.OrderNo + "</td>" +' +
                                        '"<td width=\'12%\'>" + this.ItemCode + "</td>" +' +
                                        '"<td width=\'8%\'>" + this.QtyToBuild + "</td>" +' +
                                        '"<td width=\'4%\'>" + this.Surface + "</td>" +' +
                                        '"<td width=\'6%\'>" + this.Designed + "</td>" +' +
                                        '"<td width=\'6%\'>" + this.Input + "</td>" +' +
                                        '"<td width=\'6%\'>" + this.Output + "</td>" +' +
                                        '"<td width=\'6%\'>" + this.Defects + "</td>" +' +
                                        '"<td width=\'6%\'>" + this.AllOutput + "</td>" +' +
                                        '"<td width=\'6%\'>" + this.AllDefects + "</td>" +' +
                                        '"<td width=\'8%\'>" + this.Status + "</td></tr>").appendTo($("#data_tbody tbody"));' +
                                    '});' +
                                    '$("#data_tfoot tbody tr td:eq(4)").html(data.SumQtyToBuild);' +
                                    '$("#data_tfoot tbody tr td:eq(6)").html(data.SumDesigned);' +
                                    '$("#data_tfoot tbody tr td:eq(7)").html(data.SumInput);' +
                                    '$("#data_tfoot tbody tr td:eq(8)").html(data.SumOutput);' +
                                    '$("#data_tfoot tbody tr td:eq(9)").html(data.SumDefects);' +
                                    '$("#data_tfoot tbody tr td:eq(10)").html(data.AllOutput);' +
                                    '$("#data_tfoot tbody tr td:eq(11)").html(data.AllDefects);' +
                                    '$("#tdUPPH").html(data.UPPH);' +
                                    'ResizeAll();' +
                                    'initEcharts(data);' +
                                '}' +
                            '});' +
                            'clearTimeout(ProductionDataTimeout);' +
                            'var ProductionDataTimeout = setTimeout("initProductionData()", timeInterval);' +
                        '}' +
                        'function getQueryString(name) {' +
                            'var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");' +
                            'var r = window.location.search.substr(1).match(reg);' +
                            'if (r != null) return unescape(r[2]); return null;' +
                        '}' +
                '<\/script>' +
                   '@@@@@@@@@@;' +
                   '<div id="btnFullShow" title="全屏显示" style="font-size: 12px; background:#f1f1f1;font-weight:bold;color:red; padding:5px; cursor: pointer;  display: none; position:absolute; top:5px; left:5px; z-index:1000000;" class="btn-default">' +
                   '<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAy0lEQVQ4T7WT7RHBQBCGn1QgJdBBSqATOqACUgEd0EmUQAWUoAPmzWTHZe2NGNyvu73d5/bjvQK4019nYArcnL0CjsAotRcOkAu2mBeIB6yAnXvZHzfA2owG0MsHYAssun3EmQN7oAaWKkeAU1KzOUQQf9eWI0DpGiZHlTFO7NpfguwqAaLlofIR5Oqdc4A3fXxe/w3wUQlREzXOydAmfjPGxoQkiISk8Q0RktQoIZU/k7LNRZnMgp+YfqamE19r8xnIloNIur1gOT8AdoQ+SAtB/HUAAAAASUVORK5CYII="/> 全屏显示</div>' +
                    '<table id="_layout">' +
                        '<tr>' +
                            '<td valign="top" style="border-right: 5px solid #041622;">' +
                                '<table id="_layout_left_table">' +
                                    '<tr style="height: 9%; background-color: #0D213A;">' +
                                        '<td>' +
                                            '<table style="width: 100%;" cellpadding="5" cellspacing="5" border="0">' +
                                                '<tr>' +
                                                    '<td id="_left_top_welcome">' +
                                                        '<marquee id="marquee" behavior="scroll" onstart="this.firstChild.innerHTML+=this.firstChild.innerHTML;" scrollamount="3" onmouseover="this.stop();" loop="-1" onmouseout="this.start();">' +
                                                '<div id="_left_top_welcome_text" style=" padding-top:5px; padding-bottom:5px;">' +
                                                '</div>' +
                                            '</marquee>' +
                                                    '</td>' +
                                                '</tr>' +
                                                '<tr style="margin-top: 2px;">' +
                                                    '<td align="center">' +
                                                        '<div id="_left_top_title" style="float: inherit; margin-bottom: 10px;">-</div>' +
                                                    '</td>' +
                                                '</tr>' +
                                            '</table>' +
                                        '</td>' +
                                    '</tr>' +
                                    '<tr style="height: 90%;">' +
                                        '<td valign="top">' +
                                            '<div style="width: 100%; height: 100%; background-color: #041622; border-top: 5px solid #041622;">' +
                                                '<div style="height: 30%; background-color: #0E223B; display: table; width: 100%;">' +
                                                    '<div style="display: table-cell; width: 100%; vertical-align: middle;">' +
                                                        '<table id="data_thead" style="width: 98%; height: 16%; margin: 0 auto; font-size: 21px;">' +
                                                            '<tbody>' +
                                                                '<tr class="rows" style="border-left: 1px solid #263C54; border-right: 1px solid #263C54;">' +
                                                                    '<th width="6%">线体' +
                                                                    '</th>' +
                                                                    '<th width="12%">订单号' +
                                                                    '</th>' +
                                                                    '<th width="15%">工单' +
                                                                    '</th>' +
                                                                    '<th width="12%">产品编码' +
                                                                    '</th>' +
                                                                    '<th width="8%">工单数' +
                                                                    '</th>' +
                                                                    '<th width="4%">面别' +
                                                                    '</th>' +
                                                                    '<th width="6%">计划' +
                                                                    '</th>' +
                                                                    '<th width="6%">投入' +
                                                                    '</th>' +
                                                                    '<th width="6%">产出' +
                                                                    '</th>' +
                                                                    '<th width="6%">不良' +
                                                                    '</th>' +
                                                                    '<th width="6%">总产出' +
                                                                    '</th>' +
                                                                    '<th width="6%">总不良' +
                                                                    '</th>' +
                                                                    '<th width="8%">生产状态' +
                                                                    '</th>' +
                                                                '</tr>' +
                                                            '</tbody>' +
                                                        '</table>' +
                                                        '<div id="_layout_left_data_div_tbody">' +
                                                            '<div id="_layout_left_data_div2_tbody">' +
                                                                '<table id="data_tbody" style="width: 98%; color: #4EC9CE; border-left: 1px solid #263C54; border-right: 1px solid #263C54; margin: 0 auto; font-size: 21px;">' +
                                                                    '<tbody>' +
                                                                    '</tbody>' +
                                                                '</table>' +
                                                            '</div>' +
                                                        '</div>' +
                                                        '<table id="data_tfoot" style="height: 15%; width: 98%; margin: 0 auto; font-size: 21px;">' +
                                                            '<tbody>' +
                                                                '<tr class="rows" style="border-left: 1px solid #263C54; border-right: 1px solid #263C54;">' +
                                                                    '<td width="6%">汇总' +
                                                                    '</td>' +
                                                                    '<td width="12%">-' +
                                                                    '</td>' +
                                                                    '<td width="15%">-' +
                                                                    '</td>' +
                                                                    '<td width="12%">-' +
                                                                    '</td>' +
                                                                    '<td width="8%">0' +
                                                                    '</td>' +
                                                                    '<td width="4%">-' +
                                                                    '</td>' +
                                                                    '<td width="6%">0' +
                                                                    '</td>' +
                                                                    '<td width="6%">0' +
                                                                    '</td>' +
                                                                    '<td width="6%">0' +
                                                                    '</td>' +
                                                                    '<td width="6%">0' +
                                                                    '</td>' +
                                                                    '<td width="6%">0' +
                                                                    '</td>' +
                                                                    '<td width="6%">0' +
                                                                    '</td>' +
                                                                    '<td width="8%">-' +
                                                                    '</td>' +
                                                                '</tr>' +
                                                            '</tbody>' +
                                                        '</table>' +
                                                    '</div>' +
                                                '</div>' +
                                                '<div style="height: 28%; background-color: #0E223B; padding-top: 15px; border-top: 5px solid #041622;">' +
                                                    '<div style="float: left;" id="echarts_gauge1" class="gauge">' +
                                                    '</div>' +
                                                    '<div style="float: left;" id="echarts_gauge2" class="gauge">' +
                                                    '</div>' +
                                                    '<div style="float: right;" id="echarts_gauge3" class="gauge">' +
                                                    '</div>' +
                                                '</div>' +
                                                '<div style="clear: both; height: 39%; background-color: #0E223B; border-top: 5px solid #041622;">' +
                                                    '<div id="echarts_uph" style="height: 100%;">' +
                                                    '</div>' +
                                                '</div>' +
                                            '</div>' +
                                        '</td>' +
                                    '</tr>' +
                                '</table>' +
                            '</td>' +
                            '<td valign="top" style="width: 250px;">' +
                                '<table>' +
                                    '<tr style="height: 9%;">' +
                                        '<td>' +
                                            '<div class="logo_cus" style="height: 100%;"></div>' +
                                        '</td>' +
                                    '</tr>' +
                                    '<tr style="height: 90%;">' +
                                        '<td valign="top">' +
                                           '<div style="width: 100%; height: 40px; padding-top: 3px; padding-bottom: 3px; line-height: 36px; background-color: #0E223B; text-align: center; font-weight: bold; color: #3CA2B0; font-size: 19px; border-bottom: 1px solid #265171; border-top: 5px solid #041622; white-space: nowrap;" id="dateAndWeek"></div>' +
                                            '<div id="lineInfo" style="background-color: #0E223B; height: 26.5%;">' +
                                                '<ul>' +
                                                    '<li>工序段</li>' +
                                                    '<li id="tdLineName" ></li>' +
                                                '</ul>' +
                                                '<ul>' +
                                                    '<li>标准人数</li>' +
                                                    '<li id="tdStandardHuman"></li>' +
                                                '</ul>' +
                                                '<ul>' +
                                                    '<li>实到人数</li>' +
                                                    '<li id="tdActualNumber"></li>' +
                                                '</ul>' +
                                                '<ul>' +
                                                    '<li>UPPH</li>' +
                                                    '<li id="tdUPPH"></li>' +
                                                '</ul>' +
                                            '</div>' +
                                            '<div id="picInfo" style="clear: both; height: 48%; background-color: #0E223B; border-top: 5px solid #041622;">' +
                                                '<table>' +
                                                    '<tr style="height:55px">' +
                                                        '<td style="text-align: center;">线体负责人(<span id="tdPrincipal"></span>)</td>' +
                                                    '</tr>' +
                                                    '<tr>' +
                                                        '<td style="width: 100%; text-align: center;">' +
                                                            '<img src="../Content/images/portraits/default.png" id="imgPortraits" style="width: 90%;height:82%;max-height:250px" alt="头像" title="头像" /></td>' +
                                                    '</tr>' +
                                                '</table>' +
                                            '</div>' +
                                            '<div style="clear: both; height: 18%; " class="logo_skt">' +
                                            '</div>' +
                                        '</td>' +
                                    '</tr>' +
                                '</table>' +
                            '</td>' +
                        '</tr>' +
                    '</table>' +
                    '<script type="text/javascript">' +
                       'var fullShow ="";'+
                       'if(window.location.href.indexOf("&full=1")>-1){' +
                           'fullShow = "1";' +
                       '}'+
                       '$("#btnFullShow").hide();'+
                       '$(function () {' +
                           'scrollOverflow();' +
                           '$(window).resize(function () {' +
                               'scrollOverflow();' +
                           '});' +
                           'fullMode();' +
                           'if (fullShow === "1") {' +
                               '$("#btnFullShow").show();' +
                           '}else{' +
                                '$(window).keydown(function (event) {' +
                                    'if (event.keyCode == 27) {' +
                                      'window.opener = null;' +
                                      'window.open("", "_self");' +
                                      'window.close();' +
                                    '}' +
                                '});' +
                            '}' +
                       '});' +
                       'function scrollOverflow() {' +
                           '$(\'li.marquee\').each(function () {' +
                               'if (this.offsetWidth + 5 < this.scrollWidth)' +
                                   '$(this).html(\'<marquee style="padding:0;margin:0px; margin-bottom:-20px; " behavior="alternate" direction="left" scrolldelay="20" scrollamount="1"  onmouseover="this.stop()" onmouseout="this.start()">\' + this.innerHTML +\'</marquee>\');' +
                           '});' +
                       '}' +
                       'function fullMode() {' +
                            '$("#btnFullShow").click(function () {' +
                            'var PName1="' + PName + '";' +
                            'fullShow="";' +
                            'window.open("../CustomMenu/CustomKanBan.aspx?lineId=3262&lineName=S1&welcomeMsg=%u70ED%u70C8%u6B22%u8FCE%u5404%u4F4D%u9886%u5BFC%u8385%u4E34%u53C2%u89C2%u6307%u5BFC&name=CustomKanBan&PaName="+PName1+"&Flag=1", \'newwindow\', \'width=\' + (window.screen.availWidth - 10) + \',height=\' + (window.screen.availHeight - 30) + \',top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no\');' +
                                'return false;' +
                            '});' +
                            'if (fullShow === \'1\') {' +
                                '$("#btnFullShow").css("display", "block");' +
                            '}else{' +
                                '$("#btnFullShow").hide();' +
                             '}' +         
                        '}' +
                    '<\/script>';
            var js_source = strHTML.replace(/^\s+/, '');
            var tabsize = 1;
            var tabchar = ' ';
            var finalHtml = '';
            if (tabsize == 1) {
                tabchar = '\t';
            }
            if (js_source && js_source.charAt(0) === '<') {
                finalHtml = style_html(js_source, tabsize, tabchar, 80);
            } else {
                finalHtml = js_beautify(js_source, tabsize, tabchar);
            }

            var iframes = document.getElementById("ifCtrl");
            iframes.contentWindow.setData(encodeURI(finalHtml));
            //自动调用保存功能  保障预览功能正常
            Save(1);
        }
        //控制图模版
        function showTemplateCode(cindex) {
            //展示从页面模版
            PageSub = true;
            $("#ifCtrl1").show();
            if (cindex == 1) {
                var subHtml ='<table width="100%" cellpadding="0" cellspacing="0" border="0" id="xbarTb-header">' +
                    '<tr>' +
                    '<td rowspan="2" style="width: 100px; font-size: 14px;">' +
                    '制 品<br />名 称</td>' +
                    '<td rowspan="2" bgcolor="#CCFFFF" style="min-width: 120px;">' +
                    '<span id="lblItemName" style="font-weight: bold; font-size: 16px;"></span></td>' +
                    '<td style="width: 70px;">规 格</td>' +
                    '<td style="width: 70px;">标 准</td>' +
                    '<td style="width: 80px;">群组数大小</td>' +
                    '<td style="width: 70px;">控 制</td>' +
                    '<td style="width: 60px;"><span style="text-decoration: overline">X</span> 图</td>' +
                    '<td style="width: 60px;">R 图</td>' +
                    '<td rowspan="2" style="width: 80px;">线 别</td>' +
                    '<td rowspan="2" bgcolor="#CCFFFF" style="width: 120px;"><span id="lblDepartment" style="font-size: 13px;"></span></td>' +
                    '<td rowspan="2" style="width: 70px;">时 间</td>' +
                    '<td rowspan="2" bgcolor="#CCFFFF" style="width: 120px;"> <span id="lblTime"></span></td>' +
                    '</tr>' +
                    '<tr><td>上限 USL</td>' +
                    '<td bgcolor="#CCFFFF"><span id="lblUsl" style="font-weight: bold; font-size: 13px;"></span></td>' +
                    '<td><span id="lblGropupQty"></span></td>' +
                    '<td>上限 UCL</td>' +
                    '<td><span id="lblXucl"></span></td>' +
                    '<td><span id="lblRucl"></span></td>' +
                    '</tr>' +
                    '<tr>' +
                    '<td>控制项目</td>' +
                    '<td bgcolor="#CCFFFF"><span id="lblProjectName"></span></td>' +
                    '<td>中心限SL</td>' +
                    '<td bgcolor="#CCFFFF"><span id="lblCl" style="font-weight: bold; font-size: 13px;"></span></td>' +
                    '<td>总组数</td>' +
                    '<td>中心限CL</td>' +
                    '<td><span id="lblXcl"></span></td>' +
                    '<td><span id="lblRcl"></span></td>' +
                    '<td>工 序</td><td bgcolor="#CCFFFF"><span id="lblMachine" style="font-size: 13px;"></span></td>' +
                    '<td>抽样方法</td>' +
                    '<td bgcolor="#CCFFFF"><span id="lblSampling">随机</span></td>' +
                    '</tr>' +
                    '<tr>' +
                    '<td> 测量单位</td>' +
                    '<td bgcolor="#CCFFFF"><span id="lblUnits"></span></td>' +
                    '<td>下限 LSL</td>' +
                    '<td bgcolor="#CCFFFF"><span id="lblLsl" style="font-weight: bold; font-size: 13px;"></span></td>' +
                    '<td><span id="lblTotalGroupQty"></span></td>' +
                    '<td>下限 LCL</td>' +
                    '<td><span id="lblXlcl"></span></td>' +
                    '<td><span id="lblRlcl"></span></td>' +
                    '<td></td>' +
                    '<td bgcolor="#CCFFFF"><span id="lblOperator" style="font-size: 13px;"></span></td>' +
                    '<td>日 期</td>' +
                    '<td bgcolor="#CCFFFF"><span id="lblDate"> <%=DateTime.Now.Date.ToShortDateString() %></span></td></tr>' +
                    '</table>' +
                    '<div id="createtable"></div>' +
                    '<table style="width: 100%; margin-top: -1px; margin-bottom: 3px;" id="xbarTb-graph">' +
                    '<tr>' +
                    '<td style="width: 100px;">' +
                    '<span style="text-decoration: overline">X</span><br />控<br />制<br />图<br /></td>' +
                    '<td><div id="xcharts" style="height: 200px;"></div></td>' +
                    '<td rowspan="2" style="width: 120px; vertical-align: top;"><div style=\'width: 121px; padding: 0px; margin: -2px 0px 0px -2px; text-align: left;\'>' +
                    '<ul id="processUl">' +
                    '<li style=\'height: 26px; line-height: 26px; background-color: #C0C0C0; text-align: center;\'>制程能力分析</li>' +
                    '<li>Std.Dev.=<span id="lblStddev"></span></li>' +
                    '<li>Sigma&nbsp;=<span id="lblSigma"></span></li>' +
                    '<li>PPK&nbsp;=<span id="lblPPK"></span></li>' +
                    '<li>PP&nbsp;=&nbsp;<span id="lblPP"></span></li>' +
                    '<li>Ca&nbsp;=&nbsp;<span id="lblCa"></span></li>' +
                    '<li>CPK&nbsp;=&nbsp;<span id="lblCPK"></span></li>' +
                    '<li>CP&nbsp;=&nbsp;<span id="lblCP"></span></li>' +
                    '<li>Grade&nbsp;=&nbsp;<span id="lblGrade"></span></li>' +
                    '</ul>' +
                    '</div> </td></tr>' +
                    '<tr><td>' +
                    'R<br />' +
                    '控<br />' +
                    '制<br />' +
                    '图<br />' +
                    '</td>' +
                    '<td style="border: solid 1px #a0c6e5;">' +
                    '<div id="rcharts" style="height: 200px;"></div> </td></tr>'+
                    '</table>'+
                    '<input type="hidden" id="hidSpliceQty" value="0" />'+
                    '<input type="hidden" id="hidNqty" value="0" />'+
                    '<input type="hidden" id="hidCurrentNqty" value="0" />'+
                    '<script src="../Content/plugin/echarts/echarts.min.js" type="text/javascript"><\/script>'+
                    '<script type="text/javascript">' +
                    'var spcTaskId = window.localStorage.getItem("SPCTaskId");;' +
                    'var totalGroupQty = 25;'+
                    'var groupQty = 6;'+
                    'var decimalPoint = 2;'+
                    'var spcJson = [];'+
                    'var xGraphData = [];'+
                    'var rGraphData = [];'+
                    'var subGraphpData = [];'+
                    'var xUclData = [];'+
                    'var xClData = [];'+
                    'var xLclData = [];'+
                    'var rUclData = [];'+
                    'var rClData = [];'+
                    'var rLclData = [];'+
                    'var GmaxArr = [];'+
                    'var GminArr = [];'+
                    'var graphWarnData = [];'+
                    'var exresult = 0;'+
                    'var erresult = 0;'+
                    'var xavg = 0;'+
                    'var nQty = 0;'+
                    'var lsl = 0;'+
                    'var usl = 0;'+
                    'var stddev = 0;'+
                    'var xChartsGraph;'+
                    'var rChartsGraph;'+
                    'var refeshInterval;'+
                    'var spliceQty = 0;'+
                    'var spliceLen = 0;'+
                    'var dataCount = 0;'+
                    'var isGroup = false;'+
                    'var IsCurve = 0;'+
                    '$().ready(function () {'+
                    'var entity = setHeaderContent();'+
                    'spcJson = getCheckData();'+
                    'createTable(groupQty, totalGroupQty);'+
                    'setResultContent(entity);'+
                    'setTimeout(function () {'+
                    'buildXBarRCharts("xcharts", xGraphData);'+
                    'buildXBarRCharts("rcharts", rGraphData);'+
                    'graphWarn(entity);'+
                    ' }, 100);'+
                    'setInterval(function () { Refresh(); }, refeshInterval);'+
                    'timerTick();'+
                    '});'+
                    'function Refresh() {'+
                    'var record = 0;'+
                    'spliceLen = 0;'+
                    'spcJson = getCheckData();'+
                    'nQty = 0;'+
                    'lsl = 0;'+
                    'usl = 0;'+
                    'xGraphData = [];'+
                    'rGraphData = [];'+
                    'subGraphpData = [];'+
                    'exresult = 0;'+
                    'erresult = 0;'+
                    'xavg = 0;'+
                    'stddev = 0;'+
                    '$("#createtable").empty();'+
                    'var entity = setHeaderContent();'+
                    'createTable(groupQty, totalGroupQty);'+
                    'setResultContent(entity);'+
                    'setTimeout(function () {'+
                        '$.each(xGraphData, function (index, item) {'+
                            'if (item > xUclData[index] || item < xLclData[index]) {'+
                                'if (item > usl || item < lsl) {'+
                                    '$("#xbarTb-content tr:eq(2) td:eq(" + (index + 2) + ")").css("background-color", "red").css("color", "#000");'+
                                    'for (var i = 0; i < groupQty + 2; i++) {'+
                                        '$("#xbarTb-content tr:eq(" + (i + 3) + ") td:eq(" + (index + 1) + ")").css("background-color", "red").css("color", "#000");'+
                                    '}'+
                                '}'+
                                'else {'+
                                    '$("#xbarTb-content tr:eq(2) td:eq(" + (index + 2) + ")").css("background-color", "yellow").css("color", "#000");'+
                                    'for (var i = 0; i < groupQty + 2; i++) {'+
                                        '$("#xbarTb-content tr:eq(" + (i + 3) + ") td:eq(" + (index + 1) + ")").css("background-color", "yellow").css("color", "#000");'+
                                    '}'+
                                '}'+
                                'xGraphData[index] = { value: xGraphData[index],'+
                                    'symbol: \'emptyHeart\','+
                                    'symbolSize: 5,'+
                                    'itemStyle: { normal: { color: \'#ff0000\', label: { show: true}} }'+
                                '};'+
                            '}'+
                        '});'+
                        '$.each(rGraphData, function (index, item) {'+
                            'if (item > rUclData[index] || item < rLclData[index]) {'+
                                '$("#xbarTb-content tr:eq(2) td:eq(" + (index + 2) + ")").css("background-color", "yellow").css("color", "#000");'+
                                'for (var i = 0; i < groupQty + 2; i++) {'+
                                    '$("#xbarTb-content tr:eq(" + (i + 3) + ") td:eq(" + (index + 1) + ")").css("background-color", "yellow").css("color", "#000");'+
                                '}'+
                                'rGraphData[index] = { value: rGraphData[index],'+
                                    'symbol: \'emptyHeart\','+
                                    'symbolSize: 5,'+
                                    'itemStyle: { normal: { color: \'#ff0000\', label: { show: true}} }'+
                                '};'+
                            '}'+
                        '});'+
                        'var option = xChartsGraph.getOption();'+
                        'option.series[0].data = xUclData;'+
                        'option.series[1].data = xClData;'+
                        'option.series[2].data = xLclData;'+
                        'option.series[3].data = xGraphData;'+
                        'xChartsGraph.setOption(option);'+
                        'var roption = rChartsGraph.getOption();'+
                        'roption.series[0].data = rUclData;'+
                        'roption.series[1].data = rClData;'+
                        'roption.series[2].data = rLclData;'+
                        'roption.series[3].data = rGraphData;'+
                        'rChartsGraph.setOption(roption);'+
                        'graphWarn(entity);'+
                    '}, 100);'+
                    '}'+
                    'function getCheckData() {'+
                        'var entityPrameter = {};'+
                        'entityPrameter.SPCTaskId = spcTaskId;'+
                        'entityPrameter.SpliceQty = spliceQty;'+
                        'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetXBarRGraphDataTemplate", JSON.stringify(entityPrameter), "1");' +
                        'if (ajax.error != null) {'+
                            'alert(ajax.error.Message);'+
                            'return false;'+
                        '}'+
                        'var str = JSON.parse(ajax.value).data;' +
                        'if (str == null||str.length==0||str[0].Value=="") {' +
                            'return;'+
                        '}'+
                        'var checkArr = [];'+
                        'var checkChildArr = [];'+
                        'var strArr =str[0].Value.split(\',\');' +
                        'for (var i = 0; i < strArr.length; i++) {'+
                            'if (parseFloat(strArr[i]) >= 0) {' +
                                'if (i % groupQty == 0 && i != 0) {'+
                                    'checkChildArr = [];'+
                                    'checkChildArr.push(decimal(parseFloat(strArr[i]), decimalPoint));' +
                                    'checkArr.push(checkChildArr);'+
                                '}'+
                                'else {'+
                                    'checkChildArr.push(decimal(parseFloat(strArr[i]), decimalPoint));' +
                                    'if (i == groupQty - 1) {'+
                                        'checkArr.push(checkChildArr);'+
                                    '}'+
                                '}'+
                            '}'+
                        '}'+
                        'if (checkArr.length == 0) {'+
                            'spliceQty = 0;'+
                            'xUclData = [];'+
                            'xClData = [];'+
                            'xLclData = [];'+
                            'rUclData = [];'+
                            'rClData = [];'+
                            'rLclData = [];'+
                            '$("#hidNqty").val(0);'+
                        '}'+
                        '$("#hidSpliceQty").val(spliceQty);'+
                        'var oldCurrentNqty = parseInt($("#hidCurrentNqty").val());'+
                        'var oldSpliceQty = parseInt($("#hidSpliceQty").val());'+
                        'if (checkArr.length > totalGroupQty) {'+
                            'spliceQty = spliceQty + ((checkArr.length - totalGroupQty) * groupQty);'+
                            'spliceLen = (checkArr.length - totalGroupQty);'+
                            'checkArr.splice(0, checkArr.length - totalGroupQty);'+
                        '}'+
                        'var record = 0;'+
                        '$.each(checkArr, function (index) {'+
                            '$.each(checkArr[index], function () {'+
                                'record = record + 1;'+
                            '})'+
                        '});'+
                        '$("#hidCurrentNqty").val(record);'+
                        'dataCount = (spliceQty + record) - (oldSpliceQty + oldCurrentNqty);'+
                        'isGroup = ((oldCurrentNqty % groupQty + dataCount) - groupQty >= 0);'+
                        'return checkArr;'+
                    '}'+
                    'function setHeaderContent() {'+
                        'var entityPrameter = {};'+
                        'entityPrameter.SPCTaskId = spcTaskId;' +
                        'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetSPCTaskInfo", JSON.stringify(entityPrameter), "1");' +
                        'if (ajax.error != null) {'+
                            'alert(ajax.error.Message);'+
                            'return false;'+
                        '}'+
                        'var entity = JSON.parse(ajax.value).data[0];' +
                        'if(entity==null){alert("未找到相关数据!");return false;}'+
                        'refeshInterval = entity.RefeshInterval == 0 ? (60 * 1000) : decimal(entity.RefeshInterval * 60, 0) * 1000;' +
                        'usl = entity.USL;'+
                        'lsl = entity.LSL;'+
                        'totalGroupQty = entity.GroupQty;'+
                        'groupQty = entity.SampleQty;'+
                        'decimalPoint = entity.SampleDecimalPoint;'+
                        'IsCurve = entity.IsCurve;'+
                        '$("#lblItemName").text(entity.ItemCode);'+
                        '$("#lblProjectName").text(entity.ProjectName);'+
                        '$("#lblUnits").text(entity.Unit);'+
                        '$("#lblUsl").text(usl);'+
                        '$("#lblCl").text(decimal((usl + lsl) / 2, decimalPoint));'+
                        '$("#lblLsl").text(lsl);'+
                        '$("#lblGropupQty").text(groupQty);'+
                        '$("#lblTotalGroupQty").text(totalGroupQty);'+
                        '$("#lblDepartment").text(entity.LineName);'+
                        '$("#lblMachine").text(entity.Station);'+
                        'return entity;'+
                    '}'+
                    'function createTable(rowCount, cellCount) {'+
                        'rowCount = parseInt(rowCount) <= 0 ? 1 : parseInt(rowCount);' +
                        'cellCount=parseInt(cellCount);' +
                        'var table = $("<table style=\'width:100%; margin-top: -1px;\' id=\'xbarTb-content\'>");'+
                        'table.appendTo($("#createtable"));'+
                        'for (var i = 0; i < rowCount + 5; i++) {'+
                            'var tr = $("<tr></tr>");'+
                            'tr.appendTo(table);'+
                            'for (var j = 0; j < cellCount + 3; j++) {'+
                                'var td;'+
                                'var totalVal = 0;'+
                                'if (j == 0) {'+
                                    'continue;'+
                                '}'+
                                'else if (j == 1) {'+
                                    'if (i == 0) {'+
                                        'td = $("<td colspan=\'2\'>日期/时间</td>");'+
                                        'td.appendTo(tr);'+
                                        'continue;'+
                                    '}'+
                                    'else if (i == 1) {'+
                                        'td = $("<td colspan=\'2\'>批 号</td>");'+
                                        'td.appendTo(tr);'+
                                        'continue;'+
                                    '}'+
                                    'else if (i == 2) {'+
                                        'td = $("<td style=\'width: 66px;\'  rowspan=\'" + (rowCount) + "\' >样<br />本<br />测<br />定<br />值</td><td style=\'width: 30px;\' >" + (parseInt(i) - 1) + "</td>");'+
                                        'td.appendTo(tr);'+
                                        'continue;'+
                                    '}'+
                                    'else if (i > 2 && i <= rowCount + 1) {'+
                                        'td = $("<td>" + (parseInt(i) - 1) + "</td>");'+
                                        'td.appendTo(tr);'+
                                        'continue;'+
                                    '}'+
                                    'else if (i == (rowCount + 2)) {'+
                                        'td = $("<td colspan=\'2\'>∑X</td>");'+
                                        'td.appendTo(tr);'+
                                        'continue;'+
                                    '}'+
                                    'else if (i == (rowCount + 3)) {'+
                                        'td = $("<td colspan=\'2\'><span style=\'text-decoration: overline\'>X</span></td>");'+
                                        'td.appendTo(tr);'+
                                        'continue;'+
                                    '}'+
                                    'else if (i == (rowCount + 4)) {'+
                                        'td = $("<td colspan=\'2\'>R</td>");'+
                                        'td.appendTo(tr);'+
                                        'continue;'+
                                    '}'+
                                '}'+
                                'if (j == cellCount + 2 && i == 0) {'+
                                    'td = $("<td rowspan=\'" + (rowCount + 5) + "\' style=\'width: 120px; vertical-align:top;\'><div id=\'divTotal\'></div></td>");'+
                                '}'+
                                'if (j < cellCount + 2) {'+
                                    'if (i == 0) {'+
                                        'td = $("<td bgcolor=\'#99CCFF\'></td>");'+
                                    '}'+
                                    'else if (i == 1) {'+
                                        'td = $("<td>" + (j - 1) + "</td>");'+
                                        'subGraphpData.push((j - 1));'+
                                    '}'+
                                    'else if (i >= 2 && i <= rowCount + 1) {'+
                                        'if (spcJson.length > (j - 2)) {'+
                                            'var cellVal = spcJson[j - 2][i - 2] == undefined ? "" : spcJson[j - 2][i - 2];'+
                                            'var colorVal = "";'+
                                            'if (cellVal > usl) {'+
                                                'colorVal = "style=\'color:blue;font-weight:bold;\'";'+
                                            '}'+
                                            'else if (cellVal < lsl) {'+
                                                'colorVal = "style=\'color:red;font-weight:bold;\'";'+
                                            '}'+
                                            'td = $("<td bgcolor=\'#CCFFFF\' " + colorVal + ">" + cellVal + "</td>");'+
                                        '}'+
                                        'else {'+
                                            'td = $("<td bgcolor=\'#CCFFFF\'></td>");'+
                                        '}'+
                                    '}'+
                                    'else if (i == (rowCount + 2)) {'+
                                        'if (spcJson.length > (j - 2)) {'+
                                            'var cellArr = spcJson[j - 2];'+
                                            'if (cellArr.length == groupQty) {'+
                                                'var seq = 0;'+
                                                '$.each(cellArr, function (index, item) {'+
                                                    'totalVal = totalVal + item;'+
                                                    'seq = seq + (item * item);'+
                                                    'nQty = nQty + 1;'+
                                                '});'+
                                                'stddev = stddev + seq;'+
                                                'exresult = exresult + totalVal;'+
                                                'totalVal = decimal(totalVal, decimalPoint);'+
                                                'td = $("<td style=\'color:#317010;\'>" + totalVal + "</td>");'+
                                            '} else {'+
                                                'td = $("<td></td>");'+
                                            '}'+
                                        '}'+
                                        'else {'+
                                            'td = $("<td></td>");'+
                                        '}'+
                                    '}'+
                                    'else if (i == (rowCount + 3)) {'+
                                        'if (spcJson.length > (j - 2)) {'+
                                            'var cellArr = spcJson[j - 2];'+
                                            'var totalVal = 0;'+
                                            'var avgVal = 0;'+
                                            'if (cellArr.length == groupQty) {'+
                                                '$.each(cellArr, function (index, item) {'+
                                                    'totalVal = totalVal + item;'+
                                                '});'+
                                                'avgVal = totalVal / rowCount;'+
                                                'xGraphData.push(decimal(avgVal, decimalPoint));'+
                                                'xavg = xavg + avgVal;'+
                                                'td = $("<td style=\'color:#372288;\'>" + decimal(avgVal, decimalPoint) + "</td>");'+
                                            '} else {'+
                                                'td = $("<td></td>");'+
                                            '}'+
                                        '}'+
                                        'else {'+
                                            'td = $("<td></td>");'+
                                        '}'+
                                    '}'+
                                    'else if (i == (rowCount + 4)) {'+
                                        'if (spcJson.length > (j - 2)) {'+
                                            'var cellArr = spcJson[j - 2];'+
                                            'if (cellArr.length == groupQty) {'+
                                                'var maxVal = (Math.max.apply(null, cellArr));'+
                                                'var minVal = (Math.min.apply(null, cellArr));'+
                                                'var rval = (maxVal - minVal);'+
                                                'rGraphData.push(decimal(rval, decimalPoint));'+
                                                'td = $("<td style=\'color:#372288;\'>" + decimal(rval, decimalPoint) + "</td>");'+
                                                'erresult = erresult + rval;'+
                                            '} else {'+
                                                'td = $("<td></td>");'+
                                            '}'+
                                        '}'+
                                        'else {'+
                                            'td = $("<td></td>");'+
                                        '}'+
                                    '}'+
                                    'else {'+
                                        'td = $("<td></td>");'+
                                    '}'+
                                '}'+
                                'td.appendTo(tr);'+
                            '}'+
                        '}'+
                        '$("#createtable").append("</table>");'+
                    '}'+
                    'function setResultContent(entity) {'+
                    'var cellQty = nQty / groupQty;'+
                    'var totalqty = decimal(cellQty, decimalPoint);'+
                    'var xcl = nQty == 0 ? 0 : xavg / cellQty;'+
                    'var rcl = nQty == 0 ? 0 : erresult / cellQty;'+
                    'var resultHtml = "<div style=\'width:121px; padding:0px;margin:-2px 0px 0px -2px;text-align:left;\'>";'+
                    'resultHtml += "<ul><li style=\'height:24px;line-height:24px;background-color:#C0C0C0; text-align:center;\'>合&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;计</li></ul>";'+
                    'resultHtml += "<ul><li style=\'height:24px;line-height:24px;\'>&nbsp;&nbsp;ΣＸ＝&nbsp;" + decimal(exresult, decimalPoint) + "</li></ul>";'+
                    'resultHtml += "<ul><li style=\'height:24px;line-height:24px;\'>&nbsp;&nbsp;ΣＲ＝&nbsp;" + decimal(erresult, decimalPoint) + "</li></ul>";'+
                    'resultHtml += "<ul><li style=\'height:24px;line-height:24px;background-color:#C0C0C0; text-align:center;\'>量测数值的判定条件</li></ul>";'+
                    'resultHtml += "<ul><li style=\'height:24px;line-height:24px;\'>&nbsp;&nbsp;>  USL  <span style=\'color:blue;\'>蓝色</span></li></ul>";'+
                    'resultHtml += "<ul><li style=\'height:24px;line-height:24px;\'>&nbsp;&nbsp;<  LSL  <span style=\'color:red;\'>黄色</span></li></ul>";'+
                    'resultHtml += "<ul><li style=\'height:24px;line-height:24px;\'>&nbsp;&nbsp;Ｎ＝&nbsp;" + nQty + "</li></ul>";'+
                    'resultHtml += "<ul><li style=\'height:24px;line-height:24px;background-color:#C0C0C0; text-align:center;\'>平&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;均</li></ul>";'+
                    'resultHtml += "<ul><li style=\'height:24px;line-height:24px;\'>&nbsp;&nbsp;<span style=\'text-decoration: overline\'>X</span>=&nbsp;" + decimal(xcl, decimalPoint) + "</li></ul>";'+
                    'resultHtml += "<ul><li style=\'height:24px;line-height:24px;\'>&nbsp;&nbsp;<span style=\'text-decoration: overline\'>R</span>=&nbsp;" + decimal(rcl, decimalPoint) + "</li></ul>";'+
                    'resultHtml += "</div>";'+
                    '$("#divTotal").html(resultHtml);'+
                    '$("#lblTotalGroupQty").text(totalqty);'+
                    'if (!isGroup && xUclData.length < totalGroupQty) {'+
                       ' return;'+
                    '}'+
                    'if (stddev > 0) {'+
                        'stddev = decimal(stddev, decimalPoint);'+
                        'stddev = Math.sqrt((stddev - ((exresult * exresult) / nQty)) / (nQty - 1));'+
                        '$("#lblStddev").text(decimal(stddev, decimalPoint));'+
                    '}'+
                    'var dataroot = "../spc/json/xbar-r-data.js";'+
                    '$.ajaxSettings.async = false;'+
                    '$.getJSON(dataroot, function (data) {'+
                        'var result = data[0]["n" + groupQty];'+
                        'if (result != undefined && rcl > 0) {'+
                            'var rucl = 0;'+
                            'var rlcl = 0;'+                    
                            'var xucl = 0;'+
                            'var xlcl = 0;'+  
                            'if (xUclData.length == 0'+
                                '|| (spliceQty == 0'+
                                '&& ((nQty - $("#hidNqty").val()) / groupQty > 1))) {'+ 
                                'xUclData = [];'+
                                'xClData = [];'+
                                'xLclData = [];'+
                                'rUclData = [];'+
                                'rClData = [];'+
                                'rLclData = [];'+
                                'var nXAvg = 0;'+
                                'var nRAvg = 0;'+
                                'var nXcl = 0;'+
                                'var nRcl = 0;'+
                                'for (var i = 0; i < spcJson.length; i++) {'+
                                    'if (spcJson[i].length % groupQty == 0) {'+
                                        'nXAvg = (nXAvg + xGraphData[i]);'+
                                        'nRAvg = (nRAvg + rGraphData[i]);'+
                                        'nXcl = nXAvg / (i + 1);'+
                                        'nRcl = nRAvg / (i + 1);'+
                                        'rucl = decimal(nRcl * result.D4, decimalPoint);'+
                                        'rlcl = decimal(nRcl * result.D3, decimalPoint);'+                    
                                        'xucl = decimal((nXcl + nRcl * result.A2), decimalPoint);'+
                                        'xlcl = decimal((nXcl - nRcl * result.A2), decimalPoint);'+ 
                                        'xUclData.push(xucl);'+
                                        'xLclData.push(xlcl);'+
                                        'rUclData.push(rucl);'+
                                        'rLclData.push(rlcl);'+
                                        'xClData.push(decimal(nXcl, decimalPoint));'+
                                        'rClData.push(decimal(nRcl, decimalPoint));'+
                                    '}'+
                                '}'+
                                'if (IsCurve == false) {'+
                                    'xUclData = [];'+
                                    'xLclData = [];'+
                                    'rUclData = [];'+
                                    'rLclData = [];'+
                                    'xClData = [];'+
                                    'rClData = [];'+
                                    'GmaxArr = [];'+
                                    'GminArr = [];'+
                                    'for (var i = xUclData.length; i < spcJson.length; i++) {'+
                                        'xUclData.push(xucl);'+
                                        'xLclData.push(xlcl);'+
                                        'rUclData.push(rucl);'+
                                        'rLclData.push(rlcl);'+
                                        'xClData.push(decimal(nXcl, decimalPoint));'+
                                        'rClData.push(decimal(nRcl, decimalPoint));'+
                                        'GmaxArr.push(usl);'+
                                        'GminArr.push(lsl);'+
                                    '}'+
                                '}'+
                            '}'+
                            'else {'+
                                'if (spliceQty != 0 && spliceLen > 1) {'+
                                    'xUclData.splice(0, spliceLen);'+
                                    'xClData.splice(0, spliceLen);'+
                                    'xLclData.splice(0, spliceLen);'+
                                    'rUclData.splice(0, spliceLen);'+
                                    'rClData.splice(0, spliceLen);'+
                                    'rLclData.splice(0, spliceLen);'+
                                    'var nXAvg = 0;'+
                                    'var nRAvg = 0;'+
                                    'var nXcl = 0;'+
                                    'var nRcl = 0;'+
                                    'for (var j = 0; j < xGraphData.length - spliceLen; j++) {'+
                                        'nXAvg = nXAvg + xGraphData[j];'+
                                        'nRAvg = nRAvg + rGraphData[j];'+
                                    '}'+
                                    'for (var i = xUclData.length; i < spcJson.length; i++) {'+
                                        'if (spcJson[i].length % groupQty == 0) {'+
                                            'nXAvg = (nXAvg + xGraphData[i]);'+
                                            'nRAvg = (nRAvg + rGraphData[i]);'+
                                            'nXcl = nXAvg / (i + 1);'+
                                            'nRcl = nRAvg / (i + 1);'+
                                            'rucl = decimal(nRcl * result.D4, decimalPoint);'+
                                            'rlcl = decimal(nRcl * result.D3, decimalPoint);'+                    
                                            'xucl = decimal((nXcl + nRcl * result.A2), decimalPoint);'+
                                            'xlcl = decimal((nXcl - nRcl * result.A2), decimalPoint);'+  
                                            'xUclData.push(xucl);'+
                                            'xLclData.push(xlcl);'+
                                            'rUclData.push(rucl);'+
                                            'rLclData.push(rlcl);'+
                                            'xClData.push(decimal(nXcl, decimalPoint));'+
                                            'rClData.push(decimal(nRcl, decimalPoint));'+
                                        '}'+
                                    '}'+
                                    'if (IsCurve == false) {'+
                                        'xUclData = [];'+
                                        'xLclData = [];'+
                                        'rUclData = [];'+
                                        'rLclData = [];'+
                                        'xClData = [];'+
                                        'rClData = [];'+
                                        'GmaxArr = [];'+
                                        'GminArr = [];'+
                                        'for (var i = xUclData.length; i < spcJson.length; i++) {'+
                                            'xUclData.push(xucl);'+
                                            'xLclData.push(xlcl);'+
                                            'rUclData.push(rucl);'+
                                            'rLclData.push(rlcl);'+
                                            'xClData.push(decimal(nXcl, decimalPoint));'+
                                            'rClData.push(decimal(nRcl, decimalPoint));'+
                                            'GmaxArr.push(usl);'+
                                            'GminArr.push(lsl);'+
                                        '}'+
                                    '}'+
                                '}'+
                                'else {'+
                                    'rucl = decimal(rcl * result.D4, decimalPoint);'+
                                    'rlcl = decimal(rcl * result.D3, decimalPoint);'+                    
                                    'xucl = decimal((xcl + rcl * result.A2), decimalPoint);'+
                                    'xlcl = decimal((xcl - rcl * result.A2), decimalPoint);'+ 
                                    'if (spliceQty != 0 && (spliceLen == 1)'+
                                     '|| nQty / groupQty == totalGroupQty'+
                                     '|| (spliceQty == 0) && ((nQty - $("#hidNqty").val()) / groupQty == 1)) {'+
                                        'xUclData.push(xucl);'+
                                        'xLclData.push(xlcl);'+
                                        'rUclData.push(rucl);'+
                                        'rLclData.push(rlcl);'+
                                        'xClData.push(decimal(xcl, decimalPoint));'+
                                        'rClData.push(decimal(rcl, decimalPoint));'+
                                    '}'+
                                '}'+
                                'if ((xUclData.length >= totalGroupQty)) {'+
                                    'var len = (xUclData.length - totalGroupQty);'+
                                    'if (xGraphData.length == totalGroupQty - 1) {'+
                                        'len = len + 1;'+
                                    '}'+
                                    'xUclData.splice(0, len);'+
                                    'xClData.splice(0, len);'+
                                    'xLclData.splice(0, len);'+
                                    'rUclData.splice(0, len);'+
                                    'rClData.splice(0, len);'+
                                    'rLclData.splice(0, len);'+
                                '}'+
                            '}'+
                            '$("#lblRcl").text(decimal(rcl, decimalPoint));'+
                            '$("#lblXcl").text(decimal(xcl, decimalPoint));'+
                            '$("#lblXucl").text(xucl);'+
                            '$("#lblXlcl").text(xlcl);'+
                            '$("#lblRucl").text(rucl);'+
                            '$("#lblRlcl").text(rlcl);'+
                            '$("#hidNqty").val(nQty);'+
                            'var sigma = decimal(rcl / result.d2, decimalPoint);'+
                            'var ppk = decimal(Math.min((usl - xcl) / (3 * stddev), (xcl - lsl) / (3 * stddev)), decimalPoint);'+
                            'var pp = decimal((usl - lsl) / (6 * stddev), decimalPoint);'+
                            'var ca = decimal(Math.abs((xcl - ((usl + lsl) / 2)) / ((usl - lsl) / 2)) * 100, decimalPoint);'+
                            'var cpk = decimal(Math.min((usl - xcl) / (3 * rcl / result.d2), (xcl - lsl) / (3 * rcl / result.d2)), decimalPoint);'+
                            'var cp = decimal((usl - lsl) / (6 * rcl / result.d2), decimalPoint);'+
                            'var grade = "";'+
                            'if (cpk < 0.67) {'+
                                'grade = "E";'+
                            '}'+
                            'else if (cpk < 1) {'+
                                'grade = "D";'+
                            '}'+
                            'else if (cpk < 1.33) {'+
                                'grade = "C";'+
                            '}'+
                            'else if (cpk < 1.67) {'+
                                'grade = "B";'+
                            '}'+
                            'else {'+
                                'grade = "A";'+
                            '}'+
                            '$("#lblSigma").text(sigma);'+
                            'if (entity.IsShowPPK) {'+
                                '$("#lblPPK").text(ppk);'+
                            '}'+
                            'if (entity.IsShowPP) {'+
                                '$("#lblPP").text(pp);'+
                            '}'+
                            '$("#lblCa").text(ca + "%");'+
                            'if (entity.IsShowCPK) {'+
                                '$("#lblCPK").text(cpk);'+
                            '}'+
                            'if (entity.IsShowCP) {'+
                                '$("#lblCP").text(cp);'+
                            '}'+
                            '$("#lblGrade").text(grade);'+
                        '}'+
                    '});'+
                    '$.ajaxSettings.async = true;'+    
                '}'+
        'function decimal(num, v) {'+
            'var vv = Math.pow(10, v);'+
            'return Math.round(num * vv) / vv;'+
       '}'+
            'function buildXBarRCharts(id, data) {'+
            'var maxArr = [];'+
            'var centerArr = [];'+
            'var minArr = [];'+
            'var Gmaxtip = "上限USL";'+
            'var Gmintip = "下限LSL";'+
            'var valtip = "";'+
            'var maxtip = "上限UCL";'+
            'var mintip = "下限LCL";'+
            'var centerTip = "中心限CL";'+
            'var dom = document.getElementById(id);'+
            'if (id == "xcharts") {'+
                'xChartsGraph = echarts.init(dom);'+
                'valtip = "X均值";'+
                'maxArr = xUclData;'+
                'centerArr = xClData;'+
                'minArr = xLclData;'+
            '}'+
            'else if (id == "rcharts") {'+
                'rChartsGraph = echarts.init(dom);'+
                'valtip = "R均值";'+
                'maxArr = rUclData;'+
                'centerArr = rClData;'+
                'minArr = rLclData;'+
            '}'+
            '$.each(data, function (index, item) {'+
                'if (item > maxArr[index] || item < minArr[index]) {'+
                    'if (item > usl || item < lsl) {'+
                        '$("#xbarTb-content tr:eq(2) td:eq(" + (index + 2) + ")").css("background-color", "red").css("color", "#000");'+
                        'for (var i = 0; i < groupQty + 2; i++) {'+
                            '$("#xbarTb-content tr:eq(" + (i + 3) + ") td:eq(" + (index + 1) + ")").css("background-color", "red").css("color", "#000");'+
                        '}'+
                   '}'+
                    'else {'+
                        '$("#xbarTb-content tr:eq(2) td:eq(" + (index + 2) + ")").css("background-color", "yellow").css("color", "#000");'+
                        'for (var i = 0; i < groupQty + 2; i++) {'+
                            '$("#xbarTb-content tr:eq(" + (i + 3) + ") td:eq(" + (index + 1) + ")").css("background-color", "yellow").css("color", "#000");'+
                        '}'+
                    '}'+
                'data[index] = { value: data[index],'+
                        'symbol: \'emptyHeart\','+
                        'symbolSize: 5,'+
                'itemStyle: { normal: { color: \'#ff0000\', label: { show: true}} }'+
                    '};'+
                '}'+
            '});'+
            'option = null;'+
            'if (id != "rcharts") {'+
                'option = {'+
                    'tooltip: {'+
                        'trigger: \'axis\''+
                    '},'+
                    'grid: {'+
                        'left: \'2%\','+
                        'top: \'30px\','+
                        'right: \'2%\','+
                        'bottom: \'10px\','+
                        'containLabel: true'+
                    '},'+
                    'legend: {'+                
                        'data: [Gmaxtip, Gmintip, maxtip, centerTip, mintip, valtip]'+
                    '},'+
                    'toolbox: {'+
                        'show: true,'+
                        'feature: {'+
                            'magicType: { show: false, type: [\'stack\', \'tiled\'] },'+
                            'saveAsImage: { show: true }'+
                        '}'+
                    '},'+
                    'color: ["#317010", "#e3e311", "#bd92a9", \'#60609D\', \'#00AA55\', \'#0000FF\'],'+
                    'xAxis: {'+
                        'type: \'category\','+
                        'boundaryGap: false,'+
                        'data: subGraphpData'+
                    '},'+
                    'yAxis: {'+
                        'type: \'value\''+
                    '},'+
                    'series: ['+
                    '{'+
                        'name: Gmaxtip,'+
                        'type: \'line\','+
                        'itemStyle: {'+
                            'normal: {'+
                                'lineStyle: {'+
                                    'color: \'#317010\''+
                                '}'+
                            '}'+
                        '},'+
                        'smooth: true,'+
                        'symbol: \'none\','+
                        'data: GmaxArr'+
                    '},'+
                        '{'+
                            'name: Gmintip,'+
                            'type: \'line\','+
                            'itemStyle: {'+
                                'normal: {'+
                                    'lineStyle: {'+
                                        'color: \'#e3e311\''+
                                    '}'+
                                '}'+
                            '},'+
                            'smooth: true,'+
                            'symbol: \'none\','+
                            'data: GminArr'+
                        '},'+
                    '{'+
                        'name: maxtip,'+
                        'type: \'line\','+
                        'itemStyle: {'+
                            'normal: {'+
                                'lineStyle: {'+
                                    'color: \'#bd92a9\''+
                                '}'+
                            '}'+
                        '},'+
                        'smooth: true,'+
                        'symbol: \'none\','+
                        'data: maxArr'+
                    '},'+
                    '{'+
                        'name: centerTip,'+
                        'type: \'line\','+
                        'itemStyle: {'+
                            'normal: {'+
                                'lineStyle: {'+
                                    'color: \'#60609D\''+
                                '}'+
                            '}'+
                        '},'+
                        'smooth: true,'+
                        'symbol: \'none\','+
                        'data: centerArr'+
                    '},'+
                    '{'+
                        'name: mintip,'+
                        'type: \'line\','+
                        'itemStyle: {'+
                            'normal: {'+
                                'lineStyle: {'+
                                    'color: \'#00AA55\''+
                                '}'+
                            '}'+
                        '},'+
                        'smooth: true,'+
                        'symbol: \'none\','+
                        'data: minArr'+
                    '},'+ 
                     '{'+
                         'name: valtip,'+
                         'type: \'line\','+
                         'itemStyle: {'+
                             'normal: {'+
                                 'lineStyle: {'+
                                     'color: \'#0000FF\''+
                                 '}'+
                             '}'+
                         '},'+
                         'smooth: false,'+
                         'data: data'+
                     '}]'+
                '};'+
            '}'+
            'else {'+
                'option = {'+
                    'tooltip: {'+
                        'trigger: \'axis\''+
                    '},'+
                    'grid: {'+
                        'left: \'2%\','+
                        'top: \'30px\','+
                        'right: \'2%\','+
                        'bottom: \'10px\','+
                        'containLabel: true'+
                    '},'+
                    'legend: {'+               
                        'data: [maxtip, centerTip, mintip, valtip]'+
                    '},'+
                    'toolbox: {'+
                        'show: true,'+
                        'feature: {'+
                            'magicType: { show: false, type: [\'stack\', \'tiled\'] },'+
                            'saveAsImage: { show: true }'+
                        '}'+
                    '},'+
                    'color: ["#bd92a9", \'#60609D\', \'#00AA55\', \'#0000FF\'],'+
                    'xAxis: {'+
                        'type: \'category\','+
                        'boundaryGap: false,'+
                        'data: subGraphpData'+
                    '},'+
                    'yAxis: {'+
                        'type: \'value\''+
                    '},'+
                    'series: ['+
                    '{'+
                        'name: maxtip,'+
                        'type: \'line\','+
                        'itemStyle: {'+
                            'normal: {'+
                                'lineStyle: {'+
                                    'color: \'#bd92a9\''+
                                '}'+
                            '}'+
                        '},'+
                        'smooth: true,'+
                        'symbol: \'none\','+
                        'data: maxArr'+
                    '},'+
                    '{'+
                        'name: centerTip,'+
                        'type: \'line\','+
                        'itemStyle: {'+
                            'normal: {'+
                                'lineStyle: {'+
                                    'color: \'#60609D\''+
                                '}'+
                            '}'+
                        '},'+
                        'smooth: true,'+
                        'symbol: \'none\','+
                        'data: centerArr'+
                    '},'+
                    '{'+
                        'name: mintip,'+
                        'type: \'line\','+
                        'itemStyle: {'+
                            'normal: {'+
                                'lineStyle: {'+
                                    'color: \'#00AA55\''+
                                '}'+
                            '}'+
                        '},'+
                        'smooth: true,'+
                        'symbol: \'none\','+
                        'data: minArr'+
                    '},'+
                     '{'+
                         'name: valtip,'+
                         'type: \'line\','+
                         'itemStyle: {'+
                             'normal: {'+
                                 'lineStyle: {'+
                                     'color: \'#0000FF\''+
                                 '}'+
                             '}'+
                         '},'+
                         'smooth: false,'+
                         'data: data'+
                     '}]'+
                '};'+
            '}'+
            'if (option && typeof option === "object") {'+
                'if (id == "xcharts") {'+
                    'xChartsGraph.setOption(option, true);'+
                '} else if (id == "rcharts") {'+
                    'rChartsGraph.setOption(option, true);'+
                '}'+
            '}'+
        '}'+
        'function getDateTime() {'+
            'var now = new Date();'+
            'var hour = now.getHours();'+
            'var min = now.getMinutes();'+
            'var sec = now.getSeconds();'+
            'var day = now.getDay();'+
            'hour = (hour < 10) ? \'0\' + hour.toString() : hour.toString();'+
            'min = (min < 10) ? \'0\' + min.toString() : min.toString();'+
            'sec = (sec < 10) ? \'0\' + sec.toString() : sec.toString();'+
            'return hour.toString() + ":" + min.toString() + ":" + sec.toString();'+
        '}'+
        'function timerTick() {'+
            '$("#lblTime").html(getDateTime());'+
            'setInterval(function () { $("#lblTime").html(getDateTime()); }, 1000);'+
        '}'+
                'var hasWarnQty = 0;'+
                'function graphWarn(entity) {'+
                    'var currentQty = 0;'+
                    'var isWarnA = entity.IsWarnA;'+
                    'var isWarnB = entity.IsWarnB;'+
                    'var isWarnC = entity.IsWarnC;'+
                    'var isWarnD = entity.IsWarnD;'+
                    'var isWarnE = entity.IsWarnE;'+
                    'var sideWarnQty = entity.WarnCVal;'+
                    'var upSideQty = 0;'+
                    'var downSideQty = 0;'+
                    'var rUpSideQty = 0;'+
                    'var rDownSideQty = 0;'+
                    'var nSortWarnQty = entity.WarnDVal;'+
                    'var nAscQty = 0;'+
                    'var nDescQty = 0;'+     
                    'var xrSortWarnQty = entity.WarnEVal;'+
                    'var xrSortQty = 0;'+ 
                    'var errorMsg = "";'+
                    'var needWarnQty = 0;'+
                    'needWarnQty = (nQty / groupQty);'+
                    'for (var i = needWarnQty; i > 0; i--) {'+
                        'var j = xGraphData.length - i;'+
                        'var item = (xGraphData[j]);'+
                        'if (typeof (item) == "object") {'+
                            'item = (item.value);'+
                        '}'+
                        'if (isWarnA) {'+
                            'if (item > usl) {'+
                                'errorMsg += ("A超规：" + item + " 超过规格上限USL" + usl + "！");'+
                            '}'+
                            'else if (item < lsl) {'+
                                'errorMsg += ("A超规：" + item + " 超过规格下限LSL" + lsl + "！");'+
                            '}'+
                        '}'+
                        'if (isWarnB) {'+
                            'if (item > xUclData[j]) {'+
                                'errorMsg += ("B超控：" + item + " 超过X控制上限UCL" + xUclData[j] + "！");'+
                            '}'+
                            'if (item < xLclData[j]) {'+
                                'errorMsg += ("B超控：" + item + " 超过X控制下限LCL" + xLclData[j] + "！");'+
                            '}'+
                        '}'+
                    '}'+
                    'if (isWarnC && (xGraphData.length >= sideWarnQty)) {'+
                        'for (var i = sideWarnQty; i > 0; i--) {'+
                            'var j = xGraphData.length - i;'+
                            'var item = xGraphData[j];'+
                            'if (item > xClData[j]) {'+
                                'upSideQty++;'+
                                'if (upSideQty >= sideWarnQty && (xGraphData[j + 1] <= xClData[j] || (j == xGraphData.length - 1))) {'+
                                    'errorMsg += ("C预警：" + upSideQty + "点在X中心限上的同一侧！");'+
                                '}'+
                            '}'+
                            'else {'+
                                'upSideQty = 0;'+
                            '}'+
                            'if (item < xClData[j]) {'+
                                'downSideQty++;'+
                                'if (downSideQty >= sideWarnQty && (xGraphData[j + 1] >= xClData[j] || (j == xGraphData.length - 1))) {'+
                                    'errorMsg += ("C预警：" + downSideQty + "点在X中心限下的同一侧！");'+
                                '}'+
                            '}'+
                            'else {'+
                                'downSideQty = 0;'+
                            '}'+
                        '}'+
                    '}'+
                    'if (isWarnD && (xGraphData.length >= nSortWarnQty)) {'+
                        'for (var i = nSortWarnQty; i > 0; i--) {'+
                            'var j = xGraphData.length - i;'+
                            'var item = (xGraphData[j]);'+
                            'if (item < xGraphData[j + 1] || (xGraphData[j + 1] == undefined && item > xGraphData[j - 1])) {'+
                                'nAscQty++;'+
                                'if (nAscQty == nSortWarnQty) {'+
                                    'errorMsg += ("D预警：" + nAscQty + "点数据连续上升！");'+
                                '}'+
                            '} else {'+
                                'nAscQty = 0;'+
                            '}'+
                            'if (item > xGraphData[j + 1] || (xGraphData[j + 1] == undefined && item < xGraphData[j - 1])) {'+
                                'nDescQty++;'+
                           '} else {'+
                                'nDescQty = 0;'+
                            '}'+
                        '}'+
                        'if (nDescQty == nSortWarnQty) {'+
                            'errorMsg += ("D预警：" + nDescQty + "点数据连续下降！");'+
                        '}'+
                    '}'+
                    'var sortCount = (xrSortWarnQty * 2 + 1);'+
                    'if (isWarnE && (xGraphData.length >= sortCount)) {'+
                        'for (var i = sortCount; i > 0; i--) {'+
                            'var j = xGraphData.length - i;'+
                            'var item = (xGraphData[j]);'+
                            'if ((xGraphData[j - 1] < item && item > xGraphData[j + 1])'+
                                       '|| (xGraphData[j - 1] > item && item < xGraphData[j + 1])'+
                                       '|| (xGraphData[j + 1] == undefined'+
                                       '&& ((xGraphData[j - 1] > xGraphData[j - 2] && xGraphData[j - 1] > item)'+
                                             '|| (xGraphData[j - 1] < xGraphData[j - 2] && xGraphData[j - 1] < item)))'+
                                       '|| (xGraphData[j - 1] == undefined'+
                                       '&& ((xGraphData[j + 1] > xGraphData[j + 2] && xGraphData[j + 1] > item)'+
                                             '|| (xGraphData[j + 1] < xGraphData[j + 2] && xGraphData[j + 1] < item)))'+
                                             ') {'+
                                'xrSortQty++;'+
                                'if (xrSortWarnQty == (xrSortQty - 1) / 2) {'+
                                    'errorMsg += ("E预警：" + xrSortWarnQty + "点数据上下交替！");'+
                                '}'+
                            '}'+
                            'else {'+
                                'xrSortQty = 0;'+
                            '}'+
                        '}'+
                    '}'+
                    'if (errorMsg != "") {'+
                        'var entity = {};'+
                        'entity.SPCTaskId = spcTaskId;'+
                        'entity.SPCWarnMsg = errorMsg;'+
                        'entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>";'+
                        'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc(entity.SPCActionProc, JSON.stringify(entity), "1");'+
                        'if (ajax.error != null) {'+
                            'alert(ajax.error.Message);'+
                            'return false;'+
                        '}'+
                    '}'+
                    '}' +
                    '<\/script>';
                var js_source = subHtml.replace(/^\s+/, '');
                var tabsize = 1;
                var tabchar = ' ';
                var finalHtml = '';
                if (tabsize == 1) {
                    tabchar = '\t';
                }
                if (js_source && js_source.charAt(0) === '<') {
                    finalHtml = style_html(js_source, tabsize, tabchar, 80);
                } else {
                    finalHtml = js_beautify(js_source, tabsize, tabchar);
                }
                var iframesSub = document.getElementById("ifCtrl1");
                iframesSub.contentWindow.setData(encodeURI(finalHtml));
            }
        }
        function ControlPhotoTemplate(checkbox) {
            PageSub = false;
            if (checkbox.checked == true) {
                if (!confirm("此操作会覆盖之前代码设计内容,是否确认添加控制图模版?")) {
                    $(checkbox).prop('checked', false);
                    return false;
                } else {
                    $(".template").prop('checked', false);
                    $(checkbox).prop('checked', true);
                    var cindex = prompt("请选择控制图类型(1.X-bar R 2.np Chart 3.c Chart 4.p Chart 5.u Chart)");
                    if (cindex != 1 && cindex != 2 && cindex != 3 && cindex != 4 && cindex != 5) {
                        alert("您未填写正确的控制图编号,不能正常展示模版控制图代码!");
                    }
                    showTemplateCode(cindex);
                }
                $("#<%=this.hdnPType.ClientID %>").val("0");
                var strHTML = '<table class="EditeContentTable" style="width: 100%">' +
                    '<tr>' +
                    '<td class="Label3">' +
                    '项目名称' +
                    '</td>' +
                    '<td class="Field3">' +
                    '<input type="text" class="TextBox " value="" id="txtSPCProjectName" />' +
                    '</td>' +
                    '<td class="Label3">' +
                    '任务名称' +
                    '</td>' +
                    '<td class="Field3">' +
                    '<input type="text" class="TextBox " value="" id="txtTaskName" />' +
                    '</td>' +
                    '</tr>' +
                    '<tr>' +
                    '<td class="Label3" colspan="6" align="center" style="text-align:center">' +
                    '<span style="margin-right:15px;">' +
                    '<input type="checkbox" id="chkEqul" name="chkEqul" />全字匹配</span>' +
                    '<span id="bnView" style="font-size: 12px; font-weight:bold; cursor: pointer; ">' +
                    '<img src="../Content/images/search.png" class="imgText" style="margin-right:5px;"/>' +
                    '<span class="imgText">' +
                    '查询' +
                    '</span>' +
                    '</span>' +
                    '<span id="bnImport" style="font-size: 12px; font-weight:bold; margin-left:10px;cursor: pointer;" title="导出报表到Excel">' +
                    '<img src="../Content/images/icon/Import.png" class="imgText" style="margin-right:5px;"/>' +
                    '<span class="imgText">' +
                    '导出' +
                    '</span>' +
                    '</span>' +
                    '</tr>' +
                    '</table>' +
                    '<input type="hidden" value="vwGetSPCTaskListTemplate" id="hdnTableName" name="hdnTableName" />' +
                    '<input type="hidden" value="ProdOrderID" id="hdnKey" name="hdnKey" />' +
                    '<input type="hidden" value="" id="hdnKeyValue" name="hdnKeyValue" />' +
                    '<input type="hidden" value="" id="hdnPararmValue" name="hdnPararmValue"/>' +
                    '<input type="hidden" value="TABLE" id="hdnOperation" name="hdnOperation"/>' +
                    '<input type="hidden" value="" id="hdnFileName" name="hdnFileName" />' +
                    '<input type="hidden" value="" id="hdnSN" name="hdnSN" />' +
                    '<div class="clear5"></div>' +
                    '<div id="ReportList"><div class="ListTableEmptyDataRow">请输入查询条件查看报表</div></div>' +
                    '<script type="text/javascript">' +
                    '$(function () {' +
                        '$("div[title=\'帮助\']").before(\'<div class="toolbar-btn" onclick="ExecGraph()" title="执行控制图"><div class="icon-16-list"></div><div class="btn-text">执行控制图</div></div>\');' +
                    '});' +
                    'var RowObj = {};' +
                    '$("#bnView").click(function() {' +
                    '$("#hdnKeyValue").val("");' +
                    'var conds = "";' +
                    'var conds2 = "";' +
                    'var txtSPCProjectName = $("#txtSPCProjectName").val();' +
                    'var txtTaskName = $("#txtTaskName").val();' +
                    'if (txtSPCProjectName !== "") {' +
                    'conds2 += " AND ProjectName= N\'" + $.trim($(\"#txtSPCProjectName\").val()) + "\'";' +
                    'conds += " AND ProjectName LIKE N\'%" + $.trim($("#txtSPCProjectName").val()) + "%\'";' +
                    '}' +
                    'if (txtTaskName !== "") {' +
                    'conds2 += " AND TaskName= N\'" + $.trim($("#txtTaskName").val()) + "\'";' +
                    'conds += " AND TaskName LIKE N\'%" + $.trim($("#txtTaskName").val()) + "%\'";' +
                    '}' +
                    'if ($("#chkEqul").is(":checked")) {' +
                    'conds = conds2;' +
                    '}' +
                    '$("#ReportList").replaceWith("<div id=ReportList ></div>");' +
                    'var grid = $("#ReportList").SktMesGrid({' +
                    'columns: [{' +
                    '"display": "项目名称",' +
                    '"name": "ProjectName",' +
                    '"align": "left",' +
                    '"width": 180,' +
                    '"minWidth": 60' +
                    '},' +
                    '{' +
                    '"display": "任务名称",' +
                    '"name": "TaskName",' +
                    '"align": "left",' +
                    '"width": 180,' +
                    '"minWidth": 60' +
                    '},' +
                    '{' +
                    '"display": "任务描述",' +
                    '"name": "TaskDesc",' +
                    '"align": "left",' +
                    '"width": 180,' +
                    '"minWidth": 60' +
                    '},' +
                    '{' +
                    '"display": "图表类型",' +
                    '"name": "GraphType",' +
                    '"align": "left",' +
                    '"width": 180,' +
                    '"minWidth": 60' +
                    '},' +
                    '{' +
                    '"display": "产品编码",' +
                    '"name": "ItemCode",' +
                    '"align": "left",' +
                    '"width": 180,' +
                    '"minWidth": 60' +
                    '},' +
                    '{' +
                    '"display": "单位",' +
                    '"name": "Units",' +
                    '"align": "left",' +
                    '"width": 180,' +
                    '"minWidth": 60' +
                    '},' +
                    '{' +
                    '"display": "线别",' +
                    '"name": "LineName",' +
                    '"align": "left",' +
                    '"width": 180,' +
                    '"minWidth": 60' +
                    '},' +
                    '{' +
                    '"display": "工序",' +
                    '"name": "Station",' +
                    '"align": "left",' +
                    '"width": 180,' +
                    '"minWidth": 60' +
                    '},' +
                    '{' +
                    '"display": "规格上限",' +
                    '"name": "USL",' +
                    '"align": "left",' +
                    '"width": 180,' +
                    '"minWidth": 60' +
                    '},' +
                    '{' +
                    '"display": "规格下限",' +
                    '"name": "LSL",' +
                    '"align": "left",' +
                    '"width": 180,' +
                    '"minWidth": 60' +
                    '}],' +
                    'width: "100%",' +
                    'height: "98%",' +
                    'dataAction: "TABLE",' +
                    'dataSource: "vwGetSPCTaskListTemplate",' +
                    'conditions: conds,' +
                    'multiselect: true,' +
                    'onSelectRow: function(rowid, status) {' +
                    '$("#hdnKeyValue").val(rowid[$("#hdnKey").val()]);' +
                    '$("#hdnSN").val(rowid.SPCTaskId);' +
                    'RowObj = rowid;' +
                    '},' +
                    'sortName: "SPCTaskId",' +
                    'selectFields: "SPCTaskId,ProjectName,TaskName,TaskDesc,GraphType,ItemCode,Units,LineName,Station,USL,LSL"' +
                    '});' +
                    '});' +
                    '$("#bnImport").click(function() {' +
                    'var conds = "";' +
                    'var conds2 = "";' +
                    'var txtSPCProjectName = $("#txtSPCProjectName").val();' +
                    'var txtTaskName = $("#txtTaskName").val();' +
                    'if (txtSPCProjectName !== "") {' +
                    'conds2 += " AND ProjectName= N\'" + $.trim($("#txtSPCProjectName").val()) + "\'";' +
                    'conds += " AND ProjectName LIKE N\'%" + $.trim($("#txtSPCProjectName").val()) + "%\'";' +
                    '}' +
                    'if (txtTaskName !== "") {' +
                    'conds2 += " AND TaskName= N\'" + $.trim($("#txtTaskName").val()) + "\'";' +
                    'conds += " AND TaskName LIKE N\'%" + $.trim($("#txtTaskName").val()) + "%\'";' +
                    '}' +
                    '$("#hdnPararms").val("vwGetSPCTaskListTemplate");' +
                    '$("#hdnOperation").val("TABLE");' +
                    '$("#hdnPararmValue").val(conds);' +
                    '$("#hdnFileName").val("SPC任务列表");' +
                    'document.forms[0].submit();' +
                    '});' +
                    'function ExecGraph() {' +
                        'if (RowObj == null) {' +
                            'alert("请选择记录!");' +
                            'return false;' +
                        '}' +
                        'var graphType = RowObj.GraphType;' +
                        'var openWinUrl = "";' +
                        'var PName1="' + PName + '";' +
                        'if (graphType == "X-bar R") {' +
                            'openWinUrl = _root + "/CustomMenu/CustomMenuRGraph.aspx?name=SPC_TaskExecGraph&ID=" + RowObj.SPCTaskId+"&PaName="+PName1;' +
                            'window.localStorage.setItem("SPCTaskId", RowObj.SPCTaskId);'+
                        '}' +
                        'else if (graphType == "np Chart") {' +
                            'openWinUrl = _root+ "/CustomMenu/CustomMenuRGraph.aspx?name=SPC_TaskExecGraph&ID=" + RowObj.SPCTaskId+"&PaName="+PName1;' +
                            'window.localStorage.setItem("SPCTaskId", RowObj.SPCTaskId);' +
                        '}' +
                        'else if (graphType == "c Chart") {' +
                            'openWinUrl = _root+ "/CustomMenu/CustomMenuRGraph.aspx?name=SPC_TaskExecGraph&ID=" + RowObj.SPCTaskId+"&PaName="+PName1;' +
                            'window.localStorage.setItem("SPCTaskId", RowObj.SPCTaskId);' +
                        '}' +
                         'else if (graphType == "p Chart") {' +
                            'openWinUrl = _root+ "/CustomMenu/CustomMenuRGraph.aspx?name=SPC_TaskExecGraph&ID=" + RowObj.SPCTaskId+"&PaName="+PName1;' +
                            'window.localStorage.setItem("SPCTaskId", RowObj.SPCTaskId);' +
                        '}' +
                        'else if (graphType == "u Chart") {' +
                           'openWinUrl = _root+ "/CustomMenu/CustomMenuRGraph.aspx?name=SPC_TaskExecGraph&ID=" + RowObj.SPCTaskId+"&PaName="+PName1;' +
                           'window.localStorage.setItem("SPCTaskId", RowObj.SPCTaskId);' +
                        '}' +
                        'window.open(openWinUrl, RowObj.SPCTaskId);' +
                    '}' +
                    '<\/script>';
                    var js_source = strHTML.replace(/^\s+/, '');
                    var tabsize = 1;
                    var tabchar = ' ';
                    var finalHtml = '';
                    if (tabsize == 1) {
                        tabchar = '\t';
                    }
                    if (js_source && js_source.charAt(0) === '<') {
                        finalHtml = style_html(js_source, tabsize, tabchar, 80);
                    } else {
                        finalHtml = js_beautify(js_source, tabsize, tabchar);
                    }
                    var iframes = document.getElementById("ifCtrl");
                    iframes.contentWindow.setData(encodeURI(finalHtml));
                    //自动调用保存功能  保障预览功能正常
                    Save(1);
            }
        }
        //树形图模版
        function TreeTemplate(checkbox) {
            PageSub = false;
            if (checkbox.checked == true) {
                if (!confirm("此操作会覆盖之前代码设计内容,是否确认添加树形图模版?")) {
                    $(checkbox).prop('checked', false);
                    return false;
                } else {
                    $(".template").prop('checked', false);
                    $(checkbox).prop('checked', true);
                }
                $("#<%=this.hdnPType.ClientID %>").val("0");
                var strHTML = '<link href="/Content/plugin/jqTree/img/mask.css" rel="stylesheet" type="text/css" />' +
                    '<link href="../Content/plugin/jqTree/img/saas.css" rel="stylesheet" type="text/css" />' +
                    '<script src="../Content/js/jquery.min.js" type="text/javascript"><\/script>'+
                    '<script src="../Content/plugin/jqTree/Js/saas.js" type="text/javascript"><\/script>' +
                    '<script src="../Content/plugin/jqTree/Js/jqDnR.js" type="text/javascript"><\/script>' +
                    ' <table width="100%" cellpadding="0" cellspacing="0" border="0">' +
                    '<tr>' +
                    '<td align="left" valign="top" width="195px">' +
                    '<div style="width: 190px; border: 1px solid #ccc;"> ' +
                    '<div class="divHeader" style="border: none;">' +
                    '<img src="../Content/images/icon/openrouter.png" style="vertical-align: middle;" />部门<span id="cellToolbar" style="float: right"></span></div>' +
                    '<ul id="browser" class="treeview filetree" style="overflow: auto;"></ul>' +
                    '</div></td>' +
                    ' <td align="left" valign="top">' +
                    '<div id="depUserList" style="overflow: auto;">' +
                    '<table class="ListTable" width="100%" id="userList">' +
                    '<tr class="ListTableHeader">' +
                    '<th>中文名</th><th>英文名</th><th>性别</th><th>电话</th><th>邮箱</th><th>工号 </th><th>部门</th>' +
                    '</tr>' +
                    ' </table>' +
                    ' </div>' +
                    '</td>' +
                    ' </tr></table>' +
                    '<table width="100%" class="EditeContentTable" id="editTemplate" style="display:none;">' +
                    '<tr>' +
                    '<td class="Label2">上级部门</td>' +
                    '<td class="Field2" colspan="3">' +
                    '<input type="hidden" id="hdnParentId" value="-1"/>' +
                    '<input id="txtParentDepartName" type="text"/><input type="button" value="..." class="ButtonBox" title="选择上级部门" onclick="chooseParentDepart()" />' +
                    '</td>' +
                    '</tr>' +
                    '<tr>' +
                    '<td class="Label2">部门名称<em>*</em></td>' +
                    '<td class="Field2"><input type="text" id="txtDepartName" maxlength="20"/></td>' +
                    '<td class="Label2">部门编号<em>*</em></td><td class="Field2"> <input type="text" id="txtDepartNo" maxlength="50"/></td>' +
                    '</tr>' +
                    '<tr>' +
                    '<td class="Label2">部门主管</td>' +
                    '<td class="Field2" colspan="3"><input type="hidden" id="hdnSupervisorId" value="-1"/><input id="txtSupervisor" type="text" maxlength="20"/><input type="button" value="..." class="ButtonBox" title="选择主管" onclick="chooseSupervisor()"/></td>' +
                    '</tr>' +
                    '<tr><td class="Label2">描述</td><td class="Field2" colspan="3"><input type="text" id="txtDescription" maxlength="50"/></td></tr>' +
                    '</table>' +
                    '<input type="hidden" id="hdnOperate" name="hdnOperate" value="" />' +
                    ' <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />' +
                    ' <script type="text/javascript">' +
                    'var RequireOnlyOneRecord = "<%=Resources.Messages.RequireOnlyOneRecord %>";' +
                    'var RequireOperateRecord = "<%=Resources.Messages.RequireOperateRecord %>";' +
                    'var ConfirmDelete = "<%=Resources.Messages.ConfirmDelete %>";' +
                    'var isMultiple = false;' +
                    'var openWinUrl = "";' +
                    'var hdnOperate = $("#hdnOperate");' +
                    'var hdnIdString = $("#hdnIdString");' +
                    ' $(function () {' +
                    'setSize();' +
                    '$("#toolbar").hide();' +
                    ' $(window).resize(function () { setSize(); });' +
                    ' if (buttons) {' +
                    ' var tlb = "";' +
                    'for (var i = 0, j = buttons.length; i < j; i++) {' +
                    'tlb +=\'<div class=\"toolbar-btn\" onclick=\' + InitHander(buttons[i].Handler) + \' title=\' + buttons[i].Tooltip + \'><div class=\"icon-16-\' + buttons[i].Icon + \'"></div></div>\';' +
                    ' }' +
                    '$("#cellToolbar").html(tlb);' +
                    '$("#toolbar").html("");' +
                    '$("#toolbar").hide();' +
                    '}' +
                    '});' +
                    'function setSize() {' +
                    '$("#browser").height($(window).height() - 65);' +
                    '$("#depUserList").height($(window).height() - 35);' +
                    ' }' +
                    'var organizationId = -1;' +
                    'var layindex1 = 0;' +
                    'var layindex2 = 0;' +
                    'var layindex3 = 0;' +
                    'function Add() {' +
                    'organizationId = -1;' +
                    ' $("#hdnParentId").val(-1);' +
                    '$("#txtParentDepartName").val("");' +
                    '$("#txtDepartName").val("");' +
                    '$("#txtDepartNo").val("");' +
                    '$("#hdnSupervisorId").val(-1);' +
                    '$("#txtSupervisor").val("");' +
                    '$("#txtDescription").val("");' +
                    'layindex3=layer.open({' +
                    'type: 1,' +
                    'area: ["600px", "400px"],' +
                    'title: "新增信息",' +
                    'shade: 0.6,' +
                    'moveType: 0,' +
                    'shift: 0,' +
                    'moveType: 0,' +
                    'shift: 0,' +
                    'closeBtn: 2,' +
                    'content:$("#editTemplate"),' +
                    'btn: ["保存", "取消"],' +
                    'btn1: function (index, layero) {SaveAddInfo();},' +
                    'btn2: function (index, layero) {},' +
                    'success: function () { }' +
                    ' });' +
                    '}' +
                    'function SaveAddInfo() {' +
                    'var txtParentId = $("#hdnParentId").val();' +
                    'var txtDepartNo = $.trim($("#txtDepartNo").val());' +
                    'var txtDepartName = $.trim($("#txtDepartName").val());' +
                    'var hdnSupervisorId = $.trim($("#hdnSupervisorId").val());' +
                    'var txtDescription = $.trim($("#txtDescription").val());' +
                    'var txtCreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>";' +
                    'var txtModifyBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>";' +
                    'var txtRemark = "";' +
                    ' /*表单验证*/' +
                    ' /*如需表单验证可以此处处理验证 开始*/' +
                    'if (isNull(txtDepartName)) {' +
                    'alert("部门名称不能为空！");' +
                    '$("#txtDepartName").focus();' +
                    'return false;' +
                    '}' +
                    'if (isNull(txtDepartNo)) {' +
                    'alert("部门编号不能为空！");' +
                    '$("#txtDepartName").focus();' +
                    'return false;' +
                    '}' +
                    'if (organizationId > -1 && parseInt(organizationId) == parseInt(txtParentId)) {' +
                    'alert("部门的父级部门不能是自己！");' +
                    'return false;' +
                    '}' +
                    'var entity = {};' +
                    'entity.OrganizationId = organizationId;' +
                    'entity.ParentId = txtParentId;' +
                    'entity.DepartNo = txtDepartNo;' +
                    'entity.DepartName = txtDepartName;' +
                    'entity.SupervisorId = hdnSupervisorId;' +
                    'entity.Description = txtDescription;' +
                    'entity.CreateBy = txtCreateBy;' +
                    'entity.ModifyBy = txtModifyBy;' +
                    'entity.Remark = txtRemark;' +
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSKTSYS_OrganizationAddTemplate", JSON.stringify(entity), "1");' +
                    'if (ajax.error != null) {' +
                    ' alert(ajax.error.Message);' +
                    'return false;' +
                    '}' +
                    'alert("<%=Resources.Messages.SaveInSuccess%>");' +
                    'parent.window.Refresh(ajax.value);' +
                    'layer.close(layindex3);' +
                    '}' +
                    'function chooseParentDepart() {' +
                    'layindex1=layer.open({' +
                    'type:2,' +
                    'area: ["400px", "300px"],' +
                    'title: "新增信息",' +
                    'shade: 0.6,' +
                    'moveType: 0,' +
                    'shift: 0,' +
                    'closeBtn: 2,' +
                    'content: "<%=SKT.LeanMES.Web.WebHelper.WebRoot  %>/Organization/OrganizationTree.aspx?rnd=" + Math.random(),' +
                    'btn1: function (index, layero) { SaveTreeInfo(); },' +
                    'btn2: function (index, layero) { },' +
                    'success: function () { }' +
                    '});' +
                    '}' +
                    'function getChooseValue(parentId, parentDepartName, parentDepartNo) {' +
                    ' $("#hdnParentId").val(parentId);' +
                    'if (parentDepartNo == "") {' +
                    '$("#txtParentDepartName").val(parentDepartName);' +
                    ' }' +
                    'else {' +
                    'if ($.trim(parentDepartNo) != "") {' +
                    '$("#txtParentDepartName").val(parentDepartName + "(" + parentDepartNo + ")");' +
                    '}' +
                    'else {' +
                    '$("#txtParentDepartName").val(parentDepartName);' +
                    '}' +
                    '}' +
                    'layer.close(layindex1);' +
                    '}' +
                    'function chooseSupervisor() {' +
                    'var departId = "<%=Request.QueryString["ID"] %>";' +
                    'layindex2=layer.open({' +
                    'type:2,' +
                    'area: ["400px", "300px"],' +
                    'title: "新增信息",' +
                    'shade: 0.6,' +
                    'moveType: 0,' +
                    'shift: 0,' +
                    'closeBtn: 2,' +
                    'content: "<%=SKT.LeanMES.Web.WebHelper.WebRoot  %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&CallBackFunc=setSupervisor&rnd=" + Math.random(),' +
                    'btn1: function (index, layero) { SaveTreeInfo(); },' +
                    'btn2: function (index, layero) { },' +
                    'success: function () { }' +
                    '});' +
                    '}' +
                    'function setSupervisor(list) {' +
                    '$("#hdnSupervisorId").val(list[0][0]);' +
                    'if (list[0][1] == "") {' +
                    ' $("#txtSupervisor").val(list[0][2]);' +
                    ' }else {' +
                    'if ($.trim(list[0][1]) != "") {' +
                    '$("#txtSupervisor").val(list[0][2] + "(" + list[0][1] + ")");' +
                    ' }else {' +
                    ' $("#txtSupervisor").val(list[0][2]);' +
                    ' }' +
                    '}' +
                    'layer.close(layindex2);' +
                    ' }' +
                    'function Edit() {' +
                    'var idStr = "";' +
                    '$(".treeview  input[type=\'checkbox\']").each(function () {' +
                    'if ($(this)[0].checked) {' +
                    'idStr = $(this).val();' +
                    'return;' +
                    ' }' +
                    '});' +
                    'if (idStr == "") {' +
                    'alert("请选择一个部门");' +
                    'return false;' +
                    ' }' +
                    'organizationId = idStr;' +
                    'var entity = {};' +
                    'entity.OrganizationId = organizationId;' +
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSKTSYS_OrganizationTemplate", JSON.stringify(entity), "1");' +
                    'if (ajax.error != null) {' +
                    ' alert(ajax.error.Message);' +
                    'return false;' +
                    '}' +
                    'var obj = JSON.parse(ajax.value);' +
                    'if (obj != null) {' +
                    '$("#hdnParentId").val(obj.data[0].ParentId);' +
                    '$("#txtParentDepartName").val(obj.data[0].ParentDepartName);' +
                    '$("#txtDepartName").val(obj.data[0].DepartName);' +
                    '$("#txtDepartNo").val(obj.data[0].DepartNo);' +
                    '$("#hdnSupervisorId").val(obj.data[0].SupervisorId);' +
                    '$("#txtSupervisor").val(obj.data[0].UserName);' +
                    '$("#txtDescription").val(obj.data[0].Description);' +
                    ' }' +
                    ' layindex3 = layer.open({' +
                    'type: 1,' +
                    'area: ["600px", "400px"],' +
                    'title: "新增信息",' +
                    'shade: 0.6,' +
                    ' moveType: 0,' +
                    'shift: 0,' +
                    'closeBtn: 2,' +
                    'content: $("#editTemplate"),' +
                    'btn: ["保存", "取消"],' +
                    'btn1: function (index, layero) { SaveAddInfo(); },' +
                    'btn2: function (index, layero) { },' +
                    'success: function () { }' +
                    '});' +
                    '}' +
                    'function Delete() {' +
                    'var idStr = "";' +
                    '$(".treeview  input[type=\'checkbox\']").each(function () {' +
                    'if ($(this)[0].checked) {' +
                    'idStr += $(this).val() + ",";' +
                    '}' +
                    '});' +
                    'var idStr = idStr.substring(0, idStr.length - 1);' +
                    'if (idStr == "") {' +
                    'alert("请选择一个部门");' +
                    ' return false;' +
                    '}' +
                    'if (!confirm("是否确定要删除选中的部门，如果该部门下面还有子部门也会一起删除？")) {' +
                    'return false;' +
                    '}' +
                    ' organizationId = idStr;' +
                    'var entity = {};' +
                    'entity.OrganizationId = organizationId;' +
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSKTSYS_OrganizationDelTemplate", JSON.stringify(entity), "1");' +
                    'if (ajax.error != null) {' +
                    'alert(ajax.error.Message);' +
                    'return false;' +
                    '}' +
                    'alert("删除部门成功！");' +
                    'initOrganization(-1);' +
                    '}' +
                    'function Refresh(id) {' +
                    'initOrganization(id);' +
                    'closeDialog();' +
                    '}' +
                    ' $(document).ready(function () {' +
                    'initOrganization(-1);' +
                    'GetDepartmentMemeber(-1, "");' +
                    '});' +
                    'var parentIdArr;' +
                    'var expands;' +
                    'function initOrganization(id) {' +
                    '$("#browser").html("");' +
                    'var entity = {};' +
                    'entity.OrganizationId = \'-1\';' +
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSKTSYS_OrganizationTemplate", JSON.stringify(entity), "1");' +
                    'if (ajax.error != null) {' +
                    'alert(ajax.error.Message);' +
                    'return false;' +
                    '}' +
                    'parentIdArr = new Array();' +
                    'expands = true;' +
                    'var orgjsonObj=JSON.parse(ajax.value).data;' +
                    '$("#browser").showTree({ data: orgjsonObj });' +
                    '}' +
                    'function expandTree(id, data) {' +
                    'getParentId(id, data);' +
                    'try {' +
                    'expandSelectedNodes($(".treeview  input[type=\'checkbox\']"))' +
                    '}' +
                    'catch (e) { }' +
                    '}' +
                    'function expandSelectedNodes(obj) {' +
                    'for (var i = 0; i < parentIdArr.length; i++) {' +
                    'if (obj != null) {' +
                    'obj.each(function () {' +
                    'if ($(this).val() == parentIdArr[i]) {' +
                    '$(this).next().click();' +
                    ' if (expands && i == 0) { $(this)[0].checked = true; expands = false; }' +
                    'expandSelectedNodes($(".treeview  input[type=\'checkbox\']"))' +
                    '}' +
                    '});' +
                    ' }' +
                    '}' +
                    '}' +
                    'function getParentId(id, data) {' +
                    'var pId = -1;' +
                    'for (var i = 0; i < data.length; i++) {' +
                    ' pId = -1;' +
                    'if (data[i].OrganizationId == id) {' +
                    'parentIdArr.push(id);' +
                    'pId = data[i].ParentId;' +
                    'data.splice(data[i]);' +
                    'alert(0);' +
                    'getParentId(pId, data);' +
                    '}' +
                    'else {' +
                    'break ;' +
                    '}' +
                    '}' +
                    '}' +
                    'function GetDepartmentMemeber(orgId, departNo) {' +
                    'var entity = {};' +
                    'entity.DepartId = orgId;' +
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSKTMembershipTemplate", JSON.stringify(entity), "1");' +
                    'if (ajax.error != null) {' +
                    'alert(ajax.error.Message);' +
                    'return false;' +
                    '}' +
                    'if (ajax.error != null) {' +
                    'alert(ajax.error.Message);' +
                    'return false;' +
                    '}' +
                    'var userList = "";' +
                    'var list = JSON.parse(ajax.value).data;' +
                    'var rowclass = "ListTableEvenRow";' +
                    'for (var i = 0; i < list.length; i++) {' +
                    'if (i % 2 == 0) {' +
                    'rowclass = "ListTableOddRow";' +
                    '}else {' +
                    'rowclass = "ListTableEvenRow";' +
                    '}' +
                    'userList += "<tr class=\'" + rowclass + "\'>";' +
                    'userList += "<td>" + list[i].CName + "</td>";' +
                    'userList += "<td>" + list[i].EName + "</td>";' +
                    'userList += "<td>" + ((list[i].Sex == 0) ? "女" : "男") + "</td>";' +
                    'userList += "<td>" + list[i].Phone + "</td>";' +
                    'userList += "<td>" + list[i].Email + "</td>";' +
                    'userList += "<td>" + list[i].EmployeeNo + "</td>";' +
                    'userList += "<td>" + list[i].DepartName + "</td>";' +
                    'userList += "</tr>";' +
                    '}' +
                    '$("#userList tr:gt(0)").remove();' +
                    'if (list.length == 0) {' +
                    'userList = "<tr class=\'ListTableEmptyDataRow\'><td colspan=\'7\'>该部门没有任务人员</td></tr>";' +
                    '}' +
                    '$(userList).appendTo($("#userList"));' +
                    'moEvent();' +
                    '}' +
                    'var oldBg;' +
                    'function moEvent() {' +
                    '$("#userList .ListTableOddRow,#userList .ListTableEvenRow").hover(' +
                    'function () {' +
                    ' oldBg = $(this).attr("class");' +
                    '$(this).removeClass(oldBg);' +
                    '$(this).addClass("ListTableHoverRow");' +
                    '},' +
                    'function () {' +
                    '$(this).removeClass("ListTableHoverRow");' +
                    '$(this).addClass(oldBg);' +
                    '});' +
                    '}' +
                    '<\/script>';
                var js_source = strHTML.replace(/^\s+/, '');
                var tabsize = 1;
                var tabchar = ' ';
                var finalHtml = '';
                if (tabsize == 1) {
                    tabchar = '\t';
                }
                if (js_source && js_source.charAt(0) === '<') {
                    finalHtml = style_html(js_source, tabsize, tabchar, 80);
                } else {
                    finalHtml = js_beautify(js_source, tabsize, tabchar);
                }

                var iframes = document.getElementById("ifCtrl");
                iframes.contentWindow.setData(encodeURI(finalHtml));
                //自动调用保存功能  保障预览功能正常
                Save(1);
            }
        }
        //单据打印模版
        var layindexDan;
        function DanPrintTemplate(checkbox) {
            PageSub = false;
            if (checkbox.checked == true) {
                if (!confirm("是否确认单据打印控件?")) {
                    $(checkbox).prop('checked', false);
                    return false;
                }
                var PageHtml = '<form method="post" action="./CustomMenuPage.aspx?name=CustomMenuPage&amp;PaName=4A436C27-DFCE-4F7E-AF2A-69B9E53365B6&amp;Flag=1" id="form2" onsubmit="return SubmitIdentityKey()"><div><table class="EditeContentTable" id="tbEditInfo" width="100%"></tr><td colspan="2" style="padding:3px;color:red;">提示:将下载的XML模版代码(之前若有编辑过自动会下载之前编辑过的)放入您熟悉的编辑器中编辑完成后点击上传即可。</td></tr><tr><td class="Label2">下载模版</td><td class="Field3"><div style="cursor:pointer;color:blue;text-decoration:underline;" onclick="download()">下载</div></td></tr><tr><td class="Label2">上传</td><td class="Field3"><div style="text-align:left; padding:10px;"><input type="file" id="Filedata" name="Filedata"/><input type="button" value="上传XML模版文件" class="button" id="btnUploadLogo" onclick="UploadPdfTemplate()"/></div></td></tr></table></div></form>';
                layindexDan = layer.open({
                    type: 1,
                    area: ["350px", "250px"],
                    title: "确认",
                    shade: 0.6,
                    moveType: 0,
                    shift: 0,
                    closeBtn: 2,
                    content: PageHtml,
                    //btn: ["保存", "取消"],
                    //btn1: function (index, layero) {
                    //    SaveAddInfo();
                    //},
                    //btn2: function (index, layero) { },
                    success: function () { }
                });
            }
        }
        //上传XML模版
        function UploadPdfTemplate() {
            var form = new FormData($("#form2")[0]);
            try {
                $.ajax({
                    type: "POST",
                    url: "../Handler/UploadHander.ashx?Action=UploadCustomerXMLTemplate&PName=" + PName + "&rnd=" + Math.random(),
                    data: form,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        if (layindexDan != null && layindexDan != undefined) {
                            layer.close(layindexDan);
                        }
                        alert("XML模版上传成功。");
                        //添加界面功能
                        var iframes = document.getElementById("ifCtrl");
                        var contentData = decodeURI(iframes.contentWindow.getData());
                        var LastIndexScriptTag = contentData.lastIndexOf("</script");

                        var strScript = '$(function () {' +
                       '$("div[title=\'帮助\']").before(\'<div class="toolbar-btn" onclick="RePrint()" title="补打"><div class="icon-16-printer"></div><div class="btn-text">补打</div></div>\');' +
                       '});' +
                       'function RePrint() {' +
                           'var PName1="' + PName + '";' +
                           'var entity = {};' +
                           'entity.DeliverId = 120;' +
                           'var str =JSON.stringify(entity);' +
                           'var url="../CustomMenu/CustomPDFTemplate.aspx?name=CustomPDFTemplate&ID=120&PaName="+PName1+"&strSPC=upsGetDeliverPrint&strJson="+str;' +
                           'window.open(url);' +
                       '}';

                        var js_source = strScript.replace(/^\s+/, '');
                        var tabsize = 1;
                        var tabchar = ' ';
                        if (tabsize == 1) {
                            tabchar = '\t';
                        }
                        var scriptfinalHtml = '';
                        if (js_source && js_source.charAt(0) === '<') {
                            scriptfinalHtml = style_html(js_source, tabsize, tabchar, 80);
                        } else {
                            scriptfinalHtml = js_beautify(js_source, tabsize, tabchar);
                        }
                        var preStr = contentData.substring(0, LastIndexScriptTag);
                        var nextStr = contentData.substring(LastIndexScriptTag);
                        var summaryStr = encodeURI(preStr) + encodeURI(scriptfinalHtml) + encodeURI(nextStr);
                        iframes.contentWindow.setData(summaryStr);
                    },
                    error: function (xhr, status, error) {
                        alert(error);
                    }
                });
            }
            catch (ex) {
                alert(ex);
            }
        }
        function downloadFile(content, filename) {
            var a = document.createElement('a')
            var blob = new Blob([content])
            var url = window.URL.createObjectURL(blob)
            a.href = url
            a.download = filename
            a.click()
            window.URL.revokeObjectURL(url)
        }

        function download(url) {
            ////var url = 'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=20550366,3650143321&fm=26&gp=0.jpg' // demo图片
            var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/XmlFile/PDF/DeliveryForm.xml";
            var url1 = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/CustomMenu/CustomPrintPDF/" +PName+ ".xml";
            if (isExistFile(url1)) {
                url = url1;
            }
            ajax(url, function (xhr) {
                //var filename = 'xxx.' + url.replace(/(.*\.)/, '') // 自定义文件名+后缀
                var filename = "xmlTemplate.xml";
                downloadFile(xhr.response, filename);
            }, {
                responseType: 'blob'
            })
        }
        //判断文件是否存在
        function isExistFile(url)  
        {      
            var xmlHttp ;  
            if (window.ActiveXObject)  
            {  
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");  
            }  
            else if (window.XMLHttpRequest)  
            {  
                xmlHttp = new XMLHttpRequest();  
            }   
            xmlHttp.open("get",url,false);  
            xmlHttp.send();  
            if (xmlHttp.readyState== 4) {
                if (xmlHttp.status== 200) return true;//url存在
                else if (xmlHttp.status== 404) return false;//url不存在
                else return false;//其他状态
            }
            return false;
        }

        function ajax(url, callback, options) {
            window.URL = window.URL || window.webkitURL
            var xhr = new XMLHttpRequest()
            xhr.open('get', url, true)
            if (options.responseType) {
                xhr.responseType = options.responseType
            }
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    callback(xhr)
                }
            }
            xhr.send()
        }
        //物料标签打印模版
        function MaterialTagPrintTemplate(checkbox) {
            PageSub = false;
            if (checkbox.checked == true) {
                if (!confirm("此操作会覆盖之前代码设计内容,是否确认添加物料标签打印模版?")) {
                    $(checkbox).prop('checked', false);
                    return false;
                } else {
                    $(".template").prop('checked', false);
                    $(checkbox).prop('checked', true);
                }
                $("#<%=this.hdnPType.ClientID %>").val("0");
                var strHtml = '<div id="noprtplg" class="Tips"></div>'+
                    '<div class="infoTips">带<em>*</em> 为必填项。</div>'+
                    '<table width="100%" class="EditeContentTable">'+
                    '<tr>'+
                    '<td class="Label" align="center" colspan="2" style="font-size: 22px; font-weight: bold;">物料包装箱条码:<span id="GrnPackingSN" style="font-size: 22px; font-weight: bold;"></span></td>'+
                    '</tr>'+
                    '<tr id="showSupplierList" style="display: none">'+
                    '<td class="Label1">选择供应商<em>*</em></td>'+
                    '<td class="Field1"><input type="text" id="txtVendorCode" class="TextBox" disabled="disabled" value=""  /><input type="button" id="btnSelectSupplier" class="ButtonBox" value="..." onclick="selectSupplier()" /></td>'+
                    ' </tr>'+
                    '<tr>'+
                    '<td class="Label1">物料条码<em>*</em></td>'+
                    '<td class="Field1"><input type="text" value="" id="txtGRN" class="TextBox" style="width: 250px; height: 25px;text-transform: uppercase; font-size: 16px; font-weight: bold;" /><input type="hidden" value="" id="hdnVendorCode" /><input class="TextBox" id="hidtxt" style="display: none;" /></td>'+
                    '</tr>'+
                    ' <tr>'+
                    '<td class="Label1">打印机名称</td> <td class="Field2" colspan="1"><select id="selPrintersList" style=" width: 250px; "></select></td>'+
                    '</tr>'+
                    ' <tr>'+
                    '<td class="Label1"></td>'+
                    '<td class="Field2" colspan="1"><a href="#" onclick="bindPrinters(\'selPrintersList\');">重新加载打印机列表</a></td>'+
                    '</tr>'+
                    '</table>'+
                    '<div class="clear5"></div>'+
                    '<div style="text-align: center; color: Red;"><span id="msg"></span></div>'+
                    '<!--打印状态的信息提示区域-->'+
                    '<div id="lblMessage" class="Tips" style="text-align: center"></div>'+
                    '<div id="divPackScanCode">'+
                    '<table class="ListTable" width="100%" id="tabPackScanCode">'+
                    '<tr class="ListTableHeader">'+
                    '<th><input type="checkbox" value="-1" /></th>'+
                    '<th>未关闭的包装箱号</th>'+
                    '<th>物料编码</th>'+
                    '<th>物料名称</th>'+
                    '<th>供应商名称</th>'+
                    '<th>批次号</th>'+
                    '</tr>'+
                    '<tr id="trNewInfo" class="ListTableOddRow">'+
                    '<td colspan="7" style="text-align: center;">暂无数据</td>'+
                    '</tr>'+
                    '</table>'+
                    '</div>'+
                    '<div class="clear5"></div>'+
                    '<div id="lblPt" class="Tips"></div>'+
                    '<div id="packingItemList">'+
                    '<table class="ListTable" width="100%" id="packingItemListTbl">'+
                    '<tr class="ListTableHeader">'+
                    '<th align="left" colspan="2">物料包装箱条码&nbsp;&nbsp;<span id="CartonSN"></span></th>'+
                    '</tr>'+
                    '<tr class="ListTableEvenRow">'+
                    '<td align="left" colspan="2">已包装的物料条码<span id="packedItemQty">0</span></td>'+
                    '</tr>'+
                    ' </table>'+
                    '</div>'+
                    '<input type="hidden" value="" id="hdnCartonSN" />'+
                    '<script type="text/javascript" src="../Content/plugin/layui/layui.all.js"><\/script>'+
                    '<link href="../Content/plugin/layui/css/layui.css" rel="stylesheet" />'+
                    '<script src="../Content/js/ws.js" type="text/javascript"><\/script>'+
                    '<script src="../Content/js/skt.utility.printer.js?v=3" type="text/javascript"><\/script>'+
                    '<script language="javascript" type="text/javascript">'+
                    'var vendorCode = "";'+
                    'var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>";'+
                    'var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";'+
                    'var num = 0;'+
                    '$(function () {' +
                    '$("#toolbar").html("");' +
                    '$("#divLoading").hide();' +
                    'var headHtml=\'<div class="toolbar-btn" onclick="ClosePack()" title="完成包装"><div class="icon-16-CloseBox"></div><div class="btn-text">完成包装</div></div><div class="btn-line"></div><div class="toolbar-btn" onclick="Help()" title="帮助"><div class="icon-16-help"></div><div class="btn-text">帮助</div></div><div class="clear0"></div></div>\';' +
                    '$("#toolbar").html(headHtml);' +
                    '$("#divPackScanCode").hide();'+
                    ' bindPrinters(\'selPrintersList\');'+
                    ' });'+
                    'function selectSupplier() {'+
                    'dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "../Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 700, height: 350 });'+
                    '}'+
                    'function getChooseValue(list) {'+
                    '$("#txtVendorCode").val(list[0][1]);'+
                    'vendorCode = list[0][1];'+
                    '$("#hdnVendorCode").val(vendorCode);'+
                    '}'+
                    '$(document).ready(function () {'+
                    ' var entity={};'+
                    ' entity.UserId=userId;'+
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetVendorByUserId", JSON.stringify(entity), "1");'+
                    'if (ajax.error != null) {'+
                    'alert(ajax.error.Message);'+
                    'return false;'+
                    '}'+
                    'var obj = JSON.parse(ajax.value);'+
                    'vendorCode = obj.data[0].VendorCode;'+
                    'if (vendorCode == "") {'+
                    '$("#showSupplierList").show();'+
                    '}'+
                    '$("#hdnVendorCode").val(vendorCode);'+
                    '$("#txtGRN").keydown(function (event) {'+
                    'var e = event || window.event;'+
                    'if (e && e.keyCode == 13) {'+
                    'if ($.trim($("#txtGRN").val()) != "") {'+
                    'PackGRN();'+
                    ' }'+
                    ' else {'+
                    'alert("请先扫描GRN条码");'+
                    'return false;'+
                    '}'+
                    ' }'+
                    '});'+
                    ' });'+
                    'function PackGRN() {' +
                    '$("#divLoading").hide();' +
                    '$("#msg").html("");'+
                    '$("#msg").css("color", "red");'+
                    '$(".StrongFont").removeClass("StrongFont");'+
                    'var txtGRN = $.trim($("#txtGRN").val());'+
                    'var hdnCartonSN = $.trim($("#hdnCartonSN").val());' +
                    'vendorCode = $("#hdnVendorCode").val();'+
                    'if (vendorCode == "") {'+
                    ' alert("请选择供应商!");'+
                    'return false;'+
                    '}'+
                    'if (txtGRN == "") {'+
                    'alert("请扫GRN条码！");'+
                    '$("#txtGRN").focus();'+
                    '$("#txtGRN").select();'+
                    'return false;'+
                    '}'+
                    'var entity = {};'+
                    'entity.GRN = txtGRN;'+
                    'entity.UserName = userName;'+
                    'entity.CartonSN = hdnCartonSN;'+
                    'entity.VendorCode = vendorCode;'+
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspValidatePackingGRNTemplate", JSON.stringify(entity), "1");'+
                    'if (ajax.error != null) {'+
                    ' $("#msg").html(ajax.error.Message);'+
                    '$("#msg").css("color", "red");'+
                    '$("#txtGRN").focus();'+
                    '$("#txtGRN").select();'+
                    ' highListCurrentItem(txtGRN);'+
                    ' return false;'+
                    '}'+
                    'var messageStr = JSON.parse(ajax.value);' +
                    'if(messageStr==null&&messageStr.data.length==0){alert("未找到数据!");return false;}' +
                    'vendorCode = messageStr.data[0].returnVendorCode;'+
                    '$("#hdnVendorCode").val(vendorCode);'+
                    'if (messageStr.data[0].ErrorType == -1) {'+
                    '$("#msg").html(messageStr.data[0].ErrorMessage);'+
                    '$("#txtGRN").focus();'+
                    '$("#txtGRN").select();'+
                    'return false;'+
                    '}'+
                    'if (messageStr.data[0].ErrorType == 0) {'+
                    'setCartonSN(messageStr.data[0].ErrorMessage);'+
                    'setPackInfo(txtGRN);'+
                    'appendPackItem(txtGRN);'+
                    'return false;'+
                    '}' +
                    'if (messageStr.data[0].ErrorType == 1) {' +
                    '$("#txtGRN").focus();' +
                    '$("#txtGRN").select();' +
                    'if (vendorCode == "") {' +
                    '$("#msg").html("获取供应商编码失败！");' +
                    '$("#msg").css("color", "red");' +
                    'return false;' +
                    ' }' +
                    'if (confirm("系统中还有未关闭的包装箱可使用，是否使用未关闭的包装箱？点击【确定】重新生成新的包装箱，点击【取消】打开未关闭的包装箱")) {' +
                    'var entity = {};' +
                    'entity.GRN = txtGRN;' +
                    'entity.UserName = userName;' +
                    'entity.IsBigCarton = 1;' +
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGenerateNewCartonSNAndPackTemplate", JSON.stringify(entity), "1");' +
                    'if (ajax.error != null) {' +
                    '$("#msg").html(ajax.error.Message);' +
                    '$("#msg").css("color", "red");' +
                    'return false;' +
                    '}' +
                    'var returnCartonSN = JSON.parse(ajax.value);' +
                    'if (returnCartonSN == null) {' +
                    'alert("未找到数据!");' +
                    'return false;' +
                    '}' +
                    'setCartonSN(returnCartonSN.data[0].CartonSN);' +
                    'setPackInfo(txtGRN);' +
                    'appendPackItem(txtGRN);' +
                    '}else {' +
                    'num += 1;' +
                    '$("#divPackScanCode").show();' +
                    'var entity = {};' +
                    'entity.GRN = txtGRN;' +
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetOldCartonGRNList", JSON.stringify(entity), "1");' +
                    'if (ajax.error != null) {' +
                    '$("#msg").html(ajax.error.Message);' +
                    '$("#msg").css("color", "red");' +
                    'return false;' +
                    '}' +
                    'var strHtml = "";' +
                    'var oldCartonSN = "";' +
                    'var list = JSON.parse(ajax.value).data;' +
                    '$("#trNewInfo").remove();' +
                    'if (num == 1) {' +
                    'for (var i = 0; i < list.length; i++) {' +
                    'strHtml += "<tr class=\'ListTableOddRow\'>";' +
                    'strHtml += "<td><input name=\'chkSelect\' align=\'center\' type=\'checkbox\' value=\'" + list[i].SerialNumber + "\'/></td>";' +
                    'strHtml += "<td>" + list[i].SerialNumber + "</td>";' +
                    'strHtml += "<td>" + list[i].ItemCode + "</td>";' +
                    'strHtml += "<td>" + list[i].ItemName + "</td>";' +
                    'strHtml += "<td>" + list[i].VendorName + "</td>";' +
                    'strHtml += "<td>" + list[i].LotCode + "</td>";' +
                    'strHtml += "</tr>";' +
                    '}' +
                    '$(strHtml).appendTo($("#tabPackScanCode"));' +
                    '}' +
                    '$("input[name=\'chkSelect\']").click(function () {' +
                    'if (this.checked) {' +
                    '$("#tabPackScanCode tr").each(function () {' +
                    'if ($($(this).find("td")[0]).find("input[name=\'chkSelect\']").is(":checked")) {' +
                    'oldCartonSN += $($(this).find("td")[1]).html();' +
                    '}' +
                    '});' +
                    'var entity = {};' +
                    'entity.GRN = txtGRN;' +
                    'entity.VendorCode = vendorCode;' +
                    'entity.UserName = userName;' +
                    'entity.CartonSN = hdnCartonSN;' +
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetOldCartonGRNTemplate", JSON.stringify(entity), "1");' +
                    'if (ajax.error != null) {' +
                    '$("#msg").html(ajax.error.Message);' +
                    '$("#msg").css("color", "red");' +
                    'return false;' +
                    '}' +
                    'setCartonSN(oldCartonSN);' +
                    'setPackInfo(txtGRN);' +
                    'getPackedItemList(oldCartonSN);' +
                    ' }' +
                    '});' +
                    '}' +
                    '}' +
                    'if (messageStr.data[0].ErrorType == 2) {' +
                    'var str = messageStr[1].split("|");' +
                    '$("#txtGRN").focus();' +
                    '$("#txtGRN").select();' +
                    'if (vendorCode != str[1]) {' +
                    '$("#msg").html("<%=Resources.Messages.GrnNotMatchVendorCode %>");' +
                    '$("#msg").css("color", "red");' +
                    'return false;' +
                    '}' +
                    'setCartonSN(str[0]);' +
                    'getPackedItemList(str[0]);' +
                    '$("#msg").html("成功打开旧包装，您可以继续往该包装箱内包装物料！");' +
                    ' $("#msg").css("color", "green");' +
                    'return false;' +
                    '}' +
                    ' }'+
                    ' function getSelectedValues() {'+
                    ' var selValues = "";'+
                    'var checkboxs = document.getElementsByName("chkSelect");'+
                    'var checkboxCount = checkboxs.length;'+
                    'for (var i = 0; i < checkboxCount; i++) {'+
                    'if (checkboxs[i].checked) {'+
                    ' if (selValues != "") {'+
                    'selValues += ",";'+
                    '}'+
                    'selValues += checkboxs[i].value;'+
                    ' }'+
                    ' }'+
                    ' return selValues;'+
                    '}'+
                    'function highListCurrentItem(txtGRN) {'+
                    '$("#packingItemListTbl tr").each(function () {'+
                    'if ($(this).children("td:eq(1)").html() == txtGRN) {'+
                    '$(this).addClass("StrongFont");'+
                    ' }'+
                    '});'+
                    ' }'+
                    'function setCartonSN(cartonsn) {'+
                    '$("#GrnPackingSN").html(cartonsn);'+
                    '$("#hdnCartonSN").val(cartonsn);'+
                    '$("#CartonSN").html(cartonsn);'+
                    '}'+
                    'function setPackInfo(info) {'+
                    '$("#msg").html("[" + info + "]<%=Resources.Messages.PackingSuccessful %>");'+
                    '$("#msg").css("color", "green");'+
                    '$("#txtGRN").val("");'+
                    '$("#txtGRN").focus();'+
                    '$("#txtGRN").select();'+
                    '$("#divPackScanCode").hide();'+
                    '}'+
                    ' function appendPackItem(grn) {'+
                    '$(".StrongFont").removeClass("StrongFont");'+
                    'var rows = $("#packingItemListTbl tr").length - 2;'+
                    'if (rows % 2 == 0) {'+
                    '$("<tr class=\'ListTableOddRow StrongFont\'><td width=\'3%\'>" + (rows + 1) + "</td><td>" + grn + "</td></tr>").appendTo($("#packingItemListTbl"));'+
                    '}'+
                    'else {'+
                    '$("<tr class=\'ListTableEvenRow StrongFont\'><td width=\'3%\'>" + (rows + 1) + "</td><td>" + grn + "</td></tr>").appendTo($("#packingItemListTbl"));'+
                    '}'+
                    '$("#packedItemQty").html((parseInt($("#packedItemQty").html()) + 1).toString());'+
                    '}'+
                    ' function ClosePack() {'+
                    'var txtCartonSN = $("#hdnCartonSN").val();'+
                    'if (txtCartonSN == "") {'+
                    'alert("没有可关闭的包装箱，请扫描物料条码来生成包装箱或打开未关闭的包装箱。");'+
                    'return false;'+
                    '}' +
                    'var grncount = $("#packingItemListTbl tr").length - 2;' +
                    'if (grncount == 0) {' +
                    'alert("包装箱是空的，不能关闭！");' +
                    'return false;' +
                    '}' +
                    'if (confirm(String.format("包装箱条码：{0};已包装物料GRN数量：;{1}是否确定关闭该包装箱？", txtCartonSN.toString(), grncount.toString()))) {' +
                    'var entity = {};'+
                    'entity.CartonSN = txtCartonSN;'+
                    'entity.UserName = userName;'+
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCloseGrnPack", JSON.stringify(entity), "1");'+
                    'if (ajax.error != null) {'+
                    'alert(ajax.error.Message);'+
                    'return false;'+
                    '}'+
                    ' $("#CartonSN").html("<span style=\'color:green;\'>" + txtCartonSN + "[物料包装箱已关闭，请先解包装后再移除！]</span>");'+
                    '$("#GrnPackingSN").html("");'+
                    '$("#hdnCartonSN").val("");'+
                    '$("#txtGRN").val("");'+
                    '$("#txtGRN").focus();'+
                    '$("#msg").html("正在打印...");'+
                    'printCartonLabel(txtCartonSN);'+
                    '}'+
                    '}'+
                    'function printCartonLabel(grn) {'+
                    'var entity = {};'+
                    'entity.FieldValue = grn;'+
                    'entity.IsByID = false;'+
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("Prod_MaterialUnit_GetInfo", JSON.stringify(entity), "1");'+
                    'if (ajax.error != null) {'+
                    'alert(ajax.error.Message);'+
                    'return false;'+
                    '}'+
                    'var entity = JSON.parse(ajax.value);'+
                    'labelItemId = entity.data[0].PartId;'+
                    'SNInfo = {};'+
                    'SNInfo.SNList = [];'+
                    'SNInfo.SNList.push(grn);'+
                    'if (SNInfo.SNList.length == 0) return false;'+
                    'mesLabLabelPrint();'+
                    '}'+
                    ' var ibs;'+
                    'var labelDocumentId = -1;'+
                    'var lableTypeQty = 1;'+
                    'var printName = ""; '+
                    'var labelItemId = "<%=Request.QueryString["ItemID"] %>";'+
                    'var labelProdOrderId = "<%=Request.QueryString["OrderID"] %>";'+
                    'var labelStationId = -1;'+
                    'var labelType = -14;'+
                    'var labelSequence = 8;'+
                    'var labelPrintWayId = -1; '+
                    'var lableArr = null; '+
                    'var SNInfo;'+
                    'var tempatePath = ""; '+
                    'function getDocumentInfo() {'+
                    'var entity = {};'+
                    'entity.ItemId = labelItemId;'+
                    'entity.StationId = labelStationId;'+
                    'entity.TypeId = labelType;'+
                    'entity.Sequence = labelSequence;'+
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspProdGetLableDocumentId", JSON.stringify(entity), "1");'+
                    'if (ajax.error == null) {'+
                    'var entity = JSON.parse(ajax.value).data[0];' +
                    'labelDocumentId = entity.LabelDocumentId;'+
                    'lableTypeQty = entity.PlateQty;'+
                    'printName = $("#selPrintersList").val();'+
                    'labelPrintWayId = entity.PrintWayId;'+
                    'tempatePath = entity.TemplatePath.replace("/\/\", "/\/\/\/\");'+
                    '}'+
                    'else {'+
                    'alert(ajax.error.Message);'+
                    '$("#lblMessage").html(ajax.error.Message);'+
                    'return false;'+
                    ' }'+
                    '}'+
                    'function mesLabLabelPrint() {'+
                    'lableArr = SNInfo.SNList;'+
                    'var labelStr = "";'+
                    'var printdata = [];'+
                    'for (var i = 0; i < lableArr.length; ) {'+
                    'if (lableTypeQty == 1) {'+
                    'labelStr = lableArr[i];'+
                    '}'+
                    'else {'+
                    'labelStr = "";'+
                    'for (var j = 0; j < lableTypeQty; j++) {'+
                    'if (lableArr[i + j] == null || lableArr[i + j] == "undefined") {'+
                    ' }else {'+
                    'labelStr += lableArr[i + j] + ",";'+
                    '}'+
                    '}'+
                    '}'+
                    'i = i + lableTypeQty;'+
                    'var entity = {};'+
                    'entity.LabelDocumentId = labelDocumentId;'+
                    'entity.SN = labelStr;'+
                    'entity.StationId = -1;'+
                    'entity.ResId = -1;'+
                    'entity.LineId = -1;'+
                    'entity.ItemId = labelItemId;'+
                    'entity.WOId = -1;'+
                    'var ajaxLabContent = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetLabelContentForLabPrint", JSON.stringify(entity), "1");'+
                    ' if (ajaxLabContent.error == null) {'+
                    'try {'+
                    'var list =JSON.parse(ajaxLabContent.value).data;' +
                    'if(list==null){alert("未获取到数据!");return false;};'+
                    'if (list.length > 0) {'+
                    'var page = { LabelContent: [] };'+
                    'for (var k = 0; k < list.length; k++) {'+
                    'page.LabelContent.push({ name: list[k].LabelName, value: list[k].LabelValue });'+
                    '}'+
                    ' printdata.push(page);'+
                    '}'+
                    '} catch (e) {'+
                    'printdata = [];'+
                    'alert(e);'+
                    '$("#lblMessage").html(e);'+
                    'return false;'+
                    '}'+
                    '}else {'+
                    'printdata = [];'+
                    'alert(ajaxLabContent.error.Message);'+
                    '$("#lblMessage").html(ajaxLabContent.error.Message);'+
                    'return false;'+
                    '}'+
                    '}'+
                    'if (printdata.length == 0){return;}'+
                    'try {'+
                    'sendPrintContent(JSON.stringify(printdata), printName, 1, labelDocumentId);'+
                    ' } catch (e) {'+
                    'alert(e);'+
                    '$("#lblMessage").html(e);'+
                    'return false;'+
                    ' }'+
                    'ibs = 3;'+
                    'setTimeout(function () {'+
                    '$("#lblMessage").html(\'条码打印完成!\');'+
                    '}, 300);'+
                    ' }'+
                    '<\/script>'
                var js_source = strHtml.replace(/^\s+/, '');
                var tabsize = 1;
                var tabchar = ' ';
                var finalHtml = '';
                if (tabsize == 1) {
                    tabchar = '\t';
                }
                if (js_source && js_source.charAt(0) === '<') {
                    finalHtml = style_html(js_source, tabsize, tabchar, 80);
                } else {
                    finalHtml = js_beautify(js_source, tabsize, tabchar);
                }

                var iframes = document.getElementById("ifCtrl");
                iframes.contentWindow.setData(encodeURI(finalHtml));
                //自动调用保存功能  保障预览功能正常
                Save(1);
            }
        }
        //分页标签模版
        function PagingTemplate(checkbox) {
            PageSub = false;
            if (checkbox.checked == true) {
                if (!confirm("此操作会覆盖之前代码设计内容,是否确认添加分页标签模版?")) {
                    $(checkbox).prop('checked', false);
                    return false;
                } else {
                    $(".template").prop('checked', false);
                    $(checkbox).prop('checked', true);
                }
                $("#<%=this.hdnPType.ClientID %>").val("0");
                var strHtml = '<div id="onprocess" style="text-align: center;"></div>' +
                    '<div class="wrap_tb">' +
                    '<ul class="tb"><li class="current">数据库链接配置</li><li>Logo设置</li></ul>' +
                    '<div class="tb_c"><div class="divHeader"><img src="../Content/images/icon/edit_dblink.png" class="imgText" />&nbsp;模版TEST</div>' +
                    '<table class="EditeContentTable" width="100%">' +
                    '<tr>' +
                    '<td class="Label1"> 模版名称<em>*</em></td><td class="Field1"><input type="text" id="TemplateName" style="width:250px;"/></td>' +
                    '</tr>' +
                    '<tr>' +
                    '<td class="Label1">用户名<em>*</em></td><td class="Field1"><input type="text" id="UserName"/></td>' +
                    '</tr>' +
                    '</table>' +
                    '</div>' +
                    ' <div>' +
                    '<div class="infoTips">在此上传的logo将会在系统框架右上角显示，logo尺寸：宽*高 = 200px*45px</div>' +
                    '<table class="EditeContentTable" width="100%"><tr>' +
                    '<td class="Label1">选择Logo文件：</td>' +
                    '<td class="Field1"><input type="file" id="Filedata" name="Filedata"/><img id="llLogo" src=""/><a href="#" id="btnDeleteLogo">删除自定义LOGO</a></td></tr></table>' +
                    '<div style="text-align:center; padding:10px;"><input type="button" value="上传Logo" class="button" id="btnUploadLogo"/></div>' +
                    '<div id="viewLogo" style="text-align:center; padding:10px;"><img src=""/></div></div></div>' +
                    '<div style=" height:38px; "><div id="loading" style="display: none; z-index: 111;">' +
                    '<div style="background: #cccccc; position: absolute; z-index: 112; top: 0; left: 0px;filter: Alpha(opacity=60); -moz-opacity: 0.6; opacity: 0.6;" id="loading-bg"></div>' +
                    '<div style="position: absolute; top: 35%; left: 35%; z-index: 113; background: #f7f7f7;width: 360px; border: 1px solid #333333; height: 65px; line-height: 65px; text-align: center;"id="loading-content">正在执行方法,请耐心等待...</div></div></div>' +
                    ' <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" type="text/css" />' +
                    '<script src="../Content/plugin/tabs/jPlugin-tabs.js" type="text/javascript"><\/script>' +
                    ' <script language="javascript" type="text/javascript">' +
                    '$(function () {' +
                    '$("#toolbar").html("");' +
                    'var headHtml=\'<div id="toolbar" class="toolBar"><div class="toolbar-btn" onclick="SavePlus()" title="保存"><div class="icon-16-save"></div><div class="btn-text">保存</div></div><div class="btn-line"></div><div class="toolbar-btn" onclick="Help()" title="帮助"><div class="icon-16-help"></div><div class="btn-text">帮助</div></div><div class="clear0"></div></div>\';' +
                    '$("#toolbar").html(headHtml);' +
                    '$("#btnUploadLogo").click(function () {' +
                    'var form = new FormData($("#form1")[0]);' +
                    'try {' +
                    ' $.ajax({' +
                    'type: "POST",' +
                    'url: "../Handler/UploadHander.ashx?Action=UploadCustomerTemplate&rnd=" + Math.random(),' +
                    'data: form,' +
                    'contentType: false,' +
                    'processData: false,' +
                    'success: function (data) {' +
                    '$("#viewLogo").children("img").attr("src", ".."+data.replace("//","/"));' +
                    ' alert("Logo上传成功。");' +
                    '},' +
                    'error: function (xhr, status, error) {' +
                    'alert(error);' +
                    '}' +
                    '});' +
                    ' }' +
                    'catch (ex) {' +
                    'alert(ex);' +
                    ' }' +
                    '});' +
                    ' $("#btnDeleteLogo").click(function () {' +
                    'if (confirm("是否确定要删除自定义LOGO？删除后将不再显示自定义LOGO！")) {' +
                    'document.forms[0].submit();' +
                    '}else {return false; } });' +
                    ' });' +
                    'function Save() {' +
                    'var TemplateName = $.trim($("#TemplateName").val());' +
                    'var UserName = $.trim($("#UserName").val());' +
                    'if (!TemplateName) {' +
                    ' alert("模版名称不能为空!");' +
                    'return false;' +
                    '}' +
                    'if (!UserName) {' +
                    'alert("用户名不能为空!");' +
                    'return false;' +
                    '}' +
                    'var entity = {};' +
                    'entity.TemplateName = TemplateName;' +
                    'entity.UserName = UserName;' +
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSavePagingTemplate", JSON.stringify(entity), "1");' +
                    'if (ajax.error != null) {' +
                    'alert(ajax.error.Message);' +
                    'return false;' +
                    '}' +
                    'alert("保存成功!");' +
                    '}' +
                    '<\/script>'
                var js_source = strHtml.replace(/^\s+/, '');
                var tabsize = 1;
                var tabchar = ' ';
                var finalHtml = '';
                if (tabsize == 1) {
                    tabchar = '\t';
                }
                if (js_source && js_source.charAt(0) === '<') {
                    finalHtml = style_html(js_source, tabsize, tabchar, 80);
                } else {
                    finalHtml = js_beautify(js_source, tabsize, tabchar);
                }

                var iframes = document.getElementById("ifCtrl");
                iframes.contentWindow.setData(encodeURI(finalHtml));
                //自动调用保存功能  保障预览功能正常
                Save(1);
            }
        }
        function AddWarrantTemplate(checkbox) {
            PageSub = false;
            if (checkbox.checked == true) {
                if (!confirm("是否确认添加授权按钮?")) {
                    $(checkbox).prop('checked', false);
                    return false;
                }
                var iframes = document.getElementById("ifCtrl");
                var contentData = decodeURI(iframes.contentWindow.getData());
                var LastIndexScriptTag = contentData.lastIndexOf("</script");
                var phtml = '<div>' +
                    '<table class="EditeContentTable" id="tbEditInfo" width="100%">' +
                    '<tr>' +
                    '<td class="Label2"><span>单号</span></td>' +
                    '<td class="Field2"><span id="username"></span></td>' +
                    '<td class="Label2"><span>客户订单</span></td>' +
                    '<td class="Field2"><span id="gonghao"></span></td>' +
                    '</tr>' +
                    '</table>' +
                    '<div class="clear5"></div>' +
                    '<table class="EditeContentTable" width="100%">' +
                    '<tr>' +
                    '<td class="Label" style="width: 45%; text-align: center; font-weight: bold;">' +
                    '<span id="ChooseRole">选择角色</span>' +
                    '</td>' +
                    '<td class="Label" style="width: 10%; text-align: center;"></td>' +
                    '<td class="Label" style="width: 45%; text-align: center; font-weight: bold;">' +
                    '<span id="UserRole">用户的角色</span>' +
                    '</td>' +
                    '</tr>' +
                    '<tr style="height: 300px;" valign="top">' +
                    '<td align="center" style="width: 45%; vertical-align: top;">' +
                    '<div id="loadingmessages1" class="Tips">' +
                    '<table class="EditeContentTable" style="width: 100%">' +
                    '<tr>' +
                    '<td class="Label3">单号 </td>' +
                    ' <td class="Field3"><input type="text" class="TextBox " value="" id="leftOrderNO" /></td>' +
                    '<td class="Label3">客户订单号</td>' +
                    '<td class="Field3"><input type="text" class="TextBox " value="" id="leftCustomerOrder" /></td>' +
                    '</tr>' +
                    '<tr>' +
                    '<td class="Label3" colspan="6" align="center" style="text-align:center">' +
                    '<span style="margin-right:15px;"> <input type="checkbox" id="leftchkEqul"/>全字匹配</span>' +
                    '<input type="submit" id="leftsearch" value="查询" onclick="LeftSearch()" class="SearchButton">' +
                    '<input type="button" id="leftclear" value="清空" onclick="LeftClearSearch()" class="SearchButton" title="清空查询条件">' +
                    '</td>' +
                    '</tr>' +
                    '</table>' +
                    '</div>' +
                    '<div id="LeftList"></div>' +
                    '</td>' +
                    '<td class="Field" style="width: 10%; text-align: center; vertical-align: middle;">' +
                    '<input type="button" id="btnLeftChoose" runat="server" value="" class="rightButton" onclick="btnChooseOnClick(0);" />' +
                    '<br /><br /><br /><br />' +
                    '<input type="button" id="btnRightChoose" runat="server" value="" class="leftButton" onclick="btnChooseOnClick(1);" />' +
                    '</td>' +
                    ' <td align="center" style="width: 45%; vertical-align: top;">' +
                    '<div id="loadingmessages2" class="Tips">' +
                    '<table class="EditeContentTable" style="width: 100%">' +
                    '<tr>' +
                    '<td class="Label3">单号</td>' +
                    '<td class="Field3"><input type="text" class="TextBox " value="" id="rightOrderNO" /> </td>' +
                    '<td class="Label3">客户订单号</td>' +
                    '<td class="Field3"><input type="text" class="TextBox " value="" id="rightCustomerOrder" /></td>' +
                    '</tr>' +
                    '<tr>' +
                    '<td class="Label3" colspan="6" align="center" style="text-align:center">' +
                    '<span style="margin-right:15px;"><input type="checkbox" id="rightchkEqul"/>全字匹配</span>' +
                    '<input type="submit" id="rightsearch" value="查询" onclick="RightSearch()" class="SearchButton">' +
                    '<input type="button" id="rightclear" value="清空" onclick="RightClearSearch()"  class="SearchButton" title="清空查询条件">' +
                    '</td>' +
                    '</tr>' +
                    ' </table>' +
                    '</div>' +
                    '<div id="RightList"></div>' +
                    '</td>' +
                    '</tr></table></div>'
                var strHtml = " " +
                   "var AuthonHtml = '" + phtml + "';";
                var strFunHtml = 'var RowIDs = "";' +
                    'function LeftShow(leftCon) {' +
                    'if (leftCon == null) {' +
                    'leftCon = " AND ProdOrderID=\'" + $("#hdnKeyValue").val() + "\'";' +
                    '}' +
                    '$("#LeftList").replaceWith("<div id=LeftList ></div>");' +
                    'var leftGrid = $("#LeftList").SktMesGrid({' +
                    'columns: [{' +
                    '"display": "单号",' +
                    '"name": "OrderNO",' +
                    '"align": "left",' +
                    '"width": 180,' +
                    '"minWidth": 60' +
                    ' },' +
                    '{' +
                    '"display": "客户订单号",' +
                    '"name": "CustomerOrder",' +
                    '"align": "left",' +
                    '"width": 180,' +
                    '"minWidth": 60' +
                    '}],' +
                    'width: "100%",' +
                    'height: "98%",' +
                    'dataAction: "TABLE",' +
                    'dataSource: "SKTCustom_ProOrderListTemplateLeft",' +
                    'conditions: leftCon == null ? null : leftCon,' +
                    'checkbox:true,' +
                    'multiselect: true,' +
                    'onSelectRow: function (rowid, status) { },' +
                     'onCheckRow: function (isCheck, rowid, status) {' +
                    'var arr = leftGrid.getCheckedRows();' +
                    'RowIDs = "";' +
                    'for (var i = 0; i < arr.length; i++) {' +
                    'if (i == arr.length - 1) {' +
                    'RowIDs +=  arr[i].ID ;' +
                    '} else {' +
                    'RowIDs += arr[i].ID + ",";' +
                    ' }' +
                    ' }},' +
                    'onCheckAllRow: function (isCheck, obj) {' +
                    'var arr = leftGrid.getCheckedRows();' +
                    'RowIDs = "";' +
                    'for (var i = 0; i < arr.length; i++) {' +
                   'if (i == arr.length - 1) {' +
                    'RowIDs +=  arr[i].ID ;' +
                    '} else {' +
                    'RowIDs += arr[i].ID + ",";' +
                    ' }' +
                    ' }},' +
                    'sortName: "OrderNO",' +
                    'selectFields: "ID,OrderNO,CustomerOrder"' +
                    ' });' +
                    '}' +
                    ' function RightShow(rightCon) {' +
                    'if (rightCon == null) {' +
                    'rightCon = " AND ProdOrderID=\'" + $("#hdnKeyValue").val() + "\'";' +
                    '}' +
                    '$("#RightList").replaceWith("<div id=RightList ></div>");' +
                    ' var rightGrid = $("#RightList").SktMesGrid({' +
                    'columns: [{' +
                    '"display": "单号",' +
                    '"name": "OrderNO",' +
                    '"align": "left",' +
                    '"width": 180,' +
                    '"minWidth": 60' +
                    '},' +
                    '{' +
                    ' "display": "客户订单号",' +
                    '"name": "CustomerOrder",' +
                    '"align": "left",' +
                    '"width": 180,' +
                    '"minWidth": 60' +
                    '}],' +
                    'width: "100%",' +
                    'height: "98%",' +
                    'dataAction: "TABLE",' +
                    'dataSource: "SKTCustom_ProOrderListTemplateRight",' +
                    'conditions: rightCon == null ? null : rightCon,' +
                    'checkbox:true,' +
                    'multiselect: true,' +
                    'onSelectRow: function (rowid, status) {},' +
                    'onCheckRow: function (isCheck, rowid, status) {' +
                    'var arr = rightGrid.getCheckedRows();' +
                    'RowIDs = "";' +
                    'for (var i = 0; i < arr.length; i++) {' +
                    'if (i == arr.length - 1) {' +
                    'RowIDs += arr[i].ID;' +
                    '} else {' +
                    'RowIDs += arr[i].ID + ",";' +
                    ' }' +
                    ' }},' +
                    'onCheckAllRow: function (isCheck, obj) {' +
                    'var arr = rightGrid.getCheckedRows();' +
                    'RowIDs = "";' +
                    'for (var i = 0; i < arr.length; i++) {' +
                    'if (i == arr.length - 1) {' +
                    'RowIDs += arr[i].ID ;' +
                    '} else {' +
                    'RowIDs += arr[i].ID + ",";' +
                    ' }' +
                    ' }},' +
                    'sortName: "OrderNO",' +
                    'selectFields: "ID,OrderNO,CustomerOrder"' +
                    ' });' +
                    ' }' +
                    ' $(function () {' +
                    '$("div[title=\'帮助\']").before(\'<div class="toolbar-btn" onclick="OpenAuth()" title="分配"><div class="icon-16-printer"></div><div class="btn-text">分配</div></div><div class="btn-line"></div>\');' +
                    '});' +
                    'function LeftSearch() {' +
                    'var conds = " AND ProdOrderID=\'" + $("#hdnKeyValue").val() + "\'";' +
                    'var conds2 = " AND ProdOrderID=\'" + $("#hdnKeyValue").val() + "\'";' +
                    'var leftOrderNO = $("#leftOrderNO").val();' +
                    'var leftCustomerOrder = $("#leftCustomerOrder").val();' +
                    'if (leftOrderNO !== "") {' +
                    'conds2 += " AND OrderNO= N\'" + $.trim($("#leftOrderNO").val()) + "\'";' +
                    'conds += " AND OrderNO LIKE N\'%" + $.trim($("#leftOrderNO").val()) + "%\'";' +
                    '}' +
                    ' if (leftCustomerOrder !== "") {' +
                    'conds2 += " AND CustomerOrder= N\'" + $.trim($("#leftCustomerOrder").val()) + "\'";' +
                    'conds += " AND CustomerOrder LIKE N\'%" + $.trim($("#leftCustomerOrder").val()) + "%\'";' +
                    '}' +
                    'if ($("#leftchkEqul").is(":checked")) {' +
                    'conds = conds2;' +
                    '}' +
                    ' LeftShow(conds);' +
                    '}' +
                    'function RightSearch() {' +
                    'var conds = " AND ProdOrderID=\'" + $("#hdnKeyValue").val() + "\'";' +
                    'var conds2 = " AND ProdOrderID=\'" + $("#hdnKeyValue").val() + "\'";' +
                    'var rightOrderNO = $("#rightOrderNO").val();' +
                    'var rightCustomerOrder = $("#rightCustomerOrder").val();' +
                    'if (rightOrderNO !== "") {' +
                    'conds2 += " AND OrderNO= N\'" + $.trim($("#rightOrderNO").val()) + "\'";' +
                    'conds += " AND OrderNO LIKE N\'%" + $.trim($("#rightOrderNO").val()) + "%\'";' +
                    ' }' +
                    'if (rightCustomerOrder !== "") {' +
                    'conds2 += " AND CustomerOrder= N\'" + $.trim($("#rightCustomerOrder").val()) + "\'";' +
                    'conds += " AND CustomerOrder LIKE N\'%" + $.trim($("#rightCustomerOrder").val()) + "%\'";' +
                    ' }' +
                    'if ($("#rightchkEqul").is(":checked")) {' +
                    'conds = conds2;' +
                    ' }' +
                    'RightShow(conds);' +
                    '}' +
                    'function LeftClearSearch() {' +
                    '$("#leftOrderNO").val("");' +
                    '$("#leftCustomerOrder").val("");' +
                    '}' +
                    'function RightClearSearch() {' +
                    '$("#rightOrderNO").val("");' +
                    '$("#rightCustomerOrder").val("");' +
                    ' }' +
                    'function OpenAuth(){ if($("#hdnKeyValue").val()==""){alert("请选择记录！");return false;}layer.open({ ' +
                    'type: 1,' +
                    'area:["800px", "450px"],' +
                    'title: "授权信息",' +
                    'shade: 0.6,' +
                    'moveType: 0,' +
                    'shift: 0,' +
                    'closeBtn: 2,' +
                    'content:AuthonHtml,' +
                    'resize:true,' +
                    //'btn: ["保存", "取消"],' +
                    //'btn1: function (index, layero) {SaveEditInfo();},' +
                    //'btn2: function (index, layero) {},' +
                    'success: function () { LeftShow(null);RightShow(null);$("#username").html(RowObj.OrderNO);$("#username").html(RowObj.OrderNO);$("#gonghao").html(RowObj.CustomerOrder);}})' +
                     '}' +
                     'function btnChooseOnClick(index) {' +
                     'if (index == 0) {' +
                     'var entity = {};' +
                     'entity.RowIDS = RowIDs;' +
                     'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSKTCustomProOrderListTemplateLeftToRight", JSON.stringify(entity), "1");' +
                     'if (ajax.error != null) {' +
                     'alert(ajax.error.Message);' +
                     'return false;' +
                     ' }' +
                      'LeftShow(null);RightShow(null);' +
                     '} else {' +
                     'var entity = {};' +
                     'entity.RowIDS = RowIDs;' +
                     'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSKTCustomProOrderListTemplateRightToLeft", JSON.stringify(entity), "1");' +
                     'if (ajax.error != null) {' +
                     'alert(ajax.error.Message);' +
                     'return false;' +
                     ' }' +
                     'LeftShow(null);RightShow(null);' +
                     ' }' +
                     '}';
                var fhtml = strHtml + strFunHtml;
                var js_source = fhtml.replace(/^\s+/, '');
                var tabsize = 1;
                var tabchar = ' ';
                if (tabsize == 1) {
                    tabchar = '\t';
                }
                var scriptfinalHtml = '';
                if (js_source && js_source.charAt(0) === '<') {
                    scriptfinalHtml = style_html(js_source, tabsize, tabchar, 80);
                } else {
                    scriptfinalHtml = js_beautify(js_source, tabsize, tabchar);
                }
                var preStr = contentData.substring(0, LastIndexScriptTag);
                var nextStr = contentData.substring(LastIndexScriptTag);
                var summaryStr = encodeURI(preStr) + encodeURI(scriptfinalHtml) + encodeURI(nextStr);
                iframes.contentWindow.setData(summaryStr);
            }
        }
        function AddPrintTemplate(checkbox) {
            PageSub = false;
            if (checkbox.checked == true) {
                if (!confirm("是否确认添加打印控件?")) {
                    $(checkbox).prop('checked', false);
                    return false;
                }
                var iframes = document.getElementById("ifCtrl");
                var contentData = decodeURI(iframes.contentWindow.getData());
                var LastIndexScriptTag = contentData.lastIndexOf("</script");

                var strScript = '$(function () {' +
               '$("div[title=\'帮助\']").before(\'<div class="toolbar-btn" onclick="Print()" title="打印"><div class="icon-16-printer"></div><div class="btn-text">打印</div></div><div class="btn-line"></div>\');' +
              '});' +
               'function Print() {' +
               'var stationId="2667";' +
               'var scanSN=$("#hdnSN").val();' +
               'AutoPrint(stationId, scanSN);';
                strScript += '}';

                var js_source = strScript.replace(/^\s+/, '');
                var tabsize = 1;
                var tabchar = ' ';
                if (tabsize == 1) {
                    tabchar = '\t';
                }
                var scriptfinalHtml = '';
                if (js_source && js_source.charAt(0) === '<') {
                    scriptfinalHtml = style_html(js_source, tabsize, tabchar, 80);
                } else {
                    scriptfinalHtml = js_beautify(js_source, tabsize, tabchar);
                }
                var preStr = contentData.substring(0, LastIndexScriptTag);
                var nextStr = contentData.substring(LastIndexScriptTag);
                var summaryStr = encodeURI(preStr) + encodeURI(scriptfinalHtml) + encodeURI(nextStr);
                iframes.contentWindow.setData(summaryStr);
            }
        }
        function AddControlTemplate(checkbox) {
            PageSub = false;
            if (checkbox.checked == true) {
                if (!confirm("是否确认添加控件?")) {
                    $(checkbox).prop('checked', false);
                    return false;
                }
                var iframes = document.getElementById("ifCtrl");
                var contentData = decodeURI(iframes.contentWindow.getData());
                var LastIndexScriptTag = contentData.lastIndexOf("</script");
                var strScript = '$(function () {' +
                 '$("div[title=\'帮助\']").before(\'<div class="toolbar-btn" onclick="AudiInspection()" title="审核"><div class="icon-16-savefield"></div><div class="btn-text">审核</div></div><div class="btn-line"></div>\');' +
                '});' +
                'function AudiInspection() {' +
                'if ($("#hdnKeyValue").val() == "") {' +
                'alert("请选择要审核的信息！");' +
                'return false;' +
                '}' +
                'var entity = {};' +
                'entity.KEYID = $("#hdnKeyValue").val();' +
                 'entity.UserId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";' +
                'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSKTCustomProOrderListTemplateAudi", JSON.stringify(entity),"1");' +
                'if (ajax.error != null) {' +
                'alert(ajax.error.Message);' +
                'return false;' +
                '}' +
                'alert("审核成功");' +
                'layer.closeAll();' +
                '$("#bnView").trigger("click");';
                strScript += '}';

                var js_source = strScript.replace(/^\s+/, '');
                var tabsize = 1;
                var tabchar = ' ';
                if (tabsize == 1) {
                    tabchar = '\t';
                }
                var scriptfinalHtml = '';
                if (js_source && js_source.charAt(0) === '<') {
                    scriptfinalHtml = style_html(js_source, tabsize, tabchar, 80);
                } else {
                    scriptfinalHtml = js_beautify(js_source, tabsize, tabchar);
                }
                var preStr = contentData.substring(0, LastIndexScriptTag);
                var nextStr = contentData.substring(LastIndexScriptTag);
                var summaryStr = encodeURI(preStr) + encodeURI(scriptfinalHtml) + encodeURI(nextStr);
                iframes.contentWindow.setData(summaryStr);
            }
        }
        
         var getData = function () {
             var arrList =[{"colName":"ProdOrderID","colText":"主键","colShow":"0","colKey":"1","colSelect":"0","colEdit":"0","colChoose":"0","colWidth":180,"colCssClass":""},{"colName":"OrderNO","colText":"单号","colShow":"1","colKey":"0","colSelect":"1","colEdit":"1","colChoose":"1","colWidth":180,"colCssClass":""},{"colName":"ItemId","colText":"产品ID","colShow":"1","colKey":"0","colSelect":"0","colEdit":"0","colChoose":"0","colWidth":180,"colCssClass":""},{"colName":"OrderType","colText":"类型","colShow":"1","colKey":"0","colSelect":"0","colEdit":"0","colChoose":"0","colWidth":180,"colCssClass":""},{"colName":"Status","colText":"状态","colShow":"1","colKey":"0","colSelect":"0","colEdit":"0","colChoose":"0","colWidth":180,"colCssClass":""},{"colName":"CustomerOrder","colText":"客户订单号","colShow":"1","colKey":"0","colSelect":"1","colEdit":"1","colChoose":"1","colWidth":180,"colCssClass":""}];
             var sorting = "ProdOrderID,OrderNO,ItemId,OrderType,Status,CustomerOrder"; dataSource = "SKTCustom_ProOrderListTemplate"; TableName = "SKTCustom_ProOrderListTemplate";
             return [JSON.stringify(arrList), sorting, dataSource, TableName];
         }
        //外部链接
         function OuterLinkTemplate(checkbox) {
             PageSub = false;
             if (checkbox.checked == true) {
                 if (!confirm("此操作会覆盖之前代码设计内容,是否确认添加List模版?")) {
                     $(checkbox).prop('checked', false);
                     return false;
                 } else {
                     $(".template").prop('checked', false);
                     $(checkbox).prop('checked', true);
                 }
             }
             $("#<%=this.hdnPType.ClientID %>").val("0");
             var strHtml = '<iframe style="width:100%;height:100%;" src="https://www.baidu.com"></iframe>' +
                    '<script type="text/javascript">' +
                    '$(function () {' +
                    '$("#toolbar").hide();' +
                    '$("#form1").attr("style","width:100%;height:100%");' +
                    '});' +
                    '<\/script>';
                   
             var js_source = strHtml.replace(/^\s+/, '');
             var tabsize = 1;
             var tabchar = ' ';
             var finalHtml = '';
             if (tabsize == 1) {
                 tabchar = '\t';
             }
             if (js_source && js_source.charAt(0) === '<') {
                 finalHtml = style_html(js_source, tabsize, tabchar, 80);
             } else {
                 finalHtml = js_beautify(js_source, tabsize, tabchar);
             }

             var iframes = document.getElementById("ifCtrl");
             iframes.contentWindow.setData(encodeURI(finalHtml));
             //自动调用保存功能  保障预览功能正常
             Save(1);
         }

         function ListTemplate1(checkbox) {
             PageSub = false;
             if (checkbox.checked == true) {
                 if (!confirm("此操作会覆盖之前代码设计内容,是否确认添加List模版?")) {
                     $(checkbox).prop('checked', false);
                     return false;
                 } else {
                     $(".template").prop('checked', false);
                     $(checkbox).prop('checked', true);
                 }
                 $("#<%=this.hdnPType.ClientID %>").val("0");
                var title = $("#<%=this.txtPageCName.ClientID %>").val();//表头信息
                var data = getData(); //getEdit();//数据
                var entity = $.parseJSON(data[0]);                      //格式化数据
                var cols = [];
                var rptTable = 'SKTCustom_ProOrderListTemplate'; //数据源（视图名称或者表名）
                var TableName = 'SKTCustom_ProOrderListTemplate'; //数据源（视图名称或者表名）
                var sorting = data[1];                                  //排序字段
                var strCode = '<table class="EditeContentTable" style="width: 100%"><tr>';            //HTML
                var strJS_Con = '';
                var strJS_Bind = '';
                var strJS_Excel = '';
                var strScript = '<script type="text/javascript">';         // JavaScript
                strScript += 'var RowObj={};';
                strScript += '$("#bnView").click(function () {' + '$("#hdnKeyValue").val(""); var conds = ""; var conds2 = ""; ';
                var selecteFields = ""; 
                var strClass = "";
                var strFunction = '';//function Add(){}function Edit(){}function Delete(){}
                var strEditHtml = '<div><table class="EditeContentTable" id="tbEditInfo" width="100%">'

                var FormsHtml = '';
                var strKey = "";

                for (var i = 0; i < entity.length; i++) {
                    //构造查询选项HTML，获取选项值JS
                    if (entity[i].colSelect * 1 === 1) {

                        //strEditHtml += '<tr>'
                        //strEditHtml += '<td class="Label2">' + entity[i].colText + '</td>';
                        //strEditHtml += '<td class="Field' + strClass + '">';
                        //strEditHtml += '{0}</td>'; //编辑输入框
                        //strEditHtml += '</tr>'

                        //查询条件框的样式
                        if (entity.length >= 3) {
                            strClass = "3"
                        } else {
                            strClass = entity.length
                        }
                        //每一行只放3个查询条件框
                        if (i % 3 == 0) {
                            if (i == 0) {
                                strCode += '<tr>';
                            } else {
                                strCode += '</tr><tr>';
                            }
                        }
                        strCode += '<td class="Label' + strClass + '">' + entity[i].colText + '</td>';
                        strCode += '<td class="Field' + strClass + '">';
                        strCode += '{0}</td>'; //查询条件输入框
                    
                        //-----------------------------
                        strJS_Bind += 'var ' + entity[i].colName + ' = $("#' + entity[i].colName + '").val();';

                        //----------------------------- var orderid =$("#orderid").val()
                        //2018-1-6 hufang 简易报表字段名如果是时间类型，则查询具体某一区间的数据
                        var typeStr = "";
                        if (entity[i].dataType == "时间类型") {
                            typeStr = '<input type="text" id="start' + entity[i].colName + '" style="width: 100px" class="DateTimeBox" /> --- <input type="text" id="end' + entity[i].colName + '" style="width: 100px" class="DateTimeBox" />';
                            strCode=strCode.replace('{0}', typeStr);
                            strJS_Con += ' if(start' + entity[i].colName + ' !="")' + '{ conds +=" AND ' + entity[i].colName + '>= $("#start' + entity[i].colName + '").val(); }';
                            strJS_Con += ' if(end' + entity[i].colName + ' !="")' + '{ conds +=" AND ' + entity[i].colName + '<= $("#end' + entity[i].colName + '").val();}';
                                          
                        } else {
                            typeStr = '<input type="text" class="TextBox ' + entity[i].colCssClass + '" value="" id="' + entity[i].colName + '" />  ';
                            strCode=strCode.replace('{0}', typeStr);
                            strJS_Con += ' if(' + entity[i].colName + ' !=="")' +'{ conds2 +=" AND ' + entity[i].colName + '= N\'" + $.trim($("#' + entity[i].colName + '").val()) +"\'";' +' conds +=" AND ' + entity[i].colName + ' LIKE N\'%" + $.trim($("#' + entity[i].colName + '").val()) +"%\'";}';
                        }
                        //strEditHtml = strEditHtml.replace('{0}', typeStr);
                  

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
                    //获取主键的字段
                    if (entity[i].colKey * 1 === 1) {
                        strKey = entity[i].colName;
                    }
                    //获取编辑项
                    if (entity[i].colEdit * 1 === 1) {

                        strEditHtml += '<tr>'
                        strEditHtml += '<td class="Label2">' + entity[i].colText + '</td>';
                        strEditHtml += '<td class="Field' + strClass + '">';
                        strEditHtml += '{0}</td>'; //编辑输入框
                        strEditHtml += '</tr>'
                        var InputClass = "TextBox"
                        if (entity[i].colCssClass != "") {
                            InputClass = entity[i].colCssClass;
                        }
                        var EditStr = '<input type="text" class="' + InputClass + '" value="" id="' + entity[i].colName + '" />  ';
                        strEditHtml = strEditHtml.replace('{0}', EditStr);
                    }
                }
                strEditHtml += "</table></div>"
            
                strCode += '</tr>';
                strCode += '<tr><td class="Label' + strClass + '" colspan="' + strClass * 2 + '" align="center" style="text-align:center">' +
                   '<span style="margin-right:15px;"><input type="checkbox" id="chkEqul" name="chkEqul"/>全字匹配</span>' +
                    '<span id="bnView" style="font-size: 12px; font-weight:bold; cursor: pointer; ">' +
                    '<img src="../Content/images/search.png" class="imgText" style="margin-right:5px;"\/><span class="imgText">查询</span></span> ' +
                    '<span id="bnImport" style="font-size: 12px; font-weight:bold; margin-left:10px;cursor: pointer;" title="导出报表到Excel"><img src="../Content/images/icon/Import.png" class="imgText" style="margin-right:5px;"/><span class="imgText">导出</span></span>' +
                    '</tr></table>' +
                    '<input type="hidden" value="' + TableName + '" id="hdnTableName" name="hdnTableName" />' +
                    '<input type="hidden" value="' + strKey + '" id="hdnKey" name="hdnKey" />' +
                    '<input type="hidden" value="" id="hdnKeyValue" name="hdnKeyValue" />' +
                    '<input type="hidden" value="" id="hdnPararmValue" name="hdnPararmValue" />' +
                    '<input type="hidden" value="TABLE" id="hdnOperation" name="hdnOperation" />' +
                    '<input type="hidden" value="" id="hdnFileName" name="hdnFileName" />' +
                    '<input type="hidden" value="" id="hdnSN" name="hdnSN" />' +
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

                    ',multiselect:true' +
                    ',onSelectRow:function(rowid,status){' +
                    '$("#hdnKeyValue").val(rowid[$("#hdnKey").val()]);' +
                    '$("#hdnSN").val(rowid.CustomerOrder);' +
                    'RowObj=rowid;' +
                    '}' +
                
                    ',sortName: "' + sorting + '"' +
                    ',selectFields:"' + selecteFields.substring(0, selecteFields.length - 1) + '"' +
                    '});';
                strScript += "});";
                //---------------------

                //定义弹出窗口
                //新增
                FormsHtml += 'function Add(){ layer.open({ ' +
                    'type: 1,' +
                    'area: ["600px", "400px"],' +
                    'title: "新增' + title + '信息",' +
                    'shade: 0.6,' +
                    'moveType: 0,' +
                    'shift: 0,' +
                    'closeBtn: 2,' +
                    'content:PageHtml,' +
                    'btn: ["保存", "取消"],' +
                    'btn1: function (index, layero) {SaveAddInfo();},' +
                    'btn2: function (index, layero) {},' +
                    'success: function () { }';
                FormsHtml += '});}';
                //修改
                FormsHtml += 'function Edit(){ if($("#hdnKeyValue").val()==""){alert("请选择要编辑的信息！");return false;}layer.open({ ' +
                    'type: 1,' +
                    'area: ["600px", "400px"],' +
                    'title: "编辑' + title + '信息",' +
                    'shade: 0.6,' +
                    'moveType: 0,' +
                    'shift: 0,' +
                    'closeBtn: 2,' +
                    'content:PageHtml,' +
                    'btn: ["保存", "取消"],' +
                    'btn1: function (index, layero) {SaveEditInfo();},' +
                    'btn2: function (index, layero) {},' +
                    'success: function () { }';
                FormsHtml += '}); GetInfo();}';
                //删除
                FormsHtml += 'function Delete(){ if($("#hdnKeyValue").val()==""){alert("请选择要删除的信息！");return false;} if(confirm("此操作不可逆，确定删除？")){' +
                    'var operateType=$("#hdnOperation").val();' +
                    'if(operateType=="TABLE"){' +
                    'var strDeSql="delete "+$("#hdnTableName").val()+" ";' +
                    'strDeSql=strDeSql+" where "+$("#hdnKey").val()+"=' + "'\"" + ' + $("#hdnKeyValue").val() +' + "\"'\";"+
                    'var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecuteSql(strDeSql); ' +
                    'if (ajax.error != null) { alert(ajax.error.Message);return false; }' +
                    '}else{'+
                    'var entity = {};'+
                    'entity.ProdOrderID=$("#hdnKeyValue").val();' +
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSKTCustomProOrderListTemplateDel", JSON.stringify(entity),"1");' +
                    'if (ajax.error != null) {'+
                    'alert(ajax.error.Message);'+
                    'return false;'+
                    '}'+
                    '}'+
                    'alert("删除成功！");$("#bnView").trigger("click");'
                FormsHtml += '}}';

                var InputHtml = "";
                //修改方法
                FormsHtml += 'function SaveEditInfo(){' +
                   'var operateType=$("#hdnOperation").val();' +
                   'if(operateType=="TABLE"){' +
                   'var strEditSql="update "+$("#hdnTableName").val()+" SET ";' +
                   'var strFieldEdit="";' +
                   '$("#tbEditInfo input").each(function () {' +
                   ' strFieldEdit+=$(this).attr("id")+"=' + "'\"" + ' + $(this).val() +' + "\"',\";"+
                   '});' +
                   'strFieldEdit=strFieldEdit.substring(0, strFieldEdit.length - 1);' +
                   'strEditSql=strEditSql+strFieldEdit+" where "+$("#hdnKey").val()+"=' + "'\"" + ' + $("#hdnKeyValue").val() +' + "\"'\";" +
                   'var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecuteSql(strEditSql); ' +
                   'if (ajax.error != null) { alert(ajax.error.Message);return false; }' +
                    '}else{'+
                    'var entity = {};' +
                    'entity.ProdOrderID=$("#hdnKeyValue").val();' +
                    'entity.OrderNO=$.trim($("table#tbEditInfo").find("input[id=\'OrderNO\']").val());' +
                    'entity.CustomerOrder=$.trim($("table#tbEditInfo").find("input[id=\'CustomerOrder\']").val());' +
                    'entity.ItemId=null;' +
                    'entity.OrderType=null;' +
                    'entity.Status=null;' +
                    'entity.UserId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";'+
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSKTCustomProOrderListTemplateEdit", JSON.stringify(entity),"1");' +
                    'if (ajax.error != null) {'+
                    'alert(ajax.error.Message);'+
                    'return false;'+
                    '}'+
                    '}'+
                   'alert("保存成功！");layer.closeAll();$("#bnView").trigger("click");' +
                   '} '
                //新增方法
                FormsHtml += 'function SaveAddInfo(){' +
                    'var operateType=$("#hdnOperation").val();' +
                    'if(operateType=="TABLE"){' +
                    'var strSql="insert into "+$("#hdnTableName").val()+"(";' +
                    'var strField="";' +
                    'var strValue="";' +
                    '$("#tbEditInfo input").each(function () {' +
                    ' strField+=$(this).attr("id")+",";' +
                    ' strValue+= ' + "\"'\"" + ' + $(this).val() +' + "\"',\";" +
                    '});' +
                    'strField=strField.substring(0, strField.length - 1);' +
                    'strValue=strValue.substring(0, strValue.length - 1);' +
                    'strSql=strSql+strField+") values("+strValue+")";' +
                    'var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecuteSql(strSql); ' +
                    'if (ajax.error != null) { alert(ajax.error.Message);return false; }' +
                    '}else{'+
                    'var entity = {};'+
                    'entity.OrderNO=$.trim($("table#tbEditInfo").find("input[id=\'OrderNO\']").val());' +
                    'entity.CustomerOrder=$.trim($("table#tbEditInfo").find("input[id=\'CustomerOrder\']").val());' +
                    'entity.ItemId=null;' +
                    'entity.OrderType=null;' +
                    'entity.Status=null;' +
                    'entity.UserId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";'+
                    'var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("upsSKTCustomProOrderListTemplateAdd", JSON.stringify(entity),"1");' +
                    'if (ajax.error != null) {'+
                    'alert(ajax.error.Message);'+
                    'return false;'+
                    '}'+
                    '}'+
                    'alert("保存成功！");layer.closeAll();$("#bnView").trigger("click");' +
                   '}'

                //获取信息
                FormsHtml += 'function GetInfo(){ ' +
                     'var strSelSql="select * from "+$("#hdnTableName").val()+" ";' +
                     'strSelSql=strSelSql+" where "+$("#hdnKey").val()+"=' + "'\"" + ' + $("#hdnKeyValue").val() +' + "\"'\";" +
                     'var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecuteSqlSearch(strSelSql); ' +
                     'if (ajax.error != null) { alert(ajax.error.Message);return false; }' +
                     'var rowInfo = $.parseJSON(ajax.value);' +
                     '$("#tbEditInfo input").each(function () {' +
                     '$(this).val(rowInfo[0][$(this).attr("id")])' +
                     '});' 
                FormsHtml += '}';
                //---------------------导出EXCEL 
                strJS_Excel += '$("#bnImport").click(function () { var conds ="";var conds2 ="";';
                strJS_Excel += strJS_Bind;
                strJS_Excel += strJS_Con;                                             //控件值获取
                strJS_Excel += '$("#hdnPararms").val("' + rptTable + '");';                   //DbTable
                strJS_Excel += '$("#hdnOperation").val("TABLE");';
                strJS_Excel += '$("#hdnPararmValue").val(conds);';
                strJS_Excel += '$("#hdnFileName").val("' + title + '");';

                strJS_Excel += 'document.forms[0].submit();' + '});';
                strScript += strJS_Excel;
                //---------------------
                strFunction = "var PageHtml = '" + strEditHtml + "';";
                strScript += strFunction + FormsHtml;
            
                strScript += "<\/script>";
                var finalHtml = strCode + strScript;

                js_source = finalHtml.replace(/^\s+/, '');
                tabsize = 1;
                tabchar = ' ';
                if (tabsize == 1) {
                    tabchar = '\t';
                }
                if (js_source && js_source.charAt(0) === '<') {
                    finalHtml = style_html(js_source, tabsize, tabchar, 80);
                } else {
                    finalHtml = js_beautify(js_source, tabsize, tabchar);
                }

                var iframes = document.getElementById("ifCtrl");
                iframes.contentWindow.setData(encodeURI(finalHtml));
                 //自动调用保存功能  保障预览功能正常
                Save(1);
            }
         }
        function ListTemplate(index) {
            switch (index) {
                case 1:
                    $("#listt").show();
                    $("#controlt").hide();
                    break;
                case 2:
                    $("#listt").hide();
                    $("#controlt").show();
                    break;
                default:
                    break;
            }
            $("#templateList").show();
        }
        function HideTemplateList() {
            $("#templateList").hide();
        }
    </script>
</asp:Content>
