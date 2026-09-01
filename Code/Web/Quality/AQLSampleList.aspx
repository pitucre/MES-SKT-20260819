<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="AQLSampleList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.AQLSampleList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.AqlName %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtAqlName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" >
        <Columns>
            <asp:BoundField DataField="AQLSampleName" HeaderText="<%$Resources:lang,AqlName %>"  />
            <%--<asp:BoundField DataField="AQLSampleValue" HeaderText="<%$Resources:lang,Max %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="AQLSampleDescription" HeaderText="<%$Resources:lang,Description %>"  ItemStyle-Width="150px"/>--%>
            <asp:BoundField DataField="CreaterBy" HeaderText="创建人"  ItemStyle-Width="200px"/>
            <asp:BoundField DataField="CreateDate" HeaderText="<%$Resources:lang,CreateTime %>"  ItemStyle-Width="200px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.AQLSample"
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
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/AQLSampleEdit.aspx?name=AQLSampleAdd&ID=-1";
         dialog({ title: "<%=Resources.Pages.AQLSampleAdd %>", src: openWinUrl, width: 650, height: 400 });
     }

     function Edit() {
         var idStr = getOneRecordId();
         if (idStr === "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/AQLSampleEdit.aspx?name=AQLSampleEdit&ID=" + idStr;
         dialog({ title: "<%=Resources.Pages.AQLSampleEdit %>", src: openWinUrl, width: 600, height: 400 });
     }

     function Delete() {
         var idStr = getDeletingRecordIdString();

         if (idStr === "") return false;
         hdnOperate.val("delete");
         hdnIdString.val(idStr);
         document.forms[0].submit();
     }

     function Inspection() {
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/AQLGetValue.aspx?name=AQLSampleGetFnViValue";
         dialog({ title: "<%=Resources.lang.GetFnVi %>", src: openWinUrl, width: 500, height: 350 });
     }

     function UpdateList(itemName) {
         document.forms[0].submit();
     }
 </script>
</asp:Content>
