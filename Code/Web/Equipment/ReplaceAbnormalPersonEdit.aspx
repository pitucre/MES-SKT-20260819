<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ReplaceAbnormalPersonEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.ReplaceAbnormalPersonEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="Label infoTips" style="margin-top: -5px; !margin-top: -25px;">
        <%=Resources.Messages.WithAsteriskIsRequired%>
    </div>
    <table width="100%" class="EditeContentTable">

        <tr>
            <td class="Label1">处理人<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtOperator" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="True"  Width="60%"></asp:TextBox><input type="button" value="..." class="ButtonBox" id="btnUser" onclick="selectUser()" />
                <asp:HiddenField ID="hdOperator" runat="server" />

            </td>
        </tr>
    </table>
    <asp:HiddenField runat="server" ID="hidSatatus" Value="-1" />
    <script type="text/javascript">
        var id = '<%=Request.QueryString["ID"]%>';
        $(function () {
            if ($("#<%=this.hidSatatus.ClientID%>").val() > 1) {
                $("#btnUser").attr("disabled", true);
            }
        })
        /*保存数据*/
        function Save() {
            var ajax = SKT.LeanMES.Web.Equipment.ReplaceAbnormalPersonEdit.EditOperator(id, $("#<%=this.hdOperator.ClientID%>").val());
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
           parent.window.refresh();

    }

    var chooseFlag = -1;
    /*处理人*/
    function selectUser() {
        chooseFlag = 1;
        var searchCondition = "DepartName='模具部'";
        dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&PageCondition=" + searchCondition + "&Multiple=true&rnd=" + Math.random(), width: 500, height: 300 });
         }

         function getChooseValue(list) {
             var operator = "";
             var operatorCName = "";
             if (chooseFlag == 1) {
                 if (list.length > 1) {
                     for (var i = 0; i < list.length; i++) {
                         operator += list[i][2] + ",";
                         operatorCName += list[i][3] + ",";
                     }
                     operator = operator.substring(0, operator.length - 1);
                     operatorCName = operatorCName.substring(0, operatorCName.length - 1);
                 }
                 else {
                     operator = list[0][2];
                     operatorCName = list[0][3];
                 }

                 $("#<%=this.hdOperator.ClientID %>").val(operator);
                 $("#<%=this.txtOperator.ClientID %>").val(operatorCName);
            }
        }
    </script>

</asp:Content>

