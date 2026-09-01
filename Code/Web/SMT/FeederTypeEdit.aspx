<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.FeederTypeEdit" Title="Edit FeederType" CodeBehind="FeederTypeEdit.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.FeederTypeName%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtName" runat="server" CssClass="TextBox" MaxLength="50" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Size%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSize" runat="server" CssClass="NumericBox50" Width="60px" Text="0" IsRequired='1' IsNumber='1' onkeyup="this.value=this.value.replace(/[^\d.]/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Pitch%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtPitch" runat="server" CssClass="NumericBox50" Width="60px" Text="0" IsRequired='1' IsNumber='1' onkeyup="this.value=this.value.replace(/[^\d.]/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Attrition%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtAttrition" runat="server" CssClass="NumericBox50" Width="60px" Text="0" IsRequired='1'  onkeyup="this.value=this.value.replace(/[^\d.]/g,'')"
                    onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Description%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="50"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var FeederTypeID = '<%= Request.QueryString["ID"] %>';

        function Save() {
            var errStr = "";
            var txtName = $("#<%= this.txtName.ClientID %>").val();
            var txtSize = $("#<%= this.txtSize.ClientID %>").val();
            var txtPitch = $("#<%= this.txtPitch.ClientID %>").val();
            var txtAttrition = $("#<%= this.txtAttrition.ClientID %>").val();
            var txtDescription = $("#<%= this.txtDescription.ClientID %>").val();


            txtSize = parseInt(txtSize);
            txtPitch = parseInt(txtPitch);
            txtAttrition = parseInt(txtAttrition);

            if (txtName.length <= 0) {
                errStr += "<%= Resources.Messages.FeederTypeNameEmpty %>";
            }
            if (errStr != "") {
                alert(errStr);
                return false;
            }
            var entity = {};
            var action = '<%=Request.QueryString["Action"] %>';
            if (action == "Copy") {
                entity.ID = -1;
            }
            else {
                entity.ID = FeederTypeID;
            }
            entity.Name = txtName;
            entity.Description = txtDescription;
            entity.Size = txtSize;
            entity.Pitch = txtPitch;
            entity.Attrition = txtAttrition;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceFeeder.AddFeederType(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList(entity.Name);
        }
    </script>
</asp:Content>
