<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MslEdit.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MslEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
  <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                湿度等级<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMSL" runat="server" ClientIDMode="Static" IsRequired="1" MaxLength="20"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                暴露时长(小时)<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtFloorLife" runat="server" ClientIDMode="Static" IsRequired="1" MaxLength="5"  MinValue='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                烘烤次数<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtBakeCount" runat="server" ClientIDMode="Static" IsRequired="1" MaxLength="5" MinValue='1'></asp:TextBox>
            </td>
        </tr>
       <%-- <tr>
            <td class="Label1">
                存储期限(天)<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtShelfLife" runat="server" ClientIDMode="Static" IsRequired="1" MaxLength="5"  MinValue='1'></asp:TextBox>
            </td>
        </tr>--%>
    </table>
    <script type="text/javascript">
        var mslId = '<%=Request.QueryString["ID"]%>';

        $().ready(function () {
            $("#txtFloorLife,#txtBakeCount,#txtShelfLife").bind("keyup", function () {
                getIntVal(this);
            });
        });

        function Save() {
            var txtMSL = $.trim($("#<%=this.txtMSL.ClientID%>").val());
            var txtFloorLife = $("#<%=this.txtFloorLife.ClientID%>").val();
<%--            var txtShelfLife = $("#<%=this.txtShelfLife.ClientID%>").val();--%>
            var txtBakeCount = $("#<%=this.txtBakeCount.ClientID%>").val();

            var entity = {};

            entity.MslId = mslId
            entity.OrganizationCode = "";
            entity.MSL = txtMSL;
            entity.FloorLife = txtFloorLife;
            entity.ShelfLife = 0;
            entity.BakeCount = txtBakeCount;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMSD.MslEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.UpdateList();
        }
    </script>
</asp:Content>
