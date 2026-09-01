<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="WarningTypeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warning.WarningTypeEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
     <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">       
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarningTypeName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWarningTypeName" runat="server" CssClass="TextBox" IsRequired="1" MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.WarningGroup %><em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlWarningGroup" runat="server" IsRequired="1">
                    <asp:ListItem Text="<%$ Resources:Enum, Choose %>" Value=""></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, SystemWarning %>" Value="1"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, ManufactureWarning %>" Value="2"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, QualityWarning %>" Value="3"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarningTypeValue %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWarningTypeValue" runat="server" CssClass="TextBox" IsRequired="1" IsNumber="1"></asp:TextBox>
            </td>
            <td class="Label2">存储过程</td>
            <td  class="Field2">MES_NcCaseWarning</td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine" Height="60px"  Width="90%" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var warningTypeId = '<%=Request.QueryString["ID"]%>';

        $().ready(function () {
             $("#<%=this.txtWarningTypeValue.ClientID%>").keyup(function(){
                 getDecimalVal(this);             
             });
        });
        /*保存数据*/
        function Save() {
            var txtWarningTypeName = $.trim($("#<%=this.txtWarningTypeName.ClientID%>").val());
            var txtWarningTypeValue = $("#<%=this.txtWarningTypeValue.ClientID%>").val();
            var ddlWarningGroup = $("#<%=this.ddlWarningGroup.ClientID%>").val();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.WarningTypeId = warningTypeId
            entity.WarningTypeName = txtWarningTypeName;
            entity.WarningTypeValue = parseFloat(txtWarningTypeValue);
            entity.WarningGroup = ddlWarningGroup;
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;
            entity.Remark = txtRemark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarning.WarningTypeEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warning/WarningTypeEdit.aspx?name=Quality_WarningTypeEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            } else {
                parent.window.Refresh();
            }
        }
    </script>
</asp:Content>
