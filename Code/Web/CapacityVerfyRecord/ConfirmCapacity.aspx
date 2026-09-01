<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConfirmCapacity.aspx.cs"
    MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.CapacityVerfyRecord.ConfirmCapacity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%= Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                工号
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtEmployeeNo" runat="server" Enabled="false" CssClass="TextBox" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                工序
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtStationName" runat="server" Enabled="false" CssClass="TextBox" ></asp:TextBox><input type="button" id="btnSelectEquipment" class="ButtonBox" value="..."
                        title="Select" onclick="openChoosePage(8);" />
                <asp:HiddenField ID="hdStationId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                日期
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtDate" runat="server" CssClass="DateTimeBox"  Width="150" ClientIDMode="Static"></asp:TextBox>
                &nbsp;&nbsp;<input type="button" class="SearchButton" value="查询" onclick="Query()" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                备注
            </td>
           <td class="Field2" colspan="3">
                 <asp:TextBox ID="txtRemark" CssClass="TextArea" TextMode="MultiLine" runat="server"
                    ClientIDMode="Static" Height="75"></asp:TextBox>
            </td>
        </tr>
    </table>
    <div class="divHeader">叫料记录</div>
    <div class="EditeContentTable" id="infotab" width="100%">
        <table class="ListTable" width="100%" id="tbCapacity" style="line-height: 28px;">
            <thead>
                <tr class="ListTableHeader">
                    <th>工序
                    </th>
                    <th>设备
                    </th>
                    <th>产品
                    </th>
                    <th>计件标准
                    </th>
                    <th>数量
                    </th>
                    <th>工资
                    </th>
                    <th>添加人
                    </th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script language="javascript" type="text/javascript">
        _isHms = false;

        var viewModel = {
            userName: '<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>',
            userId: '<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId%>',
            employeeNo: '<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeNo%>',
            scanDate: "",           //扫描的日期
            scanStationId: "-1",    //扫描的工序
            scanData: []            //扫描的数据
        };

        $(function () {
            $("#<%=this.txtEmployeeNo.ClientID %>").val(viewModel.employeeNo);
            $("#<%=this.txtDate.ClientID %>").val(GetDateStr(-1));
        });

        function Save() {
            var txtEmployeeNo = $("#<%=this.txtEmployeeNo.ClientID %>").val();
            var txtRemark = $("#<%=this.txtRemark.ClientID %>").val();

            if (viewModel.scanData.length == 0) {
                alert("未查询到产能信息!");
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCapacityVerfyRecord.SaveCapacityRecordEdit(viewModel.scanDate, txtRemark, viewModel.userId, viewModel.scanData);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            init();
        }

        function Query() {

            var hdStationId = $("#<%=this.hdStationId.ClientID %>").val();
            var txtDate = $.trim($("#<%=this.txtDate.ClientID %>").val());
            
            if (!txtDate) {
                alert("请选择日期!");
                $("#<%=this.txtDate.ClientID %>").focus();
                return false;
            }
            if (txtDate && isNaN(new Date(txtDate.replace(/-/g, "/")).getTime())) {
                alert("请输入正确的日期格式!");
                $("#<%=this.txtDate.ClientID %>").select().focus();
                return false;
            }
            var today = GetDateStr(0);
            if (new Date(txtDate.replace(/-/g, "/")) >= new Date(today.replace(/-/g, "/"))) {
                alert("请选择昨天或更早以前的日期!");
                $("#<%=this.txtDate.ClientID %>").select().focus();
                return false;
            }

            if (hdStationId == "-1") {
                 alert("请选择工序!");
                $("#<%=this.txtStationName.ClientID %>").focus();
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCapacityVerfyRecord.GetCapacityInfo(txtDate, viewModel.userName, hdStationId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            //
            list = ajax.value;
            if (list.length == 0) {
                alert("未查询到产能信息!");
                $("#tbCapacity tbody").html("");
                return false;
            }
            //
            var html = "";
            var model = {};
            viewModel.scanData = [];
            viewModel.scanDate = txtDate;
            for (var i = 0; i < list.length; i++) {	
                var model = {};
                html += '<tr class="ListTableOddRow">';
                html += '<td width="8%">' + list[i].StationName + '</td>';
                html += '<td width="15%">' + list[i].EquipmentCode + '</td>';
                html += '<td width="12%">' + list[i].ItemCode + '</td>';
                html += '<td width="10%">' + list[i].Price + '</td>';
                html += '<td width="10%">' + list[i].Qty + '</td>';
                html += '<td width="10%">' + list[i].Salary + '</td>';
                html += '<td width="10%">' + list[i].userName + '</td>';
                html += "</tr>";
                model.StationId = list[i].StationID;
                model.EquipmentId = list[i].EquipmentID;
                model.ItemId = list[i].ItemID;
                model.Qty = list[i].Qty;
                model.NGQty = "0";
                model.Salary = list[i].Salary;
                model.PieceWageID = list[i].PieceWageID;
                model.UserId = list[i].UserId;
                viewModel.scanData.push(model);
            }
            $("#tbCapacity tbody").html(html);
        }

        var globalFlag = -1;
        function openChoosePage(flags) {
            var condition = "";
            globalFlag = flags;

            dialog({
                title: "<%= Resources.Common.ChooseWindow %>",
                src: "<%= SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags +
                "&Multiple=false&PageCondition=" +
                escape(condition) +
                "&rnd=" +
                Math.random(),
                width: 600,
                height: 300
            });

        }
        function getChooseValue(list) {
            if (globalFlag === 8) {    //工单
                $("#<%=this.txtStationName.ClientID %>").val(list[0][1]);
                $("#<%=this.hdStationId.ClientID %>").val(list[0][0]);
            }
        }

        function init() {
            viewModel.scanData = [];
            viewModel.scanDate = "";

            $("#<%=this.txtDate.ClientID %>").val("");
            $("#<%=this.txtRemark.ClientID %>").val("");
        }

    </script>
</asp:Content>
