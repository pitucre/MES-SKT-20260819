<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ImportData.aspx.cs" Inherits="SKT.LeanMES.Web.CommonDataSource.ImportData" %>
<%@ Import Namespace="iTextSharp.text.xml.xmp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">        
        <tr>
            <td class="Label3">
                   <%= Resources.lang.IdcName%><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtIdcName" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1" ReadOnly="True"
                   ClientIDMode="Static">
                </asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectImportConfig()" />
                <asp:HiddenField ID="hdnId" runat="server" ClientIDMode="Static" />
                
            <%-- <asp:Button runat="server" Text="生成DLL" OnClick="Unnamed1_Click" Visible="True"/>--%>
            </td>
            <td class="Label3">
                   <%= Resources.lang.TemplateName%><em>*</em>
            </td>
            <td class="Field3">
                <asp:Label runat="server" ID="lblFileNames" ></asp:Label>
                 
            </td>
            <td class="Label3">
                   <%= Resources.lang.ProcedureOrBusinessName%><em>*</em>
            </td>
            <td class="Field3">
                <asp:Label runat="server"   ID="lblProcName"></asp:Label>
            </td>
        </tr>    
            <tr>
             <td class="Label3">
                目标路径<em>*</em>
            </td>
            <td class="Field3" colspan="5">
                <asp:FileUpload ID="fileBomUrl" ClientIDMode="Static" runat="server" onchange="uploadFile(this.value)" />
                <asp:Button ID="btnUpload" runat="server" OnClick="Upload_Click" ClientIDMode="Static"
                    Style="display: none;" />
                <%-- <asp:Button ID="btnView" runat="server" ClientIDMode="Static" OnClick="btnView_Click" 
                    Text=" 预 览 " />  --%>
                <a href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Template/导入模板.zip"   target="_blank" title="模板下载">模板下载</a>
            </td>
        </tr>
    </table>
    <asp:GridView ID="GridView1" runat="server" Width="100%" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="ID" Visible="true"></asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:HiddenField ID="dataXml1" runat="server" Value="-1" />
    <asp:HiddenField ID="hdnBomId" runat="server" Value="-1" />
    <script type="text/javascript">
        var bomName = "";
       
        function Save() {          
            var dataXml1 = $("#<%=this.dataXml1.ClientID %>").val();
           
            var procName = $("#<%=this.lblProcName.ClientID %>").text();
            var idcName = $("#<%=this.txtIdcName.ClientID %>").val();
            if (idcName == "") {
                alert("数据配置名称不能为空!");
                return;
            }
            if (procName == "") {
                 alert("存储过程名称不能为空!");
                return;
            }
          
            if(dataXml1 == "") {
                alert("上传导入数据!");
                return;
            }
      
            var ajax = SKT.LeanMES.Web.CommonDataSource.ImportData.DataImport(dataXml1,procName);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            ClearTxt();
          
            alert("<%=Resources.Messages.SaveInSuccess %>");
            

        }

        function selectImportConfig() {
          
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=676&Multiple=false&CallBackFunc=setConfig&rnd=" + Math.random(), width: 600, height: 500 });
        }


       function setConfig(list) {
           
                $("#<%=this.txtIdcName.ClientID %>").val(list[0][1]);
                $("#<%=this.lblFileNames.ClientID %>").html("<a href='../UploadFiles/ImportDataExecl/"+list[0][3]+"'>"+list[0][3]+"</a>");
                $("#<%=this.lblProcName.ClientID %>").text(list[0][2]);
                $("#<%=this.hdnId.ClientID %>").val(list[0][0]);
       
       }

       function ClearTxt() {
                $("#<%=this.txtIdcName.ClientID %>").val("");
                $("#<%=this.lblFileNames.ClientID %>").html("");
                $("#<%=this.lblProcName.ClientID %>").text("");
                $("#<%=this.hdnId.ClientID %>").val(-1);
           location.replace(location.href);
       }

<%--        function Download() {
            var filePath = '<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"Feeder导入模板.xls" %>';
            return window.open(filePath);
        }
  --%>
        function uploadFile(filePath) {
            var idcName = $("#<%=this.txtIdcName.ClientID %>").val();
        
            if (idcName == "") {
                alert("数据配置名称不能为空!");
                return;
            }
            if (filePath.length > 0) {
                $("#btnUpload").click();
                
            }
        }

       
    </script>
</asp:Content>
