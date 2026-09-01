<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="WarningEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warning.WarningEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">

        <tr>
            <td class="Label2">
                <%= Resources.lang.WarningName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWarningName" runat="server" CssClass="TextBox" IsRequired="1" MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.WarningType%><em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlWarningGroup" runat="server" IsRequired="1">
                    <asp:ListItem Text="<%$ Resources:Enum, Choose %>" Value=""></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, SystemWarning %>" Value="1"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, ManufactureWarning %>" Value="2"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, QualityWarning %>" Value="3"></asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="ddlWarningType" runat="server" IsRequired="1" ClientIDMode="Static">
                    <asp:ListItem Text="<%$ Resources:Enum, Choose %>" Value=""></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarningDesc %><em>*</em>
            </td>
            <td colspan="3" class="Field2">
                <asp:TextBox ID="txtWarningDesc" runat="server" CssClass="TextBox" IsRequired="1" Width="400"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">线别 
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLine" runat="server" CssClass="TextBox" MaxLength="50" ReadOnly="true"></asp:TextBox><input type="button" class="ButtonBox" value="..." onclick="selectLine(21)" />
                <asp:HiddenField ID="txtLineId" runat="server" Value="-1" />
            </td>
            <td class="Label2" id="txtRatio">警报预警值<em>*</em>
            </td>
            <td class="Field2" id="txtRatioValue">
                <%--<asp:TextBox ID="txtWarningVal" runat="server" IsRequired="1"  ClientIDMode="Static"></asp:TextBox>--%>
                <asp:Label ID="lblWarningVal" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr style="display: none">
            <td class="Label2">
                <%= Resources.lang.WarningLevel %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWarningLevel" runat="server" CssClass="TextBox" IsNumber="1" MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.CycleType %><em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlCycleType" runat="server">
                    <asp:ListItem Text="<%$ Resources:Enum, Choose %>" Value=""></asp:ListItem>
                    <asp:ListItem Text="By Count" Value="0"></asp:ListItem>
                    <asp:ListItem Text="By Minute" Value="1"></asp:ListItem>
                    <asp:ListItem Text="By Hours" Value="2"></asp:ListItem>
                    <asp:ListItem Text="By Day" Value="3"></asp:ListItem>
                    <asp:ListItem Text="By Week" Value="4"></asp:ListItem>
                    <asp:ListItem Text="By Month" Value="5"></asp:ListItem>
                    <asp:ListItem Text="By Year" Value="6"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr style="display: none">
            <td class="Label2">
                <%= Resources.lang.CycleTime %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCycleTime" runat="server" CssClass="TextBox" IsNumber="1" MaxLength="50"></asp:TextBox><asp:Label ID="labCycleTime" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.PreWarning %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPreWarning" runat="server" CssClass="TextBox" IsNumber="1" MaxLength="50"></asp:TextBox><asp:Label ID="labPreWarning" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.MessageType %><em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlMessageType" runat="server" IsRequired="1">
                    <asp:ListItem Text="<%$ Resources:Enum, Choose %>" Value=""></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, SMS %>" Value="1"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, Email %>" Value="2" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, Whistle %>" Value="3"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, WeChat %>" Value="4"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, DingTalk %>" Value="5"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">基准值
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRatioNum" runat="server" Text="0" Width="80" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">一级接收人
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRecipientLevel1" runat="server" CssClass="TextBox" ReadOnly="true" IsRequired="1" Width="180" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" value="..." onclick="selectFirst();" />
                <asp:HiddenField ID="hdfValue1" runat="server" ClientIDMode="Static" />
                <div style="clear: both;"></div>
                <asp:Label ID="lblRecipientLevel1" ClientIDMode="Static" runat="server" Style="width: 300px;"></asp:Label>
                <asp:HiddenField ID="hidRecipientLevel1" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label2">一级操作间隔<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtIntervalTime1" runat="server" CssClass="TextBox" Width="80" IsRequired="1" IsNumber="1" MaxLength="50"></asp:TextBox>&nbsp;Minutes                 
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ReceiveContent1 %><em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtReceiveContent1" runat="server" CssClass="TextBox" IsRequired="1" Width="400"></asp:TextBox>
            </td>
        </tr>
        <tr style="display: none">
            <td class="Label2">一级解决方案
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtSolution1" runat="server" CssClass="TextBox" Width="400"></asp:TextBox>&nbsp;批注时填写<em>*</em>
                <asp:HiddenField ID="hidResolve1" Value="0" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.RecipientLevel2 %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRecipientLevel2" runat="server" CssClass="TextBox" ReadOnly="true"  Width="180" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" value="..." onclick="selectSecond();" />
                <asp:HiddenField ID="hdfValue2" runat="server" ClientIDMode="Static" />
                <div style="clear: both;"></div>
                <asp:Label ID="lblRecipientLevel2" ClientIDMode="Static" runat="server" Style="width: 300px;"></asp:Label>
                <asp:HiddenField ID="hidRecipientLevel2" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label2">二级操作间隔
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtIntervalTime2" runat="server" CssClass="TextBox" Width="80"  IsNumber="1" MaxLength="50"></asp:TextBox>&nbsp;Minutes               
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ReceiveContent2 %>
            </td>
            <td class="Field3" colspan="3">
                <asp:TextBox ID="txtReceiveContent2" runat="server" CssClass="TextBox"  Width="400"></asp:TextBox>
            </td>
        </tr>
        <tr style="display: none">
            <td class="Label2">二级解决方案
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtSolution2" runat="server" CssClass="TextBox" Width="400"></asp:TextBox>&nbsp;批注时填写<em>*</em>
                <asp:HiddenField ID="hidResolve2" Value="0" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.RecipientLevel3 %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRecipientLevel3" runat="server" CssClass="TextBox" Width="300" ReadOnly="true" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" value="..." onclick="selectThird();" />
                <asp:HiddenField ID="hdfValue3" runat="server" ClientIDMode="Static" />
                <div style="clear: both;"></div>
                <asp:Label ID="lblRecipientLevel3" ClientIDMode="Static" runat="server" Style="width: 300px;"></asp:Label>
                <asp:HiddenField ID="hidRecipientLevel3" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ReceiveContent3 %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtReceiveContent3" runat="server" CssClass="TextBox" Width="400"></asp:TextBox>
            </td>
        </tr>
        <tr style="display: none">
            <td class="Label2">三级解决方案
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtSolution3" runat="server" CssClass="TextBox" Width="400"></asp:TextBox>&nbsp;批注时填写<em>*</em>
                <asp:HiddenField ID="hidResolve3" Value="0" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field3" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox" TextMode="MultiLine" Height="60px" Columns="65" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var warningId = '<%=Request.QueryString["ID"]%>';
        var warningType = 0;
        var WarningTypeValue = '<%=warningType %>';
        $(function () {
            $("#<%=this.txtRatioNum.ClientID%>").keyup(function () {
                getIntVal(this);
            });
            $("#ddlWarningType").change(function () {
                if (this.value == "") {
                    $("#<%=this.lblWarningVal.ClientID%>").text("");
                    return;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarning.GetWraningVal(this.value);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                $("#<%=this.lblWarningVal.ClientID%>").text(ajax.value);
            });
        });

        /*保存数据*/
        function Save() {
            var txtWarningName = $.trim($("#<%=this.txtWarningName.ClientID%>").val());
            var ddlWarningGroup = $.trim($("#<%=this.ddlWarningGroup.ClientID%>").val());
            var ddlWarningType = $.trim($("#<%=this.ddlWarningType.ClientID%>").val());
            var txtWarningDesc = $.trim($("#<%=this.txtWarningDesc.ClientID%>").val());

          /*var txtWarningLevel = $.trim($("#<%=this.txtWarningLevel.ClientID%>").val());
            var ddlCycleType = $.trim($("#<%=this.ddlCycleType.ClientID%>").val());
            var txtCycleTime = $.trim($("#<%=this.txtCycleTime.ClientID%>").val());
            var txtPreWarning = $.trim($("#<%=this.txtPreWarning.ClientID%>").val());*/

            var txtRatioNum = $.trim($("#<%=this.txtRatioNum.ClientID%>").val());
            var ddlMessageType = $.trim($("#<%=this.ddlMessageType.ClientID%>").val());
            var txtRecipientLevel1 = $.trim($("#<%=this.txtRecipientLevel1.ClientID%>").val());
            var hdfRecipientLevel1 = $.trim($("#<%=this.hdfValue1.ClientID%>").val());
            var txtReceiveContent1 = $.trim($("#<%=this.txtReceiveContent1.ClientID%>").val());
            var txtRecipientLevel2 = $.trim($("#<%=this.txtRecipientLevel2.ClientID%>").val());
            var hdfRecipientLevel2 = $.trim($("#<%=this.hdfValue2.ClientID%>").val());
            var txtReceiveContent2 = $.trim($("#<%=this.txtReceiveContent2.ClientID%>").val());
            var txtRecipientLevel3 = $.trim($("#<%=this.txtRecipientLevel3.ClientID%>").val());
            var hdfRecipientLevel3 = $.trim($("#<%=this.hdfValue3.ClientID%>").val());
            var txtReceiveContent3 = $.trim($("#<%=this.txtReceiveContent3.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtWarningVal = $.trim($("#<%=this.lblWarningVal.ClientID%>").text());
            //新增字段 add by peter on 2017-2-9
            var txtLineId = $.trim($("#<%=this.txtLineId.ClientID%>").val());
            var ddlNcNum = 0;
            var ddlRatio = 0;
            var txtIntervalTime1 = $.trim($("#<%=this.txtIntervalTime1.ClientID%>").val());
            var txtIntervalTime2 = $.trim($("#<%=this.txtIntervalTime2.ClientID%>").val());
            var txtSolution1 = $.trim($("#<%=this.txtSolution1.ClientID%>").val());
            var hidResolve1 = $.trim($("#<%=this.hidResolve1.ClientID%>").val());
            if (txtSolution1 != "") {
                hidResolve1 = 1;
            }
            var txtSolution2 = $.trim($("#<%=this.txtSolution2.ClientID%>").val());
            var hidResolve2 = $.trim($("#<%=this.hidResolve2.ClientID%>").val());
            if (txtSolution2 != "") {
                hidResolve2 = 1;
            }
            var txtSolution3 = $.trim($("#<%=this.txtSolution3.ClientID%>").val());
            var hidResolve3 = $.trim($("#<%=this.hidResolve3.ClientID%>").val());
            if (txtSolution3 != "") {
                hidResolve3 = 1;
            }
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};

            entity.WarningId = warningId;
            entity.WarningName = txtWarningName;
            entity.WarningGroup = ddlWarningGroup;
            entity.WarningType = ddlWarningType;
            entity.WarningDesc = txtWarningDesc;

            //entity.WarningLevel = txtWarningLevel;
            //entity.CycleType = ddlCycleType;
            //entity.CycleTime = txtCycleTime;
            //entity.PreWarning = txtPreWarning;
            //entity.ExecProcedures = txtExecProcedures;

            entity.MessageType = ddlMessageType;
            entity.RecipientLevel1 = hdfRecipientLevel1;
            entity.ReceiveContent1 = txtReceiveContent1;
            entity.RecipientLevel2 = hdfRecipientLevel2;
            entity.ReceiveContent2 = txtReceiveContent2;
            entity.RecipientLevel3 = hdfRecipientLevel3;
            entity.ReceiveContent3 = txtReceiveContent3;
            entity.Remark = txtRemark;

            entity.NcNum = parseInt(ddlNcNum);
            entity.Ratio = parseInt(ddlRatio);
            entity.LineId = parseInt(txtLineId);
            entity.IntervalTime1 = parseInt(txtIntervalTime1);
            entity.IntervalTime2 = parseInt(txtIntervalTime2);
            entity.Solution1 = txtSolution1;
            entity.Solve1 = hidResolve1;
            entity.Solution2 = txtSolution2;
            entity.Solve2 = hidResolve2;
            entity.Solution3 = txtSolution3;
            entity.Solve3 = hidResolve3;
            entity.RatioNum = txtRatioNum;
            entity.WarningVal = txtWarningVal == "" ? 0 : parseFloat(txtWarningVal);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarning.WarningEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warning/WarningEdit.aspx?name=Quality_WarningEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            } else {
                parent.window.Refresh();
            }
        }

        // 据周期类型显示相应的单位
        $("#<%= this.ddlCycleType.ClientID %>").change(function () {
            var type = $("#<%= this.ddlCycleType.ClientID %> option:selected").val();
            switch (type) {
                case "0":
                    $("#<%= this.labPreWarning.ClientID %>").text("");
                    $("#<%= this.labCycleTime.ClientID %>").text("");
                    break;
                case "1":
                    $("#<%= this.labPreWarning.ClientID %>").text("Minute");
                    $("#<%= this.labCycleTime.ClientID %>").text("Minute");
                    break;
                case "2":
                    $("#<%= this.labPreWarning.ClientID %>").text("Hours");
                    $("#<%= this.labCycleTime.ClientID %>").text("Hours");
                    break;
                case "3":
                    $("#<%= this.labPreWarning.ClientID %>").text("Day");
                    $("#<%= this.labCycleTime.ClientID %>").text("Day");
                    break;
                case "4":
                    $("#<%= this.labPreWarning.ClientID %>").text("Week");
                    $("#<%= this.labCycleTime.ClientID %>").text("Week");
                    break;
                case "5":
                    $("#<%= this.labPreWarning.ClientID %>").text("Month");
                    $("#<%= this.labCycleTime.ClientID %>").text("Month");
                    break;
                case "6":
                    $("#<%= this.labPreWarning.ClientID %>").text("Year");
                    $("#<%= this.labCycleTime.ClientID %>").text("Year");
                    break;
                default:
                    $("#<%= this.labPreWarning.ClientID %>").text("");
                    $("#<%= this.labCycleTime.ClientID %>").text("");
                    break;
            }
        });


        var temp = "";
        function selectFirst() {
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=true&rnd=" + Math.random(), width: 680, height: 300 });
        }
        function selectSecond() {
            temp = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=true&rnd=" + Math.random(), width: 680, height: 300 });
        }
        function selectThird() {
            temp = 3;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=true&rnd=" + Math.random(), width: 680, height: 300 });
        }

        var flag = 0;
        function selectLine(pageId) {
            flag = pageId;
            temp = 4;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flag + "&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }
        function getChooseValue(list) {
            if (temp == 1) {
                var RecipientLevelNames = "", RecipientLevelIds = "";
                if (list[0][0] > 0) {
                    for (var i = 0; i < list.length; i++) {
                        if (!IsHaveRecipientLevel($("#hdfValue1").val(), list[i][0])) {
                            RecipientLevelNames += (list[i][3].trim().length > 0 ? list[i][3].trim() : list[i][4].trim()) + ",";
                            RecipientLevelIds += list[i][0] + ",";
                        }
                    }
                    if (RecipientLevelNames == "") {
                        return;
                    }
                    RecipientLevelNames = RecipientLevelNames.substring(0, RecipientLevelNames.length - 1);
                    RecipientLevelIds = RecipientLevelIds.substring(0, RecipientLevelIds.length - 1);

                    if ($("#hdfValue1").val() != "") {
                        RecipientLevelIds = $("#hdfValue1").val() + "," + RecipientLevelIds;
                    }
                    //$("#txtRecipientLevel1").val(RecipientLevelNames);
                    $("#hdfValue1").val(RecipientLevelIds);

                    if ($("#hidRecipientLevel1").val() != "") {
                        $("#hidRecipientLevel1").val($("#hidRecipientLevel1").val() + "," + RecipientLevelNames);
                    }
                    else {
                        $("#hidRecipientLevel1").val(RecipientLevelNames);
                    }
                    if ($("#txtRecipientLevel1").val() != "") {
                        $("#txtRecipientLevel1").val($("#txtRecipientLevel1").val() + "," + RecipientLevelNames);
                    }
                    else {
                        $("#txtRecipientLevel1").val(RecipientLevelNames);
                    }
                    var list = "";
                    var RecipientLevelNamesList = RecipientLevelNames.split(",");
                    for (var i = 0; i < RecipientLevelNamesList.length; i++) {
                        list = list + RecipientLevelNamesList[i] + "<br/>";
                    }
                    list = $("#lblRecipientLevel1").html() + list;
                    //$("#lblRecipientLevel1").html(list); 
                    SetRecipientLevel1();
                }
                else {
                    $("#txtRecipientLevel1").val("");
                    $("#hdfValue1").val("");
                    $("#lblRecipientLevel1").html("");
                    $("#hidRecipientLevel1").val("")
                }
            }
            else if (temp == 2) {
                var RecipientLevelNames2 = "", RecipientLevelIds2 = "";
                if (list[0][0] > 0) {
                    for (var i = 0; i < list.length; i++) {
                        if (!IsHaveRecipientLevel($("#hdfValue2").val(), list[i][0])) {
                            RecipientLevelNames2 += (list[i][3].trim().length > 0 ? list[i][3].trim() : list[i][4].trim()) + ",";
                            RecipientLevelIds2 += list[i][0] + ",";
                        }
                    }
                    if (RecipientLevelNames2 == "") {
                        return;
                    }
                    RecipientLevelNames2 = RecipientLevelNames2.substring(0, RecipientLevelNames2.length - 1);
                    RecipientLevelIds2 = RecipientLevelIds2.substring(0, RecipientLevelIds2.length - 1);

                    if ($("#hdfValue2").val() != "") {
                        RecipientLevelIds2 = $("#hdfValue2").val() + "," + RecipientLevelIds2;
                    }
                    //$("#txtRecipientLevel2").val(RecipientLevelNames2);
                    $("#hdfValue2").val(RecipientLevelIds2);

                    if ($("#hidRecipientLevel2").val() != "") {
                        $("#hidRecipientLevel2").val($("#hidRecipientLevel2").val() + "," + RecipientLevelNames2);
                    }
                    else {
                        $("#hidRecipientLevel2").val(RecipientLevelNames2);
                    }
                    if ($("#txtRecipientLevel2").val() != "") {
                        $("#txtRecipientLevel2").val($("#txtRecipientLevel2").val() + "," + RecipientLevelNames2);
                    }
                    else {
                        $("#txtRecipientLevel2").val(RecipientLevelNames2);
                    }
                    var list2 = "";
                    var RecipientLevelNamesList2 = RecipientLevelNames2.split(",");
                    for (var i = 0; i < RecipientLevelNamesList2.length; i++) {
                        list2 = list2 + RecipientLevelNamesList2[i] + "<br/>";
                    }
                    list2 = $("#lblRecipientLevel2").html() + list2;
                    //$("#lblRecipientLevel2").html(list2); 
                    SetRecipientLevel2();
                }
                else {
                    $("#txtRecipientLevel2").val("");
                    $("#hdfValue2").val("");
                    $("#lblRecipientLevel2").html("");
                    $("#hidRecipientLevel2").val("");
                }
            }
            else if (temp == 3) {

                var RecipientLevelNames3 = "", RecipientLevelIds3 = "";
                if (list[0][0] > 0) {
                    for (var i = 0; i < list.length; i++) {
                        if (!IsHaveRecipientLevel($("#hdfValue3").val(), list[i][0])) {
                            RecipientLevelNames3 += (list[i][3].trim().length > 0 ? list[i][3].trim() : list[i][4].trim()) + ",";
                            RecipientLevelIds3 += list[i][0] + ",";
                        }
                    }
                    if (RecipientLevelNames3 == "") {
                        return;
                    }
                    RecipientLevelNames3 = RecipientLevelNames3.substring(0, RecipientLevelNames3.length - 1);
                    RecipientLevelIds3 = RecipientLevelIds3.substring(0, RecipientLevelIds3.length - 1);

                    if ($("#hdfValue3").val() != "") {
                        RecipientLevelIds3 = $("#hdfValue3").val() + "," + RecipientLevelIds3;
                    }
                    //$("#txtRecipientLevel3").val(RecipientLevelNames3);
                    $("#hdfValue3").val(RecipientLevelIds3);

                    if ($("#hidRecipientLevel3").val() != "") {
                        $("#hidRecipientLevel3").val($("#hidRecipientLevel3").val() + "," + RecipientLevelNames3);
                    }
                    else {
                        $("#hidRecipientLevel3").val(RecipientLevelNames3);
                    }
                    if ($("#txtRecipientLevel3").val() != "") {
                        $("#txtRecipientLevel3").val($("#txtRecipientLevel3").val() + "," + RecipientLevelNames3);
                    }
                    else {
                        $("#txtRecipientLevel3").val(RecipientLevelNames3);
                    }
                    var list3 = "";
                    var RecipientLevelNamesList3 = RecipientLevelNames3.split(",");
                    for (var i = 0; i < RecipientLevelNamesList3.length; i++) {
                        list3 = list3 + RecipientLevelNamesList3[i] + "<br/>";
                    }
                    list3 = $("#lblRecipientLevel3").html() + list3;
                    //$("#lblRecipientLevel3").html(list3); 
                    SetRecipientLevel3();
                }
                else {
                    $("#txtRecipientLevel3").val("");
                    $("#hdfValue3").val("");
                    $("#lblRecipientLevel3").html("");
                    $("#hidRecipientLevel3").val("");
                }
            }
            else if (temp == 4) {
                $("#<%=this.txtLine.ClientID %>").val(list[0][1]);
                $("#<%=this.txtLineId.ClientID %>").val(list[0][0]);
            }
        }

        //是否存在
        function IsHaveRecipientLevel(hidRecipientLevel, value) {
            var fa = false;
            var hidRecipientLevellist = hidRecipientLevel.split(',');
            for (var i = 0; i < hidRecipientLevellist.length; i++) {
                if (hidRecipientLevellist[i] == value) {
                    fa = true;
                }
            }
            return fa;
        }

        //获取一级接收人
        function SetRecipientLevel1() {
            var RecipientLevelArr = $("#hidRecipientLevel1").val().split(",");
            var lblRecipientLevelName = "";

            for (var i = 0; i < RecipientLevelArr.length; i++) {
                if (RecipientLevelArr[i] != "") {
                    if (RecipientLevelArr[i] > 5) {
                        lblRecipientLevelName = lblRecipientLevelName + "<span >" + RecipientLevelArr[i] + "&nbsp;<img onclick=\"DeleteRecipientLevel1(this," + i +");\" src='<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/delete.gif' style='cursor:pointer;' /><br></span>";
                   }
                   else {
                       lblRecipientLevelName = lblRecipientLevelName + "<span >" + RecipientLevelArr[i] + "&nbsp;<img onclick=\"DeleteRecipientLevel1(this," + i +");\" src='<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/delete.gif' style='cursor:pointer;' /></span>";
                    }
                }
            }
            $("#lblRecipientLevel1").html(lblRecipientLevelName);
        }

        //删除一级接收人
        function DeleteRecipientLevel1(spanObj, index) {
            $(spanObj).parent().remove();
            var RecipientLevelIdArr = $("#hdfValue1").val().split(",");
            var RecipientLevelArr = $("#hidRecipientLevel1").val().split(",");
            RecipientLevelIdArr.splice(index, 1);
            RecipientLevelArr.splice(index, 1);

            $("#hdfValue1").val(RecipientLevelIdArr.join(","));
            $("#hidRecipientLevel1,#txtRecipientLevel1").val(RecipientLevelArr.join(","));
            SetRecipientLevel1();
        }

        //获取二级接收人
        function SetRecipientLevel2() {
            var RecipientLevelArr2 = $("#hidRecipientLevel2").val().split(",");
            var lblRecipientLevelName2 = "";

            for (var i = 0; i < RecipientLevelArr2.length; i++) {
                if (RecipientLevelArr2[i] != "") {
                    if (RecipientLevelArr2[i] > 5) {
                        lblRecipientLevelName2 = lblRecipientLevelName2 + "<span >" + RecipientLevelArr2[i] + "&nbsp;<img onclick=\"DeleteRecipientLevel2(this," + i +");\" src='<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/delete.gif' style='cursor:pointer;' /><br></span>";
                   }
                   else {
                       lblRecipientLevelName2 = lblRecipientLevelName2 + "<span >" + RecipientLevelArr2[i] + "&nbsp;<img onclick=\"DeleteRecipientLevel2(this," + i +");\" src='<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/delete.gif' style='cursor:pointer;' /></span>";
                    }
                }
            }
            $("#lblRecipientLevel2").html(lblRecipientLevelName2);
        }

        //删除二级接收人
        function DeleteRecipientLevel2(spanObj, index) {
            $(spanObj).parent().remove();
            var RecipientLevelIdArr2 = $("#hdfValue2").val().split(",");
            var RecipientLevelArr2 = $("#hidRecipientLevel2").val().split(",");
            RecipientLevelIdArr2.splice(index, 1);
            RecipientLevelArr2.splice(index, 1);

            $("#hdfValue2").val(RecipientLevelIdArr2.join(","));
            $("#hidRecipientLevel2,#txtRecipientLevel2").val(RecipientLevelArr2.join(","));
            SetRecipientLevel2();
        }

        //获取三级接收人
        function SetRecipientLevel3() {
            var RecipientLevelArr3 = $("#hidRecipientLevel3").val().split(",");
            var lblRecipientLevelName3 = "";

            for (var i = 0; i < RecipientLevelArr3.length; i++) {
                if (RecipientLevelArr3[i] != "") {
                    if (RecipientLevelArr3[i] > 5) {
                        lblRecipientLevelName3 = lblRecipientLevelName3 + "<span >" + RecipientLevelArr3[i] + "&nbsp;<img onclick=\"DeleteRecipientLevel3(this," + i +");\" src='<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/delete.gif' style='cursor:pointer;' /><br></span>";
                   }
                   else {
                       lblRecipientLevelName3 = lblRecipientLevelName3 + "<span >" + RecipientLevelArr3[i] + "&nbsp;<img onclick=\"DeleteRecipientLevel3(this," + i +");\" src='<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/delete.gif' style='cursor:pointer;' /></span>";
                    }
                }
            }
            $("#lblRecipientLevel3").html(lblRecipientLevelName3);
        }

        //删除三级接收人
        function DeleteRecipientLevel3(spanObj, index) {
            $(spanObj).parent().remove();
            var RecipientLevelIdArr3 = $("#hdfValue3").val().split(",");
            var RecipientLevelArr3 = $("#hidRecipientLevel3").val().split(",");
            RecipientLevelIdArr3.splice(index, 1);
            RecipientLevelArr3.splice(index, 1);

            $("#hdfValue3").val(RecipientLevelIdArr3.join(","));
            $("#hidRecipientLevel3,#txtRecipientLevel3").val(RecipientLevelArr3.join(","));
            SetRecipientLevel3();
        }

        function chooseRecipients(list, hdfValue, txtRecipientLevel) {
            var hidId = "", txtValue = "";
            for (var i = 0; i < list.length; i++) {
                if (hidId == "") {
                    hidId += list[i][0];
                    txtValue += list[i][2];
                } else {
                    hidId += "," + list[i][0];
                    txtValue += "," + list[i][2];
                }
            }
            hdfValue.val(hidId);
            txtRecipientLevel.val(txtValue);
        }

        $(function () {
            //警报分组选择事件
            $('#<%= this.ddlWarningGroup.ClientID %>').change(function () {
                loadWarningType($(this).val());
            });

            //根据初始警报分组值加载警报类型列表
            loadWarningType($('#<%= this.ddlWarningGroup.ClientID %>').val());
        });

        //根据警报分组值加载警报类型列表
        function loadWarningType(groupId) {
            var options = '<option value=""><%= Resources.Enum.Choose %></option>';
            $('#<%= this.ddlWarningType.ClientID %>').html(options);
            if (groupId == '') {
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarning.GetWarningTypeListByGroupId(groupId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            for (var i = 0; i < ajax.value.length; i++) {
                if (ajax.value[i].WarningTypeId == <%= this.warningType %>) {
                    options += '<option value="' + ajax.value[i].WarningTypeId + '" selected="selected">' + ajax.value[i].WarningTypeName + '</option>';
                } else {
                    options += '<option value="' + ajax.value[i].WarningTypeId + '">' + ajax.value[i].WarningTypeName + '</option>';
                }
            }
            $('#<%= this.ddlWarningType.ClientID %>').html(options);
        }
    </script>
</asp:Content>
