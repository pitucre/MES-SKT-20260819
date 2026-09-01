<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.MachineModelEdit" Title="Edit MODEL" CodeBehind="MachineModelEdit.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.MachineModelName%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtModelName" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MachineType%>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlMachineType" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MachineModelFamilyName%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtModelFamilyName" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1'></asp:TextBox><input
                    type="button" id="BtnModelFamilyName" class="ButtonBox" value="..." title=""
                    onclick="selectModelFamily();" />
                <asp:HiddenField ID="txtModelFamilyID" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Vendor%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtVendor" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Status%>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlStatus" runat="server">
                </asp:DropDownList>
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
        var ModelID = '<%= Request.QueryString["ID"] %>';

        function Save() {
            var errStr = "";
            var txtModelName = $("#<%= this.txtModelName.ClientID %>").val();
            var ddlMachineType = $("#<%= this.ddlMachineType.ClientID %>").val();
            var txtModelFamilyID = $("#<%= this.txtModelFamilyID.ClientID %>").val();
            var txtVendor = $("#<%= this.txtVendor.ClientID %>").val();
            var ddlStatus = $("#<%= this.ddlStatus.ClientID %>").val();
            var txtDescription = $("#<%= this.txtDescription.ClientID %>").val();

            if (txtModelName.length <= 0) {
                errStr += "<%= Resources.Messages.ModelNameEmpty %>";
            }
            if (errStr != "") {
                alert(errStr);
                return false;
            }
            var entity = {};
            var action = '<%=Request.QueryString["Action"] %>';
            if (action == "Copy") {
                entity.ModelID = -1;
            }
            else {
                entity.ModelID = ModelID;
            }
            entity.ModelName = txtModelName;
            entity.Status = ddlStatus;
            entity.Description = txtDescription;
            entity.MachineType = ddlMachineType;
            entity.Vendor = txtVendor;
            entity.MachineModelFamilyID = txtModelFamilyID;
            entity.Remark = "";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceMachineModel.EditMachineMode(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList(txtModelName);
        }

        function selectModelFamily() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=38&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }

        function getChooseValue(list) {
            $("#<%=this.txtModelFamilyName.ClientID %>").val(list[0][1]);
            $("#<%=this.txtModelFamilyID.ClientID %>").val(list[0][0]);
        }
    </script>
</asp:Content>
