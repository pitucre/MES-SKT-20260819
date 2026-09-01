<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Masters/EditMaster.master" CodeBehind="FinishProductInStorageAdd.aspx.cs" Inherits="SKT.LeanMES.Web.Material.FinishProductInStorageAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" Runat="Server" >
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">     
      <tr>
                <td class="Label1">
                   输入产品序列号：
                 </td>
                 <td class="Field1">
                 <asp:TextBox ID="txtSN" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                 </td>
              </tr>
              <tr >
                 <td id="Message" style="color: Red; height:50px; text-align:center"  colspan="2" valign="middle">     
                 </td>
              </tr>
    </table>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#txtSN").focus();
            /*扫描GRN*/
            $("#txtSN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Save();
//                    $("#txtSN").val();
//                    $("#txtSN").focus();
                }
            });
        });

        function Save() {
            var txtSN = $("#txtSN").val();
            if (txtSN == "") {
                alert("请输入序列号");
                return;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.EditFinishProductInStorage(txtSN);
            if (ajax.error != null) {
                $("#Message").html($("#Message").html()+txtSN+ajax.error.Message+"<br/>");
            } else {
                $("#Message").html($("#Message").html() + txtSN + ajax.value + "<br/>");
            }
            $("#txtSN").val("");
            $("#txtSN").focus();
        }


    </script>
</asp:Content>
