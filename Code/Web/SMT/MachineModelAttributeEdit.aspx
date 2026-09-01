<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.MachineModelAttributeEdit" Title="Edit MODEL_ATTRIBUTE"
    CodeBehind="MachineModelAttributeEdit.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.MachineModelName %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMachineModelName" runat="server" CssClass="TextBox" Enabled="false"  IsRequired="1" ></asp:TextBox><input
                    type="button" id="BtnMachineModelName" class="ButtonBox" value="..." title=""
                    onclick="selectModel();" />
                <asp:HiddenField ID="txtMachineModelID" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                设备分区数量<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTablePosition" runat="server" CssClass="NumericBox50" MaxLength="3"
                    onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" Text="1" Width="70px"></asp:TextBox> <span class="Tips">设备分区数量应在0-255范围内</span>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MachineTableType%>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlMachineTableType" runat="server">
                     
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.StartSlotPosition%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtStartSlotPosition" runat="server"  IsRequired="1" CssClass="NumericBox50" onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')" Text="0" Width="70px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.EndSlotPosition%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtEndSlotPosition" runat="server"  IsRequired="1" CssClass="NumericBox50" onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')" Text="0" Width="70px"></asp:TextBox>
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
                <asp:TextBox ID="txtDescription" runat="server" Text="" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var ModelAttrID = '<%= Request.QueryString["ID"] %>';

        function Save() {
            var errStr = "";
            var txtMachineModelID = $("#<%= this.txtMachineModelID.ClientID %>").val();
            var txtMachineModelName = $("#<%= this.txtMachineModelName.ClientID %>").val();
            var txtTablePosition = $("#<%= this.txtTablePosition.ClientID %>").val();
            var ddlMachineTableType = $("#<%= this.ddlMachineTableType.ClientID %>").val();
            var txtStartSlotPosition = $("#<%= this.txtStartSlotPosition.ClientID %>").val();
            var ddlStatus = $("#<%= this.ddlStatus.ClientID %>").val();
            var txtEndSlotPosition = $("#<%= this.txtEndSlotPosition.ClientID %>").val();
            var txtDescription = $("#<%=this.txtDescription.ClientID %>").val();

            if (txtMachineModelName.length <= 0) {
                errStr += "<%= Resources.Messages.ModelNameEmpty %>";
            }
            if (txtTablePosition < 0 || txtTablePosition > 255) {
                errStr += "设备分区数量应在0-255范围内！\n";
            }
            if (errStr != "") {
                alert(errStr);
                return false;
            }

            var entity = {};

            entity.ModelAttrID = ModelAttrID;
            entity.MachineModelID = txtMachineModelID;
            entity.Status = ddlStatus;
            entity.TablePosition = txtTablePosition;
            entity.StartSlotPosition = txtStartSlotPosition;
            entity.EndSlotPosition = txtEndSlotPosition;
            entity.MachineTableType = ddlMachineTableType;
            entity.Remark = txtDescription;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceMachineModel.EditMachineModelAttribute(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList(txtMachineModelName);
        }

        function selectModel() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=40&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }

        function getChooseValue(list) {
            $("#<%=this.txtMachineModelName.ClientID %>").val(list[0][1]);
            $("#<%=this.txtMachineModelID.ClientID %>").val(list[0][0]);
        }
    </script>
</asp:Content>
