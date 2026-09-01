<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="OffLineLabelConfigDetailEdit.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialConfig.OffLineLabelConfigDetailEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
 <div class="infoTips">
            <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                内容<em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlDetailContent" runat="server" Width="150px">
                    <asp:ListItem Value='物料标签'>物料标签</asp:ListItem>
                    <asp:ListItem Value="供应商">供应商</asp:ListItem>
                    <asp:ListItem Value="物料编码">物料编码</asp:ListItem>
                    <asp:ListItem Value="数量">数量</asp:ListItem>
                    <asp:ListItem Value="批次号码">批次号码</asp:ListItem>
                    <asp:ListItem Value="制造日期">制造日期</asp:ListItem>
                    <asp:ListItem Value="MPN">MPN</asp:ListItem>
                    <asp:ListItem Value="NA">NA</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                段<em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlParagraph" runat="server" Width="150px">
                    <asp:ListItem Value='1'>1</asp:ListItem>
                    <asp:ListItem Value='2'>2</asp:ListItem>
                    <asp:ListItem Value='3'>3</asp:ListItem>
                    <asp:ListItem Value='4'>4</asp:ListItem>
                    <asp:ListItem Value='5'>5</asp:ListItem>
                    <asp:ListItem Value='6'>6</asp:ListItem>
                    <asp:ListItem Value='7'>7</asp:ListItem>
                    <asp:ListItem Value='8'>8</asp:ListItem>
                    <asp:ListItem Value='9'>9</asp:ListItem>
                    <asp:ListItem Value='10'>10</asp:ListItem>
                    <asp:ListItem Value='11'>11</asp:ListItem>
                    <asp:ListItem Value='12'>12</asp:ListItem>
                    <asp:ListItem Value='13'>13</asp:ListItem>
                    <asp:ListItem Value='14'>14</asp:ListItem>
                    <asp:ListItem Value='15'>15</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
   
    <script type="text/javascript">
        var DetailID = '<%=Request.QueryString["ID"]%>';
        var LabelID = '<%=Request.QueryString["LabelID"]%>';
        
        function Save() {
            var DetailContent = $.trim($("#<%=this.ddlDetailContent.ClientID%>").val());
            var Paragraph = $.trim($("#<%=this.ddlParagraph.ClientID%>").val());
            var entity = {};
            entity.DetailID = DetailID;
            entity.LabelID = LabelID;
            entity.DetailContent = DetailContent;
            entity.Paragraph = Paragraph;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.OffLineLabelConfigDetaiEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.UpdateList();
        }
    </script>
</asp:Content>