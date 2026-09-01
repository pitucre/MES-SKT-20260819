<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master" CodeBehind="EquipmentInspectionHistoryList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentInspectionHistoryList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <style type="text/css">
        table .hide { display:none; }
    </style>
    <style type="text/css">
 #dialogMaintain{display:none;}
 #dialogUpdateTerm{display:none;}
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
                    <asp:ListItem Value="" Selected="True">请选择</asp:ListItem>
                    <asp:ListItem Value="1" >待点检</asp:ListItem>
                    <asp:ListItem Value="3">无需点检</asp:ListItem>
                    <asp:ListItem Value="2">已点检</asp:ListItem>
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
            <td class="Label3"></td>
            <td class="Field3"></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="HistoryOptionUserName" HeaderText="操作人" SortExpression="HistoryOptionUserName" ItemStyle-CssClass="HistoryOptionUserName" />
            <asp:BoundField DataField="HistoryOptionType" HeaderText="操作类型" SortExpression="HistoryOptionType" ItemStyle-CssClass="HistoryOptionType" />
            <asp:BoundField DataField="HistoryOptionDate" HeaderText="操作时间" SortExpression="HistoryOptionDate" ItemStyle-CssClass="HistoryOptionDate" />
            <asp:BoundField DataField="InspectionNo" HeaderText="点检单号" SortExpression="InspectionNo" ItemStyle-CssClass="InspectionNo" />
            <asp:BoundField DataField="EquipmentCode" HeaderText="设备编号" SortExpression="EquipmentCode" />
            <asp:BoundField DataField="EquipmentName" HeaderText="设备名称" SortExpression="EquipmentName" />
            <asp:BoundField DataField="EquipmentTypeName" HeaderText="设备类型" SortExpression="EquipmentTypeName" />
            <asp:BoundField DataField="StatusName" HeaderText="点检状态" SortExpression="StatusName" ItemStyle-CssClass="StatusName" />
            <asp:BoundField DataField="Station" HeaderText="工序" SortExpression="Station" />
            <asp:BoundField DataField="LineName" HeaderText="产线" SortExpression="LineName" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="生成时间" SortExpression="CreateDateTime" />
            <asp:BoundField DataField="InspectionUserEmployeeNo" HeaderText="点检人工号" SortExpression="InspectionUserEmployeeNo" />
            <asp:BoundField DataField="InspectionUserCName" HeaderText="点检人姓名" SortExpression="InspectionUserCName" />
            <asp:BoundField DataField="InspectionResultName" HeaderText="点检结果" SortExpression="InspectionResultName" />
            <asp:BoundField DataField="InspectionTime" HeaderText="点检时间" SortExpression="InspectionTime" />
            <asp:BoundField DataField="OpertionUserCName" HeaderText="待点检人姓名" SortExpression="OpertionUserCName" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.EquipmentInspectionTemplateItem"
        SelectMethod="GetAllEquipmentInspectionHistoryList" SelectCountMethod="GetCount">
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
    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
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

            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值，按钮功能已去除
            // 1 改为 HistoryOptionUserName
            // 2 改为 HistoryOptionType
            // 3 改为 HistoryOptionDate
            // 4 改为 InspectionNo
            // 5 改为 EquipmentCode
            // 8 改为 StatusName
            // 10 改为 LineName
            var historyOptionUserName = getRecordCellTextsByFiled("HistoryOptionUserName"); 
            var historyOptionType = getRecordCellTextsByFiled("HistoryOptionType"); 
            var historyOptionDate = getRecordCellTextsByFiled("HistoryOptionDate"); 
            var inspectionNo = getRecordCellTextsByFiled("InspectionNo"); 
            var statusName = getRecordCellTextsByFiled("StatusName"); 
            var lineName = getRecordCellTextsByFiled("LineName"); 
            var myrults = getRecordCellTextsByFiled("EquipmentCode"); 
            if (myrults == "待点检") {
                alert("待点检单据无法进行复判操作，请先进行点检！");
                return false;
            }
            $("#labInspectionNo").text(historyOptionUserName);
            $("#labEquipmentCode").text(historyOptionType);
            $("#labEquipmentTypeName").text(inspectionNo);
            $("#labEquipmentName").text(historyOptionDate);
            $("#labInspectionUserCName").text(lineName);
            $("#labCreateDateTime").text(statusName);

            //var myrults = getRecordCellTexts(5);
            //if (myrults == "待点检") {
            //    alert("待点检单据无法进行复判操作，请先进行点检！");
            //    return false;
            //}
            //$("#labInspectionNo").text(getRecordCellTexts(1));
            //$("#labEquipmentCode").text(getRecordCellTexts(2));
            //$("#labEquipmentTypeName").text(getRecordCellTexts(4));
            //$("#labEquipmentName").text(getRecordCellTexts(3));
            //$("#labInspectionUserCName").text(getRecordCellTexts(10));
            //$("#labCreateDateTime").text(getRecordCellTexts(8));

            $("#dialogUpdateTerm").dialog({
                resizable: false,
                height: 400,
                width: 700,
                modal: true
            });
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
            entity.InspectionOrderId = idStr;
            entity.UpdateRemark = UpdateRemark;
            entity.RetrialInspectionResult = RetrialInspectionResult;
            entity.UserName = userName;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspEquipmentInspectionRetrialSave", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("复判成功！");
            $("#dialogUpdateTerm").dialog("close");
        }

        //查看
        function View() {
            return;
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentMaintenance.aspx?name=EquipmentSpotCheckView&InspectionOrderId=" + idStr + "&ViewFlag=1&InspectionType=12";
            window.open(openWinUrl);
        }

        //复判
        function Retrial() {
            UpdateTerm();
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

