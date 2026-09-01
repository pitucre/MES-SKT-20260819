<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShopOrderChangeCompare.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ShopOrderChangeCompare" MasterPageFile="~/Masters/ViewMaster.master" %>
<asp:Content ContentPlaceHolderID="viewcontent" runat="server">

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
        <td class="Label1">工单创建日期 </td>
        <td class="Field2"><label runat="server" id="lblOldCreateDate"></label></td>
        <td class="Field2"><label runat="server" id="lblNewCreateDate"></label></td>
    </tr>
<%--    <tr>
        <td class="Label1">单身项次  </td>
        <td class="Field2"><label runat="server" id="lblOldRowNO"></label></td>
        <td class="Field2"><label runat="server" id="lblNewRowNO"></label></td>
    </tr>--%>
    <tr>
        <td class="Label1">工单类型 </td>
        <td class="Field2"><label runat="server" id="lblOldBusType"></label></td>
        <td class="Field2"><label runat="server" id="lblNewBusType"></label></td>
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
<%--    <tr>
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
    </tr>--%>
    <tr>
        <td class="Label1">工单数量 </td>
        <td class="Field2"><label runat="server" id="lblOldQty"></label></td>
        <td class="Field2"><label runat="server" id="lblNewQty"></label></td>
    </tr>
<%--    <tr>
        <td class="Label1">入库数量 </td>
        <td class="Field2"><label runat="server" id="lblOldInStoargeQty"></label></td>
        <td class="Field2"><label runat="server" id="lblNewInStoargeQty"></label></td>
    </tr>--%>
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
<%--    <tr>
        <td class="Label1">备注 </td>
        <td class="Field2"><label runat="server" id="lblOldMemo"></label></td>
        <td class="Field2"><label runat="server" id="lblNewMemo"></label></td>
    </tr>--%>
    <tr>
        <td class="Label1">状态 </td>
        <td class="Field2"><label runat="server" id="lblOldMoStatus"></label></td>
        <td class="Field2"><label runat="server" id="lblNewMoStatus"></label></td>
    </tr>
</table>

<script type="text/javascript" >
    var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>
    var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"

    //确认更新
    function ConfirmUpdate() {

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.ERP_MO_ConfirmUpdate(Id, user)
        if (ajax.error != null) {
            alert(ajax.error.Message)
            return false;
        }

        alert("更新成功！");
        parent.window.UpdateList("");
    }

</script>

</asp:Content>

