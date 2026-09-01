<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="ActivitiesEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Activities.ActivitiesEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current" id="actBaseInfo">基本信息</li>
            <li id="actCode">业务代码</li>
            <li>绑定工序类型</li>
        </ul>
        <!--基本信息-->
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %></div>
            <div class="clear0">
            </div>
            <table class="EditeContentTable" width="100%">
                <tr id="tr1">
                    <td class="Label1">
                        <%=Resources.lang.AC_Name%>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtAC_Name" runat="server" CssClass="TextBox" ClientIDMode="Static"
                            IsRequired='1'></asp:TextBox><em>*</em>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        <%=Resources.lang.Description%>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" TextMode="MultiLine"
                            Width="350px" Height="120px" ClientIDMode="Static"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <!--业务代码-->
        <div>
            <div class="wrap_vtb">
                <ul class="vtb">
                    <li id="actCodeDetail" class="current">代码</li>
                    <li id="actFuncParms" onclick="getMainFunParams()">主函数参数</li>
                </ul>
                <div class="vtb_c" id="vtb_c1" style="overflow: auto;">
                    <div class="infoTips">
                        <%=Resources.Messages.WithAsteriskIsRequired %></div>
                    <div class="clear0">
                    </div>
                    <table class="EditeContentTable" width="100%">
                        <tr id="tr2">
                            <td class="Label1">
                                <%=Resources.lang.AC_FunctionName %>
                            </td>
                            <td class="Field1">
                                <asp:TextBox ID="txtFunctionName" Text="Main_XXX" runat="server" CssClass="TextBox"
                                    ClientIDMode="Static" Width="180px"></asp:TextBox><em>*</em><span class="Tips">不同业务之间不允许有相同的主函数名，主函数名在系统中是唯一的。</span>
                            </td>
                        </tr>
                    </table>
                    <div class="clear5">
                    </div>
                    <table class="EditeContentTable" width="100%">
                        <tr>
                            <td class="Label" colspan="4" id="tdlj">
                                <span style="float: left;"><b>&nbsp;&nbsp;Activity函数逻辑代码：<%//=Resources.lang.ActivityFuncCode%></b>
                                    <a href="javascript:void(0);" onclick="fullScreenEditor();">
                                        <img src="../Content/images/icon/Fullscreen.png?v2" style="vertical-align: middle;"
                                            border="0" title="全屏编辑/查看代码" />
                                    </a></span><span style="float: right; color: #cccccc; line-height: 22px;">编辑器版本 1.0.1</span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="" id="tdIframe" valign="top">
                                <div id="tdIframeDiv" style="position: relative; height: 287px; width: 100%">
                                    <div id="loadingmsg" class="loadingmessage">
                                        <img src="../Content/images/gif/loading.gif" style="vertical-align: middle; margin-right: 5px;" /><span
                                            style="line-height: 28px;"><%=Resources.Messages.LoadingData %></span>
                                    </div>
                                    <iframe id="ifCtrl" name="ifCtrl" frameborder="0" width="100%" height="100%" marginheight="0"
                                        marginwidth="0" scrolling="auto" src=""></iframe>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="vtb_c2" style="overflow: auto;">
                    <table class="ListTable" width="100%" id="tabParams">
                        <tr class="ListTableHeader">
                            <th scope="col" style="width: 5%;">
                                <%=Resources.lang.Sequence%>
                            </th>
                            <th scope="col" style="width: 30%;">
                                主函数参数名
                            </th>
                            <th scope="col" style="width: 20%;">
                                <%=Resources.lang.Param_Value%>
                            </th>
                            <th scope="col" style="width: 35%;">
                                参数显示名
                            </th>
                            <th scope="col" onclick="addParams(null);" style="color: #0066CC; cursor: pointer;
                                width: 10%;">
                                <img src="../Content/images/add.gif" title="<%= Resources.Buttons.COM_Add%>" alt=""
                                    style="vertical-align: middle;" /><%= Resources.Buttons.COM_Add%>
                            </th>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <!--绑定工序类型-->
        <div>
            <table class="ListTable" width="100%" cellspacing="0" cellpadding="4" id="tblExpand">
                <tr class="ListTableHeader">
                    <th scope="col" style="width: 25%;">
                        <%=Resources.lang.StationType%>
                    </th>
                    <th scope="col" style="width: 20%;">
                        <%=Resources.lang.Description%>
                    </th>
                    <th scope="col" style="width: 45%;">
                        Activity逻辑执行顺序
                    </th>
                    <th scope="col" onclick="addDetail(null);" style="color: #0066CC; cursor: pointer;
                        width: 65px">
                        <img src="../Content/images/add.gif" title="<%= Resources.Buttons.COM_Add%>" alt=""
                            style="vertical-align: middle;" /><%= Resources.Buttons.COM_Add%>
                    </th>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        var acid = '<%=Request.QueryString["ID"] %>';
        var tab = document.getElementById("tblExpand");
        var tabParam = document.getElementById("tabParams");
        var justEditOpeTypeACMember = '<%=Request.QueryString["flag"] %>';
        var oldFuncName = "";

        $(document).ready(function () {
            setVTabSize();
            $("#loadingmsg").show();
        });

        $(function () {
            if (parseInt(acid) > -1) {
                initParamsList(acid);
                initBindOpeTypeList(acid);
                if (parseInt(justEditOpeTypeACMember) == 1) {
                    setupEditOpeType();
                }
            }
            initFuncCode(acid);
            if (tab.rows.length < 2) {
                addDetail(null);
            }
            autoSyncACname();
            checkParamIsRepeat();
            autoSyncFuncname();
            keepSessionAlive();
            oldFuncName = $("#txtFunctionName").val();

            $(window).resize(function () { setVTabSize(); winResize(); })
        });


        var rowIndex = -1;
        var rowObj = null;

        function selectItems(obj) {
            if (isNull($("#txtAC_Name").val())) {
                alert("<%=Resources.Messages.PlsInputActivityNameFirst %>");
                $("#actBaseInfo").click();
                $("#<%=this.txtAC_Name.ClientID %>").focus();
                return false; ;
            }
            rowObj = obj.parentNode.parentNode;
            rowIndex = rowObj.rowIndex;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=4&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValue(list) {
            if (!checkIsRepeat(list[0][0])) {
                rowObj.cells[0].children[2].value = list[0][0];
                rowObj.cells[0].children[0].value = list[0][1];
                rowObj.cells[1].innerHTML = list[0][2];

                if (parseInt(list[0][0]) != -1) {
                    /*get binded activity list*/
                    updateBindCellActivity(list[0][0], rowObj, false);
                    updateBindSequence(rowObj.cells[2].children[0]);
                }
                else {
                    rowObj.cells[2].innerHTML = "";
                }
            }
        }

        function addDetail(entity) {
            if (entity == null) {
                entity = {};
                entity.OpeTypeId = "-1";
                entity.OpeType = "";
                entity.OpeDescription = "";
            }
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.innerHTML = "<input type=\"text\" name=\"txtOpeType\" class=\"TextBox\" value=\"" + entity.OpeType + "\" disabled=\"disabled\"><input type=\"button\" id=\"btnSelectItems\" onclick=\"selectItems(this);\" class=\"ButtonBox\" value=\"...\" /><input type=\"hidden\" name=\"hdnOpeTypeId\" value=\"" + entity.OpeTypeId + "\" />";

            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = entity.OpeDescription;

            cell = row.insertCell(2);
            cell.align = "center";
            cell.innerHTML = "";

            cell = row.insertCell(3);
            cell.align = "center";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(tab,this)\"><%= Resources.Buttons.COM_Delete %></span>";
        }

        function addParams(entity) {
            if (entity == null) {
                entity = {};
                entity.AOID = -1;
                entity.AC_Param_Sequence = "";
                entity.AC_Param_Name = "";
                entity.AC_Param_Value = "";
                entity.AC_Param_Remark = "";
            }

            var row, cell;
            row = tabParam.insertRow(tabParam.rows.length);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.innerHTML = entity.AC_Param_Sequence;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = "<input type=\"hidden\" name=\"hdnAOID\" value=\"" + entity.AOID + "\"/><input type=\"text\" style=\"width:90%;\" name=\"txtAC_Param_Name\" class=\"TextBox\" value=\"" + entity.AC_Param_Name + "\"  /><em>*</em>"

            cell = row.insertCell(2);
            cell.align = "center";
            cell.innerHTML = "<input type=\"text\" style=\"width:90%;\" name=\"txtAC_Param_Value\" class=\"TextBox\" value=\"" + entity.AC_Param_Value + "\"  />"

            cell = row.insertCell(3);
            cell.align = "center";
            cell.innerHTML = "<input type=\"text\" style=\"width:90%;\" name=\"txtAC_Param_Remark\" class=\"TextBox\" value=\"" + entity.AC_Param_Remark + "\"/><em>*</em>"

            cell = row.insertCell(4);
            cell.align = "center";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(tabParam,this)\"><%= Resources.Buttons.COM_Delete %></span>";

            updateSequence();
        }

        function deleteItem(tabobj, obj) {
            tabobj.deleteRow(obj.parentNode.parentNode.rowIndex);
            if (tabobj.id = "tabParams") {
                updateSequence();
            }
        }

        function Save() {
            if (checkInputIsReady()) {
                /*base info*/
                var entity = {};
                entity.AC_ID = acid;
                entity.AC_Name = $("#txtAC_Name").val();
                entity.AC_Description = $("#txtDescription").val();
                entity.AC_FunctionName = $("#txtFunctionName").val();
                entity.AC_FunctionCode = window.frames["ifCtrl"].getData();
                entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
                entity.ModifyBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

                /*options list*/
                var hdnAOID = document.getElementsByName("hdnAOID");
                var txtAC_Param_Name = document.getElementsByName("txtAC_Param_Name");
                var txtAC_Param_Value = document.getElementsByName("txtAC_Param_Value");
                var txtAC_Param_Remark = document.getElementsByName("txtAC_Param_Remark");
                var aoidString = "", ac_param_nameString = "", ac_param_valueString = "", ac_param_remarkString = "", ac_sequenceString = "", seq = "^";

                for (var i = 0; i < hdnAOID.length; i++) {
                    aoidString += hdnAOID[i].value + seq;
                    ac_param_nameString += txtAC_Param_Name[i].value + seq;
                    ac_param_valueString += txtAC_Param_Value[i].value + seq;
                    ac_param_remarkString += txtAC_Param_Remark[i].value + seq;
                    ac_sequenceString += (i + 1).toString() + seq;
                }

                /*bind operationType*/
                var tabString = "";
                var opeTypeIdString = "", acIdString = "", seqString = "";
                var idSeq = ",", trSeq = "^", tabSeq = "~";
                for (var i = 1; i < tab.rows.length; i++) {
                    if (tab.rows[i].cells[0].children[2].value != "-1") {
                        opeTypeIdString = "", acIdString = "", seqString = "";
                        var syncTab = $("#tab" + i + "")[0];
                        /*build idString*/
                        for (var h = 1; h < syncTab.rows.length; h++) {
                            var syncRow = syncTab.rows[h];
                            opeTypeIdString += syncRow.cells[3].children[1].value + idSeq;
                            acIdString += syncRow.cells[3].children[2].value + idSeq;
                            seqString += syncRow.cells[3].children[3].value + idSeq;
                        }
                        tabString += opeTypeIdString + trSeq + acIdString + trSeq + seqString + trSeq + tabSeq;
                    }
                }
                /*Save Event*/
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxActivity.EditActivity(entity, aoidString, ac_param_nameString, ac_param_valueString, ac_param_remarkString, ac_sequenceString, tabString, parseInt(justEditOpeTypeACMember));
                if (ajax.error == null) {
                    alert("<%=Resources.Messages.SaveInSuccess %>");
                    if (parseInt(justEditOpeTypeACMember) == 0) {
                        window.parent.refreshTab("Activities_ActivitiesList");
                        window.parent.closeTab(window.parent.getCurrentTab()[0]);
                    } else {
                        window.parent.refreshTab("Activities_ActivitiesList");
                    }
                } else {
                    alert(ajax.error.Message);
                }
            }
        }

        function updateSequence() {
            for (var i = 1; i < tabParam.rows.length; i++) {
                tabParam.rows[i].cells[0].innerHTML = i.toString();
            }
        }

        function updateBindSequence(objTab) {
            for (var i = 1; i < objTab.rows.length; i++) {
                objTab.rows[i].cells[1].innerHTML = i.toString();
                objTab.rows[i].cells[3].children[3].value = i.toString();
            }
        }

        function winResize() {
            var tdIframe = $("#tdIframe");
            var iframe = $("#ifCtrl").contents().find(".CodeMirror-scroll");
            var w = 210;
            if (tdIframe.css("height").toString().substr(0, 1) == "2") {
                tdIframe.css("height", ($(window).height() - w) + "px");
                $("#tdIframeDiv").css("height", ($(window).height() - w) + "px");
                iframe.css({ "overflow": "auto", "height": ($(window).height() - w) + "px" });
            } else {
                tdIframe.css("height", ($(window).height() - w) + "px");
                $("#tdIframeDiv").css("height", ($(window).height() - w) + "px");
                iframe.css({ "overflow": "auto", "height": ($(window).height() - w) + "px" });
            }

        }

        function checkInputIsReady() {
            /*check baseinfo required*/
            if (isNull($("#txtAC_Name").val())) {
                alert("业务名称不能为空！");
                $("#actBaseInfo").click();
                $("#<%=this.txtAC_Name.ClientID %>").focus();
                return false;
            }

            if (isNull($("#txtFunctionName").val())) {
                alert("业务的主函数名不能为空！");
                $("#actCode").click();
                $("#actCodeDetail").click();
                $("#<%=this.txtFunctionName.ClientID %>").focus();
                return false;
            }

            /*check tabParams required*/
            for (var i = 1; i < tabParam.rows.length; i++) {
                if (isNull(tabParam.rows[i].cells[1].children[1].value) || isNull(tabParam.rows[i].cells[3].children[0].value)) {
                    alert("<%=Resources.Messages.ParametersListNotEmpty %>");
                    $("#actCode").click();
                    $("#actFuncParms").click();
                    return false;
                }
            }
            /*check Activity code required*/
            var iframesVal = window.frames["ifCtrl"].getData();
            if (isNull(iframesVal)) {
                alert("<%=Resources.Messages.ActivityFunctionCodeNotAllowEmpty %>");
                $("#actCode").click();
                $("#actCodeDetail").click();
                return false;
            }
            /*check whether has defined function*/
            var idxOf = iframesVal.indexOf("function");
            if (idxOf == -1) {
                alert("<%=Resources.Messages.ActivityFunctionCodeMustDefineAfunction %>");
                $("#actCode").click();
                $("#actCodeDetail").click();
                return false;
            }
            var idxOfStart = iframesVal.indexOf("(");
            var idxOfEnd = iframesVal.indexOf(")");
            var str = iframesVal.substring(idxOfStart + 1, idxOfEnd);

            var strAry = str.split(",");
            if (strAry[0] != "") {
                if (strAry.length != tabParam.rows.length - 1) {
                    alert("<%=Resources.Messages.ActivityFunctionParametersNotMapParametersList %>");
                    $("#actCode").click();
                    $("#actFuncParms").click();
                    return false;
                }
            } else if (strAry[0] == "") {
                if (tabParam.rows.length - 1 != 0) {
                    alert("<%=Resources.Messages.ActivityFunctionParametersNotMapParametersList %>");
                    $("#actCode").click();
                    $("#actFuncParms").click();
                    return false;
                }
            }
            /*check function name whether equal base info function name*/
            var fucName = iframesVal.substring(idxOf, idxOfStart);
            fucName = fucName.replace(/function/g, "").replace(/ /g, "");
            if (fucName != $("#txtFunctionName").val()) {
                alert("<%=Resources.Messages.ActivityFunctionNameNotMapBaseInfoFunctionName %>");
                $("#actCode").click();
                $("#actCodeDetail").click();
                $("#<%=this.txtFunctionName.ClientID %>").focus();
                return false;
            }
            return true;
        }

        function checkIsRepeat(id) {
            var result = false;
            var idObj = document.getElementsByName("hdnOpeTypeId");
            for (var i = 0; i < idObj.length; i++) {
                if (idObj[i].value == id) {
                    result = true;
                    break;
                }
            }
            if (result) { alert("<%=Resources.Messages.RecordExists %>"); }

            return result;
        }

        function checkParamIsRepeat() {
            $("[name='txtAC_Param_Name']").live("change", function () {
                for (var i = 1; i < tabParam.rows.length; i++) {
                    if (i != this.parentNode.parentNode.rowIndex) {
                        if ($.trim(this.value) == $.trim(tabParam.rows[i].cells[1].children[1].value)) {
                            alert("<%=Resources.Messages.TheParameterDescriptionExists %>");
                            this.value = "";
                            return;
                        }
                    }
                }
            });
        }

        function autoSyncACname() {
            $("#txtAC_Name").bind("change", function () {
                $("[flag='acids']").each(function () {
                    if ($(this).val() == acid) {
                        var rowObjs = ($(this).parent().parent())[0];
                        rowObjs.cells[0].innerText = $("#txtAC_Name").val();
                    }
                });
            });
        }

        function autoSyncFuncname() {
            $("#txtFunctionName").change(function () {
                var iframes = window.frames["ifCtrl"];
                var iframesVal = iframes.getData();
                var idxOf = iframesVal.indexOf("function");
                var idxOfStart = iframesVal.indexOf("(");
                var fucName = iframesVal.substring(idxOf, idxOfStart);

                iframesVal = iframesVal.replace(new RegExp(oldFuncName, "g"), this.value);
                iframes.setData(iframesVal);
                oldFuncName = $("#txtFunctionName").val();
            });
        }

        function initParamsList(acids) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxActivity.GetActionByACID(acids);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var entityAry = ajax.value;
            var entity = {};
            for (var i = 0; i < entityAry.length; i++) {
                entity.AOID = entityAry[i].AOID;
                entity.AC_Param_Sequence = entityAry[i].AC_Param_Sequence;
                entity.AC_Param_Name = entityAry[i].AC_Param_Name;
                entity.AC_Param_Value = entityAry[i].AC_Param_Value;
                entity.AC_Param_Remark = entityAry[i].AC_Param_Remark;
                addParams(entity);
            }
        }

        function initFuncCode(acids) {
            var iframes = document.getElementById("ifCtrl");
            iframes.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/highlight/editor.html?rnd=" + Math.random();
            winResize();
            if (acids > -1) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxActivity.GetFuncCode(acids);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
            }

            if (iframes.attachEvent) {
                iframes.attachEvent("onload", function () {
                    $("#loadingmsg").hide();
                    if (acids > -1) {
                        iframes.contentWindow.setData(ajax.value);
                    }
                });
            }
            else {
                iframes.onload = function () {
                    $("#loadingmsg").hide();
                    if (acids > -1) {
                        iframes.contentWindow.setData(ajax.value);
                    }
                };
            }

        }

        function initBindOpeTypeList(acids) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxActivity.GetActivityStation(acids);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var entityAry = ajax.value;
            var entity = {};
            for (var i = 0; i < entityAry.length; i++) {
                entity.OpeTypeId = entityAry[i].StationTypeId;
                entity.OpeType = entityAry[i].StationType;
                entity.OpeDescription = entityAry[i].StationDesc;
                addDetail(entity);

                /*get binded activity list*/
                updateBindCellActivity(entity.OpeTypeId, tab.rows[tab.rows.length - 1], true);
            }
        }

        function updateBindCellActivity(opeTypeId, rowObj, isInit) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxActivity.GetActivityStationMember(opeTypeId);
            var ary = ajax.value;
            var html = "<table id='tab" + rowObj.rowIndex + "' class='ListTable' cellspacing='0' cellpadding='4' style='border-width:0px;width:100%;border-collapse:collapse;'><tr class='ListTableHeader' style='background-color:steelblue; color:#ffffff; text-align:center;'><td style='font-size:12px;'><%=Resources.lang.AC_Name%></td><td style='font-size:12px;'><%=Resources.lang.ExecuteSequence %></td><td style='font-size:12px;'><%=Resources.lang.UP %></td><td style='font-size:12px;'><%=Resources.lang.Down %></td></tr>";
            if (ary.length > 0) {
                for (var i = 0; i < ary.length; i++) {
                    html += "<tr class='ListTableOddRow'><td style='text-align:left;'>" + ary[i].AC_Name + "</td><td style='text-align:center;'>" + (i + 1).toString() + "</td><td style='text-align:center;'><img src='../Content/images/arrowup.gif' style='cursor:pointer;' onclick='seqUp(this);' /></td><td style='text-align:center;'><img src='../Content/images/arrowdown.gif' style='cursor:pointer;' onclick='seqDown(this);' /><input type='hidden' name='hdnOpeTypeId" + rowObj.rowIndex + "' value='" + opeTypeId + "'><input type='hidden' flag='acids' name='hdnACId" + rowObj.rowIndex + "' value='" + ary[i].AC_ID + "'><input type='hidden' name='hdnSeq" + rowObj.rowIndex + "' value='" + ary[i].Seq + "'></td></tr>";
                }
            }
            if (!isInit) {
                html += "<tr class='ListTableOddRow'><td style='text-align:left;'>" + $("#txtAC_Name").val() + "</td><td style='text-align:center;'>" + (ary.length + 1).toString() + "</td><td style='text-align:center;'><img src='../Content/images/arrowup.gif' style='cursor:pointer;' onclick='seqUp(this);' /></td><td style='text-align:center;'><img src='../Content/images/arrowdown.gif' style='cursor:pointer;' onclick='seqDown(this);' /><input type='hidden' name='hdnOpeTypeId" + rowObj.rowIndex + "' value='" + opeTypeId + "'><input type='hidden' flag='acids' name='hdnACId" + rowObj.rowIndex + "' value='" + acid.toString() + "'><input type='hidden' name='hdnSeq" + rowObj.rowIndex + "' value='" + (ary.length + 1).toString() + "'></td></tr>";
            }
            html += "</table>";

            /*update activity sequence*/
            rowObj.cells[2].innerHTML = html;
        }

        function keepSessionAlive() {
            setInterval(function () {
                $.post("../Framework/Expired.aspx?rnd=" + Math.random() * 1000);
            }, 180000);
        }

        function setupEditOpeType() {
            selectTab(this, 2);
            $("#infoTabItem2").addClass("infoTabItem-selected");
            winResize();
        }

        function seqUp(obj) {
            var current = $(obj).parent().parent();
            var tabobj = current[0].parentNode;
            var prev = current.prev();
            if (current.index() > 1) {
                current.insertBefore(prev);
            }
            updateBindSequence(tabobj);
        }

        function seqDown(obj) {
            var current = $(obj).parent().parent();
            var tabobj = current[0].parentNode;
            var next = current.next();
            if (next) {
                current.insertAfter(next);
            }
            updateBindSequence(tabobj);
        }

        function setEditorValue(obj) {
            var ifm = obj.children("#popIframe").children("iframe").attr("id");
            document.getElementById("ifCtrl").contentWindow.setData(parent.document.getElementById(ifm).contentWindow.getData());
        }

        function fullScreenEditor() {
            var w = $(window.parent).width() - 80;
            var h = $(window.parent).height() - 80;

            var ht = document.getElementById("ifCtrl").contentWindow.getData();
            //window.parent.dialog({ content: "<textarea class='TextArea' style='padding:5px;width:" + (w - 13) + "px; height:" + (h - 13) + "px;' id='aabbccee'>" + ht + "</textarea>", width: w, height: h, resizeable: false });
            var cnt = "<div id='popIframe'><div style='color:red; text-align:center;'>数据正在加载...</div><iframe id='dialogIfrm'  frameborder='0' width='100%' height='100%' marginheight='0'  marginwidth='0' scrolling='auto' ></iframe></div>";

            var cuIfrId = $(".tabs-items-selected", window.parent.document.body).attr("id");
            var curIframeId = $($(window.parent.document.getElementById(cuIfrId)).children("iframe:eq(0)")).attr("id");

            window.parent.dialog({ title: "编辑/查看业务" + $("#txtAC_Name").val(), content: cnt, width: w, height: h, resizeable: false, onClosing: "document.getElementById('" + curIframeId + "').contentWindow.setEditorValue" });

            setTimeout(function () {
                var dialogIfrm = parent.document.getElementById("dialogIfrm");
                dialogIfrm.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/highlight/editor.html?rnd=" + Math.random();
                $(dialogIfrm).css({ "width": (w - 5), "height": (h - 5) });

                if (dialogIfrm.attachEvent) {
                    dialogIfrm.attachEvent("onload", function () {
                        dialogIfrm.contentWindow.setData(ht);
                        var iframe = $(".CodeMirror-scroll", dialogIfrm.contentWindow.document.body);
                        iframe.css({ "overflow": "auto", "height": (h - 15) + "px" });
                        $(dialogIfrm).prev().html("");
                    });
                }
                else {
                    dialogIfrm.onload = function () {
                        dialogIfrm.contentWindow.setData(ht);
                        var iframe = $(".CodeMirror-scroll", dialogIfrm.contentWindow.document.body);
                        iframe.css({ "overflow": "auto", "height": (h - 15) + "px" });
                        $(dialogIfrm).prev().html("");
                    };
                }
            }, 100);
        }

        $(function () {
            $(".ListTableOddRow,.ListTableEvenRow,.ListTableSelectedRow").live({
                mouseenter: function () {
                    $(this).addClass("ListTableHoverRow");
                },
                mouseleave: function () {
                    $(this).removeClass("ListTableHoverRow");
                },
                click: function () {
                    $(".ListTableSelectedRow").not($(this)).removeClass("ListTableSelectedRow");
                    $(this).toggleClass("ListTableSelectedRow");
                }
            });
        });

        function setVTabSize() {
            var winW = $(window).width();
            var winH = $(window).height();
            $("#vtb_c1,#vtb_c2").height(winH - 80);
            $("#vtb_c1,#vtb_c2").width(winW - 110);
        }

        function getMainFunParams() {
            var iframes = window.frames["ifCtrl"];
            var iframesVal = iframes.getData();
            var idxOf = iframesVal.indexOf("(");
            var idxOfStart = iframesVal.indexOf(")");
            var fucParams = iframesVal.substring(idxOf + 1, idxOfStart);
            var arr = fucParams.replace(",......", "").split(",");
            var entity = {};
            var hdnAOID, txtAC_Param_Name;
            var hasParam = false;
            for (var i = 0, l = arr.length; i < l; i++) {
                hasParam = false;
                $("#tabParams tr:gt(0)").each(function () {
                    if ($(this).children("td:eq(1)").children("input[name=txtAC_Param_Name]").val() == $.trim(arr[i])) {
                        hasParam = true;
                        return false;
                    }
                });
                if (!hasParam && $.trim(arr[i]) != "") {
                    entity.AOID = -1;
                    entity.AC_Param_Sequence = (i + 1).toString();
                    entity.AC_Param_Name = $.trim(arr[i]);
                    entity.AC_Param_Value = "";
                    entity.AC_Param_Remark = "";
                    addParams(entity);
                }
            }
        }
    </script>
</asp:Content>
