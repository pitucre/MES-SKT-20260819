<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="PieceworkCompensationEdit.aspx.cs" Inherits="SKT.LeanMES.Web.PieceWage.PieceworkCompensationEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr><td colspan="2" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td></tr>
        <tr>
          <td class="Label2"><%=Resources.lang.PieceCountingTime%><em>*</em></td>
        <td class="Field2"  colspan="3">
            <asp:TextBox ID="txtPieceCountingTime" runat="server" CssClass="DateTimeBox" IsRequired='1' Width="140" ClientIDMode="Static"></asp:TextBox>
        </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.UserName%><em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox" IsRequired='1' Enabled="false"  ClientIDMode="Static" ></asp:TextBox><input type="button" id="btnSelectProductType" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(12);" />
                <asp:HiddenField ID="hdnUserId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2"><%=Resources.lang.wage%><em>*</em></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtwage" runat="server" isNumber="1" CssClass="TextBox" IsRequired='1' onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Remark %></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" TextMode="MultiLine"  Width="60%"  runat="server" CssClass="TextArea"  MaxLength="500"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        _isHms = false; /*开启时分秒*/
        var PieceworkCompensationId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtPieceCountingTime = $("#<%=this.txtPieceCountingTime.ClientID%>").val();
            var hdnUserId = $("#<%=this.hdnUserId.ClientID%>").val();
            var txtwage = $("#<%=this.txtwage.ClientID%>").val();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            /*表单验证*/
            if (txtPieceCountingTime && isNaN(new Date(txtPieceCountingTime.replace(/\-/g, "\/")).getTime())) {
                alert("请输入正确的日期格式！");
                $("#<%=this.txtPieceCountingTime.ClientID%>").select().focus();
                return;
            }
            /*如需表单验证可以此处处理验证 开始*/
            var entity = {};
            entity.PieceworkCompensationID = PieceworkCompensationId;
            entity.PieceCountingTime = new Date(txtPieceCountingTime);
            entity.UserID = parseInt(hdnUserId);
            entity.Wage = parseFloat(txtwage);
            entity.CreateBy = username;
            entity.Remark = txtRemark;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPieceWage.PieceworkCompensationEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/PieceWage/PieceworkCompensationEdit.aspx?name=StationOutputRateEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }

        var flag = 0;
        //选择视窗
        function openChoosePage(flags) {
            var condition = "";
            flag = flags;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&PageCondition=" + condition + "&rnd=" + Math.random(), width: 600, height: 300 });
        }

        //获取选择值
        function getChooseValue(list) {
            if (flag == 12) {
                $("#txtUserName").val(list[0][3]);
                $("#hdnUserId").val(list[0][0]);
            } 
            flag = -1;
        }
    </script>
</asp:Content>
