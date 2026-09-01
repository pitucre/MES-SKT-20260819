<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="InspectionRuleList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionRuleList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.InspectionRuleName%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtInspectionRuleName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" >
        <Columns>
            <asp:BoundField DataField="InspectionRuleId" HeaderText="<%$Resources:lang,InspectionRuleId %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="InspectionRuleName" HeaderText="<%$Resources:lang,InspectionRuleName %>" ItemStyle-Width="120px"/>
            <asp:BoundField DataField="Status" HeaderText="<%$Resources:lang,Status %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="Creater" HeaderText="<%$Resources:lang,CreateBy %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="CreateTime" HeaderText="<%$Resources:lang,CreateTime %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="Description" HeaderText="<%$Resources:lang,Description %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="InspectionTemplateIdList" HeaderText="InspectionTemplateIdList"  ItemStyle-Width="150px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.InspectionRule"
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
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionRuleEdit.aspx?name=QC_InspectionRuleAdd&ID=-1";
         dialog({ title: "QC_InspectionRuleAdd", src: openWinUrl, width: 650, height: 400 });
     }

     function Edit() {
         var idStr = getOneRecordId();
         if (idStr === "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionRuleEdit.aspx?name=QC_InspectionRuleEdit&ID=" + idStr;
         dialog({ title: "QC_InspectionRuleEdit", src: openWinUrl, width: 600, height: 400 });
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


 </script>
</asp:Content>
