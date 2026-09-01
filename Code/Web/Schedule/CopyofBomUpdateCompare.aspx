<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CopyofBomUpdateCompare.aspx.cs" Inherits="SKT.LeanMES.Web.Schedule.CopyofBomUpdateCompare" MasterPageFile="~/Masters/ViewMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
<table class="EditeContentTable" width="100%">
    <tr class="divHeader">
        <td class="Label1"></td>
        <td class="Field2">原内容</td>
        <td class="Field2">新内容</td>
    </tr>
    <tr>
        <td class="Label1">生产工单号码 </td>
        <td class="Field2"><label runat="server" id="lblOldOrderNO"></label></td>
        <td class="Field2"><label runat="server" id="lblNewOrderNO"></label></td>
    </tr>
    <tr>
        <td class="Label1">单身项次  </td>
        <td class="Field2"><label runat="server" id="lblOldRowNO"></label></td>
        <td class="Field2"><label runat="server" id="lblNewRowNO"></label></td>
    </tr>
    <tr>
        <td class="Label1">工单类型 </td>
        <td class="Field2"><label runat="server" id="lblOldBusType"></label></td>
        <td class="Field2"><label runat="server" id="lblNewBusType"></label></td>
    </tr>
    <tr>
        <td class="Label1">物料编码  </td>
        <td class="Field2"><label runat="server" id="lblOldInvCode"></label></td>
        <td class="Field2"><label runat="server" id="lblNewInvCode"></label></td>
    </tr>
    <tr>
        <td class="Label1">物料名称 </td>
        <td class="Field2"><label runat="server" id="lblOldInvName"></label></td>
        <td class="Field2"><label runat="server" id="lblNewInvName"></label></td>
    </tr>
    <tr>
        <td class="Label1">单位 </td>
        <td class="Field2"><label runat="server" id="lblOldUnit"></label></td>
        <td class="Field2"><label runat="server" id="lblNewUnit"></label></td>
    </tr>
    <tr>
        <td class="Label1">部门编号 </td>
        <td class="Field2"><label runat="server" id="lblOldDepartNO"></label></td>
        <td class="Field2"><label runat="server" id="lblNewDepartNO"></label></td>
    </tr>
    <tr>
        <td class="Label1">部门名称 </td>
        <td class="Field2"><label runat="server" id="lblOldDepartName"></label></td>
        <td class="Field2"><label runat="server" id="lblNewDepartName"></label></td>
    </tr>
    <tr>
        <td class="Label1">工单应发数量 </td>
        <td class="Field2"><label runat="server" id="lblOldQty"></label></td>
        <td class="Field2"><label runat="server" id="lblNewQty"></label></td>
    </tr>
    <tr>
        <td class="Label1">申请已领数量 </td>
        <td class="Field2"><label runat="server" id="lblOldRequisitionIssQty"></label></td>
        <td class="Field2"><label runat="server" id="lblNewRequisitionIssQty"></label></td>
    </tr>
        <tr>
        <td class="Label1">已领数量 </td>
        <td class="Field2"><label runat="server" id="lblOldIssQty"></label></td>
        <td class="Field2"><label runat="server" id="lblNewIssQty"></label></td>
    </tr>
    <tr>
        <td class="Label1">损耗率 </td>
        <td class="Field2"><label runat="server" id="lblOldCompScrap"></label></td>
        <td class="Field2"><label runat="server" id="lblNewCompScrap"></label></td>
    </tr>
    <tr>
        <td class="Label1">批号 </td>
        <td class="Field2"><label runat="server" id="lblOldcBatch"></label></td>
        <td class="Field2"><label runat="server" id="lblNewcBatch"></label></td>
    </tr>
    <tr>
        <td class="Label1">工段号 </td>
        <td class="Field2"><label runat="server" id="lblOldRSortSeq"></label></td>
        <td class="Field2"><label runat="server" id="lblNewRSortSeq"></label></td>
    </tr>    
    <tr>
        <td class="Label1">工序号 </td>
        <td class="Field2"><label runat="server" id="lblOldSortSeq"></label></td>
        <td class="Field2"><label runat="server" id="lblNewSortSeq"></label></td>
    </tr>    
    <tr>
        <td class="Label1">仓库编码 </td>
        <td class="Field2"><label runat="server" id="lblOldWhCode"></label></td>
        <td class="Field2"><label runat="server" id="lblNewWhCode"></label></td>
    </tr>    
    <tr>
        <td class="Label1">货位编码 </td>
        <td class="Field2"><label runat="server" id="lblOldPosition"></label></td>
        <td class="Field2"><label runat="server" id="lblNewPosition"></label></td>
    </tr>    

</table>
<script type="text/javascript" >
    var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>
    var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"

    //BOM确认变更
    function ConfirmUpdate() {

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.BomConfirmChange(Id, user)
        if (ajax.error != null) {
            alert(ajax.error.Message)
            return false;
        }

        alert("变更成功！");

        parent.window.UpdateList("");
    }


</script>

</asp:Content>
