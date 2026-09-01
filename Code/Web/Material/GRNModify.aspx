<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="GRNModify.aspx.cs" Inherits="SKT.LeanMES.Web.Material.GRNModify" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" Runat="Server" >
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label1">
                   输入数量：
                </td>
                <td class="Field1">
                    <input id="txtQuantity" type="text" /> 
                </td>
             </tr>
            <tr>
                <td class="Label1">
                </td>
                <td class="Field1">
                    <input id="saveBtn" type="button" value="保存"  onclick="Save()"/>
                </td>
              </tr>
    </table>
    <script type="text/javascript">

        var materialId = "<%=materialId%>";
        function Save() {

            if (materialId == null || materialId == "") {
                alert("没有选择项");
                return;
            }
            var numS = $("#txtQuantity").val();
            if (numS == "") {
                alert("请输入挑选数量");
                return;
            }
            var num;
            if (isNaN(numS)) {
                alert("请输入数字");
                return;
            }
            else {
                num = parseFloat(numS);
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ModifyGRNQuantity(materialId,num);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else {
                if (ajax.value == 1) {
                    alert("<%=Resources.Messages.OperationSuccess %>");
               }
            }

            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/GRNModify.aspx?name=Material_GRNModifyEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.refresh();
            }
        }

      
    </script>
</asp:Content>
