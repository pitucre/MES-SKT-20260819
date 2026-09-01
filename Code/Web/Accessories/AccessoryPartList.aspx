<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="AccessoryPartList.aspx.cs" Inherits="SKT.LeanMES.Web.Accessories.AccessoryPartList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
   <table class="EditeContentTable" width="100%">        
        <tr>
            <td class="Label1">
                <%=Resources.lang.ItemName%>
            </td>
            <td class="Field1">
                <input type="text" id="txtItemName" class="TextBox" runat="server" />
            </td>
        </tr>
         
    </table>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
   <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" 
        onrowdatabound="GridView1_RowDataBound" >
        <Columns>
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang,ItemName %>" ItemStyle-Width="150px"/>
            <asp:BoundField DataField="LeedFree" HeaderText="<%$ Resources:lang,PartType %>" ItemStyle-Width="150px"/>
            <asp:BoundField DataField="UserName" HeaderText="<%$ Resources:lang,Creator %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateTime %>" ItemStyle-Width="150px"/>                   
        </Columns>
    </asp:GridView>
   
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Accessories.BLL.AccessoryPart"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource> 

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />


    <script language="javascript" type="text/javascript">
        isMultiple = true;
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        //增加 
        function Add() 
        {
            dialog({ title: "<%= Resources.lang.AccessoryPartAdd %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Accessories/AccessoryPartEdit.aspx?name=AccessoryPartAdd&ID=-1", width: 520, height: 300, resizeable: true });
        }

        //编辑
        function Edit() 
        {
            //var idStr = getOneRecordId();
            //if (idStr == "") return;
            //dialog({ title: "<%= Resources.lang.AccessoryPartEdit %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Accessories/AccessoryPartEdit.aspx?name=AccessoryPartEdit&ID=" + idStr, width: 600, height: 350, resizeable: true });
        }

         //删除
        function Delete()
         {
             var idStr = getDeletingRecordIdString();
             if (idStr == "") return false;
             hdnOperate.val("delete");
             hdnIdString.val(idStr);
             document.forms[0].submit();
         }

         function UpdateList(strName)
         {
             $("#<%=this.txtItemName.ClientID %>").val(strName);
             document.forms[0].submit();
         }
 </script>

</asp:Content>
