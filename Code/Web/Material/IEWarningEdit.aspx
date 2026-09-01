<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="IEWarningEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Material.IEWarningEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5"></tr>
        <tr id="tr1">
            <td class="Label2">
                产品编码<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"  IsRequired='1'></asp:TextBox><input type="button" id="btnItemCode" class="ButtonBox" value="..." title="Select"
                    onclick="selectMaterials()" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                预警库龄天数<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLibraryCollar" runat="server" CssClass="TextBox" MaxLength="9" IsRequired='1'
                    onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                安全库存数<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSafetyStock" runat="server" MaxLength="9" CssClass="TextBox" IsRequired='1' onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript" language="javascript">
        var ID = '<%=Request.QueryString["ID"]%>';
        $(function () {

            /*如果是编辑状态，关闭字段提示*/
            if (parseInt(ID) > 0) {
                $(".Tips").hide();
                GetInfo();
                $("#<%=this.txtItemCode.ClientID%>").attr("readonly", "readonly");
                $("#<%=this.txtItemCode.ClientID%>").attr("disabled", "disabled");
                $("#btnItemCode").hide();
            }

            $("#btnSubmit").click(function () {
                Save();
            });

        });
        function GetInfo() {

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEarlyWarning.GetInfo(ID);
            var entity = ajax.value;
            if (entity != null || entity.length == 0) {

                $("#<%=this.txtItemCode.ClientID%>").val(entity.ItemCode);
                $("#<%=this.txtLibraryCollar.ClientID%>").val(entity.LibraryCollar);
                $("#<%=this.txtSafetyStock.ClientID%>").val(entity.SafetyStock);
            }
        }
        function selectMaterials() {

            flag = 1
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 700, height: 300 });

        }
        function getChooseValue(list) {
            switch (flag) {
                case 1:
                    $("#<%=this.txtItemCode.ClientID%>").val(list[0][2]);
                    break;
                case 2:
                    break;
                default:
                    flag = -1;
                    break;
            }

            flag = -1;
        }
        /*保存数据*/
        function Save() {
            var ItemCode = $("#<%=this.txtItemCode.ClientID%>").val().trim();
            var LibraryCollar = $("#<%=this.txtLibraryCollar.ClientID%>").val().trim();
            var SafetyStock = $("#<%=this.txtSafetyStock.ClientID%>").val().trim();

            if (parseInt(SafetyStock) < parseInt(LibraryCollar)) {
                alert("安全库存数不可小于预警库龄天数！");
                $("#<%=this.txtSafetyStock.ClientID%>").focus()
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEarlyWarning.EarlyWarningEdit(ID, ItemCode, LibraryCollar, SafetyStock);
            if (ajax.error == null) {
                alert('保存成功')
                parent.window.UpdateList();
            } else {
                alert(ajax.error.Message);
                return false;
            }
        }
    </script>
</asp:Content>
