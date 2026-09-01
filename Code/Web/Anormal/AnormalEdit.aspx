<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="AnormalEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Anormal.AnormalEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <fieldset id="fieldset1">
        <legend><span>异常信息</span></legend>
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label3">异常单号编码</td>
                <td class="Field3">
                    <asp:TextBox ID="txtAbnormalDocumentNo" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" Width="80%"></asp:TextBox>
                </td>
                <td class="Label3">异常类型<em>*</em></td>
                <td class="Field3">
                    <asp:TextBox ID="txtAnormalTypeName" IsRequired='1' Enabled="false" runat="server" CssClass="TextBox" ClientIDMode="Static" Width="80%"></asp:TextBox>
                    <input type="button" runat="server" class="ButtonBox" value="..." title="选择异常类型" onclick="openChoosePage(1, 831, '选择异常类型');" />
                    <asp:HiddenField ID="hdAnormalTypeId" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
                <td class="Label3">异常名称<em>*</em></td>
                <td class="Field3">
                    <asp:TextBox ID="txtAnormalName" IsRequired='1' Enabled="false" runat="server" CssClass="TextBox" Width="80%" ClientIDMode="Static"></asp:TextBox>
                    <input type="button" runat="server" class="ButtonBox" value="..." title="选择异常名称" onclick="openChooseAnormalPage();" />
                    <asp:HiddenField ID="hdAnormalId" runat="server" Value="-1" ClientIDMode="Static" />
                </td>

            </tr>
            <tr>
                <td class="Label3">工单号码</td>
                <td class="Field3">
                    <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" Width="80%"></asp:TextBox>
                    <input type="button" id="btnSelectOrder" runat="server" class="ButtonBox" value="..." title="选择工单" onclick="openChoosePage(3, 44, '选择工单');" />
                    <asp:HiddenField ID="hdnOrderId" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
                <td class="Label3">订单数量</td>
                <td class="Field3">
                    <asp:TextBox ID="txtOrderQty" runat="server" CssClass="TextBox" ClientIDMode="Static" Enabled="false" Width="80%"></asp:TextBox>
                </td>
                <td class="Label3">产品编码</td>
                <td class="Field3">
                    <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" Width="80%"></asp:TextBox>
                    <input type="button" id="btnSelectItemCode" runat="server" class="ButtonBox" value="..." title="选择产品编码" onclick="openChoosePage(4, 1, '选择产品编码');" />
                    <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
            </tr>
            <tr>
                <td class="Label3">线别<em>*</em></td>
                <td class="Field3">
                    <asp:TextBox ID="txtLineName" IsRequired='1' runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" Width="80%"></asp:TextBox>
                    <input type="button" id="btnSelectLineName" runat="server" class="ButtonBox" value="..." title="选择线别" onclick="openChoosePage(6, 21, '选择线别');" />
                    <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
                <td class="Label3">工位</td>
                <td class="Field3">
                    <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" Width="80%"></asp:TextBox>
                    <input type="button" id="btnSelectStation" runat="server" class="ButtonBox" value="..." title="选择工位" onclick="openChoosePage(5, 8, '选择工位');" />
                    <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
                <td class="Label3">责任部门</td>
                <td class="Field3">
                    <asp:TextBox ID="txtDeptName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" Width="80%"></asp:TextBox>
                    <input type="button" id="btnSelectDeptName" runat="server" class="ButtonBox" value="..." title="选择部门" onclick="selectDeptName(10);" />
                    <asp:HiddenField ID="hdnDeptId" runat="server" Value="-1" ClientIDMode="Static" />
                </td>

            </tr>
            <tr>
                <td class="Label3">异常时长<em>*</em></td>
                <td class="Field3">
                    <asp:TextBox ID="txtAnormalTime" IsRequired="1" runat="server" Text="0" CssClass="NumericBox50" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
                    <asp:DropDownList ID="ddlUnit" runat="server" ToolTip="异常时长单位">
                        <asp:ListItem Value="分钟" Text="分钟"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label3">影响人数<em>*</em></td>
                <td class="Field3">
                    <asp:TextBox ID="txtEffectPerson" IsRequired="1" runat="server" CssClass="NumericBox50" Width="80%" Text="0" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
                </td>
                <td class="Label3">异常提出人</td>
                <td class="Field3">
                    <asp:TextBox ID="txtAbnormalProposer" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" Width="80%"></asp:TextBox>
                    <input type="button" runat="server" class="ButtonBox" value="..." title="选择异常提出人" onclick="openChoosePage(8, 12, '选择异常提出人', true);" />
                </td>
            </tr>
            <tr>
                <td class="Label3">班次</td>
                <td class="Field3">
                    <asp:DropDownList ID="ddlShift" runat="server">
                    </asp:DropDownList>
                </td>
                <td class="Label3">是否停线</td>
                <td class="Field3">
                    <asp:CheckBox ID="ckbIsLineStop" runat="server" /><span>已停线</span>
                </td>
            </tr>
            <tr>
                <td class="Label3">异常描述<em>*</em></td>
                <td class="Field3" colspan="5">
                    <asp:TextBox ID="txtAnormalDesc" IsRequired="1" runat="server" TextMode="MultiLine" CssClass="TextArea" Width="80%"></asp:TextBox>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset id="fieldset2">
        <legend><span>原因分析</span></legend>
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label3">原因分析人</td>
                <td class="Field3">
                    <asp:TextBox ID="txtPECauseAnalysisMan" runat="server" CssClass="TextBox" ClientIDMode="Static" Enabled="false" Width="80%"></asp:TextBox>
                    <input type="button" runat="server" class="ButtonBox" value="..." title="选择原因分析人" onclick="openChoosePage(7, 12, '选择原因分析人',true);" />
                </td>
                <td class="Label3">原因分析时间</td>
                <td class="Field3">
                    <asp:TextBox ID="txtPECauseAnalysisTime" runat="server" CssClass="DateTimeBox" ClientIDMode="Static" Width="80%"></asp:TextBox>
                </td>
                <td class="Field3" style="border-right: none;"></td>
                <td class="Field3" style="border-left: none;"></td>
            </tr>
            <tr>
                <td class="Label3">原因分析</td>
                <td class="Field3" colspan="5">
                    <asp:TextBox ID="txtCauseAnalysis" runat="server" TextMode="MultiLine" CssClass="TextArea" Width="80%"></asp:TextBox>
                </td>
            </tr>

        </table>
    </fieldset>
    <fieldset id="fieldset3">
        <legend><span>临时处理方案</span></legend>
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label3">临时处理方案</td>
                <td class="Field3" colspan="5">
                    <asp:CheckBox ID="TreatmentScheme1" runat="server" ClientIDMode="Static" /><span>继续生产</span>
                    <asp:CheckBox ID="TreatmentScheme2" runat="server" ClientIDMode="Static" /><span>停线</span>
                    <asp:CheckBox ID="TreatmentScheme3" runat="server" ClientIDMode="Static" /><span>其他</span>

                </td>
            </tr>
            <tr>
                <td class="Label3">责任人</td>
                <td class="Field3">
                    <asp:TextBox ID="txtDutyMan" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" Width="80%"></asp:TextBox>
                    <input type="button" runat="server" class="ButtonBox" value="..." title="选择责任人" onclick="openChoosePage(12, 12, '选择责任人',true);" />

                </td>
                <td class="Label3">责任确认人</td>
                <td class="Field3">
                    <asp:TextBox ID="txtQEConfirmer" runat="server" CssClass="TextBox" Enabled="false" Width="80%"></asp:TextBox>
                    <input type="button" runat="server" class="ButtonBox" value="..." title="选择确认人" onclick="openChoosePage(13, 12, '选择确认人', true);" />
                </td>
                <td class="Label3">责任确认时间</td>
                <td class="Field3">
                    <asp:TextBox ID="txtQEConfirmTime" runat="server" CssClass="DateTimeBox" Width="80%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="Label3">临时措施</td>
                <td class="Field3" colspan="5">
                    <asp:TextBox ID="txtTempSolution" runat="server" TextMode="MultiLine" CssClass="TextArea" Width="80%"></asp:TextBox>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset id="fieldset4">
        <legend><span>永久改善对策</span></legend>
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label3">改善制定人</td>
                <td class="Field3">
                    <asp:TextBox ID="txtImproveMaker" runat="server" CssClass="TextBox" Enabled="false" Width="80%"></asp:TextBox>
                    <input type="button" runat="server" class="ButtonBox" value="..." title="选择改善制定人" onclick="openChoosePage(14, 12, '选择改善制定人', true);" />
                </td>
                <td class="Label3">改善制定时间</td>
                <td class="Field3">
                    <asp:TextBox ID="txtImproveTime" runat="server" CssClass="DateTimeBox" Width="80%"></asp:TextBox>
                </td>
                <td class="Field3" style="border-right: none;"></td>
                <td class="Field3" style="border-left: none;"></td>
            </tr>
            <tr>
                <td class="Label3">永久改善对策</td>
                <td class="Field3" colspan="5">
                    <asp:TextBox ID="txtPermanentSolution" runat="server" TextMode="MultiLine" CssClass="TextArea" Width="80%"></asp:TextBox>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset id="fieldset5">
        <legend><span>品管结案</span></legend>
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label3">是否结案</td>
                <td class="Field3">
                    <asp:CheckBox ID="Closed" runat="server" ClientIDMode="Static" /><span>结案</span>
                    <asp:CheckBox ID="NoClosed" runat="server" ClientIDMode="Static" /><span>未结案</span>
                </td>
                <td class="Label3">品管最终确认人</td>
                <td class="Field3">
                    <asp:TextBox ID="txtQAFinalConfirm" runat="server" CssClass="TextBox" Width="80%" Enabled="false"></asp:TextBox>
                    <input type="button" runat="server" class="ButtonBox" value="..." title="选择品管最终确认人" onclick="openChoosePage(16, 12, '选择品管最终确认人', true);" />
                </td>
                <td class="Label3">最终确认时间</td>
                <td class="Field3">
                    <asp:TextBox ID="txtQAFinalConfirmTime" runat="server" CssClass="DateTimeBox" Width="80%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="Label3">对策追踪</td>
                <td class="Field3" colspan="5">
                    <asp:TextBox ID="txtCountermeasureTracking" runat="server" TextMode="MultiLine" CssClass="TextArea" Width="80%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="Label3">上传RCCA报告</td>
                <td class="Field3" colspan="5">
                    <input type="file" id="Filedata" name="Filedata" title="上传RCCA报告" /><br />
                    <asp:Label ID="lblRCCAPath" runat="server"></asp:Label>
                    <span id="showUploadCtrl"></span>
                    <asp:HiddenField ID="hdnRCCAFilePath" runat="server" Value="" />
                </td>
            </tr>
        </table>
    </fieldset>
    <asp:HiddenField ID="anormalObject" runat="server" Value="" />
    <style type="text/css">
        fieldset {
            border: #2491BF solid 1px;
        }

        legend {
            font-size: 13px;
            font-weight: bold;
            color: #296AA0;
            background-repeat: no-repeat;
            height: 24px;
            padding-top: 2px;
            padding-left: 5px;
        }
    </style>
    <script type="text/javascript">
        var id = '<%=Request.QueryString["ID"]%>';
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var pageName = getQueryVariable('name');
        var chooseFlag = -1;
        _isHms = true;
        var flag = '<%=Request.QueryString["Flag"]%>';  //1：编辑  2：响应 3：完结
        $(function () {
            if (pageName === "Anormal_Add") {
                id = -1;
                window.document.title = "新增异常";
            }
            else if (pageName === "Anormal_Edit") {
                window.document.title = "修改异常";
            }
            else if (pageName === "Anormal_View") {
                $("input").attr("disabled", true);
                $(".ui-datepicker-trigger").hide();
                $("textarea").attr("disabled", true);
                $("select").attr("disabled", true);
                $("#showUploadCtrl").hide();
                window.document.title = "查看异常";
            }

            //新增或者编辑时，不允许修改原因分析、临时处理方案、永久改善对策、品管结案
            if (id == -1 || flag == 1) {
                $(".response-table input,.response-table textarea,.complete-table input,.complete-table textarea").attr("disabled", "disabled");
                $(".ui-datepicker-trigger").hide();
                $(".ShowDateTime").siblings(".ui-datepicker-trigger").show();
                $(".toolbar-btn[onclick=\"SavePlus()\"]").remove();
            }

            if (flag == 2) {
                //响应
                $(".add-table textarea,.add-table input,select,.complete-table textarea,.complete-table input").attr("disabled", "disabled");
                //$(".ui-datepicker-trigger").hide();
                //$(".not-hide").siblings(".ui-datepicker-trigger").show();
                $(".toolbar-btn[onclick=\"SavePlus()\"]").remove();
                //$(".toolbar-btn[onclick=\"EquipmentRepair()\"]").remove();


            } else if (flag == 3) {
                //完结
                $(".add-table textarea,.add-table input,select,.response-table input,.response-table textarea").attr("disabled", "disabled");
                //$(".ui-datepicker-trigger").hide();
                $(".toolbar-btn[onclick=\"SaveAndSend()\"]").remove();
            }


            $("#<%=this.ckbIsLineStop.ClientID%>").click(function () {
                if ($(this)[0].checked) {
                    $(this).parent("td").css("color", "red");
                }
                else {
                    $(this).parent("td").css("color", "");
                }
            });

            if ($("#<%=this.ckbIsLineStop.ClientID%>")[0].checked) {
                $("#<%=this.ckbIsLineStop.ClientID%>").parent("td").css("color", "red");
            }
            else {
                $("#<%=this.ckbIsLineStop.ClientID%>").parent("td").css("color", "");
            }

            if (id != "-1") {
                $("#Filedata").hide();
                $("#showUploadCtrl").html("<a href='#'>重新上传</a>").click(function () {
                    $(this).hide();
                    $("#Filedata").show();
                })
            }
            else {
                $("#Filedata").show();
                $("#showUploadCtrl").html("");
            }
            var anormalObject = $("#<%=this.anormalObject.ClientID%>").val();
            var obj = jQuery.parseJSON(anormalObject);
            if (obj != null) {
                $('#<%=this.txtOrderNo.ClientID%>').val(obj.order);
                $('#<%=this.hdnOrderId.ClientID%>').val(obj.orderid);
                $('#<%=this.txtItemCode.ClientID%>').val(obj.itemcode);
                $('#<%=this.hdnItemId.ClientID%>').val(obj.itemid);
            }
        });

        //选择ChoosePage
        function openChoosePage(flag, pageId, title, multiple, pageCondition) {
            chooseFlag = flag;
            multiple = multiple || false;
            title = title || "";
            pageCondition = pageCondition || "";
            dialog({ title: title, src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot%>/Framework/ChoosePage.aspx?PageId=" + pageId + "&Multiple=" + multiple + "&PageCondition=" + pageCondition + "&CallBackFunc=setChoosePageValue&rnd=" + Math.random(), width: 680, height: 350 });
        }
        //设置ChoosePage返回值
        function setChoosePageValue(list) {
            if (chooseFlag == 1) {          //选择异常类型
                $('#<%=this.txtAnormalTypeName.ClientID%>').val(list[0][1]);
                $('#<%=this.hdAnormalTypeId.ClientID%>').val(list[0][0]);
                $('#<%=this.txtAnormalName.ClientID%>').val("");
                $('#<%=this.hdAnormalId.ClientID%>').val("-1");
            }
            else if (chooseFlag == 2) {     //选择异常名称
                $('#<%=this.txtAnormalName.ClientID%>').val(list[0][1]);
                $('#<%=this.hdAnormalId.ClientID%>').val(list[0][0]);
            }
            else if (chooseFlag == 3) {     //选择工单
                $('#<%=this.txtOrderNo.ClientID%>').val(list[0][1]);
                $('#<%=this.hdnOrderId.ClientID%>').val(list[0][0]);
                $('#<%=this.txtOrderQty.ClientID%>').val(list[0][3]);

                if (list[0][0] != "-1") {
                    $('#<%=this.txtItemCode.ClientID%>').val(list[0][2]);
                    $('#<%=this.hdnItemId.ClientID%>').val("-1");

                    $('#<%=this.hdnItemId.ClientID%>').attr("disabled", "disabled");
                    $('#<%=this.btnSelectItemCode.ClientID%>').attr("disabled", "disabled");
                    $('#<%=this.btnSelectItemCode.ClientID%>').hide();
                }
                else {
                    $('#<%=this.txtItemCode.ClientID%>').val("");
                    $('#<%=this.hdnItemId.ClientID%>').val("-1");

                    $('#<%=this.hdnItemId.ClientID%>').removeAttr("disabled");
                    $('#<%=this.btnSelectItemCode.ClientID%>').removeAttr("disabled");
                    $('#<%=this.btnSelectItemCode.ClientID%>').show();
                }
            }
            else if (chooseFlag == 4) {     //选择产品编码
                $('#<%=this.txtItemCode.ClientID%>').val(list[0][2]);
                $('#<%=this.hdnItemId.ClientID%>').val(list[0][0]);
            }
            else if (chooseFlag == 5) {     //选择工位
                $('#<%=this.txtStation.ClientID%>').val(list[0][1]);
                $('#<%=this.hdnStationId.ClientID%>').val(list[0][0]);
            }
            else if (chooseFlag == 6) {     //选择线别
                $('#<%=this.txtLineName.ClientID%>').val(list[0][1]);
                $('#<%=this.hdnLineId.ClientID%>').val(list[0][0]);
            }
            else if (chooseFlag == 7) {     //选择原因分析人
                var peCauseAnalysisMan = $('#<%=this.txtPECauseAnalysisMan.ClientID%>').val().trim();
                var listPECauseAnalysisMan = peCauseAnalysisMan.split(";");
                //清空选择项
                if (list.length > 0 && list[0][0] == "-1") {
                    peCauseAnalysisMan = "";
                }
                else {//添加不重复项
                    for (var i = 0; i < list.length; i++) {
                        if (listPECauseAnalysisMan.indexOf(list[i][3]) == -1) {
                            peCauseAnalysisMan += ';' + list[i][3];
                        }
                    }
                    if (peCauseAnalysisMan.indexOf(";") == 0) {
                        peCauseAnalysisMan = peCauseAnalysisMan.substring(1);
                    }
                }
                $('#<%=this.txtPECauseAnalysisMan.ClientID%>').val(peCauseAnalysisMan);
            }
            else if (chooseFlag == 8) {     //选择异常提出人
                var abnormalProposer = $('#<%=this.txtAbnormalProposer.ClientID%>').val().trim();
                var listAbnormalProposer = abnormalProposer.split(";");
                //清空选择项
                if (list.length > 0 && list[0][0] == "-1") {
                    abnormalProposer = "";
                }
                else {//添加不重复项
                    for (var i = 0; i < list.length; i++) {
                        if (listAbnormalProposer.indexOf(list[i][3]) == -1) {
                            abnormalProposer += ';' + list[i][3];
                        }
                    }
                    if (abnormalProposer.indexOf(";") == 0) {
                        abnormalProposer = abnormalProposer.substring(1);
                    }
                }
                $('#<%=this.txtAbnormalProposer.ClientID%>').val(abnormalProposer);
            }
            else if (chooseFlag == 12) {
                var dutyMan = $('#<%=this.txtDutyMan.ClientID%>').val().trim();
                var listDutyMan = dutyMan.split(";");
                //清空选择项
                if (list.length > 0 && list[0][0] == "-1") {
                    dutyMan = "";
                }
                else {//添加不重复项
                    for (var i = 0; i < list.length; i++) {
                        if (listDutyMan.indexOf(list[i][3]) == -1) {
                            dutyMan += ';' + list[i][3];
                        }
                    }
                    if (dutyMan.indexOf(";") == 0) {
                        dutyMan = dutyMan.substring(1);
                    }
                }
                $('#<%=this.txtDutyMan.ClientID%>').val(dutyMan);
            }
            else if (chooseFlag == 13) {
                var qeConfirmer = $('#<%=this.txtQEConfirmer.ClientID%>').val().trim();
                var listQEConfirmer = qeConfirmer.split(";");
                //清空选择项
                if (list.length > 0 && list[0][0] == "-1") {
                    qeConfirmer = "";
                }
                else {//添加不重复项
                    for (var i = 0; i < list.length; i++) {
                        if (listQEConfirmer.indexOf(list[i][3]) == -1) {
                            qeConfirmer += ';' + list[i][3];
                        }
                    }
                    if (qeConfirmer.indexOf(";") == 0) {
                        qeConfirmer = qeConfirmer.substring(1);
                    }
                }
                $('#<%=this.txtQEConfirmer.ClientID%>').val(qeConfirmer);
            }
            else if (chooseFlag == 14) {
                var improveMaker = $('#<%=this.txtImproveMaker.ClientID%>').val().trim();
                var listImproveMaker = improveMaker.split(";");
                //清空选择项
                if (list.length > 0 && list[0][0] == "-1") {
                    improveMaker = "";
                }
                else {//添加不重复项
                    for (var i = 0; i < list.length; i++) {
                        if (listImproveMaker.indexOf(list[i][3]) == -1) {
                            improveMaker += ';' + list[i][3];
                        }
                    }
                    if (improveMaker.indexOf(";") == 0) {
                        improveMaker = improveMaker.substring(1);
                    }
                }
                $('#<%=this.txtImproveMaker.ClientID%>').val(improveMaker);
            }
            else if (chooseFlag == 15) {
                $("#txtPushInformation").val(list[0][2]);
            }
            else if (chooseFlag == 16) {
                var qaFinalConfirm = $('#<%=this.txtQAFinalConfirm.ClientID%>').val().trim();
                var listQAFinalConfirm = qaFinalConfirm.split(";");
                //清空选择项
                if (list.length > 0 && list[0][0] == "-1") {
                    qaFinalConfirm = "";
                }
                else {//添加不重复项
                    for (var i = 0; i < list.length; i++) {
                        if (listQAFinalConfirm.indexOf(list[i][3]) == -1) {
                            qaFinalConfirm += ';' + list[i][3];
                        }
                    }
                    if (qaFinalConfirm.indexOf(";") == 0) {
                        qaFinalConfirm = qaFinalConfirm.substring(1);
                    }
                }
                $('#<%=this.txtQAFinalConfirm.ClientID%>').val(qaFinalConfirm);
            }
        }

        //选择部门
        function selectDeptName(flag) {
            chooseFlag = flag;
            dialog({ title: "选择部门", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot  %>/Organization/OrganizationTree.aspx?rnd=" + Math.random(), width: 550, height: 350 });
        }

        function getChooseValue(departId, departName, departNo) {
            if (chooseFlag == 10) {
                $("#<%=this.hdnDeptId.ClientID %>").val(departId);
                if (departNo != "") {
                    $("#<%=this.txtDeptName.ClientID %>").val(departName + "(" + departNo + ")");
                }
                else {
                    $("#<%=this.txtDeptName.ClientID %>").val(departName);
                }
            }
            closeDialog();
        }

        //选择异常名称
        function openChooseAnormalPage() {
            var txtAnormalTypeName = $('#<%=this.txtAnormalTypeName.ClientID%>').val();
            var pageCondition = "";
            pageCondition = "AnormalGroupName='" + txtAnormalTypeName + "'";
            openChoosePage(2, 702, '选择异常名称', false, pageCondition);
        }

        //临时处理方案
        var treatmentScheme = 0;
        $("#TreatmentScheme1").change(function () {
            if ($(this).attr("checked")) {
                $("#TreatmentScheme2").attr("checked", false);
                $("#TreatmentScheme3").attr("checked", false);
                treatmentScheme = 1;
            }
            else {
                treatmentScheme = 0;
            }
        });
        $("#TreatmentScheme2").change(function () {
            if ($(this).attr("checked")) {
                $("#TreatmentScheme1").attr("checked", false);
                $("#TreatmentScheme3").attr("checked", false);
                treatmentScheme = 2;
            }
            else {
                treatmentScheme = 0;
            }
        });
        $("#TreatmentScheme3").change(function () {
            if ($(this).attr("checked")) {
                $("#TreatmentScheme1").attr("checked", false);
                $("#TreatmentScheme2").attr("checked", false);
                treatmentScheme = 3;
            }
            else {
                treatmentScheme = 0;
            }
        });

        //是否结案
        var anormalClosed = 0;
        $("#Closed").change(function () {
            if ($(this).attr("checked")) {
                $("#NoClosed").attr("checked", false);
                anormalClosed = 1;
            }
            else {
                anormalClosed = 0;
            }
        });
        $("#NoClosed").change(function () {
            if ($(this).attr("checked")) {
                $("#Closed").attr("checked", false);
                anormalClosed = 2;
            }
            else {
                anormalClosed = 0;
            }
        });

        //保存并发送消息
        function SaveAndSend() {
            if (SubmitValidation()) {
                Save(true);
            }
        }

        //保存（默认不发送消息）
        function Save(isSendMsg) {
            isSendMsg = isSendMsg || false;
            //异常信息
            var txtAbnormalDocumentNo = $('#<%=this.txtAbnormalDocumentNo.ClientID%>').val();
            var txtAnormalName = $('#<%=this.txtAnormalName.ClientID%>').val();
            var hdAnormalId = $('#<%=this.hdAnormalId.ClientID%>').val();
            var txtAnormalTypeName = $('#<%=this.txtAnormalTypeName.ClientID%>').val();
            var hdAnormalTypeId = $('#<%=this.hdAnormalTypeId.ClientID%>').val();
            var txtOrderNo = $('#<%=this.txtOrderNo.ClientID%>').val();
            var hdnOrderId = $('#<%=this.hdnOrderId.ClientID%>').val();
            var txtOrderQty = $('#<%=this.txtOrderQty.ClientID%>').val();
            var txtItemCode = $('#<%=this.txtItemCode.ClientID%>').val();
            var hdnItemId = $('#<%=this.hdnItemId.ClientID%>').val();
            var txtStation = $('#<%=this.txtStation.ClientID%>').val();
            var hdnStationId = $('#<%=this.hdnStationId.ClientID%>').val();
            var txtDeptName = $('#<%=this.txtDeptName.ClientID%>').val();
            var hdnDeptId = $('#<%=this.hdnDeptId.ClientID%>').val();
            var txtLineName = $('#<%=this.txtLineName.ClientID%>').val();
            var hdnLineId = $('#<%=this.hdnLineId.ClientID%>').val();
            var txtAnormalTime = $('#<%=this.txtAnormalTime.ClientID%>').val();
            var txtEffectPerson = $('#<%=this.txtEffectPerson.ClientID%>').val();
            var txtAbnormalProposer = $("#<%=this.txtAbnormalProposer.ClientID%>").val();
            var ddlShift = $('#<%=this.ddlShift.ClientID%>').find('option:selected').val();
            var ckbIsLineStop = $('#<%=this.ckbIsLineStop.ClientID%>')[0].checked;
            var txtAnormalDesc = $('#<%=this.txtAnormalDesc.ClientID%>').val();
            //原因分析
            var txtPECauseAnalysisMan = $('#<%=this.txtPECauseAnalysisMan.ClientID%>').val();
            var txtPECauseAnalysisTime = $('#<%=this.txtPECauseAnalysisTime.ClientID%>').val();
            var txtCauseAnalysis = $('#<%=this.txtCauseAnalysis.ClientID%>').val();
            //临时处理方案
            var txtDutyMan = $('#<%=this.txtDutyMan.ClientID%>').val();
            var txtQEConfirmer = $('#<%=this.txtQEConfirmer.ClientID%>').val();
            var txtQEConfirmTime = $('#<%=this.txtQEConfirmTime.ClientID%>').val();
            var txtTempSolution = $('#<%=this.txtTempSolution.ClientID%>').val();
            //永久改善对策
            var txtPermanentSolution = $('#<%=this.txtPermanentSolution.ClientID%>').val();
            var txtImproveMaker = $('#<%=this.txtImproveMaker.ClientID%>').val();
            var txtImproveTime = $('#<%=this.txtImproveTime.ClientID%>').val();
            //品管结案
            var txtQAFinalConfirm = $('#<%=this.txtQAFinalConfirm.ClientID%>').val();
            var txtQAFinalConfirmTime = $('#<%=this.txtQAFinalConfirmTime.ClientID%>').val();
            var txtCountermeasureTracking = $('#<%=this.txtCountermeasureTracking.ClientID%>').val();

            //校验
            //结案
            if (anormalClosed != 0) {
                if (!txtQAFinalConfirm) {
                    alert("请选择品管最终确认人");
                    $('#<%=this.txtQAFinalConfirm.ClientID%>').focus();
                    return false;
                }
                if (!txtQAFinalConfirmTime) {
                    alert("请选择最终确认时间");
                    $('#<%=this.txtQAFinalConfirmTime.ClientID%>').focus();
                    return false;
                }
            }
            //时间格式（兼容IE）
            txtPECauseAnalysisTime = txtPECauseAnalysisTime.replace(/-/g, "/");
            txtQEConfirmTime = txtQEConfirmTime.replace(/-/g, "/");
            txtImproveTime = txtImproveTime.replace(/-/g, "/");
            txtQAFinalConfirmTime = txtQAFinalConfirmTime.replace(/-/g, "/");
            if (txtPECauseAnalysisTime && isNaN(new Date(txtPECauseAnalysisTime).getTime())) {
                alert("原因分析时间格式不正确");
                $('#<%=this.txtPECauseAnalysisTime.ClientID%>').focus();
                return false;
            }
            if (txtQEConfirmTime && isNaN(new Date(txtQEConfirmTime).getTime())) {
                alert("确认时间格式不正确");
                $('#<%=this.txtQEConfirmTime.ClientID%>').focus();
                return false;
            }
            if (txtImproveTime && isNaN(new Date(txtImproveTime).getTime())) {
                alert("改善制定时间格式不正确");
                $('#<%=this.txtImproveTime.ClientID%>').focus();
                return false;
            }
            if (txtQAFinalConfirmTime && isNaN(new Date(txtQAFinalConfirmTime).getTime())) {
                alert("最终确认时间格式不正确");
                $('#<%=this.txtQAFinalConfirmTime.ClientID%>').focus();
                return false;
            }
            //实体
            var entity = {};
            entity.AbnormalDocumentNo = txtAbnormalDocumentNo;
            entity.AnormalId = parseInt(id || -1);
            entity.AnormalTypeId = parseInt(hdAnormalTypeId);
            entity.AnormalObject = JSON.stringify({
                order: txtOrderNo,
                orderid: parseInt(hdnOrderId),
                itemcode: txtItemCode,
                itemid: parseInt(hdnItemId)
            });
            entity.AnormalNameId = hdAnormalId;
            entity.OrderQty = (txtOrderQty || 0) * 1;
            entity.OpeId = parseInt(hdnStationId);
            entity.DeptId = hdnDeptId;
            entity.LineId = parseInt(hdnLineId);
            entity.AbnormalTimeLength = parseFloat(txtAnormalTime || 0);
            entity.AbnormalUnit = $("#<%=this.ddlUnit.ClientID%>").val();
            entity.EffectPerson = parseFloat(txtEffectPerson || 0);
            entity.Shift = parseInt(ddlShift);
            entity.IsLineStop = ckbIsLineStop;
            entity.Descriptions = txtAnormalDesc;
            entity.AbnormalProposer = txtAbnormalProposer;
            entity.UserId = parseInt("<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId%>");
            entity.Status = anormalClosed == 1 ? 2 : 1;     //1：已建立 2：已关闭（结案的时候才关闭）
            entity.CreateBy = userName;
            entity.ModifyBy = userName;

            entity.PECauseAnalysisMan = txtPECauseAnalysisMan;
            entity.PECauseAnalysisTime = txtPECauseAnalysisTime == "" ? null : new Date(txtPECauseAnalysisTime);
            entity.CauseAnalysis = txtCauseAnalysis;

            entity.TempTreatmentScheme = parseInt(treatmentScheme);
            entity.DutyMan = txtDutyMan;
            entity.QEConfirmer = txtQEConfirmer;
            entity.QEConfirmTime = txtQEConfirmTime == "" ? null : new Date(txtQEConfirmTime);
            entity.TempSolution = txtTempSolution;

            entity.PermanentSolution = txtPermanentSolution;
            entity.ImproveMaker = txtImproveMaker;
            entity.ImproveTime = txtImproveTime == "" ? null : new Date(txtImproveTime);
            entity.SolutionFinished = (entity.PermanentSolution && entity.ImproveMaker && entity.ImproveTime) ? true : false;

            entity.Closed = parseInt(anormalClosed);
            entity.QAFinalConfirm = txtQAFinalConfirm;
            entity.QAFinalConfirmTime = txtQAFinalConfirmTime == "" ? null : new Date(txtQAFinalConfirmTime);
            entity.CountermeasureTracking = txtCountermeasureTracking;

            //未使用
            entity.Owner = "";
            entity.Remark = "";
            entity.ActionPerson = "";
            entity.Solution = "";
            entity.PushInformation = "";
            entity.Supervisor = "";
            entity.ProductIntoQty = 0;
            entity.BadQty = 0;
            entity.BadRate = 0;
            entity.MachineModel = "";
            entity.Source = "";
            entity.IPQCConfirmer = "";
            entity.AnormalItemCode = "";
            entity.AnormalItemName = "";
            entity.InventoryMaterialHandlingMethod = -1;
            entity.TempHandler = "";
            entity.TempHandleTime = null;
            entity.Supplier = "";
            entity.OutputHandlingMethod = 0;
            entity.PackedHandlingMethod = 0;
            entity.FinalBadRate = 0;
            entity.DutyDept = "";

            if (flag == 2) {
                //响应
                if (txtCauseAnalysis == "") {
                    alert("请输入原因分析");
                    $("#txtCauseAnalysis").val("").focus();
                    return false;
                }
            } else if (flag == 3) {
                //完结
                var closed = $("#Closed").prop("checked");
                var noClosed = $("#NoClosed").prop("checked");

                if (!closed && !noClosed) {
                    alert("请选择是否结案");
                    return false;
                }

                if (txtCountermeasureTracking == "") {
                    alert("请输入对策追踪");
                    $("#txtCountermeasureTracking").val("").focus();
                    return false;
                }
            }

            try {
                if ($("#Filedata").val() != "") {
                    UploadRCCA(entity);
                }
                else {
                    entity.RCCA = $("#<%=this.hdnRCCAFilePath.ClientID%>").val();
                }
                if (flag == "") {
                    flag = 0;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProdAnormal.Editdata(entity, isSendMsg, flag);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                if (isSendMsg) {
                    alert("保存并发送成功！");
                } else {

                    alert("保存成功！");
                }
                if (window) {
                    if (window.opener) {
                        window.opener.refresh();
                    }
                    window.close();
                }
            }
            catch (ex) {
                alert(ex);
            }
        }

        function UploadRCCA(entity) {
            var form = new FormData($("#form1")[0]);
            $.ajax({
                type: "POST",  //提交方式  
                url: "../Handler/UploadHander.ashx?Action=UploadRCCA&rnd=" + Math.random(),//路径  
                data: form,//数据
                async: false,
                contentType: false, //禁止设置请求类型
                processData: false, //禁止jquery对DAta数据的处理,默认会处理
                success: function (data) {//返回数据根据结果进行相应的处理  
                    $("#<%=this.lblRCCAPath.ClientID%>").text(data.substring(data.lastIndexOf("/") + 1));
                    $("#<%=this.hdnRCCAFilePath.ClientID%>").val(data);
                    entity.RCCA = data;
                },
                error: function (xhr, status, error) {

                }
            });
        }

        // 获取url参数
        function getQueryVariable(variable) {
            var query = window.location.search.substring(1);
            var vars = query.split("&");
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split("=");
                if (pair[0] == variable) { return pair[1]; }
            }
            return (false);
        }
    </script>
</asp:Content>
