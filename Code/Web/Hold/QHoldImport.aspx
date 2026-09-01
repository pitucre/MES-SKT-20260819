<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="QHoldImport.aspx.cs" Inherits="SKT.LeanMES.Web.Hold.QHoldImport" %>
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
    <asp:GridView ID="GridView1" runat="server" Width="100%" OnRowDataBound="GridView1_RowDataBound"><%--OnRowDataBound="GridView1_RowDataBound"--%>
        <Columns>
            <asp:TemplateField HeaderText="ID" Visible="true"></asp:TemplateField>
        </Columns>
    </asp:GridView>
      <script type="text/javascript">
        var bomName = "";
         var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"
        function Save() { 
            var xml = '<%=feederXml %>';   
            var IsEmpty = '<%=IsEmpty%>';
                if(xml==""){
                    alert("暂无QHold导入数据");
                     return;
                }
                if (IsEmpty != "")
                {
                    alert(IsEmpty);
                    return;

                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.SaveQHold(xml,4,userName,1);
                if (ajax.error != null) {
                   alert(ajax.error.Message);
                    return false;
                }else{
                  var showmsg = false;
                  var data = ajax.value;
                  var parentData = [];     //分离原始数据和错误信息
                  if (data != null) {
                      for (var i = 0; i < data.length; i++) {
                          if ((data[i].msg1 != "" && data[i].msg1 != null) || (data[i].msg2 != "" && data[i].msg2 != null)) {
                              alert(data[i].msg1 + data[i].msg2);
                              showmsg = true;
                              break;
                          }
                          if (data[i].ObjectName)
                          {
                              parentData.push(data[i]);
                          }
                      }
                      if (!showmsg) {
                          alert("<%=Resources.Messages.SaveInSuccess %>");
                          parent.window.load(parentData);
                          window.close();
                      }

                  }
              }
          }

        function Download() {
            var filePath = '<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"QHold模板.xlsx" %>';
            return window.open(filePath);
        }
  
        function uploadFile(filePath) {
            if (filePath.length > 0) {
                $("#btnUpload").click();
            }
        }

       
    </script>
</asp:Content>
