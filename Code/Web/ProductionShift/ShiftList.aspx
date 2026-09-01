<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" Inherits="SKT.LeanMES.Web.ProductionShift.ShiftList" ViewStateMode="Disabled" Codebehind="ShiftList.aspx.cs" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
   <table class="EditeContentTable" width="100%">        
        <tr>
            <td class="Label1">
                <%=Resources.lang.ShiftName%> 
            </td>
            <td class="Field1">
                <input type="text" id="txtShiftName" class="TextBox" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.ShiftRemark%>
            </td>
            <td class="Field1">
                <input type="text" id="txtShiftRemark" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
 
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" >
        <Columns>
            <asp:BoundField DataField="ShiftName" HeaderText="<%$ Resources:lang,ShiftName %>" />
            <asp:BoundField DataField="Remark"   HeaderText="<%$ Resources:lang,ShiftRemark %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ProductionShift.BLL.ProductionShift"
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
         dialog({ title: "<%= Resources.Pages.ShiftAdd %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ProductionShift/ShiftEdit.aspx?name=ShiftAdd&ID=-1", width: 900, height: 420, resizeable: true });
     }

     //编辑
     function Edit() {
         var idStr = getOneRecordId();
         if (idStr == "") return;
         dialog({ title: "<%= Resources.Pages.ShiftEdit %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ProductionShift/ShiftEdit.aspx?name=ShiftEdit&ID=" + idStr, width: 900, height: 420, resizeable: true });
     }

     //删除
     function Delete() {
         var idStr = getDeletingRecordIdString();
         if (idStr == "") return false;
         hdnOperate.val("delete");
         hdnIdString.val(idStr);
         document.forms[0].submit();
     }
     function UpdateList(namestr) {
         $("#<%=this.txtShiftName.ClientID %>").val(namestr);
         document.forms[0].submit();
     }   
 </script>
</asp:Content>
