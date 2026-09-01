<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AlertMessageControl.ascx.cs" Inherits="SKT.LeanMES.Web.SDP.ControlFuntion.AlertMessageControl" %>
<div>
    <table border="0" width="100%">
        <tr >
            <td class="Label2" style="width:100px;min-width:100px">
                消息<span style="color:Red">*</span>
            </td>
            <td class="Field2"  colspan="3">
                <asp:TextBox ID="txtMessage" runat="server" Rows="3" TextMode="MultiLine" 
                    class="textbox" style="border:1px solid gray;min-width:100px;width:460px"
                    Width="95%"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        /*****************************公共方法***********************************/
        function GetControl(type) {
            return "";
        }

        function GetSource(type) {
            return "";
        }

        function GetStepXml() {
            var returnXml ="<message>" + $("#<%= txtMessage.ClientID %>").val() + "</message>";
            return returnXml;
        }

        function checkValue() {
            var returnCheck = true;

            if ("" == $.trim($("#<%= txtMessage.ClientID %>").val())) {
                alert("请填写需要提示的消息");
                returnCheck = false;
            }
            return returnCheck;
        }
    </script>
</div>