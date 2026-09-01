<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="CertificationEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Certification.CertificationEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">

    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                认证名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtCert" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                认证类型<em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlType" runat="server" IsRequired='1'>
                     <asp:ListItem></asp:ListItem>
                    <asp:ListItem Value="Skill" Text="<%$ Resources:lang,SkillsCertification %>"></asp:ListItem>
                    <asp:ListItem Value="License" Text="<%$ Resources:lang,CertificateAuthentication %>"></asp:ListItem>
                    <asp:ListItem Value="Qualification" Text="<%$ Resources:lang,Certification %>"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Description%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtDesc" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                有效期(天)
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRenewal" runat="server" CssClass="NumericBox50" MinValue='0' IsNumber='1' ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                到期提前警告天数
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtWarning" runat="server" CssClass="NumericBox50" MinValue='0' IsNumber='1' ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                到期行为
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtEvent" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
    <% if (Request.QueryString["ID"] == null) { %>
        var certID = -1;
    <% } else { %>
        var certID = <%= Request.QueryString["ID"] %>;
    <% } %>

    function Save()
    {
        var txtCert = $("#<%=this.txtCert.ClientID %>").val();
        var ddlType = $("#<%=this.ddlType.ClientID %>").val();
        var txtDesc = $("#<%=this.txtDesc.ClientID %>").val();
        var txtRenewal = $("#<%=this.txtRenewal.ClientID %>").val();
        var txtWarning = $("#<%=this.txtWarning.ClientID %>").val();
        var txtEvent = $("#<%=this.txtEvent.ClientID %>").val();
        var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var entity = {};
        entity.CertificationId=certID;
        entity.Certification=txtCert;
        entity.Type=ddlType;
        entity.Description=txtDesc;
        entity.RenewalDays=txtRenewal==""?0:txtRenewal;
        entity.WarningDays=txtWarning==""?0:txtWarning;
        entity.Expiration_Alarm_Event=txtEvent;        
        entity.Remark="";
        entity.ModifyBy = txtModifyBy;
        entity.CreateBy = txtCreateBy;       
        
        if(parseInt(txtRenewal)<parseInt(txtWarning)){
            alert("到期提前警告天数不可大于有效天数！");
            $("#<%=this.txtWarning.ClientID %>").focus();
            return false;
        }
        var ajax_inserCert = SKT.LeanMES.Web.AjaxServices.AjaxCertification.EditCertification(entity);
        if (ajax_inserCert.error ==null) 
        {
            alert("<%= Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList(txtCert);
        }     
        else
        {
            alert(ajax_inserCert.error.Message);
            return false;
        }
    }
    </script>
</asp:Content>
