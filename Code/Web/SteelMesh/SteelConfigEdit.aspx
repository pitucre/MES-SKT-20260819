<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="SteelConfigEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelConfigEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label1">
                配置项<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSteelName" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1" Enabled="false"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                结果<em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlResult" runat="server">
                    <asp:ListItem Text="需要" Value="1"></asp:ListItem>
                    <asp:ListItem Text="不需要" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                系统内置<em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlIsGlobal" runat="server">
                    <asp:ListItem Text="是" Value="1"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                描述<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server"  CssClass="TextArea" TextMode="MultiLine" MaxLength="50" Width="99%" Height="50"></asp:TextBox>                
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var code = '<%= Request.QueryString["ID"] == null ? "" : Request.QueryString["ID"].ToString()%>';
        function Save() {
            var txtSteelName = $.trim($("#<%=this.txtSteelName.ClientID%>").val());
            var ddlResult = $.trim($("#<%=this.ddlResult.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSteelItem.SteelCofigEdit(code,ddlResult,txtRemark);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelConfig.aspx?name=SteelMeshEdit&ID=" + code;
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
    </script>
</asp:Content>
