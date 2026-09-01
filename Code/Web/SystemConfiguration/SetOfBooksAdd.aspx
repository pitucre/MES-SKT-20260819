<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="SetOfBooksAdd.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.SetOfBooksAdd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr><td colspan="2" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td></tr>
        <tr>
            <td class="Label1">事业部编码</td>
            <td class="Field1">
                <asp:TextBox ID="txtDepartCode" runat="server" CssClass="TextBox"  MaxLength="200"></asp:TextBox><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label1">事业部名称</td>
            <td class="Field1">
                <asp:TextBox ID="txtDepartName" runat="server" CssClass="TextBox"  MaxLength="200"></asp:TextBox><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label1">事业部URL地址</td>
            <td class="Field1">
                <asp:TextBox ID="txtMesUrl" runat="server" CssClass="TextBox"  MaxLength="300"></asp:TextBox><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label1">数据库名</td>
            <td class="Field1">
                <asp:TextBox ID="txtDataBaseName" runat="server" CssClass="TextBox"  MaxLength="300"></asp:TextBox><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label1">链接服务器名</td>
            <td class="Field1">
                <asp:TextBox ID="txtDBLinkName" runat="server" CssClass="TextBox"  MaxLength="300"></asp:TextBox>
            </td>
        </tr>
        <tr class="ReportInfo">
            <td class="Label1">
                        是否启用
                    </td>
                    <td class="Field1">
                        <asp:CheckBox ID="ckIsEnabled" runat="server" ClientIDMode="Static"/>
                    </td>
                </tr>        
    </table>
    <script type="text/javascript">
        var Id = '<%=Request.QueryString["ID"]%>';
        /*保存数据*/
        function Save() {
            var DepartCode = $.trim($("#<%=this.txtDepartCode.ClientID%>").val());  
            if (DepartCode == "") {
                alert("事业部编码不能为空");
                return false;
            }
            var DepartName = $.trim($("#<%=this.txtDepartName.ClientID%>").val());  
            if (DepartName == "") {
                alert("事业部名称不能为空");
                return false;
            }
            var MesUrl = $.trim($("#<%=this.txtMesUrl.ClientID%>").val());  
            if (MesUrl == "") {
                alert("事业部URL地址不能为空");
                return false;
            }
            var DataBaseName = $.trim($("#<%=this.txtDataBaseName.ClientID%>").val());  
            if (DataBaseName == "") {
                alert("数据库名称不能为空");
                return false;
            }
            var DBLinkName = $.trim($("#<%=this.txtDBLinkName.ClientID%>").val()); 
            var ckIsEnabled = $("#ckIsEnabled").is(":checked");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxOrganization.EditDataDistribution(parseInt(Id), DepartCode, DepartName, MesUrl, DataBaseName, DBLinkName, ckIsEnabled);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();
        }
    </script>
</asp:Content>
