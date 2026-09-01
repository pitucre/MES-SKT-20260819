<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master" 
  CodeBehind="CertificationRecordList.aspx.cs" Inherits="SKT.LeanMES.Web.Certification.CertificationRecordList" %>
  <%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
   <table class="EditeContentTable" width="100%">        
         <tr>
            <td class="Label3">
                用户名
            </td>
            <td class="Field3" >
                <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                认证名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtCertName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                认证类型
            </td>
            <td class="Field3">                
                <asp:DropDownList ID="ddlCertType" runat="server">
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem Value="Skill" Text="<%$ Resources:lang,SkillsCertification %>"></asp:ListItem>
                    <asp:ListItem Value="License" Text="<%$ Resources:lang,CertificateAuthentication %>"></asp:ListItem>
                    <asp:ListItem Value="Qualification" Text="<%$ Resources:lang,Certification %>"></asp:ListItem>
                </asp:DropDownList> 
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
<asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" 
        onrowdatabound="GridView1_RowDataBound" >
        <Columns>
            <asp:BoundField DataField="UserName" HeaderText="用户名" />
            <asp:BoundField DataField="CName" HeaderText="<%$Resources:lang,CertificationName %>" />
            <asp:BoundField DataField="Certification" HeaderText="认证名称" />
            <asp:BoundField DataField="CertType" HeaderText="认证类型" />
            <asp:BoundField DataField="Expiration_Date" HeaderText="过期日期" DataFormatString="{0:yyyy-MM-dd}"/>
            <asp:BoundField DataField="Certification_Date"   HeaderText="授权日期" DataFormatString="{0:yyyy-MM-dd}"/>    
            <asp:BoundField DataField="Warning_Sent"   HeaderText="预警信息发送" />    
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Certification.BLL.CertificationMember"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource> 
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
     <script language="javascript" type="text/javascript">
         isMultiple = false;
         var hdnOperate = $("#hdnOperate");
         var hdnIdString = $("#hdnIdString");

         $(document).ready(function () {
             //$("#ckbMultipleSelected").parent().hide();
//             $("#<%=this.GridView1.ClientID %> tr").find("th:eq(0)").hide();
//             $("#<%=this.GridView1.ClientID %> tr").find("td:eq(0)").hide();
         });

         //打印
         function Print() {
             var idStr = getOneRecordId();
             if (idStr == "") return;
             dialog({ title: "打印认证记录", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Certification/CertificationMemberList.aspx?name=CustomerMaintenanceEdit&ID=" + idStr, width: 600, height: 350, resizeable: true });
         }

         function UpdateList(strName) {
             document.forms[0].submit();
         }
         </script>
</asp:Content>     

