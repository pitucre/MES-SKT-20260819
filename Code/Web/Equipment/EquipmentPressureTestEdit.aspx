<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="EquipmentPressureTestEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentPressureTestEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="Label infoTips" style="margin-top: -5px; !margin-top: -25px;">
        <%=Resources.Messages.WithAsteriskIsRequired%>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.EquipmentCode %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox" Enabled="false" IsRequired="1"
        ClientIDMode="Static"></asp:TextBox><input type="button" id="btnEquipmentName"  class="ButtonBox"
                        value="..." onclick="selectEquipmentName()" />
                <asp:HiddenField ID="hdnEquipmentId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.EquipmentName %><em></em></td>
            <td class="Field2">
                <asp:Label ID="lblEquipmentName" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
         <tr>
            <td class="Label2">测试周期（天）<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtTestCycel" runat="server" Text="365"  CssClass="TextBox numbercheck"  IsRequired="1" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var id = '<%=Request.QueryString["ID"]%>';

        $().ready(function () {
            if (id > 0) {
                $("#btnEquipmentName").hide();
            }
        });

        $(".numbercheck").keyup(function () {
            getDecimalVal(this);
        });

        /*保存数据*/
        function Save() {
            var hdnEquipmentId = $("#hdnEquipmentId").val();
            var txtEquipmentCode = $("#txtEquipmentCode").val();
            var lblEquipmentName = $("#lblEquipmentName").text();
            var txtTestCycel = $("#txtTestCycel").val();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};
            entity.EquipmentPressureTestId = id;
            entity.EquipmentId = hdnEquipmentId
            entity.EquipmentCode = txtEquipmentCode;
            entity.EquipmentName = lblEquipmentName;
            entity.TestCycle = txtTestCycel;
            entity.CreateBy = txtCreateBy;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentPressureTest.Edit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            
            parent.window.Refresh();
        
    }

    function selectEquipmentName() {
        dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&Multiple=false&rnd=" + Math.random(), width: 420, height: 250 });
    }

    function getChooseValue(list) {
        $("#<%=this.hdnEquipmentId.ClientID %>").val(list[0][0]);
            $("#<%=this.txtEquipmentCode.ClientID %>").val(list[0][1]);
            $("#<%=this.lblEquipmentName.ClientID %>").text(list[0][2]);
        }
    </script>

</asp:Content>
