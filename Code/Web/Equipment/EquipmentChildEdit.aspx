<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="EquipmentChildEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentChildEdit" Title="Edit EquipmentPosition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="Label infoTips" style="margin-top: -5px; !margin-top: -25px;">
        <%=Resources.Messages.WithAsteriskIsRequired%>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">上级设备名称<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentName" runat="server" CssClass="TextBox" MaxLength="100"></asp:TextBox>
                 <input type="button" value="..." class="ButtonBox" onclick="selectEq()" />
                <asp:HiddenField ID="HiddenEquipmentId" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">设备名称<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentNameChild" runat="server" CssClass="TextBox" MaxLength="100"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">设备编码<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentCodeChild" runat="server" CssClass="TextBox" MaxLength="100"></asp:TextBox>
            </td>
        </tr>
       <tr>
            <td class="Label2">型号规格<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtTypeSpec" runat="server" CssClass="TextBox" MaxLength="100"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Remark %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" MaxLength="500" TextMode="MultiLine" Width="90%" Height="65"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var equipmentId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var parentequipmentId = $.trim($("#<%=this.HiddenEquipmentId.ClientID%>").val());
            var txtEquipmentCode = $.trim($("#<%=this.txtEquipmentCodeChild.ClientID%>").val());
            var txtEquipmentName = $.trim($("#<%=this.txtEquipmentNameChild.ClientID%>").val());
            var txtTypeSpec = $.trim($("#<%=this.txtTypeSpec.ClientID%>").val());
        
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';


        /*表单验证*/
        /*如需表单验证可以此处处理验证 开始*/


        var entity = {};
        entity.EquipmentChildId = equipmentId;
        entity.ParentEquipmentId = parentequipmentId;
        entity.EquipmentCodeChild = txtEquipmentCode;
        entity.EquipmentNameChild = txtEquipmentName;
        entity.TypeSpec = txtTypeSpec;
        entity.Remark = txtRemark;
        entity.CreateBy = txtCreateBy;

        var ajax = SKT.LeanMES.Web.Equipment.EquipmentChildEdit.EquipmentChildEditInfo(entity);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }

        alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.UpdateList("");
        
    }

         function selectEq() {
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&Multiple=false&rnd=" + Math.random(), width: 620, height: 300 });
        }


          function getChooseValue(list) {
            if (temp == 1) {
              
                $("#<%=this.txtEquipmentName.ClientID %>").val(list[0][1]);
                $("#<%=this.HiddenEquipmentId.ClientID %>").val(list[0][0]);

             } 
            }
    </script>

</asp:Content>
