<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ImportRoute.aspx.cs" Inherits="SKT.LeanMES.Web.Router.ImportRoute" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                目标路径<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <%--<input type="button" value="open" onclick="openUploadDialog();"/>--%>
                <asp:FileUpload ID="fileBomUrl" ClientIDMode="Static" onchange="uploadFile(this.value)" runat="server" multiple="multiple"/>
                <asp:Button ID="btnUpload" runat="server" OnClick="Upload_Click" ClientIDMode="Static"
                    Style="display: none;" />                
            </td>
        </tr>
    </table>
    <%--<asp:GridView ID="GridView1" runat="server" Width="100%" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="ID" Visible="true"></asp:TemplateField>
        </Columns>
    </asp:GridView>--%>
    <asp:HiddenField ID="hdnBomId" runat="server" Value="-1" />
     <script type="text/javascript">   
         function uploadFile(filePath) {
             if (filePath.length > 0) {
                 $("#btnUpload").click();
             }
             
         }

         //下载Excel模板
         function Download() {
             return downLoadField('<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"工艺流程卡模板.xlsx" %>');
         }
         function downLoadField(fieldPath) {
             window.open(fieldPath);
             return null;
         }
        
     </script>
    </asp:Content>
