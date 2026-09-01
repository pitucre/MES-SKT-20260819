<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="CapacityVerfyRecordEdit.aspx.cs" Inherits="SKT.LeanMES.Web.CapacityVerfyRecord.CapacityVerfyRecordEdit" Title="Edit CapacityVerfyRecord" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%= Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">计件编号</td>
            <td class="Field2">
                <asp:Label ID="labNO" runat="server"></asp:Label>
            </td>
            <td class="Label2">用户</td>
            <td class="Field2">
                <asp:Label ID="labUserName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">工序</td>
            <td class="Field2">
                <asp:Label ID="labStation" runat="server"></asp:Label>
            </td>
            <td class="Label2">设备编码</td>
            <td class="Field2">
                <asp:Label ID="labEquipmentCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">产品编码</td>
            <td class="Field2">
                <asp:Label ID="labItemCode" runat="server"></asp:Label>
            </td>
            <td class="Label2">产品名称</td>
            <td class="Field2">
                <asp:Label ID="labItemName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">数量</td>
            <td class="Field2">
                <asp:Label ID="labQty" runat="server"></asp:Label>
            </td>
            <td class="Label2">价格</td>
            <td class="Field2">
                <asp:Label ID="labPrice" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">审核工资</td>
            <td class="Field2">
                <asp:TextBox ID="txtAuditingSalary" runat="server" CssClass="TextBox" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
            </td>
            <td class="Label2">工资</td>
            <td class="Field2">
                <asp:Label ID="labSalary" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">添加时间</td>
            <td class="Field2">
                <asp:Label ID="labCreateTime" runat="server"></asp:Label>
            </td>
            <td class="Label2">添加人</td>
            <td class="Field2">
                <asp:Label ID="labCreateBy" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">产能确认时间</td>
            <td class="Field2">
                <asp:Label ID="labQueryDate" runat="server"></asp:Label>
            </td>
            <td class="Label2">备注</td>
            <td class="Field2">
                <asp:Label ID="labRemark" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var capacityVerfyRecordId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtAuditingSalary = $("#<%=this.txtAuditingSalary.ClientID%>").val();
            if (txtAuditingSalary == "") {
                alert("审核工资不能为空!")
                return
            }
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCapacityVerfyRecord.CapacityVerfyRecordEdit(capacityVerfyRecordId, txtAuditingSalary);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
    </script>

</asp:Content>