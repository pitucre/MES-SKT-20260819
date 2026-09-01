<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="FeederImport.aspx.cs" Inherits="SKT.LeanMES.Web.SMT.FeederImport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">        
        <tr>
            <td class="Label2">
                目标路径<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:FileUpload ID="fileBomUrl" ClientIDMode="Static" runat="server" onchange="uploadFile(this.value)" />
                <asp:Button ID="btnUpload" runat="server" OnClick="Upload_Click" ClientIDMode="Static"
                    Style="display: none;" />
                <%-- <asp:Button ID="btnView" runat="server" ClientIDMode="Static" OnClick="btnView_Click" 
                    Text=" 预 览 " />  --%>
            </td>
        </tr>
    </table>
    <asp:GridView ID="GridView1" runat="server" Width="100%" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="ID" Visible="true"></asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:HiddenField ID="hdnBomId" runat="server" Value="-1" />
    <script type="text/javascript">
        var bomName = "";

        function Save() {          
         var feederXml = '<%=feederXml %>';
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceFeeder.UserImport(feederXml);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList();

        }

        function Download() {
            var filePath = '<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"Feeder导入模板.xlsx" %>';
            return window.open(filePath);
        }
  
        function uploadFile(filePath) {
            if (filePath.length > 0) {
                $("#btnUpload").click();
            }
        }

       
    </script>
</asp:Content>
