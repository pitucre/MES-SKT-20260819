<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="InspectionItemList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionItemList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.InspectionItemName%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtInspectionItemName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" >
        <Columns>
            <asp:BoundField DataField="InspectionItemName" HeaderText="<%$Resources:lang,InspectionItemName %>" ItemStyle-Width="120px"/>
            <asp:BoundField DataField="Creater" HeaderText="Creater"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="CreateTime" HeaderText="<%$Resources:lang,CreateTime %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="Description" HeaderText="<%$Resources:lang,Description %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="Status" HeaderText="<%$Resources:lang,Status %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="InspectionItemId" HeaderText="<%$Resources:lang,InspectionItemId %>"  ItemStyle-Width="150px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.InspectionItem"
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
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionItemEdit.aspx?name=QC_InspectionItemAdd&ID=-1";
         dialog({ title: "<%=Resources.Pages.QC_InspectionItemAdd %>", src: openWinUrl, width: 800, height: 400 });
     }

     function Edit() {
         var idStr = getOneRecordId();
         if (idStr === "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionItemEdit.aspx?name=QC_InspectionItemEdit&ID=" + idStr;
         dialog({ title: "<%=Resources.Pages.QC_InspectionItemEdit %>", src: openWinUrl, width: 800, height: 400 });
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
