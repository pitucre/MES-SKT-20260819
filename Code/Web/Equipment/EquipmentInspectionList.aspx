<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master" CodeBehind="EquipmentInspectionList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentInspectionList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <style type="text/css">
        table .hide { display:none; }
    </style>
   <style type="text/css">
       #dialogMaintain{display:none;}
       #dialogUpdateTerm{display:none;}
       #dialogUpdateAudit{display:none;}
       #dialogUpdateSecondAudit{display:none;}
</style> 
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">设备编号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">点检单号</td>
            <td class="Field3">
                <asp:TextBox ID="txtInspectionNo" runat="server" CssClass="TextBox"></asp:TextBox></td>
            <td class="Label3">产线
            </td>
            <td class="Field3">
                <asp:TextBox ID="LineName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">设备名称
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="EquipmentName" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">点检状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlEquipmentStatus" runat="server" AutoPostBack="false" ClientIDMode="Static">
                    <asp:ListItem Value="">请选择</asp:ListItem>
                    <asp:ListItem Value="1" Selected="True">待点检</asp:ListItem>
                    <asp:ListItem Value="3">无需点检</asp:ListItem>
                    <asp:ListItem Value="2">已点检</asp:ListItem>
                  <%--  <asp:ListItem Value="4">已审核</asp:ListItem>
                    <asp:ListItem Value="5">已终审</asp:ListItem>--%>
                </asp:DropDownList>
            </td>
            <td class="Label3">点检结果
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlEquipmentResult" runat="server" AutoPostBack="false" ClientIDMode="Static">
                    <asp:ListItem Selected="True" Value="">请选择</asp:ListItem>
                    <asp:ListItem Value="1">合格</asp:ListItem>
                    <asp:ListItem Value="0">不合格</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label3">点检人
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="InspectionEndUserName"></asp:TextBox>
            </td>
            <td class="Label3">点检时间
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtStartDate" CssClass="DateTimeBox"></asp:TextBox>
                -
                <asp:TextBox runat="server" ID="txtEndDate" CssClass="DateTimeBox"></asp:TextBox>
            </td>
            <td class="Label3">点检单生成时间
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="CreateTimeStart" CssClass="DateTimeBox"></asp:TextBox>
                -
                <asp:TextBox runat="server" ID="CreateTimeEnd" CssClass="DateTimeBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">设备类型名称
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="EquipmentTypeName" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" value="..." onclick="openChoosePage(680);" />
            </td>
            <td class="Label3">待点检人账号
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="SpotCheckUser" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(12);" />
            </td>
            <td class="Label3">工序
            </td>
            <td class="Field3">
                <asp:TextBox ID="Station" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <asp:BoundField DataField="InspectionNo" HeaderText="点检单号" SortExpression="InspectionNo" ItemStyle-CssClass="InspectionNo" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="EquipmentCode" HeaderText="设备编号" SortExpression="EquipmentCode" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="EquipmentName" HeaderText="设备名称" SortExpression="EquipmentName" HeaderStyle-Width="220px"  />
            <asp:BoundField DataField="EquipmentTypeName" HeaderText="设备类型" SortExpression="EquipmentTypeName" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="StatusName" HeaderText="点检状态" SortExpression="StatusName" ItemStyle-CssClass="StatusName" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="Station" HeaderText="工序" SortExpression="Station" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="LineName" HeaderText="产线" SortExpression="LineName" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="生成时间" SortExpression="CreateDateTime" HeaderStyle-Width="170px" />
            <asp:BoundField DataField="InspectionUserEmployeeNo" HeaderText="点检人工号" SortExpression="InspectionUserEmployeeNo" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="InspectionUserCName" HeaderText="点检人姓名" SortExpression="InspectionUserCName" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="InspectionResultName" HeaderText="点检结果" SortExpression="InspectionResultName" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="InspectionTime" HeaderText="点检时间" SortExpression="InspectionTime" HeaderStyle-Width="170px"  />
            <asp:BoundField DataField="OpertionUserCName" HeaderText="待点检人" SortExpression="OpertionUserCName" HeaderStyle-Width="80px" />
          <%--  <asp:BoundField DataField="JoinInspectionNo" HeaderText="关联点检单号" SortExpression="JoinInspectionNo" HeaderStyle-Width="120px" />--%>
           <%-- <asp:BoundField DataField="AuditUserName" HeaderText="审核人" SortExpression="AuditUserName" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="AuditResultName" HeaderText="审核结果" SortExpression="AuditResultName" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="AuditDateTime" HeaderText="审核时间" SortExpression="AuditDateTime" HeaderStyle-Width="170px" />
            <asp:BoundField DataField="AuditRemark" HeaderText="审核备注" SortExpression="AuditRemark" HeaderStyle-Width="150px" />
            <asp:BoundField DataField="SecondAuditUserName" HeaderText="终审人" SortExpression="SecondAuditUserName " HeaderStyle-Width="60px" />
            <asp:BoundField DataField="SecondAuditResult" HeaderText="终审结果" SortExpression="SecondAuditResult" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="SecondAuditDate" HeaderText="终审时间" SortExpression="SecondAuditDate" HeaderStyle-Width="170px" />
            <asp:BoundField DataField="SecondAuditNote" HeaderText="终审备注" SortExpression="SecondAuditNote" HeaderStyle-Width="150px" />--%>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.EquipmentInspectionTemplateItem"
        SelectMethod="GetAllEquipmentInspectionList" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div id="dialogUpdateTerm" title="设备点检复判">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">
                    点检单号
                </td>
                <td  class="Field2">
                    <label id="labInspectionNo"></label>
                </td>
                <td class="Label2">
                    设备编号
                </td>
                <td  class="Field2">
                    <label id="labEquipmentCode"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    设备类型
                </td>
                <td  class="Field2">
                    <label id="labEquipmentTypeName"></label>
                </td>
                <td class="Label2">
                    设备名称
                </td>
                <td  class="Field2">
                    <label id="labEquipmentName"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    点检人
                </td>
                <td  class="Field2">
                    <label id="labInspectionUserCName"></label>
                </td>
                <td class="Label2">
                    生成时间
                </td>
                <td  class="Field2">
                    <label id="labCreateDateTime"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">处理结果<em>*</em></td>
                <td class="Field2" colspan="3">
                    <asp:DropDownList ID="ddlRetrialInspectionResult" runat="server" AutoPostBack="false" ClientIDMode="Static">
                    <asp:ListItem Selected="True" Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="1">合格</asp:ListItem>
                    <asp:ListItem Value="0">不合格</asp:ListItem>
                </asp:DropDownList>
                </td> 
            </tr>
            <tr>
                <td class="Label2">异常原因<em>*</em></td>
                <td class="Field2" colspan="3">
                    <textarea name="txtUpdateRemark" rows="2" cols="20" id="txtUpdateRemark" class="TextArea" style="height:100px;width:500px;"></textarea>
                </td> 
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <input id="btnSavedialogUpdateTerm" type="button" onclick="SavedialogUpdateTerm()" value=" 提 交 " />&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </div>
    <div id="dialogUpdateAudit" title="设备点检审核">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">
                    点检单号
                </td>
                <td  class="Field2">
                    <label id="labInspectionNo2"></label>
                </td>
                <td class="Label2">
                    设备编号
                </td>
                <td  class="Field2">
                    <label id="labEquipmentCode2"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    设备类型
                </td>
                <td  class="Field2">
                    <label id="labEquipmentTypeName2"></label>
                </td>
                <td class="Label2">
                    设备名称
                </td>
                <td  class="Field2">
                    <label id="labEquipmentName2"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    点检人
                </td>
                <td  class="Field2">
                    <label id="labInspectionUserCName2"></label>
                </td>
                <td class="Label2">
                    生成时间
                </td>
                <td  class="Field2">
                    <label id="labCreateDateTime2"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">审核结果<em>*</em></td>
                <td class="Field2" colspan="3">
                    <asp:DropDownList ID="ddlAuditResult" runat="server" AutoPostBack="false" ClientIDMode="Static">
                    <asp:ListItem Selected="True" Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="1">通过</asp:ListItem>
                    <asp:ListItem Value="0">不通过</asp:ListItem>
                </asp:DropDownList>
                </td> 
            </tr>
            <tr>
                <td class="Label2">审核备注</td>
                <td class="Field2" colspan="3">
                    <textarea name="txtAuditRemark" rows="2" cols="20" id="txtAuditRemark" class="TextArea" style="height:100px;width:500px;"></textarea>
                </td> 
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <input id="btnSavedialogUpdateAudit" type="button" onclick="SavedialogUpdateAudit()" value=" 提 交 " />&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </div>
    <div id="dialogUpdateSecondAudit" title="设备点检终审">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">
                    点检单号
                </td>
                <td  class="Field2">
                    <label id="labInspectionNo4"></label>
                </td>
                <td class="Label2">
                    设备编号
                </td>
                <td  class="Field2">
                    <label id="labEquipmentCode4"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    设备类型
                </td>
                <td  class="Field2">
                    <label id="labEquipmentTypeName4"></label>
                </td>
                <td class="Label2">
                    设备名称
                </td>
                <td  class="Field2">
                    <label id="labEquipmentName4"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    点检人
                </td>
                <td  class="Field2">
                    <label id="labInspectionUserCName4"></label>
                </td>
                <td class="Label2">
                    生成时间
                </td>
                <td  class="Field2">
                    <label id="labCreateDateTime4"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">终审结果<em>*</em></td>
                <td class="Field2" colspan="3">
                    <asp:DropDownList ID="ddlSecondAuditResult" runat="server" AutoPostBack="false" ClientIDMode="Static">
                    <asp:ListItem Selected="True" Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="1">通过</asp:ListItem>
                    <asp:ListItem Value="0">不通过</asp:ListItem>
                </asp:DropDownList>
                </td> 
            </tr>
            <tr>
                <td class="Label2">终审备注</td>
                <td class="Field2" colspan="3">
                    <textarea name="txtSecondAuditNote" rows="2" cols="20" id="txtSecondAuditNote" class="TextArea" style="height:100px;width:500px;"></textarea>
                </td> 
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <input id="btnSavedialogUpdateSecondAudit" type="button" onclick="SavedialogUpdateSecondAudit()" value=" 提 交 " />&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var gridId = "<%=this.GridView1.ClientID%>";
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>";
        var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId%>";
        var flag = -1;

        $(function () {
            $("#txtEquipmentCode").focus();

            //设备编码回车即查询
            $("#txtEquipmentCode").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Refresh();
                }
            });
        })

        function UpdateTerm() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值
            // 1 改为 InspectionNo
            // 2 改为 EquipmentCode
            // 3 改为 EquipmentName
            // 4 改为 EquipmentTypeName
            // 5 改为 StatusName
            // 8 改为 CreateDateTime
            // 10 改为 InspectionUserCName
            var myrults = getRecordCellTextsByFiled("StatusName");
            if (myrults == "待点检") {
                alert("待点检单据无法进行复判操作，请先进行点检！");
                return false;
            }
            $("#labInspectionNo").text(getRecordCellTextsByFiled("InspectionNo"));
            $("#labEquipmentCode").text(getRecordCellTextsByFiled("EquipmentCode"));
            $("#labEquipmentTypeName").text(getRecordCellTextsByFiled("EquipmentTypeName"));
            $("#labEquipmentName").text(getRecordCellTextsByFiled("EquipmentName"));
            $("#labInspectionUserCName").text(getRecordCellTextsByFiled("InspectionUserCName"));
            $("#labCreateDateTime").text(getRecordCellTextsByFiled("CreateDateTime"));

            $("#dialogUpdateTerm").dialog({
                resizable: false,
                height: 400,
                width: 700,
                modal: true
            });
        }

        function EquipmentAudit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值
            // 1 改为 InspectionNo
            // 2 改为 EquipmentCode
            // 3 改为 EquipmentName
            // 4 改为 EquipmentTypeName
            // 5 改为 StatusName
            // 8 改为 CreateDateTime
            // 10 改为 InspectionUserCName
            var myrults = getRecordCellTextsByFiled("StatusName");
            if (myrults == "待点检") {
                alert("待点检单据无法进行复判操作，请先进行点检！");
                return false;
            }
            $("#labInspectionNo2").text(getRecordCellTextsByFiled("InspectionNo"));
            $("#labEquipmentCode2").text(getRecordCellTextsByFiled("EquipmentCode"));
            $("#labEquipmentTypeName2").text(getRecordCellTextsByFiled("EquipmentTypeName"));
            $("#labEquipmentName2").text(getRecordCellTextsByFiled("EquipmentName"));
            $("#labInspectionUserCName2").text(getRecordCellTextsByFiled("InspectionUserCName"));
            $("#labCreateDateTime2").text(getRecordCellTextsByFiled("CreateDateTime"));

            $("#dialogUpdateAudit").dialog({
                resizable: false,
                height: 400,
                width: 700,
                modal: true
            });
        }

        function SavedialogUpdateAudit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var AuditRemark = $("#txtAuditRemark").val();
            var AuditResult = $("#ddlAuditResult").val();
            if (AuditResult == "" || AuditResult == "-1") {
                alert("请选择处理结果");
                return;
            }
            var entity = {};
            entity.InspectionOrderId = idStr;
            entity.AuditRemark = AuditRemark;
            entity.AuditResult = AuditResult;
            entity.UserName = userName;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspEquipmentInspectionAuditSave", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("审核成功！");
            $("#dialogUpdateAudit").dialog("close");
            UpdateList();
        }

        function SavedialogUpdateTerm() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var UpdateRemark = $("#txtUpdateRemark").val();
            var RetrialInspectionResult = $("#ddlRetrialInspectionResult").val();
            if (UpdateRemark == "") {
                alert("请填写异常原因");
                return;
            }
            if (RetrialInspectionResult == "" || RetrialInspectionResult=="-1") {
                alert("请选择处理结果");
                return;
            }
            var entity = {};
            entity.InspectionOrderId = parseInt( idStr);
            entity.UpdateRemark = UpdateRemark;
            entity.RetrialInspectionResult = parseInt(RetrialInspectionResult);
            entity.UserName = userName;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspEquipmentInspectionRetrialSave", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("复判成功！");
            $("#dialogUpdateTerm").dialog("close");
            UpdateList();
        }

        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentMaintenance.aspx?name=EquipmentSpotCheckView&InspectionOrderId=" + idStr + "&ViewFlag=1&InspectionType=12";
            window.open(openWinUrl);
        }
        //begin:wtt 20230519 终审
        function SecondEquipmentAudit() {
            var idStr = getOneRecordId();
            var SecondAuditResultV="";
            if (idStr == "") return false;

            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值
            // 1 改为 InspectionNo
            // 2 改为 EquipmentCode
            // 3 改为 EquipmentName
            // 4 改为 EquipmentTypeName
            // 5 改为 StatusName
            // 8 改为 CreateDateTime
            // 10 改为 InspectionUserCName
            var myrults = getRecordCellTextsByFiled("StatusName");
            if (myrults == "待点检") {
                alert("待点检单据无法进行审核操作，请先进行点检！");
                return false;
            }
            if (myrults == "已终审") {
                alert("单据已经终审了！");
                return false;
            }

            $("#labInspectionNo4").text(getRecordCellTextsByFiled("InspectionNo"));
            $("#labEquipmentCode4").text(getRecordCellTextsByFiled("EquipmentCode"));
            $("#labEquipmentTypeName4").text(getRecordCellTextsByFiled("EquipmentTypeName"));
            $("#labEquipmentName4").text(getRecordCellTextsByFiled("EquipmentName"));
            $("#labInspectionUserCName4").text(getRecordCellTextsByFiled("InspectionUserCName"));
            $("#labCreateDateTime4").text(getRecordCellTextsByFiled("CreateDateTime"));

            $("#dialogUpdateSecondAudit").dialog({
                resizable: false,
                height: 400,
                width: 700,
                modal: true
            });
        }
          function SavedialogUpdateSecondAudit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var AuditRemark = $("#txtSecondAuditNote").val();
            var AuditResult = $("#ddlSecondAuditResult").val();
            if (AuditResult == "" || AuditResult == "-1") {
                alert("请选择处理结果");
                return;
            }
            var entity = {};
            entity.InspectionOrderId = idStr;
            entity.AuditRemark = AuditRemark;
            entity.AuditResult = AuditResult;
            entity.UserName = userName;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspEquipmentInspectionSecondAuditSave", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("审核成功！");
            $("#dialogUpdateSecondAudit").dialog("close");
            UpdateList();
        }

        //审核
        function Audit() {
            EquipmentAudit();
            return;
        }
       
        //复判
        function Retrial() {
            UpdateTerm();
            return;
        }
        //begin:wtt 20230519 终审
        function SecondAudit() {
            SecondEquipmentAudit();
            return;
        }
        //编辑
        function Edit() {
            var idStr = -1;
            var len = $("#" + gridId + " input[type=\"checkbox\"][name=\"chkSelect\"]:checked").length;
            if (len > 0) {
                var idStr = getOneRecordId();
                if (idStr == "") return false;

                //var spotCheckUserOne = getTextByClass("SpotCheckUserOne");
                //var spotCheckUserTwo = getTextByClass("SpotCheckUserTwo");
                //if (userId != "-1" && userName != spotCheckUserOne && userName != spotCheckUserTwo) {
                //    alert("只有一级点检人[" + spotCheckUserOne + "]或二级点检人[" + spotCheckUserTwo + "]，才能点检此设备");
                //    return false;
                //}

            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentMaintenance.aspx?name=EquipmentSpotCheck&InspectionOrderId=" + idStr + "&InspectionType=12";
            window.open(openWinUrl);
        }

        //无需保养
        function NoSpotCheck() {
            var idStr = getRecordIdString();
            if (idStr == "") return false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.InspectionEquipmentNoMaintenance(idStr, 12);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("保存成功！");
            UpdateList();
        }

        //打印
        function Print() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var url = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Equipment/EquipmentMaintenancePrint.aspx?name=EquipmentMaintenancePrint&type=2&ID=" + idStr + "&rnd=" + Math.random();
            window.open(url);
        }

        //导出
        function Export() {
            hdnOperate.val("exportexcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        function Refresh() {
            hdnOperate.val("");
            document.forms[0].submit();
        }

        function UpdateList() {
            document.forms[0].submit();
        }

        function openChoosePage(flags) {
            var condition = "";
            flag = flags;
            dialog({ title: "选择窗口", src: "../Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&SearchCondition=" + condition + "&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function getChooseValue(list) {
            if (flag == 8) {
                $("#txtStation").val(list[0][1]);
                flag = -1;
            } else if (flag == 12) {
                $("#SpotCheckUser").val(list[0][2]);
            } else if (flag == 680) {
                $("#EquipmentTypeName").val(list[0][2]);
            }
        }
    </script>
</asp:Content>

