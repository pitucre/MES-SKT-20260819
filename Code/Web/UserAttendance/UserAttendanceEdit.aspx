<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="UserAttendanceEdit.aspx.cs" Inherits="SKT.LeanMES.Web.UserAttendance.UserAttendanceEdit" Title="Edit UserAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%= Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">用户<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" Width="64%" IsRequired='1'></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(12);" />
                <asp:HiddenField ID="hdnUserId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">日期<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtDate" runat="server" CssClass="DateTimeBox" Width="150" ClientIDMode="Static" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr style="display:none;">
            <td class="Label2">部门中心类别</td>
            <td class="Field2">
                <asp:TextBox ID="txtCategory" runat="server" CssClass="TextBox"  MaxLength="100"></asp:TextBox>
            </td>
            <td class="Label2">部门</td>
            <td class="Field2">
                <asp:TextBox ID="txtDepartment" runat="server" CssClass="TextBox"  MaxLength="100"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">职务</td>
            <td class="Field2">
                <asp:TextBox ID="txtDuty" runat="server" CssClass="TextBox"  MaxLength="100"></asp:TextBox>
            </td>
            <td class="Label2">入职日期</td>
            <td class="Field2">
                <asp:TextBox ID="txtEntryDate" runat="server" CssClass="DateTimeBox" Width="150" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">是否转正</td>
            <td class="Field2">
                <asp:RadioButtonList ID="rblBecome" runat="server" RepeatDirection="Horizontal" CssClass="rbl" CellSpacing="5" CellPadding="3">
                            <asp:ListItem Selected="True" Text="否" Value="0"></asp:ListItem>
                            <asp:ListItem  Text="是" Value="1"></asp:ListItem>
                        </asp:RadioButtonList> 
            </td>
            <td class="Label2" style="display:none;">班次</td>
            <td class="Field2" style="display:none;">
                <asp:TextBox ID="txtShift" runat="server" CssClass="TextBox"  MaxLength="100"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">上班天数</td>
            <td class="Field2">
                <asp:TextBox ID="txtWorkDay" runat="server" CssClass="TextBox" Text="0" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
            </td>
            <td class="Label2">上班时间</td>
            <td class="Field2">
                <asp:TextBox ID="txtWorkTime" runat="server" CssClass="TextBox" Text="0" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">平常时间</td>
            <td class="Field2">
                <asp:TextBox ID="txtUsualTime" runat="server" CssClass="TextBox" Text="0" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
            </td>
            <td class="Label2">平常加班</td>
            <td class="Field2">
                <asp:TextBox ID="txtUsualOverTime" runat="server" CssClass="TextBox" Text="0" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">周末加班</td>
            <td class="Field2">
                <asp:TextBox ID="txtWeekendOverTime" runat="server" CssClass="TextBox" Text="0" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Remark %></td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox"  MaxLength="50"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var userAttendanceId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtUserName = $.trim($("#<%=this.txtUserName.ClientID%>").val());
            var txtDate = $("#<%=this.txtDate.ClientID%>").val();
            var txtCategory = $.trim($("#<%=this.txtCategory.ClientID%>").val());
            var txtDepartment = $.trim($("#<%=this.txtDepartment.ClientID%>").val());
            var txtDuty = $.trim($("#<%=this.txtDuty.ClientID%>").val());
            var txtEntryDate = $("#<%=this.txtEntryDate.ClientID%>").val();
            var txtShift = $.trim($("#<%=this.txtShift.ClientID%>").val());
            var txtWorkDay = $("#<%=this.txtWorkDay.ClientID%>").val();
            var txtWorkTime = $("#<%=this.txtWorkTime.ClientID%>").val();
            var txtUsualTime = $("#<%=this.txtUsualTime.ClientID%>").val();
            var txtUsualOverTime = $("#<%=this.txtUsualOverTime.ClientID%>").val();
            var txtWeekendOverTime = $("#<%=this.txtWeekendOverTime.ClientID%>").val();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());

            if (txtDate && isNaN(new Date(txtDate.replace(/\-/g, "\/")).getTime())) {
                alert("请输入正确的日期格式！");
                $("#<%=this.txtDate.ClientID%>").select().focus();
                return;
            }

            if (txtEntryDate && isNaN(new Date(txtEntryDate.replace(/\-/g, "\/")).getTime())) {
                alert("请输入正确的日期格式！");
                $("#<%=this.txtEntryDate.ClientID%>").select().focus();
                return;
            }

            if (txtWorkDay == "") {
                txtWorkDay = 0;
            }
            if (txtWorkTime == "") {
                txtWorkTime = 0;
            }
            if (txtUsualTime == "") {
                txtUsualTime = 0;
            }
            if (txtUsualOverTime == "") {
                txtUsualOverTime = 0;
            }
            if (txtWeekendOverTime == "") {
                txtWeekendOverTime = 0;
            }
            var txtIsBecome = 0;

            if ($("#<%=this.rblBecome.ClientID %> :checked").val() == "1") {
                txtIsBecome = 1;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxUserAttendance.Edit(userAttendanceId, txtUserName, txtDate, txtCategory, txtDepartment, txtDuty, txtEntryDate, txtIsBecome.toString(), txtShift, txtWorkDay.toString(), txtWorkTime.toString(), txtUsualTime.toString(), txtUsualOverTime.toString(), txtWeekendOverTime.toString(), txtRemark);
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


        var flag = 0;
        //选择视窗
        function openChoosePage(flags) {
            flag = flags;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        //获取选择值
        function getChooseValue(list) {
            if (flag == 12) {
                $("#txtUserName").val(list[0][2]);
                $("#hdnUserId").val(list[0][0]);
            }
            flag = -1;
        }
    </script>

</asp:Content>