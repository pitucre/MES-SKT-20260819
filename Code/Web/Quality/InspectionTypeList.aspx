<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="InspectionTypeList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionTypeList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">检验类型名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtInspectionTypeName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">QC类型
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlSystemType" IsRequired="1" ClientIDMode="Static" runat="server">
                    <asp:ListItem Value="">--请选择--</asp:ListItem>
                    <asp:ListItem Value="1">IQC</asp:ListItem>
                    <asp:ListItem Value="2">IPQC</asp:ListItem>
                    <asp:ListItem Value="3">PQC</asp:ListItem>
                    <asp:ListItem Value="4">FQC</asp:ListItem>
                    <asp:ListItem Value="5">OQC</asp:ListItem>
                    <asp:ListItem Value="6">FAI</asp:ListItem>
                    <asp:ListItem Value="7">EAI</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <asp:BoundField DataField="InspectionTypeId" HeaderText="检验类型编号" ItemStyle-Width="120px" />
            <asp:BoundField DataField="InspectionTypeName" HeaderText="检验类型名称" ItemStyle-Width="150px" />
            <asp:BoundField DataField="QCTypeName" HeaderText="QC类型" ItemStyle-Width="150px" />            
            <asp:BoundField DataField="Description" HeaderText="<%$Resources:lang,Description %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="Status" HeaderText="<%$Resources:lang,Status %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="Creater" HeaderText="创建人" ItemStyle-Width="150px" />
            <asp:BoundField DataField="CreateTime" HeaderText="<%$Resources:lang,CreateTime %>" ItemStyle-Width="150px" />
             <asp:BoundField DataField="ModifyBy" HeaderText="修改人" ItemStyle-Width="150px" />
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$Resources:lang,ModifyDateTime %>" ItemStyle-Width="150px" />
            <%--<asp:BoundField DataField="GenerateNumberTypeName" HeaderText="<%$Resources:lang,NextNumberType %>"  ItemStyle-Width="150px"/>--%>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.InspectionType"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script language="javascript" type="text/javascript">
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionTypeEdit.aspx?name=QC_InspectionTypeAdd&ID=-1";
         dialog({ title: "<%=Resources.Pages.QC_InspectionTypeAdd %>", src: openWinUrl, width: 650, height: 400 });
     }

     function Edit() {
         var idStr = getOneRecordId();
         if (idStr === "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionTypeEdit.aspx?name=QC_InspectionTypeEdit&ID=" + idStr;
         dialog({ title: "<%=Resources.Pages.QC_InspectionTypeEdit %>", src: openWinUrl, width: 600, height: 400 });
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
