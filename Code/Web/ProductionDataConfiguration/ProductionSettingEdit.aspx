<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" 
    CodeBehind="ProductionSettingEdit.aspx.cs" Inherits="SKT.LeanMES.Web.ProductionDataConfiguration.ProductionSettingEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
         <tr>
            <td class="Label1">
                配置类型
            </td>
            <td class="Field1">
                <asp:DropDownList runat="server" ID="ddlConfigType" ClientIDMode="Static">                   
                    <asp:ListItem Value="1">是否JIT发料</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="showIsCheckBox">
            <td class="Label1">
                配置数据
            </td>
            <td class="Field1">
                <asp:DropDownList runat="server" ID="ddlIsCheckBox" ClientIDMode="Static">
                    <asp:ListItem Value="1">是</asp:ListItem>
                    <asp:ListItem Value="2">否</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                备注
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>

    </table>
    <script type="text/javascript">
        var productionSettingId = '<%=Request.QueryString["ID"]%>';
        
        function Save() {
            var txtID = $("#ddlConfigType").val() * 1;
            var txtConfigType = $("#ddlConfigType").find(":selected").text();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtIsGlobal = 1;
            var txtConfigResult = $("#ddlIsCheckBox").val();;
            var txtConfigDesc = $("#ddlIsCheckBox").find(":selected").text();
            

            
            var entity = {};

            entity.ID = productionSettingId;
            entity.ConfigTypeId = txtID;
            entity.ConfigType = txtConfigType;
            entity.ConfigResult = txtConfigResult;
            entity.ConfigDesc = txtConfigDesc;
            entity.IsGlobal = Boolean(txtIsGlobal);
            entity.Remark = txtRemark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProductionSetting.ProdSettingEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.UpdateList(txtID);

        }
    </script>
</asp:Content>
