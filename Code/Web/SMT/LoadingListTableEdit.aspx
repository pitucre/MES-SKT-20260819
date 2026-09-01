<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="LoadingListTableEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SMT.LoadingListTableEdit" %>

<%@ MasterType VirtualPath="~/Masters/EditMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
     <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">        
        <tr>
            <td class="Label2"><%= Resources.lang.LoadingListTable%><em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtTableName" runat="server" CssClass="TextBox"  MaxLength="50" Enabled="false"></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.LoadingListTableDesc%></td>
            <td class="Field2">
                <asp:TextBox ID="txtTableDesc" runat="server" CssClass="TextBox"  MaxLength="200"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Remark %></td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox"  MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2"><%= Resources.lang.IsActive %></td>
            <td class="Field2">
                <asp:DropDownList ID="ddlIsActive" runat="server">
                    <asp:ListItem Text="启用" Value="1" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="不启用" Value="0" ></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>        
    </table>

    <script type="text/javascript">
        var loadingListTableId = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var txtTableName = $.trim($("#<%=this.txtTableName.ClientID%>").val());
            var txtTableDesc = $.trim($("#<%=this.txtTableDesc.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtEnableFlag = $("#<%=this.ddlIsActive.ClientID%>").val();


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.LoadingListTableId = loadingListTableId
            entity.TableName = txtTableName;
            entity.TableDesc = txtTableDesc;            
            entity.Remark = txtRemark;
            entity.EnableFlag = txtEnableFlag;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.LoadingListTableEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();
        }
    </script>
</asp:Content>

