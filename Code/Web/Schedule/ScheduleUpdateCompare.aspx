<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScheduleUpdateCompare.aspx.cs" Inherits="SKT.LeanMES.Web.Schedule.ScheduleUpdateCompare" MasterPageFile="~/Masters/ViewMaster.master"%>

<asp:Content ContentPlaceHolderID="viewcontent" runat="server">

<table class="EditeContentTable" width="100%">
    <tr class="divHeader">
        <td class="Label1"></td>
        <td class="Field2">原内容</td>
        <td class="Field2">新内容</td>
    </tr>
    <tr>
        <td class="Label1">生产计划编号 </td>
        <td class="Field2"><label runat="server" id="lblOldMPID"></label></td>
        <td class="Field2"><label runat="server" id="lblNewMPID"></label></td>
    </tr>
    <tr>
        <td class="Label1">计划编制日期 </td>
        <td class="Field2"><label runat="server" id="lblOldCreateDate"></label></td>
        <td class="Field2"><label runat="server" id="lblNewCreateDate"></label></td>
    </tr>
    <tr>
        <td class="Label1">生产工单号码  </td>
        <td class="Field2"><label runat="server" id="lblOldOrderNO"></label></td>
        <td class="Field2"><label runat="server" id="lblNewOrderNO"></label></td>
    </tr>
    <tr>
        <td class="Label1">业务类型 </td>
        <td class="Field2"><label runat="server" id="lblOldBusType"></label></td>
        <td class="Field2"><label runat="server" id="lblNewBusType"></label></td>
    </tr>
    <tr>
        <td class="Label1">业务类型名称 </td>
        <td class="Field2"><label runat="server" id="lblOldBusTypeName"></label></td>
        <td class="Field2"><label runat="server" id="lblNewBusTypeName"></label></td>
    </tr>
    <tr>
        <td class="Label1">产品编码  </td>
        <td class="Field2"><label runat="server" id="lblOldInvCode"></label></td>
        <td class="Field2"><label runat="server" id="lblNewInvCode"></label></td>
    </tr>
    <tr>
        <td class="Label1">产品名称 </td>
        <td class="Field2"><label runat="server" id="lblOldInvName"></label></td>
        <td class="Field2"><label runat="server" id="lblNewInvName"></label></td>
    </tr>
    <tr>
        <td class="Label1">单位 </td>
        <td class="Field2"><label runat="server" id="lblOldUnit"></label></td>
        <td class="Field2"><label runat="server" id="lblNewUnit"></label></td>
    </tr>
    <tr>
        <td class="Label1">工厂编号 </td>
        <td class="Field2"><label runat="server" id="lblOldFactoryNO"></label></td>
        <td class="Field2"><label runat="server" id="lblNewFactoryNO"></label></td>
    </tr>
    <tr>
        <td class="Label1">作业编号 </td>
        <td class="Field2"><label runat="server" id="lblOldWorkSEQ"></label></td>
        <td class="Field2"><label runat="server" id="lblNewWorkSEQ"></label></td>
    </tr> 
    <tr>
        <td class="Label1">工序序号 </td>
        <td class="Field2"><label runat="server" id="lblOldSortSeq"></label></td>
        <td class="Field2"><label runat="server" id="lblNewSortSeq"></label></td>
    </tr>
    <tr>
        <td class="Label1">工单数量 </td>
        <td class="Field2"><label runat="server" id="lblOldQty"></label></td>
        <td class="Field2"><label runat="server" id="lblNewQty"></label></td>
    </tr>
    <tr>
        <td class="Label1">计划生产数量 </td>
        <td class="Field2"><label runat="server" id="lblOldPlanQty"></label></td>
        <td class="Field2"><label runat="server" id="lblNewPlanQty"></label></td>
    </tr>
    <tr>
        <td class="Label1">计划上线时间 </td>
        <td class="Field2"><label runat="server" id="lblOldPlanDate"></label></td>
        <td class="Field2"><label runat="server" id="lblNewPlanDate"></label></td>
    </tr>
    <tr>
        <td class="Label1">计划完工时间 </td>
        <td class="Field2"><label runat="server" id="lblOldPlanEndDate"></label></td>
        <td class="Field2"><label runat="server" id="lblNewPlanEndDate"></label></td>
    </tr>

</table>

<script type="text/javascript" >
    var moCode = '<%= Request.QueryString["moCode"] == null ? "" : Request.QueryString["moCode"].ToString()%>'
    var workSEQ = '<%= Request.QueryString["workSEQ"] == null ? "" : Request.QueryString["workSEQ"].ToString()%>'
    var pubufts = '<%= Request.QueryString["pubufts"] == null ? "" : Request.QueryString["pubufts"].ToString()%>'
    var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"

    //确认更新
    function ConfirmUpdate() {

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.ConfirmUpdate(moCode, workSEQ, pubufts, user, 2)
        if (ajax.error != null) {
            alert(ajax.error.Message)
            return false;
        }

        alert("更新成功！");
        parent.window.UpdateList("");
    }

    //取消更新
    function CancelUpdate() {

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.ConfirmUpdate(moCode, workSEQ, pubufts, user, 1)
        if (ajax.error != null) {
            alert(ajax.error.Message)
            return false;
        }

        alert("更新忽略成功！");
        parent.window.UpdateList("");
    }
</script>

</asp:Content>

