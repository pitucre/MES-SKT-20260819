<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" 
    AutoEventWireup="true" CodeBehind="StockOrderEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.StockOrderEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
 <div class="infoTips">
            <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        
        <tr>
            <td class="Label1">
                备货单编号<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="txtDNCode" CssClass="TextBox" ClientIDMode="Static" Width="36.5%" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                备货计划时间<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="txtSalOrderDate" CssClass="DateTimeBox" ClientIDMode="Static" Width="34%" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                客户编码<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtCusCode" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" IsRequired='1'></asp:TextBox>
                <input type="button" class="ButtonBox" value="..." title="Select" onclick="selectSupplier();" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                客户名称
            </td>
            <td class="Field1">
                <asp:Label runat="server" ID="lblCusName" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                交货地址
            </td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="txtAddress" CssClass="TextBox" ClientIDMode="Static" Width="36.5%"></asp:TextBox>
            </td>
        </tr>
    </table>
   
    <script type="text/javascript">
        var SalOrderID = '<%=Request.QueryString["ID"]%>';
        function selectSupplier() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&Multiple=false&rnd=" + Math.random(), width: 660, height: 350 });
        }

        function getChooseValue(list) {
            $("#txtCusCode").val(list[0][2]);
            $("#lblCusName").text(list[0][3]);
        }

        function Save() {
            var DNCode = $("#txtDNCode").val();
            var SalOrderDate = $("#txtSalOrderDate").val();
            var CusCode = $("#txtCusCode").val();
            var CusName = $("#lblCusName").text();
            var Address = $("#txtAddress").val();
            
            var entity = {};

            entity.SalOrderID = SalOrderID;
            entity.DNCode = DNCode;
            entity.SalOrderDate = SalOrderDate;
            entity.CusCode = CusCode;
            entity.CusName = CusName;
            entity.Address = Address;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.StockOrderEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('保存成功！')
            parent.window.Refresh();
        }
    </script>
</asp:Content>

