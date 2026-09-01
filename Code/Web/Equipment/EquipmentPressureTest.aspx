<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="EquipmentPressureTest.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentPressureTest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="Label infoTips" style="margin-top: -5px; !margin-top: -25px;">
        <%=Resources.Messages.WithAsteriskIsRequired%>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">计算公式<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquation" runat="server" CssClass="TextArea" TextMode="MultiLine" Columns="5" IsRequired="1" ClientIDMode="Static"></asp:TextBox> 
            </td>
        </tr>
       
         <tr>
            <td class="Label2">机台标称压力<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtPressure" runat="server"  CssClass="TextBox"  IsRequired="1" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var id = '<%=Request.QueryString["ID"]%>';
         
        $(".numbercheck").keyup(function () {
            getDecimalVal(this);
        });

        /*保存数据*/
        function Save() {
            var txtEquation = $("#txtEquation").val();
            var txtPressure = $("#txtPressure").val();
             
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().EmployeeCName%>';
            
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            
            var entity = {};
            entity.EquipmentPressureTestId = id;
            entity.Equation = txtEquation
            entity.Pressure = txtPressure;
            entity.CreateBy = txtCreateBy;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentPressureTest.EditDtl(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            
            parent.window.Refresh();
        
    }
 
    </script>

</asp:Content>
