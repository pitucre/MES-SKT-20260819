<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NavigationGroupEdit.aspx.cs" 
    Inherits="SKT.LeanMES.Web.Navigation.NavigationGroupEdit" MasterPageFile="~/Masters/EditMaster.master" 
      %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
        <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                序号<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSequence" runat="server" CssClass="TextBox" IsRequired="1" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                导航组图标<em>*</em>
            </td>
            <td class="Field1">
                <asp:FileUpload ID="fileBomUrl" ClientIDMode="Static" runat="server" onchange="uploadFile(this.value)" />
                <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click" ClientIDMode="Static"></asp:LinkButton>
                <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady" CssClass="redFont" ForeColor="Red">未载入</asp:Label>
             
            </td>
        </tr>
        <tr>
            <td class="Label1">
                导航组名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtName" runat="server" CssClass="TextBox" ></asp:TextBox>
            </td>
        </tr>               
    </table>
    <asp:HiddenField ID="filepaths" runat="server" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript">
        var Id = '<%=Request.QueryString["ID"] %>';      
        $(function () {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxNavigation.GetSequence(Id);
            if(ajax.error !=null)
            {
                alert(ajax.error.Message);
                return false;
            }

            $("#<%=this.txtSequence.ClientID%>").val(ajax.value);

            $("#txtSequence").focus(function () { this.select() });
        })
        function Save() {           
            var txtSequence = $("#<%=this.txtSequence.ClientID%>").val();
            var txtIcon = $("#<%=this.lbFileReady.ClientID%>").html();
            var txtName=$("#<%=this.txtName.ClientID%>").val();
            var CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var ModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
         
            if (txtSequence == "" || lbFileReady == "" || txtName == "")
            {
                alert("带*号不可为空！");
                return false;
            }

            var entity = {};
            entity.ID = Id;
            entity.Sequence = txtSequence;
            entity.Icon = txtIcon;
            entity.NavigationgpName = txtName;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxNavigation.NavigationGroupEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.UpdateList(txtName);

        }

        function uploadFile(filePath) {
            if (filePath.length > 0) {
                var str = '';
                var postback = $('#<%= linkUploadFile.ClientID %>').attr('href');
                var funcStartIndex = postback.indexOf('\'');
                var funcEndIndex = postback.indexOf('\',');
                if (funcStartIndex != -1 && funcEndIndex != -1) {
                    var str = postback.substring(funcStartIndex + 1, funcEndIndex);

                    __doPostBack(str, '');
                } else {
                    return false;
                }
                $("#btnIcon").click();
            }
        }
    </script>
</asp:Content>

