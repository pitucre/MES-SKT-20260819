<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="InspectionTemplateList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionTemplateList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.InspectionTemplateName%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtInspectionTemplateName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
                <td class="Label2">
                模板类型
            </td>
            <td class="Field2">
                  <asp:DropDownList ID="ddlInspectionType" runat="server">
                </asp:DropDownList>
                <asp:HiddenField ID="hfInspectionType" runat="server" Value="-1" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
       
            <asp:BoundField DataField="InspectionTemplateName" HeaderText="<%$Resources:lang,InspectionTemplateName %>" ItemStyle-Width="120px"/>
              <asp:BoundField DataField="InspectionTypeName" HeaderText="<%$Resources:lang,InspectionTypeName %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="Version" HeaderText="<%$Resources:lang,AC_OBA_Rev %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="Status" HeaderText="<%$Resources:lang,Status %>"  ItemStyle-Width="70px"/>
            <asp:BoundField DataField="Creater" HeaderText="创建人"  ItemStyle-Width="80px"/>
            <asp:BoundField DataField="CreateTime" HeaderText="<%$Resources:lang,CreateTime %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人"  ItemStyle-Width="80px"/>
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$Resources:lang,ModifyDateTime %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="Description" HeaderText="<%$Resources:lang,Description %>"  ItemStyle-Width="150px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.InspectionTemplate"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString" value=""/>
     
 <script language="javascript" type="text/javascript">
     var openWinUrl = "";
     var hdnOperate = $("#hdnOperate");
     var hdnIdString = $("#hdnIdString");

     function Add() {
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionTemplateEdit.aspx?name=QC_InspectionTemplateAdd&ID=-1";
         dialog({ title: "<%=Resources.Pages.QC_InspectionTemplateAdd %>", src: openWinUrl, width: 850, height: 400 });
     }

     function Edit() {
         var idStr = getOneRecordId();
         if (idStr === "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionTemplateEdit.aspx?name=QC_InspectionTemplateEdit&ID=" + idStr;
         dialog({ title: "<%=Resources.Pages.QC_InspectionTemplateEdit %>", src: openWinUrl, width: 850, height: 400 });
     }

     function Copy() {
         var idStr = getOneRecordId();
         if (idStr === "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionTemplateCopy.aspx?name=QC_InspectionTemplateCopy&ID=" + idStr;
         dialog({ title: "<%=Resources.Pages.QC_InspectionTemplateCopy %>", src: openWinUrl, width: 850, height: 400 });
     }



     function Delete() {
         var idStr = getDeletingRecordIdString();
         if (idStr === "") return false;
         hdnOperate.val("delete");
         hdnIdString.val(idStr);
         document.forms[0].submit();
     }
     function UpdateList(itemName) {
         document.forms[0].submit();
     }

     $(function () {
         $("#<%=this.ddlInspectionType.ClientID%>").change(function () {

             $("#<%=this.hfInspectionType.ClientID%>").val($(this).val())
         });
     })
 </script>
</asp:Content>
