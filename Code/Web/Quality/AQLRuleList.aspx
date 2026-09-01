<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="AQLRuleList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.AQLRuleList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.RuleName %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtAqlRuleName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound" >
        <Columns>
            <asp:BoundField DataField="RuleName" HeaderText="<%$Resources:lang,RuleName %>" ItemStyle-Width="120px" />
            <asp:BoundField DataField="AQLRuleTypeName" HeaderText="<%$Resources:lang,TypeName %>" ItemStyle-Width="120px"/>
            <asp:BoundField DataField="RuleDescription" HeaderText="<%$Resources:lang,Description %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="CreaterBy" HeaderText="创建人"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="CreateDate" HeaderText="<%$Resources:lang,CreateTime %>"  ItemStyle-Width="150px"/>
             <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDate" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.AQLRule"
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
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/AQLRuleEdit.aspx?name=AQLRuleAdd&ID=-1";
         dialog({ title: "<%=Resources.Pages.AQLRuleAdd %>", src: openWinUrl, width: 760, height: 400 });
     }

     function Edit() {
         var idStr = getOneRecordId();
         if (idStr === "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/AQLRuleEdit.aspx?name=AQLRuleEdit&ID=" + idStr;
         dialog({ title: "<%=Resources.Pages.AQLRuleEdit %>", src: openWinUrl, width: 760, height: 400 });
     }

      function Copy() {
         var idStr = getOneRecordId();
         if (idStr === "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/AQLRuleEdit.aspx?name=AQLRuleCopy&ID=" + idStr;
          dialog({ title: "<%=Resources.Pages.AQLRuleCopy %>", src: openWinUrl, width: 760, height: 400 });
      }

     function Delete() {
         var idStr = getDeletingRecordIdString();

         if (idStr === "") return false;
         hdnOperate.val("delete");
         hdnIdString.val(idStr);
         document.forms[0].submit();
     }



     function UpdateList(itemName) {
         $("#<%=this.txtAqlRuleName.ClientID %>").val(itemName);
         document.forms[0].submit();
     }
 </script>
</asp:Content>
