<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.BasalData.MaskMemberEdit" CodeBehind="MaskMemberEdit.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.Sequence%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSeq" IsRequired='1' IsNumber='1' runat="server" onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')" CssClass="TextBox NumericBox50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.DisplayMask%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtDisplay" runat="server" IsRequired='1' CssClass="TextBox" Width="175px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MaskType%><em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlType" runat="server" IsRequired='1' >
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem Text="简单格式" Value="Simple Format" ></asp:ListItem>
                    <asp:ListItem Text="正则表达式" Value="Reg Expression" ></asp:ListItem>
                   <%-- <asp:ListItem>Partial Checking</asp:ListItem>--%>
                </asp:DropDownList>
            </td>
        </tr>
        <tr style="display:none;">
            <td class="Label1">
                <%= Resources.lang.MinLength%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMin" runat="server" CssClass="TextBox NumericBox" Width="65px" onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
        <tr  style="display:none;">
            <td class="Label1">
                <%= Resources.lang.MaxLength%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMax" runat="server" CssClass="TextBox NumericBox" Width="65px" onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.ValidFrom%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtFrom" runat="server" CssClass="DateTimeBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.ValidTo%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTo" runat="server" CssClass="DateTimeBox"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var ID = '<%= Request.QueryString["ID"] %>';
        var TID = '<%= Request.QueryString["TID"] %>';

        function Save() {
            var errStr = "";
            var txtSeq = $("#<%=this.txtSeq.ClientID %>").val();
            var txtDisplay = $("#<%=this.txtDisplay.ClientID %>").val();
            var ddlType = $("#<%=this.ddlType.ClientID %>").val();

            var txtMin = $("#<%=this.txtMin.ClientID %>").val();
            if (txtMin.length == 0) {
                txtMin = 0;
            }
            else {
                if (txtMin.length > 0 && !isNumber(txtMin)) {
                    errStr += "<%= Resources.lang.MinLength%>" + "<%= Resources.Messages.MustbeNumber %>";
                }
            }
            var txtMax = $("#<%=this.txtMax.ClientID %>").val();
            if (txtMax.length == 0) {
                txtMax = 0;
            }
            else {
                if (txtMax.length > 0 && !isNumber(txtMax)) {
                    errStr += "<%= Resources.lang.MaxLength%>" + "<%= Resources.Messages.MustbeNumber %>";
                }
            }
            //最大值必须大于最小值    
            if (Number(txtMax) < Number(txtMin)) {
                errStr += "<%= Resources.Messages.MaxMustLargeMin %>";
            }

            var txtFrom = $("#<%=this.txtFrom.ClientID %>").val();
            var txtTo = $("#<%=this.txtTo.ClientID %>").val();

//            if ((txtFrom == "" && txtTo != "") || (txtFrom != "" && txtTo == "")) {
//                errStr += "<%= Resources.Messages.DateBothEmpty %>";
//            }
            if (ddlType == "" || ddlType == null) {
                errStr += "<%= Resources.Messages.WithAsteriskIsRequiredAlert %>";
            }
            if (errStr != "") {
                alert(errStr);
                return false;
            }

            if (txtFrom != "" && txtTo != "") {
                if (!checkTwoDate(txtFrom, txtTo)) {
                    return false;
                }
            }
            var action = '<%=Request.QueryString["Action"] %>';
            var entity = {};
            if (action == "Copy") {
                entity.ID = -1;
            }
            else {
                entity.ID = ID;
            }
            entity.MaskID = TID;
            entity.Sequence = txtSeq;
            entity.MaskType = ddlType;
            entity.DisplayMask = txtDisplay;
            entity.RegularExpression = "";
            entity.MinLength = txtMin;
            entity.MaxLength = txtMax;

            var ajax_inserMember = SKT.LeanMES.Web.AjaxServices.AjaxMaskGroup.MaintenanceMaskGroupMember(entity, txtFrom, txtTo);
            if (ajax_inserMember.error != null) {
                alert(ajax_inserMember.error.Message);
                return false;
            }
            else {
                alert("<%= Resources.Messages.SaveInSuccess %>");
            }
            parent.window.UpdateList(TID);
        }  
    
    </script>
</asp:Content>
