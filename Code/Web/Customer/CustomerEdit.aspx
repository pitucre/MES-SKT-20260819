<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="CustomerEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Customer.CustomerEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                客户全称<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtCustomerRemarke" runat="server" CssClass="TextBox" IsRequired='1'
                    Width="200px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.CustomerName%><em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtCustomerName" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                客户编码<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtCustomerCode" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                国籍
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtCountry" runat="server" CssClass="TextBox" Text="中国" ></asp:TextBox>
            </td>
            <td class="Label2" style="display:none;">
                省
            </td>
            <td class="Field2" style="display:none;">
                <asp:TextBox ID="txtStateProvince" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr style="display:none;">
            <td class="Label2">
                <%= Resources.lang.City%>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtCity" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                地址<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <SKTControl:PCD ID="PCD1" runat="server" ></SKTControl:PCD>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                详细地址<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtCustomerAddress1" CssClass="TextArea" TextMode="MultiLine" runat="server"
                    IsRequired='1' Width="400px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                邮箱地址
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                邮编
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPostal" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                备注
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtCustomerAddress2" CssClass="TextArea" TextMode="MultiLine" runat="server"
                    Width="400px"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#selProvince").val($("#<%=this.txtStateProvince.ClientID %>").val());
            bindCity($("#<%=this.txtStateProvince.ClientID %>").val());
            var city = $("#<%=this.txtCity.ClientID %>").val();
            var dist = "";
            if (city.indexOf("，") != -1) {
                var cityArr = city.split("，");
                city = cityArr[0];
                dist = cityArr[1];
            }
            $("#selCity").val(city);
            bindDist(city);
            $("#selDistrict").val(dist);

        });
        function Save() {
            var customerId = '<%=Request.QueryString["ID"] %>';
            var action = '<%=Request.QueryString["Action"] %>';
            var errStr = "";
            var txtCustomerName = $.trim($("#<%=this.txtCustomerName.ClientID %>").val());
            var txtCustomerCode = $.trim($("#<%=this.txtCustomerCode.ClientID %>").val());
            var txtCustomerAddress1 = $("#<%=this.txtCustomerAddress1.ClientID %>").val();
            var txtCustomerAddress2 = $("#<%=this.txtCustomerAddress2.ClientID %>").val();
            var txtCity = $("#selCity").val() + "，" + $("#selDistrict").val(); // $("#<%=this.txtCity.ClientID %>").val();
            var txtStateProvince = $("#selProvince").val(); //$("#<%=this.txtStateProvince.ClientID %>").val();
            var txtCountry = $("#<%=this.txtCountry.ClientID %>").val();
            var txtPostal = $.trim($("#<%=this.txtPostal.ClientID %>").val());
            var txtCustomerRemarke = $.trim($("#<%=this.txtCustomerRemarke.ClientID %>").val());
            var txtEmailAddress = $.trim($("#<%=this.txtEmailAddress.ClientID %>").val());
            if (errStr != "") {
                alert(errStr);
                return false;
            }

            

            if (txtEmailAddress != "") {
                if (!checkEmail(txtEmailAddress)) {
                    $("#<%=this.txtEmailAddress.ClientID %>").focus();
                    return;
                }
            }

            if (txtPostal != "") {
                if (!checkPostal(txtPostal)) {
                    $("#<%=this.txtPostal.ClientID %>").focus();
                    return;
                }
            }

            var entity = {};
            if (action.toLocaleLowerCase() == "copy") {
                entity.CustomerID = -1;
            }
            else {
                entity.CustomerID = customerId;
            }
            entity.CustomerName = txtCustomerName;
            entity.CustomerCode = txtCustomerCode;
            entity.Address1 = txtCustomerAddress1;
            entity.Address2 = txtCustomerAddress2;
            entity.City = txtCity;
            entity.StateProvince = txtStateProvince;
            entity.Country = txtCountry;
            entity.Postal = txtPostal;
            entity.Remark = txtCustomerRemarke;
            entity.Country = txtCountry;
            entity.EmailAddress = txtEmailAddress;

            var ajax_inserDict = SKT.LeanMES.Web.AjaxServices.AjaxCustomer.EditCustomer(entity);
            if (ajax_inserDict.error != null) {
                alert(ajax_inserDict.error.Message);
                return false;
            }
            else {
                alert("<%= Resources.Messages.SaveInSuccess %>");
            }
            parent.window.UpdateList(txtCustomerName);
        }
    </script>
</asp:Content>
