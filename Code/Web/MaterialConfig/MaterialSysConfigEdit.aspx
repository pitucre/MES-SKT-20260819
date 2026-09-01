<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialSysConfigEdit.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialConfig.MaterialSysConfigEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">配置类型
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlConfigType" ClientIDMode="Static">
                    <asp:ListItem Value="1">供应商是否启用物料条码规则</asp:ListItem>
                  <%--  <asp:ListItem Value="2">仓库收料</asp:ListItem>--%>
                    <asp:ListItem Value="3">是否备料确认</asp:ListItem>
                    <asp:ListItem Value="4">发料是否交接确认</asp:ListItem>
                    <asp:ListItem Value="5">是否进行IQC检验</asp:ListItem>
                    <asp:ListItem Value="6">供应商是否交期维护</asp:ListItem>
                    <asp:ListItem Value="7">先进先出备料规则</asp:ListItem>
                    <asp:ListItem Value="8">IQC退料扫描确认</asp:ListItem>
                    <asp:ListItem Value="9">是否进行IQC交接确认</asp:ListItem>
                    <asp:ListItem Value="10">不良仓选择</asp:ListItem>
                    <asp:ListItem Value="11">JIT首套发料时间</asp:ListItem>
                    <asp:ListItem Value="12">JIT预警时间</asp:ListItem>
                    <asp:ListItem Value="13">生产配送时间</asp:ListItem>
                    <asp:ListItem Value="14">SMT料站表计算用量方式</asp:ListItem>
                 <%--   <asp:ListItem Value="15">看板欢迎词</asp:ListItem>
                    <asp:ListItem Value="16">平帐处理方式</asp:ListItem>--%>
                    <asp:ListItem Value="17">线边仓是否按GRN接收</asp:ListItem>
                    <asp:ListItem Value="18">仓库库位条码中间符设定</asp:ListItem>
                   <%-- <asp:ListItem Value="19">辅料解冻/使用次数配置</asp:ListItem>--%>

                    <asp:ListItem Value="22">仓库备料是否自动分料</asp:ListItem>
                    <asp:ListItem Value="23">是否启用调拨出库</asp:ListItem>
                    <asp:ListItem Value="24">是否启用历史物料打印到产线</asp:ListItem>
                    <%--<asp:ListItem Value="25">打印历史物料是否选择仓库</asp:ListItem>--%>
                    <asp:ListItem Value="26">电子货架对接</asp:ListItem>
                    <asp:ListItem Value="27">先进先出成品出货规则</asp:ListItem>
                    <asp:ListItem Value="888">成品出库先进先出管控</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="showMaterialPrint">
            <td class="Label2">配置数据
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlPrintType" ClientIDMode="Static">
                    <asp:ListItem Value="1">是</asp:ListItem>
                    <asp:ListItem Value="2">否</asp:ListItem>
                    <%--<asp:ListItem Value="3">到货单</asp:ListItem>--%>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="showReceive">
            <td class="Label2">配置数据
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlReceiveType" ClientIDMode="Static">
                    <asp:ListItem Value="1">采购订单</asp:ListItem>
                    <asp:ListItem Value="2">到货单</asp:ListItem>
                    <asp:ListItem Value="3">送货单</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="showIsCheckBox">
            <td class="Label2">配置数据
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlIsCheckBox" ClientIDMode="Static">
                    <asp:ListItem Value="1">是</asp:ListItem>
                    <asp:ListItem Value="2">否</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="showRulePrepare" style="display: none">
            <td class="Label2">配置数据
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlRuleObj" ClientIDMode="Static">
                    <asp:ListItem Value="CreateDate">生产日期</asp:ListItem>
                    <asp:ListItem Value="InDate">入库日期</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>

        <tr id="showRulePrepareP2" style="display: none">
            <td class="Label2">控制范围
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlRuleUnit" ClientIDMode="Static">
                    <asp:ListItem Value="day">日</asp:ListItem>
                    <asp:ListItem Value="week">周</asp:ListItem>
                    <asp:ListItem Value="month">月</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
         <tr id="showRulePrepare3" style="display: none">
            <td class="Label2">配置数据
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlRuleObj1" ClientIDMode="Static">
                    <asp:ListItem Value="InDate">入库日期</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="showNgWarehouse" style="display: none">
            <td class="Label2">不良仓
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWhCode" runat="server" CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input id="button1" class="ButtonBox" type="button" onclick="selectWhCodeList()"
                        value="..." title="选择仓库" />
                <asp:HiddenField ID="hdnWhCode" runat="server" Value="" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnWhID" runat="server" Value="" ClientIDMode="Static" />
            </td>
        </tr>
        <tr id="showJITFirst" style="display: none">
            <td class="Label2">时间(小时)
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtJITFirst" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr id="showJITWarn" style="display: none">
            <td class="Label2">时间(小时)
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtJITWarn" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr id="showJITSendTime" style="display: none">
            <td class="Label2">时间(小时)
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtJITSendTime" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr id="showSMTPanelType" style="display: none">
            <td class="Label2">配置数据
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlSMTPanelType" ClientIDMode="Static">
                    <asp:ListItem Value="1">小板</asp:ListItem>
                    <asp:ListItem Value="2">拼板</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="showKanbanWelcomeMSG" style="display: none">
            <td class="Label2">欢迎词
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtKanbanWelcomeMSG" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr id="showChangeHandle" style="display: none">
            <td class="Label2">处理方式
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlChangeHandle" ClientIDMode="Static">
                    <asp:ListItem Value="1">盘亏，数量为0处理</asp:ListItem>
                    <asp:ListItem Value="2">正常，盘点后数量为系统数量处理</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="showThawUserNum" style="display: none">
            <td class="Label2">配置数据
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlThawUserType" ClientIDMode="Static">
                    <asp:ListItem Value="1">最大允许解冻次数</asp:ListItem>
                    <asp:ListItem Value="2">最大允许使用次数</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="showThawUserNum2" style="display: none">
            <td class="Label2">次数
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtThawUserNum" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr id="wareLocationBarCode" style="display: none">
            <td class="Label2">配置数据
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtBarCodeLocation" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
         <tr id="ShowPoCodeType" style="display:none;" >
             <td class="Label2">采购单类型
             </td>
             <td class="Field2">
                 <asp:CheckBox ID="CheckBox1" runat="server" /><span>采购订单</span>
                 <asp:CheckBox ID="CheckBox2" runat="server" /><span>委外订单</span>
                 <asp:CheckBox ID="CheckBox3" runat="server" /><span>客供料</span>
             </td>
         </tr>
        <tr>
            <td class="Label2">备注
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine" Width="95%"  Height="70px"></asp:TextBox>
            </td>
        </tr>


    </table>
    <script type="text/javascript">
        var materialSysConfigId = '<%=Request.QueryString["ID"]%>';
        var configTypeId = "<%=configTypeId %>";
        $(function () {
            if (materialSysConfigId == -1) {
                $("#showReceive").hide();
                $("#showIsCheckBox").hide();
                $("#showRulePrepare").hide();
                $("#showRulePrepareP2").hide();
                $("#showRulePrepare3").hide();
                $("#showNgWarehouse").hide();
                $("#showJITFirst").hide();
                $("#showJITWarn").hide();
                $("#showJITSendTime").hide();
                $("#showKanbanWelcomeMSG").hide();
                $("#showChangeHandle").hide();
                $("#showThawUserNum").hide();
                $("#showThawUserNum2").hide();

               
            } else {
                showConfigTypeMsg(configTypeId);
            }

            $("#txtJITFirst,txtJITWarn,#txtJITSendTime").keyup(function () {
                getDecimalVal(this);
            });

            $("#<%=this.ddlIsCheckBox.ClientID%>").change(function () {
                var txtID = $("#ddlConfigType").val() * 1;
                if (txtID == 5 && this.value == 2) {
                    $("input:[type='checkbox']")[0].checked = false
                    $("input:[type='checkbox']")[1].checked = false
                    $("input:[type='checkbox']")[2].checked = false
                }
            })

        });

        $("#ddlConfigType").bind("change", function () {
            var chooseTypeId = $(this).val();
            showConfigTypeMsg(chooseTypeId);
        });

        //选择仓库
        function selectWhCodeList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&CallBackFunc=setWhCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setWhCode(list) {
            var whCodes = list[0][1] + "|" + list[0][2];
            if (list[0][0] == "-1") {
                whCodes = "";
            }
            $("#<%=this.txtWhCode.ClientID %>").val(whCodes);
            $("#hdnWhID").val(list[0][0]);
            $("#hdnWhCode").val(list[0][1]);
        }

        function showConfigTypeMsg(chooseTypeId) {
            switch (chooseTypeId * 1) {
                case 1:
                    {
                        $("#showMaterialPrint").show();
                        $("#showReceive").hide();
                        $("#showIsCheckBox").hide();
                        $("#showRulePrepare").hide();
                        $("#showRulePrepareP2").hide();
                        $("#showRulePrepare3").hide();
                        $("#showNgWarehouse").hide();
                        $("#showJITFirst").hide();
                        $("#showJITWarn").hide();
                        $("#showJITSendTime").hide();
                        $("#showSMTPanelType").hide();
                        $("#showKanbanWelcomeMSG").hide();
                        $("#showChangeHandle").hide();
                        $("#showThawUserNum").hide();
                        $("#showThawUserNum2").hide();
                        $("#wareLocationBarCode").hide();
                        $("#ShowPoCodeType").hide();
                        break;
                    }
                case 2:
                    {
                        $("#showReceive").show();
                        $("#showMaterialPrint").hide();
                        $("#showIsCheckBox").hide();
                        $("#showRulePrepare").hide();
                        $("#showRulePrepareP2").hide();
                        $("#showRulePrepare3").hide();
                        $("#showNgWarehouse").hide();
                        $("#showJITFirst").hide();
                        $("#showJITWarn").hide();
                        $("#showJITSendTime").hide();
                        $("#showSMTPanelType").hide();
                        $("#showKanbanWelcomeMSG").hide();
                        $("#showChangeHandle").hide();
                        $("#showThawUserNum").hide();
                        $("#showThawUserNum2").hide();
                        $("#wareLocationBarCode").hide();
                        $("#ShowPoCodeType").hide();
                        break;
                    }
                case 5:{
                    $("#showIsCheckBox").show();
                    $("#ShowPoCodeType").show();
                    $("#showMaterialPrint").hide();
                    $("#showReceive").hide();
                    $("#showRulePrepare").hide();
                    $("#showRulePrepareP2").hide();
                    $("#showRulePrepare3").hide();
                    $("#showNgWarehouse").hide();
                    $("#showJITFirst").hide();
                    $("#showJITWarn").hide();
                    $("#showJITSendTime").hide();
                    $("#showSMTPanelType").hide();
                    $("#showKanbanWelcomeMSG").hide();
                    $("#showChangeHandle").hide();
                    $("#showThawUserNum").hide();
                    $("#showThawUserNum2").hide();
                    $("#wareLocationBarCode").hide();
                    break;
                }
                case 3: case 4:  case 6: case 8: case 9: case 17: case 22: case 23: case 24: case 25: case 26:case 888:
                    {
                        $("#showIsCheckBox").show();
                        $("#showMaterialPrint").hide();
                        $("#showReceive").hide();
                        $("#showRulePrepare").hide();
                        $("#showRulePrepareP2").hide();
                        $("#showRulePrepare3").hide();
                        $("#showNgWarehouse").hide();
                        $("#showJITFirst").hide();
                        $("#showJITWarn").hide();
                        $("#showJITSendTime").hide();
                        $("#showSMTPanelType").hide();
                        $("#showKanbanWelcomeMSG").hide();
                        $("#showChangeHandle").hide();
                        $("#showThawUserNum").hide();
                        $("#showThawUserNum2").hide();
                        $("#wareLocationBarCode").hide();
                        $("#ShowPoCodeType").hide();
                        break;
                    }
                case 7: 
                    {
                        $("#showRulePrepare").show();
                        $("#showRulePrepareP2").show();
                        $("#showRulePrepare3").hide();
                        $("#showIsCheckBox").hide();
                        $("#showMaterialPrint").hide();
                        $("#showReceive").hide();
                        $("#showNgWarehouse").hide();
                        $("#showJITFirst").hide();
                        $("#showJITWarn").hide();
                        $("#showJITSendTime").hide();
                        $("#showSMTPanelType").hide();
                        $("#showKanbanWelcomeMSG").hide();
                        $("#showChangeHandle").hide();
                        $("#showThawUserNum").hide();
                        $("#showThawUserNum2").hide();
                        $("#wareLocationBarCode").hide();
                        $("#ShowPoCodeType").hide();
                        break;
                    }
                 case 27:
                    {
                        $("#showRulePrepare").show();
                        $("#showRulePrepare").hide();
                        $("#showRulePrepareP2").show();
                        $("#showIsCheckBox").hide();
                        $("#showMaterialPrint").hide();
                        $("#showReceive").hide();
                        $("#showNgWarehouse").hide();
                        $("#showJITFirst").hide();
                        $("#showJITWarn").hide();
                        $("#showJITSendTime").hide();
                        $("#showSMTPanelType").hide();
                        $("#showKanbanWelcomeMSG").hide();
                        $("#showChangeHandle").hide();
                        $("#showThawUserNum").hide();
                        $("#showThawUserNum2").hide();
                        $("#wareLocationBarCode").hide();
                        $("#ShowPoCodeType").hide();
                        break;
                    }
                  
                case 10:
                    {
                        $("#showRulePrepare").hide();
                        $("#showRulePrepareP2").hide();
                        $("#showRulePrepare3").hide();
                        $("#showIsCheckBox").hide();
                        $("#showMaterialPrint").hide();
                        $("#showReceive").hide();
                        $("#showJITFirst").hide();
                        $("#showJITWarn").hide();
                        $("#showNgWarehouse").show();
                        $("#showJITSendTime").hide();
                        $("#showSMTPanelType").hide();
                        $("#showKanbanWelcomeMSG").hide();
                        $("#showChangeHandle").hide();
                        $("#showThawUserNum").hide();
                        $("#showThawUserNum2").hide();
                        $("#wareLocationBarCode").hide();
                        $("#ShowPoCodeType").hide();
                        break;
                    }
                case 11:
                    {
                        $("#showRulePrepare").hide();
                        $("#showRulePrepareP2").hide();
                        $("#showRulePrepare3").hide();
                        $("#showIsCheckBox").hide();
                        $("#showMaterialPrint").hide();
                        $("#showReceive").hide();
                        $("#showJITFirst").show();
                        $("#showJITWarn").hide();
                        $("#showNgWarehouse").hide();
                        $("#showJITSendTime").hide();
                        $("#showSMTPanelType").hide();
                        $("#showKanbanWelcomeMSG").hide();
                        $("#showChangeHandle").hide();
                        $("#showThawUserNum").hide();
                        $("#showThawUserNum2").hide();
                        $("#wareLocationBarCode").hide();
                        $("#ShowPoCodeType").hide();
                        break;
                    }
                case 12:
                    {
                        $("#showRulePrepare").hide();
                        $("#showRulePrepareP2").hide();
                        $("#showRulePrepare3").hide();
                        $("#showIsCheckBox").hide();
                        $("#showMaterialPrint").hide();
                        $("#showReceive").hide();
                        $("#showNgWarehouse").hide();
                        $("#showJITFirst").hide();
                        $("#showJITWarn").show();
                        $("#showJITSendTime").hide();
                        $("#showSMTPanelType").hide();
                        $("#showKanbanWelcomeMSG").hide();
                        $("#showChangeHandle").hide();
                        $("#showThawUserNum").hide();
                        $("#showThawUserNum2").hide();
                        $("#wareLocationBarCode").hide();
                        $("#ShowPoCodeType").hide();
                        break;
                    }
                case 13:
                    {
                        $("#showRulePrepare").hide();
                        $("#showRulePrepareP2").hide();
                        $("#showRulePrepare3").hide();
                        $("#showIsCheckBox").hide();
                        $("#showMaterialPrint").hide();
                        $("#showReceive").hide();
                        $("#showNgWarehouse").hide();
                        $("#showJITFirst").hide();
                        $("#showJITWarn").hide();
                        $("#showJITSendTime").show();
                        $("#showSMTPanelType").hide();
                        $("#showKanbanWelcomeMSG").hide();
                        $("#showChangeHandle").hide();
                        $("#showThawUserNum").hide();
                        $("#showThawUserNum2").hide();
                        $("#wareLocationBarCode").hide();
                        $("#ShowPoCodeType").hide();
                        break;
                    }
                case 14:
                    {
                        $("#showRulePrepare").hide();
                        $("#showRulePrepareP2").hide();
                        $("#showRulePrepare3").hide();
                        $("#showIsCheckBox").hide();
                        $("#showMaterialPrint").hide();
                        $("#showReceive").hide();
                        $("#showNgWarehouse").hide();
                        $("#showJITFirst").hide();
                        $("#showJITWarn").hide();
                        $("#showJITSendTime").hide();
                        $("#showSMTPanelType").show();
                        $("#showKanbanWelcomeMSG").hide();
                        $("#showChangeHandle").hide();
                        $("#showThawUserNum").hide();
                        $("#showThawUserNum2").hide();
                        $("#wareLocationBarCode").hide();
                        $("#ShowPoCodeType").hide();
                        break;
                    }
                case 15:
                    {
                        $("#showRulePrepare").hide();
                        $("#showRulePrepareP2").hide();
                        $("#showRulePrepare3").hide();
                        $("#showIsCheckBox").hide();
                        $("#showMaterialPrint").hide();
                        $("#showReceive").hide();
                        $("#showNgWarehouse").hide();
                        $("#showJITFirst").hide();
                        $("#showJITWarn").hide();
                        $("#showJITSendTime").hide();
                        $("#showSMTPanelType").hide();
                        $("#showKanbanWelcomeMSG").show();
                        $("#showChangeHandle").hide();
                        $("#showThawUserNum").hide();
                        $("#showThawUserNum2").hide();
                        $("#wareLocationBarCode").hide();
                        $("#ShowPoCodeType").hide();
                        break;
                    }
                case 16:
                    {
                        $("#showRulePrepare").hide();
                        $("#showRulePrepareP2").hide();
                        $("#showRulePrepare3").hide();
                        $("#showIsCheckBox").hide();
                        $("#showMaterialPrint").hide();
                        $("#showReceive").hide();
                        $("#showNgWarehouse").hide();
                        $("#showJITFirst").hide();
                        $("#showJITWarn").hide();
                        $("#showJITSendTime").hide();
                        $("#showSMTPanelType").hide();
                        $("#showKanbanWelcomeMSG").hide();
                        $("#showChangeHandle").show();
                        $("#showThawUserNum").hide();
                        $("#showThawUserNum2").hide();
                        $("#wareLocationBarCode").hide();
                        $("#ShowPoCodeType").hide();
                        break;
                    }
                case 18:
                    {
                        $("#showRulePrepare").hide();
                        $("#showRulePrepareP2").hide();
                        $("#showRulePrepare3").hide();
                        $("#showIsCheckBox").hide();
                        $("#showMaterialPrint").hide();
                        $("#showReceive").hide();
                        $("#showNgWarehouse").hide();
                        $("#showJITFirst").hide();
                        $("#showJITWarn").hide();
                        $("#showJITSendTime").hide();
                        $("#showSMTPanelType").hide();
                        $("#showKanbanWelcomeMSG").hide();
                        $("#showChangeHandle").hide();
                        $("#showThawUserNum").hide();
                        $("#showThawUserNum2").hide();
                        $("#wareLocationBarCode").show();
                        $("#ShowPoCodeType").hide();
                        break;
                    }
                case 19:
                    {
                        $("#showRulePrepare").hide();
                        $("#showRulePrepareP2").hide();
                        $("#showRulePrepare3").hide();
                        $("#showIsCheckBox").hide();
                        $("#showMaterialPrint").hide();
                        $("#showReceive").hide();
                        $("#showNgWarehouse").hide();
                        $("#showJITFirst").hide();
                        $("#showJITWarn").hide();
                        $("#showJITSendTime").hide();
                        $("#showSMTPanelType").hide();
                        $("#showKanbanWelcomeMSG").hide();
                        $("#showChangeHandle").hide();
                        $("#showThawUserNum").show();
                        $("#showThawUserNum2").show();
                        $("#wareLocationBarCode").hide();
                        $("#ShowPoCodeType").hide();
                        break;
                    }
            }
        }

        /*保存数据*/
        function Save() {
            var txtID = $("#ddlConfigType").val() * 1;
            var txtConfigType = $("#ddlConfigType").find(":selected").text();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtIsGlobal = 1;
            var txtConfigResult = "";
            var txtConfigDesc = "";
            var chooseDDLName = "";
            var rules = {};
            
            if (txtID === 1) {
                //物料条码打印数据配置
                chooseDDLName = "ddlPrintType";
            }
            else if (txtID === 2) {
                chooseDDLName = "ddlReceiveType";
            } else if (txtID > 2 && txtID !== 7) {
                chooseDDLName = "ddlIsCheckBox";
            }
            txtConfigResult = $("#" + chooseDDLName + "").val();
            txtConfigDesc = $("#" + chooseDDLName + "").find(":selected").text();
            //BirongLiang 增加配置项，ConfigResult改为保存JSON，显示改为变化html描述
            if (txtID === 5) { 
                if ($("#<%=this.CheckBox1.ClientID%>")[0].checked) {
                    txtConfigResult += "|1|";
                    txtConfigDesc += "|采购订单|";
                } else {
                    txtConfigResult += "|0|"; 
                    txtConfigDesc += "|";
                }

                if ($("#<%=this.CheckBox2.ClientID%>")[0].checked) {
                    txtConfigResult += "1|";
                    txtConfigDesc   += "委外订单|";
                } else {
                    txtConfigResult += "0|";
                }

                if ($("#<%=this.CheckBox3.ClientID%>")[0].checked) {
                    txtConfigResult += "1";
                    txtConfigDesc += "客供料";
                } else {
                    txtConfigResult += "0";
                }
                
            }
            else if (txtID === 7) {
                rules.ruleObj = $("#ddlRuleObj").find(":selected").val();
                rules.ruleUnit = $("#ddlRuleUnit").find(":selected").val();
                txtConfigResult = JSON.stringify(rules);
                txtConfigDesc = $("#ddlRuleObj").find(":selected").text();
            }
            else if (txtID === 10) {//不良仓库选择
                txtConfigResult = $("#hdnWhCode").val();
                txtConfigDesc = $("#<%=this.txtWhCode.ClientID %>").val();
            }
            else if (txtID === 11) {//JIT首套料发料时间
                txtConfigResult = $("#txtJITFirst").val();
                txtConfigDesc = $("#txtJITFirst").val() + " 小时";
            }
            else if (txtID === 12) {//JIT预警时间
                txtConfigResult = $("#txtJITWarn").val();
                txtConfigDesc = $("#txtJITWarn").val() + " 小时";
            }
            else if (txtID === 13) {//JIT生产配送时间
                txtConfigResult = $("#txtJITSendTime").val();
                txtConfigDesc = $("#txtJITSendTime").val() + " 小时";
            }
            else if (txtID === 14) {//JIT生产配送时间
                txtConfigResult = $("#ddlSMTPanelType").find(":selected").val();
                txtConfigDesc = $("#ddlSMTPanelType").find(":selected").text();
            }
            else if (txtID === 15) {//看板欢迎词
                txtConfigResult = $("#txtKanbanWelcomeMSG").val();
                txtConfigDesc = $("#txtKanbanWelcomeMSG").val();
            }
            else if (txtID === 16) { //平帐处理方式
                txtConfigResult = $("#ddlChangeHandle").find(":selected").val();
                txtConfigDesc = $("#ddlChangeHandle").find(":selected").text();
            }
            else if (txtID == 18) { //库位条码中间符设定
                txtConfigResult = $("#txtBarCodeLocation").val();
                txtConfigDesc = $("#txtBarCodeLocation").val();
            } else if (txtID === 19) { //辅料解冻/使用次数配置
                txtConfigResult = $("#txtThawUserNum").val();
                txtConfigDesc = $("#ddlThawUserType option:selected").text();
            } else if (txtID === 27) {
                rules.ruleObj = $("#ddlRuleObj1").find(":selected").val();
                rules.ruleUnit = $("#ddlRuleUnit").find(":selected").val();
                txtConfigResult = JSON.stringify(rules);
                txtConfigDesc = $("#ddlRuleObj1").find(":selected").text();
            }
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

            var entity = {};

            entity.ID = materialSysConfigId;
            entity.ConfigTypeId = txtID;
            entity.ConfigType = txtConfigType;
            entity.ConfigResult = txtConfigResult;
            entity.ConfigDesc = txtConfigDesc;
            entity.IsGlobal = Boolean(txtIsGlobal);
            entity.Remark = txtRemark;
            entity.UserName = userName;
            entity.Moudle = 0;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.MaterialSysConfigEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.UpdateList(txtID);
        }
    </script>
</asp:Content>
