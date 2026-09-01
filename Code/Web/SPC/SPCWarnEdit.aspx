<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="SPCWarnEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SPC.SPCWarnEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
<div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">        
        <tr>
            <td class="Label2">
                任务名称
            </td>
            <td class="Field2">
                <asp:Label ID="lblTaskName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                报警内容
            </td>
            <td class="Field2">
                <asp:Label ID="lblSPCWarnMsg" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                报警时间
            </td>
            <td class="Field2">
                <asp:Label ID="lblWarnTime" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                原因分析<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtReson" runat="server" TextMode="MultiLine" CssClass="TextArea" MaxLength="200" IsRequired="1" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                处理内容<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDealDesc" runat="server" TextMode="MultiLine" CssClass="TextArea" MaxLength="200" IsRequired="1" ></asp:TextBox>
            </td>            
        </tr>
        <tr>
            <td class="Label2">
               处理人<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDealBy" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1" ></asp:TextBox>
            </td>
        </tr>        
    </table>
    <script type="text/javascript">
        var sPCWarnId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {            
            var txtReson = $.trim($("#<%=this.txtReson.ClientID%>").val());
            var txtDealDesc = $.trim($("#<%=this.txtDealDesc.ClientID%>").val());
            var txtDealBy = $.trim($("#<%=this.txtDealBy.ClientID%>").val());            

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            
            var entity = {};

            entity.SPCWarnId = sPCWarnId;           
            entity.Reson = txtReson;
            entity.DealDesc = txtDealDesc;
            entity.DealBy = txtDealBy;
 
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSPC.SPCWarnEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();
             
        }
    </script>
</asp:Content>
