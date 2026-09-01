<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="SpareScrap.aspx.cs" Inherits="SKT.LeanMES.Web.Sparepart.SpareScrap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
              <span>工具编码</span>&nbsp;
                <asp:HiddenField ID="hdfPartId" runat="server" />
            </td>
            <td class="Field1">
                <asp:Label ID="lblPartNickName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                累积报废数量
            </td>
            <td class="Field1">
                <asp:Label ID="labScrapQty" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                剩余可报废数量
            </td>
            <td class="Field1">
                <asp:Label ID="labInStockQty" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">本次报废数量<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtScrapQty" runat="server" CssClass="TextBox" Width="80" patterns="ufloat"
                    ClientIDMode="Static" IsRequired='1' MaxLength='8' MinValue='0' IsNumber='1'></asp:TextBox>&nbsp;
            </td>
        </tr>
        <tr>
            <td class="Label1">
               报废原因<em>*</em>
            </td>
            <td class="Field1" id="tdPartName">
                <asp:TextBox ID="txtScrapRemark" runat="server" IsRequired='1' CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
              <input id="btnSave" type="button" value="确认报废" onclick="Save();"
                    style="height: 25px; width: 80px; " />
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var ID = "";
        var code = "";

        <% if (Request.QueryString["ID"] == null)
        { %>

        <% }
        else
        { %>
        ID = <%= Request.QueryString["ID"] %>;
        $("#<%=this.hdfPartId.ClientID%>").val(ID);
        <% } %>

        function Save() {
            var ScrapQty=$("#<%=this.txtScrapQty.ClientID %>").val();
            var ScrapRemark=$("#<%=this.txtScrapRemark.ClientID %>").val();
            if (ScrapQty=="" || ScrapRemark=="") {
                alert('请填写必填项信息！');
                return;
            }
            var entry={};
            entry.PartId=ID;
            entry.ScrapQty=ScrapQty;
            entry.ScrapRemark=ScrapRemark;
            var ajax =SKT.LeanMES.Web.AjaxServices.AjaxSparepart.EditPartScrap(entry);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('报废成功！')
            window.parent.Refresh();
        }
       
    </script>
</asp:Content>
