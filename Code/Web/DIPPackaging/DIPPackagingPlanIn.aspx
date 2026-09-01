<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="DIPPackagingPlanIn.aspx.cs" Inherits="SKT.LeanMES.Web.DIPPackaging.DIPPackagingPlanIn" %>
<%@ Import Namespace="iTextSharp.text.xml.xmp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
        <table class="EditeContentTable" width="100%">    
            <tr>
                <td class="Label3">
                    模板下载
                </td>
                <td class="Field3">
                    <a  href="/ExcelTemplate/DIP包装计划导入模板.xlsx" title="" target="_blank">DIP包装计划导入模板.xlsx</a>
                 </td>
            </tr>       
            <tr>
             <td class="Label3">
                目标路径<em>*</em>
            </td>
            <td class="Field3">
                <asp:FileUpload ID="fileBomUrl" ClientIDMode="Static" runat="server" onchange="uploadFile(this.value)" />
                <asp:Button ID="btnUpload" runat="server" OnClick="Upload_Click" ClientIDMode="Static"
                    Style="display: none;" />
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
        function Save() {
            var dataXml1 = '<%=dataXml %>';
            var procName = "uspDIPPackagingPlanIn";
            var ajax = SKT.LeanMES.Web.DIPPackaging.DIPPackagingPlanIn.DataImport(dataXml1, procName);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.Refresh();
        }


        function uploadFile(filePath) {
            if (filePath.length > 0) {
                $("#btnUpload").click(); 
            }
        }
    </script>
</asp:Content>
