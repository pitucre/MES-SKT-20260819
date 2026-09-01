<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="SteelIn.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelIn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                 钢网刮刀编号<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSteelMeshCode" runat="server" CssClass="TextBox"  ReadOnly="true" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                 钢网刮刀名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtName" runat="server" CssClass="TextBox"  ReadOnly="true"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                张力
            </td>
            <td class="Field1">                
                <asp:TextBox ID="txtTension" runat="server" CssClass="TextArea"  MaxLength="10" TextMode="MultiLine" Columns="2" Width="80%" Height="60px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
               外观检查
            </td>
            <td class="Field1" id="tdAdmin">
                <asp:TextBox ID="txtCheckResult" runat="server" CssClass="TextArea" MaxLength="50" TextMode="MultiLine" Columns="2" Width="80%" Height="60px"></asp:TextBox>
            </td>
        </tr> 
    </table>
    <script type="text/javascript">
        var Id = '<%= Request.QueryString["ID"] == null ? "-1" : Request.QueryString["ID"]%>';
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        $(function () {
            var txtSteelMeshCode = $("#<%=this.txtSteelMeshCode.ClientID %>").val();
            if(txtSteelMeshCode!= ""){
                $("#<%=this.txtSteelMeshCode.ClientID %>").attr("disabled","true");
            }
        });

        function Save() {
            var txtSteelMeshCode = $("#<%=this.txtSteelMeshCode.ClientID %>").val();
            var txtTension = $("#<%=this.txtTension.ClientID %>").val();
            var txtCheckResult = $("#<%=this.txtCheckResult.ClientID %>").val();
           
            if(txtSteelMeshCode==""){
                alert("请填写钢网编号!");
                return false;
            }            
            if (!confirm("是否确认清洗？")) {
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEqSteelNet.SteelWashNew(txtSteelMeshCode, txtTension, txtCheckResult, userName, 0);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('设备清洗成功');              
            parent.window.UpdateCodeList(txtSteelMeshCode);
        }
    </script>
</asp:Content>
