<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.FeederGroupEdit" Title="Edit FeederGroup" CodeBehind="FeederGroupEdit.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.MachineModelName%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtModelName" runat="server" CssClass="TextBox" Enabled="false"
                    ReadOnly="true" IsRequired='1'></asp:TextBox><input type="button" id="btnModel" class="ButtonBox"
                        value="..." title="" onclick="selectModel();" />
                <asp:HiddenField ID="txtModelID" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.minSize%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMinSize" runat="server" CssClass="NumericBox50" Width="60px"
                    onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"
                    IsNumber="1" Text="0" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.maxSize%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMaxSize" runat="server" CssClass="NumericBox50" Width="60px"
                    onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"
                    IsNumber="1" Text="0" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var FeederGroupId = '<%= Request.QueryString["ID"] %>';

        function Save() {
            var errStr = "";
            var txtModelID = $("#<%= this.txtModelID.ClientID %>").val();
            var txtModelName = $("#<%= this.txtModelName.ClientID %>").val();
            var txtMinSize = $("#<%= this.txtMinSize.ClientID %>").val();
            var txtMaxSize = $("#<%= this.txtMaxSize.ClientID %>").val();

            txtMinSize = parseInt(txtMinSize);
            txtMaxSize = parseInt(txtMaxSize);
            if (txtModelName.length <= 0) {
                errStr += "<%= Resources.Messages.ModelNameEmpty %>";
            }
            if (errStr != "") {
                alert(errStr);
                return false;
            }

            if (txtMinSize > txtMaxSize) {
                alert('设备最小值不可大于最大值！');
                $("#<%= this.txtMaxSize.ClientID %>").focus();
                return false;
            }
            var entity = {};
            entity.ID = FeederGroupId;
            entity.Description = "";
            entity.MachineModelID = txtModelID;
            entity.ModelName = txtModelName;
            entity.MinSize = txtMinSize;
            entity.MaxSize = txtMaxSize;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceFeeder.AddFeederGroup(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList(entity.ModelName);
        }

        function selectModel() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=40&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }

        function getChooseValue(list) {
            $("#<%=this.txtModelName.ClientID %>").val(list[0][1]);
            $("#<%=this.txtModelID.ClientID %>").val(list[0][0]);
        }
    </script>
</asp:Content>
