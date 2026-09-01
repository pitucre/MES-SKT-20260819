<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="AllowanceEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Allowance.AllowanceEdit" Title="Edit Allowance" %>

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
        </tr>
        <tr>
            <td class="Label2">津贴工资<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtwages" runat="server" CssClass="TextBox" IsRequired='1' onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">产出率津贴<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtOutputAllowance" runat="server" CssClass="TextBox"  IsRequired='1' onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Remark %></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox"  MaxLength="50"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var allowanceId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtUserID = $("#<%=this.hdnUserId.ClientID%>").val();
            var txtUserName = $("#<%=this.txtUserName.ClientID%>").val();
            var txtwages = $("#<%=this.txtwages.ClientID%>").val();
            var txtOutputAllowance = $("#<%=this.txtOutputAllowance.ClientID%>").val();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());

            if (txtwages == "") {
                alert("津贴工资不能为空！");
                return false;
            }
            if (txtOutputAllowance == "") {
                alert("产出率津贴不能为空！");
                return false;
            }
            if (txtUserName == "") {
                alert("请选择用户！")
                return
            }

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAllowance.Edit(allowanceId, txtUserID, txtwages, txtRemark, txtUserName, txtOutputAllowance);
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