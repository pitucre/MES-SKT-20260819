<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="EquipmentInspectionTemplateItemEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentInspectionTemplateItemEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<div class="infoTips">
                <em>*</em><span>为必填项</span></div>
    <table class="EditeContentTable" width="100%">
        
        <tr>
            <asp:HiddenField ID="txtHideInspectionTypeId" runat="server" />
            <asp:HiddenField ID="txtHideCreater" runat="server" />
            <asp:HiddenField ID="txtHideCreateTime" runat="server" />
            <td class="Label2" colspan="2">
                模板名称<em>*</em>
            </td>
            <td class="Field2" colspan="2">
                <asp:TextBox ID="txtInspectionTemplateName" runat="server" CssClass="TextBox" ReadOnly="true" IsRequired="1" Width="180" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" value="..." onclick="selectFirst();" />
                <asp:HiddenField ID="HiddenInspectionTemplateId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2" colspan="2">类型
            </td>
            <td class="Field2" colspan="2">
                <input id="rdoItem" name="Fruit" type="radio" runat="server" class="itp-type" value="1" checked="true" />
                <span>按设备编码</span>           
                <input id="rdoType" name="Fruit" type="radio" runat="server" class="itp-type" value="2" />
                <span>按设备类型</span>
            </td>
        </tr>
        <tr class="EquipmentCode">
            <td class="Label2" colspan="2">
                设备编码<em>*</em>
            </td>
            <td class="Field2" colspan="2">
                <asp:TextBox ID="txtEquipmentName" runat="server" CssClass="TextBox" ReadOnly="true" Width="180" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" value="..." onclick="selectEquipmentCode();" />
                <asp:HiddenField ID="HiddenEquipmentCode" runat="server" Value="-1" />
            </td>
        </tr>
        <tr class="EquipmentType">
            <td class="Label2" colspan="2">
                设备类型<em>*</em>
            </td>
            <td class="Field2" colspan="2">
                <asp:TextBox ID="txtEquipmentType" runat="server" CssClass="TextBox" ReadOnly="true" Width="180" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" value="..." onclick="selectEquipmentType();" />
                <asp:HiddenField ID="HiddenEquipmentTypeID" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                周期方式
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlMaintainWay" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="1">--按周期--</asp:ListItem>
                    <asp:ListItem Value="2">--按用途--</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">
                周期类型
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlCycleType" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="1">--小时--</asp:ListItem>
                    <asp:ListItem Value="2">--天--</asp:ListItem>
                    <asp:ListItem Value="3">--周--</asp:ListItem>
                    <asp:ListItem Value="4">--月--</asp:ListItem>
                    <asp:ListItem Value="5">--年--</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                警报提前<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPrewarning" runat="server" CssClass="TextBox" MaxLength="50"
                    isRequired="1" isNumber="1" ClientIDMode="Static"></asp:TextBox>
                <asp:Label ID="labPrewarning" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
            <td class="Label2">
                周期间隔<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCycleTime" runat="server" isRequired="1" isNumber="1" CssClass="TextBox"
                    MaxLength="50" ClientIDMode="Static"></asp:TextBox>
                <asp:Label ID="labCycleTime" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                操作人<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtOperionUserName" runat="server" CssClass="TextBox" ReadOnly="true" IsRequired="1" Width="180" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" value="..." onclick="selectOperionUser();" />
                <asp:HiddenField ID="HiddenOperionUser" runat="server" Value="-1" />
            </td>
            <td class="Label2">
                异常上报方案<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtExceptionReportingName" runat="server" CssClass="TextBox" ReadOnly="true" IsRequired="1" Width="180" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" value="..." onclick="selectExceptionReporting();" />
                <asp:HiddenField ID="HiddenExceptionReportingId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">上一次点检时间<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLastTime" runat="server" class="DateTimeBox" Width="150" isRequired="1"
                    ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">下一次点检时间<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMaintainTime" runat="server" class="DateTimeBox" Width="150" isRequired="1"
                    ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script language="javascript" type="text/javascript">
        var ReqId = '<%=Request.QueryString["ID"] %>';
        $("select").css("width", "140px");
        _isHms = true;
        $(function () {
            //$("tr[class='itemCode']").css("display", "none");
            var val = $("input[type='radio'].itp-type:checked").val();
            changeType(val);
        });

        $("input[type='radio'].itp-type").on("change", function () {
            var val = $(this).val();
            changeType(val);
        });

        function changeType(val) {
            if (val == 1) {
                $("tr[class='EquipmentCode']").css("display", "");
                $("tr[class='EquipmentType']").css("display", "none");
                $("#<%=this.HiddenEquipmentTypeID.ClientID %>").val(-1);
                $("#txtEquipmentType").val("");
                Flag = 1;
            } else {
                Flag = 2;
                $("tr[class='EquipmentCode']").css("display", "none");
                $("tr[class='EquipmentType']").css("display", "");
                $("#txtEquipmentName").val("");
            }
        }

        //获取设备编码
        function selectEquipmentCode() {
            //var searchCondition = " 1=1 ";
            var searchCondition= " EquipmentTypeId NOT IN (-2,-3,-4)";
          
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&CallBackFunc=getChooseValuesEquipmentCode&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }

        function getChooseValuesEquipmentCode(list) {
            $("#txtEquipmentName").val(list[0][1]);
        }

        /*获取设备类型*/
        function selectEquipmentType() {

           
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquimentTypeDialog.aspx?name=Equipment_EquimentTypeDialog&controlId=controlId";
            dialog({ title: " <%=Resources.lang.EquipmentType%>", src: openWinUrl, width: 355, height: 450 });
        }

        SetValue = function (list) {
            closeDialog();
            $("#<%=this.HiddenEquipmentTypeID.ClientID %>").val(list[0].id);
            $("#txtEquipmentType").val(list[0].name);
        }

        //获取模板
        function selectFirst() {
           // var searchCondition = " 1=1 ";
            var searchCondition = "";
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=834&CallBackFunc=getChooseValuesFirst&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }

        function getChooseValuesFirst(list) {
            $("#<%=this.HiddenInspectionTemplateId.ClientID %>").val(list[0][0]);
            $("#txtInspectionTemplateName").val(list[0][1]);
        }

        //获取操作人
        function selectOperionUser() {
            //var searchCondition = " 1=1 ";
            var searchCondition = "";

            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&CallBackFunc=getChooseValuesOperionUser&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }

        function getChooseValuesOperionUser(list) {
            $("#<%=this.HiddenOperionUser.ClientID %>").val(list[0][2]);
            $("#txtOperionUserName").val(list[0][3]);
        }

        //获取异常上报方案
        function selectExceptionReporting() {
            //var searchCondition = " 1=1 ";  
            var searchCondition = "";

            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=835&CallBackFunc=getChooseValuesExceptionReporting&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }

        function getChooseValuesExceptionReporting(list) {
            $("#<%=this.HiddenExceptionReportingId.ClientID %>").val(list[0][0]);
            $("#txtExceptionReportingName").val(list[0][2]);
        }

        // 据保养类型显示相应的单位
        $("#ddlCycleType").change(function () {
            var type = $("#ddlCycleType option:selected").val();
            if (type == "1") {
                $("#labLifeTime").text("　小时");
                $("#labPrewarning").text("　小时");
                $("#labCycleTime").text("　小时");
            }
            if (type == "2") {
                $("#labLifeTime").text("　日");
                $("#labPrewarning").text("　日");
                $("#labCycleTime").text("　日");
            }
            if (type == "3") {
                $("#labLifeTime").text("　周");
                $("#labPrewarning").text("　日");
                $("#labCycleTime").text("　周");
            }
            if (type == "4") {
                $("#labLifeTime").text("　月");
                $("#labPrewarning").text("　日");
                $("#labCycleTime").text("　月");
            }
            if (type == "5") {
                $("#labLifeTime").text("　年");
                $("#labPrewarning").text("　日");
                $("#labCycleTime").text("　年");
            }
        })

        // 根据保养方式，改变对应单位，是否禁用类型下拉。
        $("#ddlMaintainWay").change(function () {
            var way = $("#ddlMaintainWay").val();
            if (way == "1") {
                var type = $("#ddlCycleType option:selected").val();
                if (type == "1") {
                    $("#labLifeTime").text("　小时");
                    $("#labPrewarning").text("　小时");
                    $("#labCycleTime").text("　小时");
                }
                if (type == "2") {
                    $("#labLifeTime").text("　日");
                    $("#labPrewarning").text("　日");
                    $("#labCycleTime").text("　日");
                }
                if (type == "3") {
                    $("#labLifeTime").text("　周");
                    $("#labPrewarning").text("　日");
                    $("#labCycleTime").text("　周");
                }
                if (type == "4") {
                    $("#labLifeTime").text("　月");
                    $("#labPrewarning").text("　日");
                    $("#labCycleTime").text("　月");
                }
                if (type == "5") {
                    $("#labLifeTime").text("　年");
                    $("#labPrewarning").text("　日");
                    $("#labCycleTime").text("　年");
                }
                $("#ddlCycleType").attr("disabled", false);
            }
            else {
                $("#ddlCycleType").attr("disabled", true);
                $("#labLifeTime").text("　时间");
                $("#labPrewarning").text("　时间");
                $("#labCycleTime").text("　时间");
            }
        })

        /*保存数据*/
        function Save() {
            var InspectionTemplateId = $("#<%=this.HiddenInspectionTemplateId.ClientID %>").val();
            var EquipmentTypeID = $("#<%=this.HiddenEquipmentTypeID.ClientID %>").val();
            var EquipmentCode = $("#txtEquipmentName").val();
            var EquipmentInspectionType = "";
            var OperionUser = $("#<%=this.HiddenOperionUser.ClientID %>").val();
            var ExceptionReportingId = $("#<%=this.HiddenExceptionReportingId.ClientID %>").val();

            var txtLastTime = $("#txtLastTime").val();         
            var txtMaintainTime = $("#txtMaintainTime").val();

            //如果是增加模式，则从下拉框获取编码，编辑模式不存在下拉框，则从label获取编码。
            var ddlMaintainWay = $("#ddlMaintainWay option:selected").val();

            //如果选择的是按次数，那么保养类型将被赋值为0。
            if (ddlMaintainWay == '1') {
                var ddlCycleType = $("#ddlCycleType option:selected").val();
            }
            else {
                var ddlCycleType = '0';
            }

            var textCycleTime = $("#txtCycleTime").val();
            var textPrewarning = $("#txtPrewarning").val();

            var val = $("input[type='radio'].itp-type:checked").val();
            if (val == 1) {
                EquipmentInspectionType = "EquipmentCode";
            }
            else {
                EquipmentInspectionType = "EquipmentType";
            }

            if (EquipmentInspectionType == "EquipmentCode" && EquipmentCode=="") {
                alert("请选择设备编码");
                return false;
            }
            if (EquipmentInspectionType == "EquipmentType" && EquipmentTypeID == -1) {
                alert("请选择设备类型");
                return false;
            }

            var IsSave=true;
            //switch (ddlCycleType) {
            //    case "3":
            //        if( (parseInt(textCycleTime*7) - parseInt(textPrewarning)) <= 0)
            //        {
            //            IsSave=false;
            //        }
            //        break;
            //    case "4":
            //        if( (parseInt(textCycleTime*30) - parseInt(textPrewarning)) <= 0)
            //        {
            //            IsSave=false;
            //        }
            //        break;
            //    case "5":
            //        if( (parseInt(textCycleTime*365) - parseInt(textPrewarning)) <= 0)
            //        {
            //            IsSave=false;
            //        }
            //        break;
            //    default:
            //        if( (parseInt(textCycleTime) - parseInt(textPrewarning)) <= 0)
            //        {
            //            IsSave=false;
            //        }
        
            //}
            if(!IsSave)
            {
                alert('<%=Resources.Messages.CycleTimeMustGreaterPrewarning %>');
                return false;
            }
            
            var entity = {};
            entity.InspectionTemplateItemId = ReqId;
            entity.InspectionTemplateId = InspectionTemplateId;
            entity.EquipmentInspectionType = EquipmentInspectionType;
            entity.EquipmentCode = EquipmentCode;
            entity.EquipmentTypeID = EquipmentTypeID;
            entity.MaintainWay = ddlMaintainWay;
            entity.CycleType = ddlCycleType;
            entity.Prewarning = textPrewarning;
            entity.CycleTime = textCycleTime;
            entity.OperionUser = OperionUser;
            entity.ExceptionReportingId = ExceptionReportingId;
            entity.LastTime = txtLastTime;
            entity.MaintainTime = txtMaintainTime;
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.ModifyBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.EquipmentInspectionTemplateItemEdit(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList("");
            return ajax;
        }

        function selectInspectionRuleValue() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?" +
                    "PageId=73&CallBackFunc=getChooseValueInspectionRule&Multiple=true&rnd=" + Math.random(),
                width: 400,
                height: 250
            });
        }
    </script>
</asp:Content>
