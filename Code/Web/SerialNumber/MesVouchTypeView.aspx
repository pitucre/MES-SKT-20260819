<%@ Page Language="C#"  MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="MesVouchTypeView.aspx.cs" Inherits="SKT.LeanMES.Web.SerialNumber.MesVouchTypeView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="Label" style="margin-top: -5px; !margin-top: -25px;">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
      
        <tr>
            <td class="Label1">
               单据名称
            </td>
            <td class="Field1">
                <asp:Label ID ="txtTypeName"  runat ="server"></asp:Label>
                 <em>*</em>
                <asp:HiddenField ID="hdnFrmTypeValue" runat="server" Value="" />
                <asp:HiddenField ID="hdnFrmTypeName" runat="server" Value="" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                编码规则
            </td>
            <td class="Field1">
                 <asp:Label ID ="txtCodingRule"  runat ="server"></asp:Label>
                &nbsp;<asp:HiddenField ID="hdnSelectCodingRuleId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
              批号规则
            </td>
            <td class="Field1">
                <asp:Label ID ="txtRuleName"  runat ="server"></asp:Label>
                &nbsp;<asp:HiddenField ID="hdnSelectRuleNameId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                包装规则
            </td>
            <td class="Field1">
                <asp:Label ID ="txtPackRuleName"  runat ="server"></asp:Label>
                &nbsp;<asp:HiddenField ID="hdnSelectPackNameId" runat="server" Value="-1" />
            </td>
        </tr>
         <tr>
            <td class="Label1">
                备注
            </td>
            <td class="Field1">
                <asp:Label ID ="txtDesc"  runat ="server"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SerialNumber/MesVouchTypeEdit.aspx?name=SerialNumber_MesVouchTypeEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
            location.href = openWinUrl;
        }

    </script>
</asp:Content>
