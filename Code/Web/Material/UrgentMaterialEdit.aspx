<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="UrgentMaterialEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Material.UrgentMaterialEdit" Title="Edit UrgentMaterial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.ItemCode %><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true"></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." onclick="chooseMaterial()" />
            </td>
            <td class="Label2"><%= Resources.lang.OrderFormNO %></td>
            <td class="Field2">
                <asp:TextBox ID="txtPOCode" runat="server" CssClass="TextBox" ReadOnly="true"></asp:TextBox><input
                    type="button" id="btnSelectPo" class="ButtonBox" value="..." onclick="choosePOCode()" />
            </td>
        </tr>
        <tr>
            <td class="Label2">开始时间<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtStarDateTime" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true"></asp:TextBox>
            </td>
            <td class="Label2">结束时间<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtEndDateTime" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var urgentMaterialId = '<%=Request.QueryString["ID"]%>';
        $(function () {
            $("#<%=this.txtStarDateTime.ClientID%>").datepicker({
                showHms: true,
<%--                onClose: function (selectedDate) {
                    $("#<%=this.txtEndDateTime.ClientID%>").datepicker("option", "minDate", selectedDate);
                }--%>
            });
            $("#<%=this.txtEndDateTime.ClientID%>").datepicker({
                showHms: true,
<%--                onClose: function (selectedDate) {
                    $("#<%=this.txtStarDateTime.ClientID%>").datepicker("option", "maxDate", selectedDate);
                }--%>
            });
        });





        function chooseMaterial() {
            Mark = 1
            dialog({ title: "", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }
        function choosePOCode() {
            Mark = 2
            if ($("#<%=this.txtItemCode.ClientID%>").val() == '') {
                alert("请选择物料");
                return false;
            }
            var pageCondition = " ItemCode='" + $("#<%=this.txtItemCode.ClientID%>").val() + "'";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=608&PageCondition=" + pageCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }
        function getChooseValue(list) {
            if (Mark == 1)
                $("#<%=this.txtItemCode.ClientID%>").val(list[0][2]);
            if (Mark == 2)
                $("#<%=this.txtPOCode.ClientID%>").val(list[0][1]);
        }
        /*保存数据*/
        function Save() {
            var txtItemCode = $.trim($("#<%=this.txtItemCode.ClientID%>").val());
            var txtPOCode = $.trim($("#<%=this.txtPOCode.ClientID%>").val());
            var txtStarDateTime = $("#<%=this.txtStarDateTime.ClientID%>").val();
            var txtEndDateTime = $("#<%=this.txtEndDateTime.ClientID%>").val();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

            if (CompareDate(txtStarDateTime, txtEndDateTime)) {
                alert("结束时间不能小于开始时间");
                return false;
            }

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.UrgentMaterialId = urgentMaterialId
            entity.ItemCode = txtItemCode;
            entity.POCode = txtPOCode;
            entity.StarDateTime = new Date(Date.parse(txtStarDateTime.replace(/-/g, "/")));
            entity.EndDateTime = new Date(Date.parse(txtEndDateTime.replace(/-/g, "/")));
            entity.CreateBy = txtCreateBy;
            entity.UpdateBy = txtCreateBy;
            entity.Reserve = '';
            entity.Reserve1 = '';

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxUrgentMaterial.UrgentMaterialEdit(entity);
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
        function CompareDate(d1, d2) {
            return ((new Date(d1.replace(/-/g, "\/"))) > (new Date(d2.replace(/-/g, "\/"))));
        }
    </script>

</asp:Content>
