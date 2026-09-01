<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportTypeEdit.aspx.cs"
    MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.Report.ReportTypeEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%= Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                序号<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSequence" runat="server" CssClass="NumericBox50" Text="1" IsRequired="1" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                报表类型名字(中文)<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtReportTypeNameCN" MaxLength="20" runat="server" IsRequired="1"  CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                报表类型名字(英文)<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtReportTypeNameEN" MaxLength="20" runat="server" IsRequired="1"  CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script language="javascript" type="text/javascript">
        var reportTypeId = '<%=Request.QueryString["ID"]%>';
        function Save() {
            var reportTypeName = $("#<%=this.txtReportTypeNameCN.ClientID %>").val();
            var reportTypeNameEN = $("#<%=this.txtReportTypeNameEN.ClientID %>").val();
            var seq = $("#<%=this.txtSequence.ClientID %>").val();
            var error = "";
            if ($.trim(seq) == "") {
                error += "报表序号不能为空，且只能为数字。\n";
             }
            if ($.trim(reportTypeName) == "") {
                error += "<%=Resources.Messages.ReportTypeNameCNIsEmpty %>\n";
            }
            if ($.trim(reportTypeNameEN) == "") {
                error += "<%=Resources.Messages.ReportTypeNameENIsEmpty %>\n";
            }
            if (!isNumber(seq)) {
                error += "<%=Resources.Messages.SequenceShouldBeNumber %>\n";
            }
            if (error != "") {
                alert(error);
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxReport.EditReportType(reportTypeName, reportTypeNameEN, seq, reportTypeId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");

            parent.UpdateList(reportTypeName);
        }
    </script>
</asp:Content>
