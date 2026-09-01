<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="NCCodeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.NCCode.NCCodeEdit"
    Title="Edit NCCode" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                不良代码类型
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtNCCodeType" runat="server" CssClass="TextBox" Enabled="false" ></asp:TextBox><input
                    type="button" id="btnChooseNCCodeType" class="ButtonBox" value="..." title=""
                    onclick="selectNCCodeType();" />
                <asp:HiddenField ID="hdnNCCodeTypeId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.NCCode%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtNCCode" runat="server" CssClass="TextBox" MaxLength="20" IsRequired='1' ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.DataType%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDataType" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1' ></asp:TextBox><input type="button" id="btnDataType" class="ButtonBox" value="..." title="" onclick="selectDateType();" />
                <asp:HiddenField ID="txtDataTypeID" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Category%>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlCategory" runat="server">
                    <asp:ListItem Value="Failure" Text="不良现象"></asp:ListItem>
                    <asp:ListItem Value="Defect" Text="不良原因"></asp:ListItem>
                    <asp:ListItem Value="Repair" Text="维修方法"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Status%>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="Enabled" Text="生效"></asp:ListItem>
                    <asp:ListItem Value="Disabled" Text="失效"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Description %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="50"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var nCCodeId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var errStr = "";
            txtNCCode = $.trim($("#<%=this.txtNCCode.ClientID%>").val());
            ddlStatus = $("#<%=this.ddlStatus.ClientID%>").val();
            ddlCategory = $("#<%=this.ddlCategory.ClientID%>").val();
            txtDataTypeID = $("#<%=this.txtDataTypeID.ClientID%>").val();
            txtDataType = $("#<%=this.txtDataType.ClientID%>").val();
            txtDescription = $("#<%=this.txtDescription.ClientID%>").val();
            txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            hdnNCCodeTypeId = $("#<%=this.hdnNCCodeTypeId.ClientID %>").val();

            /*表单验证*/
            if (txtNCCode.length <= 0) {
                errStr += "<%= Resources.Messages.NCCodeEmpty %>";
            }
            if (txtDataType.length <= 0) {
                errStr += "<%= Resources.Messages.DataTypeEmpty %>";
            }
            if (errStr != "") {
                alert(errStr);
                return false;
            }
            var entity = {};
            var action = '<%=Request.QueryString["Action"] %>';
            if (action == "Copy") {
                entity.NCCodeId = -2;
            }
            else {
                entity.NCCodeId = nCCodeId;
            }
            entity.NCCode = txtNCCode;
            entity.Status = ddlStatus;
            entity.Category = ddlCategory;
            entity.DataTypeID = txtDataTypeID;
            entity.DataType = txtDataType;
            entity.Description = txtDescription;
            entity.ModifyBy = txtModifyBy;
            entity.CreateBy = txtCreateBy;
            entity.NCCodeTypeId = hdnNCCodeTypeId;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxNCCode.EditNCCode(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.UpdateList(txtNCCode);
        }

        /*选择数据类型*/
        function selectDateType() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot  %>/Framework/ChoosePage.aspx?PageId=2&Multiple=false&rnd=" + Math.random(), width: 545, height: 300 });
        }

        /*选择不良代码类型*/
        function selectNCCodeType() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot  %>/Framework/ChoosePage.aspx?PageId=67&Multiple=false&CallBackFunc=setNCCodeType&rnd=" + Math.random(), width: 545, height: 300 });
        }

        /*设置数据类型*/
        function getChooseValue(list) {
            $("#<%=this.txtDataType.ClientID %>").val(list[0][2]);
            $("#<%=this.txtDataTypeID.ClientID %>").val(list[0][0]);
        }

        /*设置不良代码类型*/
        function setNCCodeType(list) {
            $("#<%=this.txtNCCodeType.ClientID %>").val(list[0][1]);
            $("#<%=this.hdnNCCodeTypeId.ClientID %>").val(list[0][0]);
        }
    </script>
</asp:Content>
