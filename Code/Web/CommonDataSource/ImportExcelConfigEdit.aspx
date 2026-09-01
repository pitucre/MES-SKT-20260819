<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="ImportExcelConfigEdit.aspx.cs" Inherits="SKT.LeanMES.Web.CommonDataSource.ImportExcelConfigEdit" %>

<%@ MasterType VirtualPath="~/Masters/EditMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">

    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="导入数据配置信息">导入数据配置信息
            </li>
        </ul>
        <!--基本信息-->
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %> &nbsp
            </div>
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label1" align="left">导入表名称</td>
                    <td class="Field1" align="left">
                        <asp:TextBox ID="txtIdcName" runat="server" CssClass="TextBox" IsRequired="1" MaxLength="20"
                            ClientIDMode="Static" Width="250px">
                        </asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1" align="left">导入数据模板<em>*</em>
                    </td>
                    <td class="Field1" align="left">
                        <asp:FileUpload ID="flupload" runat="server" /><label id="lblFileNames" runat="server"></label>
                    </td>
                </tr>
                <tr>
                    <td class="Label1" align="left">导入数据存储过程名称<em>*</em>
                    </td>
                    <td class="Field1" align="left">
                        <asp:TextBox ID="txtProcName" runat="server" Text="" CssClass="TextArea" TextMode="MultiLine"
                            ClientIDMode="Static" Width="250px">
                        </asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1" align="left">备注信息：
                    </td>
                    <td class="Field1" align="left">
                        <asp:TextBox ID="txtRemark" runat="server" Text="" CssClass="TextArea" TextMode="MultiLine"
                            ClientIDMode="Static" Width="250px">
                        </asp:TextBox>
                    </td>
                </tr>
            </table>
            <div class="clear5"></div>
            <input type="hidden" id="hdnOperate" name="hdnOperate" value="Eidt" />
            <input type="hidden" id="hdnId" name="hdnId" value="-1" />
        </div>
        <!--tab2-->
        <div>
        </div>
    </div>

    <script type="text/javascript">
        var dbSrcId = '<%=Request.QueryString["ID"] %>';
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
 
    
        function Save() {

         <%--   var idcName =  $("#<%=this.txtIdcName.ClientID%>").val();
            var procName =  $("#<%=this.txtProcName.ClientID%>").val();
            var remark =$("#<%=this.txtRemark.ClientID%>").val(); 
         
            var entity = {};
            entity.ID = dbSrcId;
            entity.IdcName = idcName;
            entity.FileNames = "";
            entity.TableName = "";
            entity.ProcName = procName;
            entity.CreateBy = userName;
            entity.Remark = remark;
            var ajax = SKT.LeanMES.Web.CommonDataSource.ImportExcelConfigEdit.Edit(remark);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                alert("<%= Resources.Messages.SaveInSuccess %>");
            }--%>
          
         
            document.forms[0].submit();
           
        }
             


    </script>
</asp:Content>
