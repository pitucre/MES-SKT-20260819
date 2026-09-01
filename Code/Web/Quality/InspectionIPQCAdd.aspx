<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="InspectionIPQCAdd.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionIPQCAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                工单号
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtOrder" runat="server" IsRequired='1' CssClass="TextBox" Enabled="false"
                    MaxLength="30"></asp:TextBox>
                <input type="button" id="btn1" class="ButtonBox" value="..." title="" onclick="selectOrder();" /><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                班别
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlType" runat="server" IsRequired="1">
                    <asp:ListItem Value="0">白班</asp:ListItem>
                    <asp:ListItem Value="1">晚班</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        /*保存数据*/
        function Save() {
            var ddlType = $("#<%=this.ddlType.ClientID %>").val();
            var txtOrder = $.trim($("#<%=this.txtOrder.ClientID%>").val());
            
            var entity = {};
            entity.OrderNO = txtOrder;
            entity.ShiftType = ddlType;
            entity.CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

            var ajax = SKT.AjaxCommon.DBService.Edit("uspAddInspectionIPQC", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();
        }
        function selectOrder() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&Multiple=false&rnd=" + Math.random(), width: 400, height: 200 });
        }
        function getChooseValue(list) {
            $("#<%=this.txtOrder.ClientID %>").val(list[0][1]);
        }
    </script>
</asp:Content>
