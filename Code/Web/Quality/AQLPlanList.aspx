<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="AQLPlanList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.AQLPlanList" %>
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
            <asp:BoundField DataField="AqlName" HeaderText="<%$Resources:lang,AqlName %>" ItemStyle-Width="120px"/>
            <asp:BoundField DataField="AqlRuleTypeId" HeaderText="<%$Resources:lang,AqlRuleType %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="AqlPlanType" HeaderText="<%$Resources:lang,AqlPlanType %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="ApplyTo" HeaderText="<%$Resources:lang,ApplyTo %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="Reject" HeaderText="<%$Resources:lang,Reject %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="AqlPlanStatus" HeaderText="<%$Resources:lang,Status %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="AqlDescription" HeaderText="<%$Resources:lang,Description %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="Remark" HeaderText="<%$Resources:lang,Remark %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="CreaterBy" HeaderText="<%$Resources:lang,CreateBy %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="CreateDate" HeaderText="<%$Resources:lang,CreateTime %>"  ItemStyle-Width="150px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.AQLPlan"
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
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/OBARuleEdit.aspx?name=OBA_OBARuleAdd&ID=-1";
         dialog({ title: "", src: openWinUrl, width: 650, height: 400 });
     }

     function Edit() {
         var idStr = getOneRecordId();
         if (idStr === "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/OBARuleEdit.aspx?name=OBA_OBARuleEdit&ID=" + idStr;
         dialog({ title: "", src: openWinUrl, width: 600, height: 400 });
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
