<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="EquipmentExceptionReportingList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentExceptionReportingList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2" >
                异常上报方案名称
            </td>
            <td class="Field2" >
                <asp:TextBox ID="txtInspectionTemplateName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2" >
                类型
            </td>
            <td class="Field2" >
                <asp:DropDownList ID="ddlExceptionType" runat="server" AutoPostBack="false" ClientIDMode="Static">
                    <asp:ListItem Value="">--请选择--</asp:ListItem>
                    <asp:ListItem Value="点检异常上报">点检异常上报</asp:ListItem>
                    <asp:ListItem Value="保养异常上报">保养异常上报</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
       
            <asp:BoundField DataField="ExceptionReportingCode" HeaderText="异常上报方案编号" ItemStyle-Width="120px"/>
              <asp:BoundField DataField="ExceptionReportingName" HeaderText="异常上报方案名称"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="Version" HeaderText="版本号"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="ExceptionType" HeaderText="类型"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="Status" HeaderText="状态"  ItemStyle-Width="80px"/>
            <asp:BoundField DataField="Creater" HeaderText="创建人"  ItemStyle-Width="80px"/>
            <asp:BoundField DataField="CreateTime" HeaderText="<%$Resources:lang,CreateTime %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人"  ItemStyle-Width="80px"/>
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$Resources:lang,ModifyDateTime %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="Description" HeaderText="<%$Resources:lang,Description %>"  ItemStyle-Width="150px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.EquipmentExceptionReporting"
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
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentExceptionReportingEdit.aspx?name=Equipment_ExceptionReportingAdd&ID=-1";
         dialog({ title: mesLang("新增异常上报方案"), src: openWinUrl, width: 1000, height: 650 });
     }

     function Edit() {
         var idStr = getOneRecordId();
         if (idStr === "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentExceptionReportingEdit.aspx?name=Equipment_ExceptionReportingEdit&ID=" + idStr;
         dialog({ title: mesLang("编辑异常上报方案"), src: openWinUrl, width: 1000, height: 650 });
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
