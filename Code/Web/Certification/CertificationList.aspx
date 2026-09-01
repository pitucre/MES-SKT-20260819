<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master" 
 CodeBehind="CertificationList.aspx.cs" Inherits="SKT.LeanMES.Web.Certification.CertificationList" %>
 <%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
   <table class="EditeContentTable" width="100%">        
        <tr>
            <td class="Label2">
                认证名称
            </td>
            <td class="Field2">
                <input type="text" id="txtCert" class="TextBox" runat="server" />
            </td>
         
            <td class="Label2">
                认证类型
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlType" runat="server">
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
 
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" >
        <Columns>
            <asp:BoundField DataField="Certification" HeaderText="认证名称" />
            <asp:BoundField DataField="Type"          HeaderText="认证类型" />
            <asp:BoundField DataField="RenewalDays"   HeaderText="有效期(天)" />
            <asp:BoundField DataField="WarningDays"   HeaderText="到期提前警告天数"  />
            <asp:BoundField DataField="CreateBy"   HeaderText="创建人"  />
            <asp:BoundField DataField="CreateDateTime"   HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"  SortExpression="CreateDateTime" />
            <asp:BoundField DataField="ModifyBy"   HeaderText="修改人"  />
            <asp:BoundField DataField="ModifyDateTime"   HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"  SortExpression="ModifyDateTime" />
            <asp:BoundField DataField="Description"   HeaderText="<%$ Resources:lang,Description %>"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Certification.BLL.Certification"
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
     //增加 
     function Add() {
         dialog({ title: "新增岗位资格认证", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Certification/CertificationEdit.aspx?name=Account_CertificationListAdd&ID=-1", width: 600, height: 400, resizeable: false });
     }

     //编辑
     function Edit() {
         var idStr = getOneRecordId();
         if (idStr == "") return;
         dialog({ title: "编辑岗位资格认证", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Certification/CertificationEdit.aspx?name=Account_CertificationListEdit&ID=" + idStr, width: 600, height: 400, resizeable: false });
     }

     //查看
     function View() {
         var idStr = getOneRecordId();
         if (idStr == "") return;
         dialog({ title: "查看岗位资格认证", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Certification/CertificationView.aspx?name=Account_CertificationListView&ID=" + idStr, width: 600, height: 400, resizeable: false });
     }

     //删除
     function Delete() {
         var idStr = getDeletingRecordIdString();
         if (idStr == "") return false;
         hdnOperate.val("delete");
         hdnIdString.val(idStr);
         document.forms[0].submit();
     }

     function UpdateList(Certification) {
         document.forms[0].submit();
     }
 </script>
</asp:Content>


