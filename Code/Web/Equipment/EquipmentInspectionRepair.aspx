<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="EquipmentInspectionRepair.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentInspectionRepair" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">
                    设备编号
                </td>
                <td  class="Field2">
                    <label id="labEquipmentCode2"></label>
                </td>
                <td class="Label2">
                    域
                </td>
                <td  class="Field2">
                    <label id="labContract2"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    线别名称
                </td>
                <td  class="Field2">
                    <label id="labLineName2"></label>
                </td>
                <td class="Label2">
                    工序名称
                </td>
                <td  class="Field2">
                    <label id="labStationName2"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    故障部位
                </td>
                <td  class="Field2" colspan="3">
                    <label id="labInspectionItemName2"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    故障状况
                </td>
                <td  class="Field2" colspan="3">
                    <label id="labInspectionResult2"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    已上传图片
                </td>
                <td  class="Field2" colspan="3" id="myUploadImg">
                    
                </td>
            </tr>
            <tr>
                <td class="Label2">报修途径<em>*</em></td>
                <td class="Field2" colspan="3">
                    <asp:DropDownList ID="ddlRepairChannel" runat="server" AutoPostBack="false" ClientIDMode="Static">
                    <asp:ListItem Value="1">点检</asp:ListItem>
                    <asp:ListItem Value="2">保养</asp:ListItem>
                    <asp:ListItem Value="3">安灯</asp:ListItem>
                    <asp:ListItem Value="4">正常</asp:ListItem>
                </asp:DropDownList>
                </td> 
            </tr>
            <tr>
                <td class="Label2">
                    故障描述
                </td>
                <td  class="Field2" colspan="3">
                    <label id="labNGRemark2"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">紧急程度<em>*</em></td>
                <td class="Field2" colspan="3">
                    <asp:DropDownList ID="ddlUrgency2" runat="server" AutoPostBack="false" ClientIDMode="Static">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="0">低</asp:ListItem>
                    <asp:ListItem Value="1">中</asp:ListItem>
                    <asp:ListItem Value="2">高</asp:ListItem>
                </asp:DropDownList>
                </td> 
            </tr>
            <tr>
                <td class="Label2">是否停机<em>*</em></td>
                <td class="Field2" colspan="3">
                    <asp:DropDownList ID="ddlShutdownOrNot" runat="server" AutoPostBack="false" ClientIDMode="Static">
                    <asp:ListItem Value="0">否</asp:ListItem>
                    <asp:ListItem Value="1">是</asp:ListItem>
                </asp:DropDownList>
                </td> 
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <input id="btnSavedialogUpdateAudit" type="button" onclick="SavedialogUpdateAudit()" value=" 提 交 " />&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    <script language="javascript" type="text/javascript">
        var InspectionOrderOATemplateDetailId = '<%=Request.QueryString["ID"] %>';
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>";

        $(function () {
            LoadEquipmentRepair();
        });

        function LoadEquipmentRepair() {

            var info = { InspectionOAId: InspectionOrderOATemplateDetailId };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspLoadEquipmentRepairData", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = JSON.parse(ajax.value);
            var listOrder = list.data;

            $("#labEquipmentCode2").text(listOrder[0].EquipmentCode);
            $("#labContract2").text(listOrder[0].Contract);
            $("#labLineName2").text(listOrder[0].LineName);
            $("#labStationName2").text(listOrder[0].StationName);
            $("#labInspectionItemName2").text(listOrder[0].InspectionItemName);
            $("#labInspectionResult2").text("NG");
            $("#myUploadImg").html(listOrder[0].UploadImg);
            $("#labNGRemark2").text(listOrder[0].NGRemark);

            $("#dialogUpdateAudit").dialog({
                resizable: false,
                height: 400,
                width: 700,
                modal: true
            });
        }

        function SavedialogUpdateAudit() {

            var RepairChannel = $("#ddlRepairChannel").val();
            var Urgency = $("#ddlUrgency2").val();
            var ShutdownOrNot = $("#ddlShutdownOrNot").val();

            if (Urgency == "" || Urgency == "-1") {
                alert("请选择紧急程度");
                return;
            }

            var info = { InspectionOAId: InspectionOrderOATemplateDetailId, UrgencyFlag: Urgency, StopFlag: ShutdownOrNot, RepairChannel: RepairChannel, ModifyBy: userName };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspEquipmentInspectionRepairSave", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = JSON.parse(ajax.value);
            var listOrder = list.data;
            var RepairNo = listOrder[0].RepairNo;
            alert('报修成功，报修单号：' + RepairNo);
            parent.UpdateList();
        }

    </script>
</asp:Content>
