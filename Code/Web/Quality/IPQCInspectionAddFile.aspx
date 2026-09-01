<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="IPQCInspectionAddFile.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.IPQCInspectionAddFile" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style type="text/css">
 .redFont {
     color: red;
 }

    td{
        max-width:500px;
        word-wrap:break-word;
        /*overflow:hidden;*/
    }
    table{
        width:100%
    }
    </style>
    <table class="EditeContentTable" width="100%" style="margin-top:10px;">
         <tr>
            <td class="Label2">
                上传文件
            </td>
            <td class="Field2" style="text-align: left" colspan="3">
                <asp:FileUpload ID="fuLoadingListF" runat="server" onchange="uploadFileF(this.value)" ClientIDMode="Static"/>
                <asp:LinkButton ID="linkUploadFileF" runat="server" OnClick="linkUploadFileF_Click" ClientIDMode="Static"></asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                上传文件路径
            </td>
            <td class="Field2" style="text-align: left" colspan="3">
                 <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReadyF" CssClass="redFont">未上传</asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                
            </td>
            <td class="Field2" style="text-align: left" colspan="3">
                 <input id="btnDoFile"   onclick="Save()" type="button"  title="上传" style="cursor: pointer;" value=" 上传 " />
            </td>
        </tr>
        <tr class="clear5"></tr>
    </table>
    <asp:HiddenField ID="hdnfURL" runat="server" Value="" ClientIDMode="Static" />
    <script type="text/javascript">
        var id = '<%=Request.QueryString["ID"]==null?-1: Convert.ToInt32(Request.QueryString["ID"]) %>';
        function Save() {
            alert('上传成功！！！');
            parent.window.ReturnDoFileRow($("#hdnfURL").val(), id);

        }
        function uploadFileF(filePath) {
            if (filePath.length > 0) {
                var str = '';
                var postback = $('#<%= linkUploadFileF.ClientID %>').attr('href');
                var funcStartIndex = postback.indexOf('\'');
                var funcEndIndex = postback.indexOf('\',');
                if (funcStartIndex != -1 && funcEndIndex != -1) {
                    var str = postback.substring(funcStartIndex + 1, funcEndIndex);
                    
                    __doPostBack(str, '');
                } else {
                    return false;
                }
            }
        }
    </script>
</asp:Content>


