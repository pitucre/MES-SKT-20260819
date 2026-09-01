<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.FeederEdit" Title="Feeder Edit" CodeBehind="FeederEdit.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                Feeder号<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSerialNumbe" runat="server" CssClass="TextBox" ClientIDMode="Static" IsRequired='1' ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.FeederTypeName%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtFeederType" runat="server" CssClass="TextBox" Enabled="false"
                    ReadOnly="true" IsRequired='1' ></asp:TextBox><input type="button" id="btnType" class="ButtonBox"
                        value="..." title="" onclick="selectType();" />
                <asp:HiddenField ID="txtFeederTypeID" runat="server" Value="-1" />
            </td>
        </tr>
        <tr style="display:none">
            <td class="Label1">
                <%= Resources.lang.MachineModelName%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtModelName" runat="server" CssClass="TextBox" Enabled="false"
                    ReadOnly="true" ></asp:TextBox><input type="button" id="btnModel" class="ButtonBox"
                        value="..." title="" onclick="selectModel();" />
                <asp:HiddenField ID="txtModelID" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.FeederCategory%>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlFeederCategory" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MaxUseDuration%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMaxUseDuration" runat="server" CssClass="NumericBox50" Width="60px"
                    onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"
                    IsNumber="1" Text="0"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MaxUnuseDuration%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMaxUnuseDuration" runat="server" CssClass="NumericBox50" Width="60px"
                    onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"
                    IsNumber="1" Text="0"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MaxPickUp%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMaxPickUp" runat="server" CssClass="NumericBox50" Width="60px"
                    onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"
                    IsNumber="1" Text="0"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MaxPickUpErr%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMaxPickUpErr" runat="server" CssClass="NumericBox50" Width="60px"
                    onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"
                    IsNumber="1" Text="0"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MaxPickUpErrRatio%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMaxPickUpErrRatio" runat="server" CssClass="NumericBox50" Width="60px"
                    onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"
                    IsNumber="1" Text="0"></asp:TextBox>
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
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var FeederId = '<%= Request.QueryString["ID"] %>';

        function Save() {
            var errStr = "";
            var txtModelID = $("#<%= this.txtModelID.ClientID %>").val();
            var txtSerialNumbe = $.trim($("#<%= this.txtSerialNumbe.ClientID %>").val());
            var txtFeederType = $("#<%= this.txtFeederType.ClientID %>").val();
            var txtModelName = $("#<%= this.txtModelName.ClientID %>").val();
            var txtFeederTypeID = $("#<%= this.txtFeederTypeID.ClientID %>").val();
            var ddlFeederCategory = $("#<%= this.ddlFeederCategory.ClientID %>").val();
            var txtMaxUseDuration = $("#<%= this.txtMaxUseDuration.ClientID %>").val();
            var txtMaxUnuseDuration = $("#<%= this.txtMaxUnuseDuration.ClientID %>").val();
            var txtMaxPickUp = $("#<%= this.txtMaxPickUp.ClientID %>").val();
            var txtMaxPickUpErr = $("#<%= this.txtMaxPickUpErr.ClientID %>").val();
            var txtMaxPickUpErrRatio = $("#<%= this.txtMaxPickUpErrRatio.ClientID %>").val();
            var ddlStatus = $("#<%= this.ddlStatus.ClientID %>").val();
            var txtDescription = $("#<%= this.txtDescription.ClientID %>").val();

            if (txtSerialNumbe.length <= 0) {
                errStr += "<%= Resources.Messages.SerialNumbeEmpty %>";
            }
//            if (txtModelName.length <= 0) {
//                errStr += "<%= Resources.Messages.ModelNameEmpty %>";
//            }
            if (txtFeederType.length <= 0) {
                errStr += "<%= Resources.Messages.FeederTypeEmpty %>";
            }
            if (errStr != "") {
                alert(errStr);
                return false;
            }

            if (parseInt(txtMaxUseDuration) < parseInt(txtMaxUnuseDuration)) {
                alert("最大未使用天数不能大于最大使用天数！");
                $("#<%= this.txtMaxUnuseDuration.ClientID %>").focus();
                return falg;
            }

            if (parseInt(txtMaxPickUp) < parseInt(txtMaxPickUpErr)) {
                alert("最大使用错误数不能大于最大使用次数！");
                $("#<%= this.txtMaxPickUpErr.ClientID %>").focus();
                return falg;
            }

            var entity = {};
            var action = '<%=Request.QueryString["Action"] %>';
            if (action == "Copy") {
                entity.ID = -1;
            }
            else {
                entity.ID = FeederId;
            }
            entity.Description = txtDescription;
            entity.MachineModelID = txtModelID;
            entity.ModelName = txtModelName;
            entity.SerialNumber = txtSerialNumbe;
            entity.FeederTypeID = txtFeederTypeID;
            entity.FeederCategoryID = ddlFeederCategory;
            entity.MaxUseDuration = (txtMaxUseDuration == "" ? 0 : txtMaxUseDuration);
            entity.MaxUnuseDuration = (txtMaxUnuseDuration == "" ? 0 : txtMaxUnuseDuration);
            entity.MaxPickUp = (txtMaxPickUp == "" ? 0 : txtMaxPickUp);
            entity.MaxPickUpErr = (txtMaxPickUpErr == "" ? 0 : txtMaxPickUpErr);
            entity.StatusID = ddlStatus;
            entity.PickUpErrRatio = txtMaxPickUpErrRatio;


            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceFeeder.AddFeeder(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList(entity.ModelName);
        }
        var falg = 0;
        function selectModel() {
            falg = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=40&Multiple=false&rnd=" + Math.random(), width: 650, height: 320 });
        }

        function selectType() {
            falg = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=41&Multiple=false&rnd=" + Math.random(), width: 650, height: 320 });
        }

        function getChooseValue(list) {
            if (falg == 1) {
                $("#<%=this.txtModelName.ClientID %>").val(list[0][1]);
                $("#<%=this.txtModelID.ClientID %>").val(list[0][0]);
            }
            if (falg == 2) {
                $("#<%=this.txtFeederType.ClientID %>").val(list[0][1]);
                $("#<%=this.txtFeederTypeID.ClientID %>").val(list[0][0]);
            }
        }
    </script>
</asp:Content>
