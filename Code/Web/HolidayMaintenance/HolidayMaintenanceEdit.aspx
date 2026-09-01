<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="HolidayMaintenanceEdit.aspx.cs" Inherits="SKT.LeanMES.Web.HolidayMaintenance.HolidayMaintenanceEdit" Title="Edit HolidayMaintenance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%= Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">日期<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtDate" runat="server" CssClass="DateTimeBox" IsRequired='1' Width="150" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">倍数</td>
            <td class="Field2">
                <asp:DropDownList ID="ddlMultiple" runat="server" ClientIDMode="Static">
                <asp:ListItem Text="正常" Selected="True" Value="1"></asp:ListItem>
                <asp:ListItem Text="两倍" Value="2"></asp:ListItem>
                <asp:ListItem Text="三倍" Value="3"></asp:ListItem>
            </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">是否上班</td>
            <td class="Field2">
                <asp:RadioButtonList ID="rblHoliday" runat="server" RepeatDirection="Horizontal" CssClass="rbl" CellSpacing="5" CellPadding="3">
                            <asp:ListItem Selected="True" Text="否" Value="0"></asp:ListItem>
                            <asp:ListItem  Text="是" Value="1"></asp:ListItem>
                        </asp:RadioButtonList> 
            </td>
            <td class="Label2"><%= Resources.lang.Remark %></td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox"  MaxLength="500"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var holidayMaintenanceId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtDate = $("#<%=this.txtDate.ClientID%>").val();
            var ddlMultiple = $("#<%=this.ddlMultiple.ClientID%>").val();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var Holiday = 0;

            if (txtDate && isNaN(new Date(txtDate.replace(/\-/g, "\/")).getTime())) {
                alert("请输入正确的日期格式！");
                $("#<%=this.txtDate.ClientID%>").select().focus();
                return;
            }

            if ($("#<%=this.rblHoliday.ClientID %> :checked").val() == "1") {
                Holiday = 1;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxHolidayMaintenance.Edit(holidayMaintenanceId, txtDate, ddlMultiple, Holiday, txtRemark);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
    </script>

</asp:Content>