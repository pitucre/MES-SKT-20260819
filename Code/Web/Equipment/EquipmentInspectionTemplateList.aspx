<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="EquipmentInspectionTemplateList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentInspectionTemplateList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                点检模板名
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtInspectionTemplateName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
                <td class="Label2">
                点检模板类型
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
       
            <asp:BoundField DataField="InspectionTemplateName" HeaderText="点检模板名" ItemStyle-Width="120px"/>
              <asp:BoundField DataField="InspectionTypeName" HeaderText="点检模板类型名称"  ItemStyle-Width="150px"/>
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
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.EquipmentInspectionTemplate"
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
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentInspectionTemplateEdit.aspx?name=Equipment_InspectionTemplateAdd&ID=-1";
         dialog({ title: mesLang("新增点检模板"), src: openWinUrl, width: 850, height: 400 });
     }

     function Edit() {
         var idStr = getOneRecordId();
         if (idStr === "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentInspectionTemplateEdit.aspx?name=Equipment_InspectionTemplateEdit&ID=" + idStr;
         dialog({ title: mesLang("编辑点检模板"), src: openWinUrl, width: 850, height: 400 });
     }

     function Copy() {
         var idStr = getOneRecordId();
         if (idStr === "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentInspectionTemplateCopy.aspx?name=Equipment_InspectionTemplateCopy&ID=" + idStr;
         dialog({ title: mesLang("复制点检模板"), src: openWinUrl, width: 850, height: 400 });
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
