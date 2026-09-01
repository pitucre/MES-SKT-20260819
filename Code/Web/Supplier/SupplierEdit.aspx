<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="SupplierEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Supplier.SupplierEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                类型
            </td>
            <td class="Field1">
                <select id="selVendorType">
                    <option value="0" selected="selected">供应商</option>
                    <option value="-1">客户</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.VendorCode %><em>*</em>
            </td>
            <td class="Field1">
                <span id="prefix" style="float: left; line-height: 20px; padding: 0px; margin-right: 2px;">
                </span>
                <asp:TextBox ID="txtVendorCode" IsRequired='1' runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.VendorSort %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtVendorSort" IsRequired='1' runat="server" CssClass="TextBox" Width="60%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.VendorName %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtVendorName" runat="server" IsRequired='1' CssClass="TextBox" Width="60%"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td class="Label1">
                <%=Resources.lang.IsShipmentReport %><em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlIsShipmentReport" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="0" Selected="True">否</asp:ListItem>
                    <asp:ListItem Value="1">是</asp:ListItem>
                </asp:DropDownList> 
            </td>
        </tr>

        <tr>
            <td class="Label1">
                <%=Resources.lang.IsLaboratoryReport %><em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlIsLaboratoryReport" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="0" Selected="True">否</asp:ListItem>
                    <asp:ListItem Value="1">是</asp:ListItem>
                </asp:DropDownList> 
            </td>
        </tr>


             <tr>
            <td class="Label1">
                  <%=Resources.lang.SupplierUserName %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtVenUserName"  runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                 <%=Resources.lang.SupplierPhone %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtVenPhone" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
          <tr>
            <td class="Label1">
                <%=Resources.lang.VendorAddress %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtVenderAddress" runat="server" CssClass="TextBox"   Width="80%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Remark %>
            </td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="txtDescript" CssClass="TextArea" TextMode="MultiLine" Width="80%"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var supplierId = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>;
        var isView= <%= Request.QueryString["isView"] == null ? 0 : Convert.ToInt32(Request.QueryString["isView"].ToString())%>

        function Save() {
            var txtVendorCode = $("#<%=this.txtVendorCode.ClientID %>").val();
            var txtVendorName = $("#<%=this.txtVendorName.ClientID %>").val();
            var txtDescript = $("#<%=this.txtDescript.ClientID %>").val();
            var txtVendorSort = $("#<%=this.txtVendorSort.ClientID %>").val();

            var IsShipmentReport = $("#<%=this.ddlIsShipmentReport.ClientID %>").val();
            var IsLaboratoryReport = $("#<%=this.ddlIsLaboratoryReport.ClientID %>").val();
            

            if ($("#selVendorType").val() == "-1") {
                txtVendorCode = "K" + txtVendorCode.toString();
            }
           
            var entity = {};
            entity.SupplierId = supplierId;
            entity.VendorCode = txtVendorCode;
            entity.VendorName = txtVendorName;
            entity.VendorSort = txtVendorSort;
            entity.Description = txtDescript;
            entity.VendorAddress=$("#<%=this.txtVenderAddress.ClientID %>").val();
            entity.IsMesAdd = 1;
            entity.VenUserName=$("#<%=this.txtVenUserName.ClientID %>").val();
            entity.VenPhone=$("#<%=this.txtVenPhone.ClientID %>").val();
            entity.Remark ="";
            entity.IsShipmentReport=IsShipmentReport;
            entity.IsLaboratoryReport=IsLaboratoryReport;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplier.EditSupplier(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                alert("<%= Resources.Messages.SaveSuccess %>");
            }
            parent.window.UpdateList(txtVendorCode);
        }

        $(function () {
            $("#selVendorType").change(function () {
                if ($(this).val() == "-1") {
                    $("#prefix").html("K");
                }
                else {
                    $("#prefix").html("");
                }
            });
        });
    </script>
</asp:Content>
