<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GRNFormList.aspx.cs" MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.Material.GRNFormList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
     <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">
                    <%=Resources.lang.ReveivedNO%>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtGRN" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
                 <td class="Label2">
                   物料代码：
                </td>
                <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
             </tr>
               <tr>
                <td class="Label2">
                   开始时间：
                </td>
                <td class="Field2">
              <asp:TextBox ID="txtDateTimeStart" runat="server" CssClass="DateTimeBox"></asp:TextBox>
                </td>
                  <td class="Label2">
                   结束时间：
                </td>
                <td class="Field2">
                  <asp:TextBox ID="txtDateTimeEnd" runat="server" CssClass="DateTimeBox"></asp:TextBox>
                </td>
             </tr>

    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="SerialNumber" HeaderText="GRN"  /> 
            <asp:BoundField DataField="Quantity" HeaderText="数量"  />
            <asp:BoundField DataField="ItemCode" HeaderText="物料代码"  />
            <asp:BoundField DataField="ItemName" HeaderText="物料名称" />
            <asp:BoundField DataField="ItemDesc" HeaderText="物料描述" />
            <asp:BoundField DataField="Flag_CN" HeaderText="状态" />
            <asp:BoundField DataField="CreationTime" HeaderText="创建时间" />  
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.MaterialUnit"
        SelectMethod="GetAllGRN" SelectCountMethod="GetCount">
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
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/GRNModify.aspx?ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Material_IQCFormView %>", src: openWinUrl, width: 200, height: 200 });
        }
    </script>
    <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
        type="text/javascript" charset="GBK"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
        type="text/javascript"></script>
</asp:Content>
