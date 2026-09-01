<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="MouldSizeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldSizeEdit" Title="Edit EquipmentPosition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style>
        .Label {
            text-align: right;
        }
    </style>
    <div class="Label infoTips" style="margin-top: -5px; !margin-top: -25px; text-align: left;">
        <%=Resources.Messages.WithAsteriskIsRequired%>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label">模具编码<em>*</em></td>
            <td class="Field">
                <asp:TextBox ID="txtMouldCode" runat="server" CssClass="TextBox" MaxLength="100" IsRequired="1"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectMould()" />
                <asp:HiddenField ID="hdnMouldId" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label"><%=Resources.lang.MouldName%><em>*</em></td>
            <td class="Field">
                <asp:Label ID="lblBomName" runat="server" CssClass="TextBox" MaxLength="100"></asp:Label>
                <asp:HiddenField ID="hdnMouldBomId" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label">构件名称<em>*</em></td>
            <td class="Field">
                <asp:Label ID="lblMouldTypeName" runat="server" CssClass="TextBox" MaxLength="100"></asp:Label>
                <asp:HiddenField ID="hdnMouldTypeId" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label">单位</td>
            <td class="Field">
                <asp:TextBox ID="txtUnits" runat="server" CssClass="TextBox" MaxLength="10" Text="MM"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label" style="width: 220px"><span>测试项目</span></td>
            <td class="Field" style="width: 300px; text-align: center;"><b><span>测试项目1</span></b></td>
            <td class="Field" style="width: 300px; text-align: center;"><b><span>测试项目2</span></b> </td>
            <td class="Field" style="width: 300px; text-align: center;"><b><span>测试项目3</span></b> </td>
        </tr>
        <tr>
            <td class="Label">标准值<em>*</em></td>
            <td class="Field">
                <asp:TextBox ID="txtExternalDiameterMin" runat="server" CssClass="TextBox numbercheck" MaxLength="10" IsRequired="1" Text="0" IsNumber='1' Width="100" onblur="ExternalDiameterStandard(this)" ClientIDMode="Static"></asp:TextBox>
                ~
                <asp:TextBox ID="txtExternalDiameterMax" runat="server" CssClass="TextBox numbercheck" IsRequired="1" MaxLength="10" Text="0" IsNumber='1' Width="100" onblur="ExternalDiameterStandard(this)" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Field">
                <asp:TextBox ID="txtInternalDiameterMin" runat="server" CssClass="TextBox numbercheck" MaxLength="10" IsRequired="1" Text="0" IsNumber='1' Width="100" onblur="ExternalDiameterStandard(this)" ClientIDMode="Static"></asp:TextBox>
                ~
                <asp:TextBox ID="txtInternalDiameterMax" runat="server" CssClass="TextBox numbercheck" IsRequired="1" MaxLength="10" Text="0" IsNumber='1' Width="100" onblur="ExternalDiameterStandard(this)" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Field">
                <asp:TextBox ID="txtTestItemMin3" runat="server" CssClass="TextBox numbercheck" MaxLength="10" IsRequired="1" Text="0" IsNumber='1' Width="100" onblur="ExternalDiameterStandard(this)" ClientIDMode="Static"></asp:TextBox>
                ~
                <asp:TextBox ID="txtTestItemMax3" runat="server" CssClass="TextBox numbercheck" IsRequired="1" MaxLength="10" Text="0" IsNumber='1' Width="100" onblur="ExternalDiameterStandard(this)" ClientIDMode="Static"></asp:TextBox>
            </td>

        </tr>
        <tr>
            <td class="Label">测量值一</td>
            <td class="Field">
                <asp:TextBox ID="txtExternalDiameter1" runat="server" CssClass="TextBox numbercheck" MaxLength="100" Text="0" IsNumber='1' onblur="ExternalDiameter(this)"></asp:TextBox>
            </td>
            <td class="Field">
                <asp:TextBox ID="txtInternalDiameter1" runat="server" CssClass="TextBox numbercheck" Text="0" IsNumber='1' MaxLength="100" onblur="InternalDiameter(this)"></asp:TextBox></td>
            <td class="Field">
                <asp:TextBox ID="txtTestItem3_1" runat="server" CssClass="TextBox numbercheck" MaxLength="100" Text="0" IsNumber='1' onblur="TestItem3(this)"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label">测量值二</td>
            <td class="Field">
                <asp:TextBox ID="txtExternalDiameter2" runat="server" CssClass="TextBox numbercheck" MaxLength="100" Text="0" IsNumber='1' onblur="ExternalDiameter(this)"></asp:TextBox>
            </td>
            <td class="Field">
                <asp:TextBox ID="txtInternalDiameter2" runat="server" CssClass="TextBox numbercheck" Text="0" IsNumber='1' MaxLength="100" onblur="InternalDiameter(this)"></asp:TextBox></td>
            <td class="Field">
                <asp:TextBox ID="txtTestItem3_2" runat="server" CssClass="TextBox numbercheck" MaxLength="100" Text="0" IsNumber='1' onblur="TestItem3(this)"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label">测量值三</td>
            <td class="Field">
                <asp:TextBox ID="txtExternalDiameter3" runat="server" CssClass="TextBox numbercheck" MaxLength="100" Text="0" IsNumber='1' onblur="ExternalDiameter(this)"></asp:TextBox>
            </td>
            <td class="Field">
                <asp:TextBox ID="txtInternalDiameter3" runat="server" CssClass="TextBox numbercheck" Text="0" IsNumber='1' MaxLength="100" onblur="InternalDiameter(this)"></asp:TextBox></td>
            <td class="Field">
                <asp:TextBox ID="txtTestItem3_3" runat="server" CssClass="TextBox numbercheck" MaxLength="100" Text="0" IsNumber='1' onblur="TestItem3(this)"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label">平均值</td>
            <td class="Field">
                <asp:Label ID="lblExternalDiameterAvg" runat="server"></asp:Label>
            </td>
            <td class="Field">
                <asp:Label ID="lblInternalDiameterAvg" runat="server"></asp:Label></td>
            <td class="Field">
                <asp:Label ID="lblTestItem3Avg" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td class="Label">硬度<em>*</em></td>
            <td class="Field">
                <asp:TextBox ID="txtHardness" runat="server" CssClass="TextBox numbercheck" MaxLength="100" IsNumber='1' IsRequired="1"></asp:TextBox>
            </td>
            <td class="Label">判断</td>
            <td class="Field">
                <input type="radio" name="rdoResult" value="1" /><span>合格</span>
                <input type="radio" name="rdoResult" value="2" /><span>不合格</span>
            </td>
        </tr>
        <tr>
            <td class="Label">备注</td>
            <td class="Field" colspan="3">
                <asp:TextBox ID="txtRemark" ClientIDMode="Static" TextMode="MultiLine" CssClass="TextArea" runat="server" Height="60px" Width="80%"></asp:TextBox>
            </td>
        </tr>

    </table>
    <input type="hidden" id="hdParentEquipmentCode" />
    <asp:HiddenField ID="hdnIsHege" runat="server" Value="0" ClientIDMode="Static" />

    <script type="text/javascript">

        $(".numbercheck").keyup(function () {
            getDecimalVal(this);
        });

        var chooseFlag = -1;
        /*选择设备*/
        function selectMould() {

            //查询父类型=1 以及BomId 关联的设备
            var searchCondition = "  EquipmentTypeId =-4";
            chooseFlag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&SearchCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });

        }

        $(document).ready(function () {
            if (copy == "Copy") {
                msmId = -1;
                $("#<%=this.txtHardness.ClientID%>").val(0);

            }
            else {
                $("input[name='rdoResult'][value=" + $("#<%=this.hdnIsHege.ClientID%>").val() + "]").attr("checked", true);
            }

        });

        function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.txtMouldCode.ClientID %>").val(list[0][1]);

                $("#<%=this.hdnMouldId.ClientID %>").val(list[0][0]);
                GetMouldInfo(list[0][0]);

            }
        }
        function ExternalDiameterStandard(obj) {
            if (obj.value == "0" || obj.value == "") {
                return;
            }
            switch (obj.id) {
                case "txtExternalDiameterMin":
                    var txtExternalDiameterMax = $("#txtExternalDiameterMax").val();
                    if (txtExternalDiameterMax == "") {
                        $("#txtExternalDiameterMax").select();
                        return false;
                    }
                    if (parseFloat(obj.value) > parseFloat(txtExternalDiameterMax) && parseFloat(txtExternalDiameterMax) > 0) {
                        alert("输入的最小标准值不能大于外径最大值标准值！");
                        $("#txtExternalDiameterMin").val(0).select();
                        return false;
                    }
                    setResult();
                    break;
                case "txtExternalDiameterMax":
                    var txtExternalDiameterMin = $("#txtExternalDiameterMin").val();
                    if (parseFloat(obj.value) < parseFloat(txtExternalDiameterMin)) {
                        alert("输入的最小标准值不能大于外径最大值标准值！");
                        $("#txtExternalDiameterMax").val(0).select();
                        return false;
                    }
                    setResult();
                    break;
                case "txtInternalDiameterMin":
                    var txtInternalDiameterMax = $("#txtInternalDiameterMax").val();
                    if (txtInternalDiameterMax == "") {
                        $("#txtInternalDiameterMax").select();
                        return false;
                    }
                    if (parseFloat(obj.value) > parseFloat(txtInternalDiameterMax) && parseFloat(txtInternalDiameterMax) > 0) {
                        alert("输入的最小标准值不能大于最大值标准值！");
                        $("#txtInternalDiameterMin").val(0).select();
                        return false;
                    }
                    setResult();
                    break;
                case "txtInternalDiameterMax":
                    var txtInternalDiameterMin = $("#txtInternalDiameterMin").val();
                    if (parseFloat(obj.value) < parseFloat(txtInternalDiameterMin)) {
                        alert("输入的最小标准值不能大于最大值标准值！");
                        $("#txtInternalDiameterMax").val(0).select();
                        return false;
                    }
                    setResult();
                    break;
                case "txtTestItemMin3":
                    var txtTestItemMax3 = $("#txtTestItemMax3").val();
                    if (txtTestItemMax3 == "") {
                        $("#txtTestItemMax3").select();
                        return false;
                    }
                    if (parseFloat(obj.value) > parseFloat(txtTestItemMax3) && parseFloat(txtTestItemMax3) > 0) {
                        alert("输入的最小标准值不能大于最大值标准值！");
                        $("#txtTestItemMin3").val(0).select();
                        return false;
                    }
                    setResult();
                    break;
                case "txtTestItemMax3":
                    var txtTestItemMin3 = $("#txtTestItemMin3").val();
                    if (parseFloat(obj.value) < parseFloat(txtTestItemMin3)) {
                        alert("输入的最小标准值不能大于最大值标准值！");
                        $("#txtTestItemMax3").val(0).select();
                        return false;
                    }
                    setResult();
                    break;

            }
        }

        function ExternalDiameter(obj) {
            var txtExternalDiameterMin = $("#<%=this.txtExternalDiameterMin.ClientID%>").val();
             var txtExternalDiameterMax = $("#<%=this.txtExternalDiameterMax.ClientID%>").val();
             if (txtExternalDiameterMin == "") {
                 alert("请先输入外径标准值！");
                 $("#<%=this.txtExternalDiameterMin.ClientID%>").select();
                return;
            }
            if (txtExternalDiameterMax == "") {
                alert("请先输入外径标准值！");
                $("#<%=this.txtExternalDiameterMax.ClientID%>").select();
                return;
            }

            var txtExternalDiameter1 = parseFloat($("#<%=this.txtExternalDiameter1.ClientID%>").val());
             var txtExternalDiameter2 = parseFloat($("#<%=this.txtExternalDiameter2.ClientID%>").val());
             var txtExternalDiameter3 = parseFloat($("#<%=this.txtExternalDiameter3.ClientID%>").val());

             var txtExternalDiameterAvg = parseFloat(((txtExternalDiameter1 + txtExternalDiameter2 + txtExternalDiameter3) / 3).toFixed(2));
             $("#<%=this.lblExternalDiameterAvg.ClientID%>").text(txtExternalDiameterAvg);

            setResult();
        }
        function InternalDiameter(obj) {
            var txtInternalDiameterMin = $("#<%=this.txtInternalDiameterMin.ClientID%>").val();
            var txtInternalDiameterMax = $("#<%=this.txtInternalDiameterMax.ClientID%>").val();
            if (txtInternalDiameterMin == "") {
                alert("请先输入标准值！");
                $("#<%=this.txtInternalDiameterMin.ClientID%>").select();
                $(obj).val(0);
                return;
            }
            if (txtInternalDiameterMax == "") {
                alert("请先输入标准值！");
                $("#<%=this.txtInternalDiameterMax.ClientID%>").select();
                $(obj).val(0);
                return;
            }
            var txtInternalDiameter1 = parseFloat($("#<%=this.txtInternalDiameter1.ClientID%>").val());
            var txtInternalDiameter2 = parseFloat($("#<%=this.txtInternalDiameter2.ClientID%>").val());
            var txtInternalDiameter3 = parseFloat($("#<%=this.txtInternalDiameter3.ClientID%>").val());

            var txtInternalDiameterAvg = parseFloat(((txtInternalDiameter1 + txtInternalDiameter2 + txtInternalDiameter3) / 3).toFixed(2));
            $("#<%=this.lblInternalDiameterAvg.ClientID%>").text(txtInternalDiameterAvg);
            setResult();
        }

        function TestItem3(obj) {
            var txtTestItemMin3 = $("#<%=this.txtTestItemMin3.ClientID%>").val();
            var txtTestItemMax3 = $("#<%=this.txtTestItemMax3.ClientID%>").val();
            if (txtTestItemMin3 == "") {
                alert("请先输入标准值！");
                $("#<%=this.txtTestItemMin3.ClientID%>").select();
                $(obj).val(0);
                return;
            }
            if (txtTestItemMax3 == "") {
                alert("请先输入标准值！");
                $("#<%=this.txtTestItemMax3.ClientID%>").select();
                $(obj).val(0);
                return;
            }
            var txtTestItem3_1 = parseFloat($("#<%=this.txtTestItem3_1.ClientID%>").val());
            var txtTestItem3_2 = parseFloat($("#<%=this.txtTestItem3_2.ClientID%>").val());
            var txtTestItem3_3 = parseFloat($("#<%=this.txtTestItem3_3.ClientID%>").val());

            var lblTestItem3Avg = parseFloat(((txtTestItem3_1 + txtTestItem3_2 + txtTestItem3_3) / 3).toFixed(2));
            $("#<%=this.lblTestItem3Avg.ClientID%>").text(lblTestItem3Avg);
            setResult();
        }

        function setResult() {
            var txtInternalDiameterMin = $("#<%=this.txtInternalDiameterMin.ClientID%>").val();
            var txtInternalDiameterMax = $("#<%=this.txtInternalDiameterMax.ClientID%>").val();
            var txtInternalDiameterAvg = parseFloat($("#<%=this.lblInternalDiameterAvg.ClientID%>").text());

            if (!isNaN(txtInternalDiameterAvg)) {
                if (txtInternalDiameterAvg < parseFloat(txtInternalDiameterMin) || txtInternalDiameterAvg > parseFloat(txtInternalDiameterMax)) {
                    $("input[type='radio'][name='rdoResult'][value='2']").prop("checked", true);
                    return;
                }
                else {
                    $("input[type='radio'][name='rdoResult'][value='1']").prop("checked", true);

                }
            }

            var txtExternalDiameterMin = $("#<%=this.txtExternalDiameterMin.ClientID%>").val();
            var txtExternalDiameterMax = $("#<%=this.txtExternalDiameterMax.ClientID%>").val();
            var txtExternalDiameterAvg = parseFloat($("#<%=this.lblExternalDiameterAvg.ClientID%>").text());
            if (!isNaN(txtExternalDiameterAvg)) {
                if (txtExternalDiameterAvg < parseFloat(txtExternalDiameterMin) || txtExternalDiameterAvg > parseFloat(txtExternalDiameterMax)) {
                    $("input[type='radio'][name='rdoResult'][value='2']").prop("checked", true);
                    return;
                }
                else {
                    $("input[type='radio'][name='rdoResult'][value='1']").prop("checked", true);
                }
            }

            var txtTestItemMin3 = $("#<%=this.txtTestItemMin3.ClientID%>").val();
            var txtTestItemMax3 = $("#<%=this.txtTestItemMax3.ClientID%>").val();
            var txtTestItemMaxAvg3 = parseFloat($("#<%=this.lblTestItem3Avg.ClientID%>").text());
            if (!isNaN(txtTestItemMaxAvg3)) {
                if (txtTestItemMaxAvg3 < parseFloat(txtTestItemMin3) || txtTestItemMaxAvg3 > parseFloat(txtTestItemMax3)) {
                    $("input[type='radio'][name='rdoResult'][value='2']").prop("checked", true);
                    return;
                }
                else {
                    $("input[type='radio'][name='rdoResult'][value='1']").prop("checked", true);
                }
            }
        }

        function GetMouldInfo(mouldId) {
            var result = SKT.LeanMES.Web.Equipment.MouldSizeEdit.GetMouldInfo(mouldId);
            if (result.error != null) {
                alert(result.error.Message);
                return false;
            }
            $("#<%=this.lblBomName.ClientID%>").text(result.value.EquipmentName);
            $("#<%=this.lblMouldTypeName.ClientID%>").text(result.value.ComponentName);
            return result;
        }

        var msmId = '<%=Request.QueryString["ID"]%>';
        var copy = '<%=Request.QueryString["action"]%>';
        /*保存数据*/
        function Save() {

            <%-- var txtFName = $.trim($("#<%=this.txt.ClientID%>").val());
            var txtFcode = $.trim($("#<%=this.txtFcode.ClientID%>").val());--%>
            <%-- var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());--%>
            if (!SubmitValidation()) {
                return false;
            }

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var remark = $.trim($("#txtRemark").val());
            var txtInternalDiameterMin = $("#<%=this.txtInternalDiameterMin.ClientID%>").val();
            var txtInternalDiameterMax = $("#<%=this.txtInternalDiameterMax.ClientID%>").val();
            var txtExternalDiameterMin = $("#<%=this.txtExternalDiameterMin.ClientID%>").val();
            var txtExternalDiameterMax = $("#<%=this.txtExternalDiameterMax.ClientID%>").val();
            var txtTestItemMin3 = $("#<%=this.txtTestItemMin3.ClientID%>").val();
            var txtTestItemMax3 = $("#<%=this.txtTestItemMax3.ClientID%>").val();
            var txtUnits = $("#<%=this.txtUnits.ClientID%>").val();

            var entity = {};
            entity.MsmId = msmId;
            entity.MouldId = $("#<%=this.hdnMouldId.ClientID%>").val();
            entity.MouldBomId = -1;
            entity.MouldTypeId = -1;
            entity.ExternalDiameter1 = parseFloat($("#<%=this.txtExternalDiameter1.ClientID%>").val());
            entity.ExternalDiameter2 = parseFloat($("#<%=this.txtExternalDiameter2.ClientID%>").val());
            entity.ExternalDiameter3 = parseFloat($("#<%=this.txtExternalDiameter3.ClientID%>").val());
            entity.ExternalDiameterAvg = isNaN(parseFloat($("#<%=this.lblExternalDiameterAvg.ClientID%>").text())) ? 0 : parseFloat($("#<%=this.lblExternalDiameterAvg.ClientID%>").text());
            entity.InternalDiameter1 = parseFloat($("#<%=this.txtInternalDiameter1.ClientID%>").val());
            entity.InternalDiameter2 = parseFloat($("#<%=this.txtInternalDiameter2.ClientID%>").val());
            entity.InternalDiameter3 = parseFloat($("#<%=this.txtInternalDiameter3.ClientID%>").val());
            entity.InternalDiameterAvg = isNaN(parseFloat($("#<%=this.lblInternalDiameterAvg.ClientID%>").text())) ? 0 : parseFloat($("#<%=this.lblInternalDiameterAvg.ClientID%>").text());
            entity.Hardness = $("#<%=this.txtHardness.ClientID%>").val();
            entity.Result = $("input[name='rdoResult']:checked").val();
            entity.CreateBy = txtCreateBy;
            entity.Remark = remark;
            entity.InternalDiameterMin = parseFloat(txtInternalDiameterMin);
            entity.InternalDiameterMax = parseFloat(txtInternalDiameterMax);
            entity.ExternalDiameterMin = parseFloat(txtExternalDiameterMin);
            entity.ExternalDiameterMax = parseFloat(txtExternalDiameterMax);

            entity.TestItem3_1 = parseFloat($("#<%=this.txtTestItem3_1.ClientID%>").val());
            entity.TestItem3_2 = parseFloat($("#<%=this.txtTestItem3_2.ClientID%>").val());
            entity.TestItem3_3 = parseFloat($("#<%=this.txtTestItem3_3.ClientID%>").val());
            entity.TestItem3Avg = isNaN(parseFloat($("#<%=this.lblTestItem3Avg.ClientID%>").text())) ? 0 : parseFloat($("#<%=this.lblTestItem3Avg.ClientID%>").text());
            entity.TestItem3Min = parseFloat(txtTestItemMin3);
            entity.TestItem3Max = parseFloat(txtTestItemMax3);
            entity.Units = txtUnits;
            var ajax = SKT.LeanMES.Web.Equipment.MouldSizeEdit.Edit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.UpdateList($("#<%=this.txtMouldCode.ClientID%>").val());

        }


    </script>
</asp:Content>
