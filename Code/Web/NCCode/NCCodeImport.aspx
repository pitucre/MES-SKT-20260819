<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="NCCodeImport.aspx.cs" Inherits="SKT.LeanMES.Web.NCCode.NCCodeImport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
     <div id="toolbar" class="toolBar">
        <div class="toolbar-btn" onclick="Save()" title="保存">
            <div class="icon-16-save"></div>
            <div class="btn-text">保存</div>
            <div class="btn-line" style="margin-top:0px"></div>
        </div>
        <div class="toolbar-btn" onclick="Download()" title="用户模板下载">
            <div class="icon-16-copy"></div>
            <div class="btn-text">不良代码模板下载</div>
        </div>
        <div class="clear0"></div>
    </div>
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
        var IsGroup = parseInt('<%=Request.QueryString["IsGroup"]%>') == 1 ? "1" : "0";
        function Save() {
            var resutl=checkRepeat();
            if (resutl!="") {
                alert(resutl);
                return false;

            }
            var userXml = '<%=ncCodeXml %>';

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxNCCode.NCCodeImport(userXml, IsGroup);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList();

        }

        function checkRepeat() {
            var nameIndex = 0, employeeNoIndex = 0;
            var resulttMessage="";
            $(".ListTableHeader").find("th").each(function (i, v) {
                if ($(this).text() == "用户名") {
                    nameIndex = i;  
                }
                if ($(this).text() == "工号") {
                    employeeNoIndex = i;
                }
            });
            var nameArr = [];
            var employeeNoArr = [];
            $("#ContentPlaceHolder1_EditContent_GridView1 tr").each(function (i, v) {
                var nameTxt = $(this).find("td").eq(nameIndex).text();
                var employeeNoTxt = $(this).find("td").eq(employeeNoIndex).text();
                var index1 = $.inArray(nameTxt, nameArr);
                var index2 = $.inArray(employeeNoTxt, employeeNoArr);
                if (index1 >= 0) {
                    resulttMessage = "第" + i + "行用户名重复，请检查后重新上传";
                    return false;
                }
                else {
                    nameArr.push(nameTxt);
                }
                if (index2 >= 0) {
                    resulttMessage = "第" + i + "行工号重复，请检查后重新上传";
                    return false;
                }
                else {
                    employeeNoArr.push(employeeNoTxt);
                }
            })
            return resulttMessage;
        }

        function Download() {
            var filePath = '<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"导入不良代码模板.xlsx" %>';
            return window.open(filePath);
        }

        function uploadFile(filePath) {
            if (filePath.length > 0) {
                $("#btnUpload").click();
            }
        }

       
    </script>
</asp:Content>
