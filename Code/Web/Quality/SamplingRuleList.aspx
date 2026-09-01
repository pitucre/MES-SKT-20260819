<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="SamplingRuleList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.SamplingRuleList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.ItemsName %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" >
        <Columns>
            <asp:BoundField DataField="ItemName" HeaderText="<%$Resources:lang,ItemsName %>" ItemStyle-Width="120px"/>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$Resources:lang,ItemCode %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="LotSize" HeaderText="<%$Resources:lang,AC_MSOBA_LotQty %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="SamplePercentStr" HeaderText="<%$Resources:lang,AC_OBA_Percent %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="SampleSize" HeaderText="<%$Resources:lang,AC_OBA_SampleSize %>"  ItemStyle-Width="150px"/>
            <asp:BoundField />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.OBAAudit"
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
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/SamplingRuleEdit.aspx?name=Quality_SamplingRuleAdd&ID=-1";
         dialog({ title: "<%=Resources.Pages.Quality_SamplingRuleAdd %>", src: openWinUrl, width: 650, height: 400 });
     }

     function Edit() {
         var idStr = getOneRecordId();
         if (idStr == "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/SamplingRuleEdit.aspx?name=Quality_SamplingRuleEdit&ID=" + idStr;
         dialog({ title: "<%=Resources.Pages.Quality_SamplingRuleEdit %>", src: openWinUrl, width: 600, height: 400 });
     }

     function Delete() {
         var idStr = getDeletingRecordIdString();

         if (idStr == "") return false;
         hdnOperate.val("delete");
         hdnIdString.val(idStr);
         document.forms[0].submit();
     }



     function UpdateList(itemName) {
         $("#<%=this.txtItemName.ClientID %>").val(itemName);
         document.forms[0].submit();
     }
 </script>
</asp:Content>
