<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="SetOfBooksList.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.SetOfBooksList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">帐套编码</td>
            <td class="Field2">
                <asp:TextBox ID="txtDepartCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">帐套名称</td>
            <td class="Field2">
                <asp:TextBox ID="txtDepartName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" RowStyle-VerticalAlign="Middle">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="DepartCode" HeaderText="账套编码" />
            <asp:BoundField DataField="DepartName" HeaderText="账套名称" />
            <asp:BoundField DataField="MesUrl" HeaderText="账套URL地址" />
            <asp:BoundField DataField="DataBaseName" HeaderText="数据库名" />
            <asp:BoundField DataField="DBLinkName" HeaderText="链接服务器名" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.DataDistribution.BLL.DataDistributionSYBConfig" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");


        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/SetOfBooksAdd.aspx?name=SetOfBooksEdit&ID=-1";
            dialog({ title: "<%=Resources.Popedom.SetOfBooksAdd %>", src: openWinUrl, width: 650, height: 350 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/SetOfBooksAdd.aspx?name=SetOfBooksEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Popedom.SetOfBooksAdd %>", src: openWinUrl, width: 600, height: 400 });
        }
         //数据下发
        function DataDistributionOperate() {
            var idStr = getRecordIdString();
            if (idStr == "") {
                return false;
            }
            var oname = $.trim(window.localStorage.getItem("OrganizationName"));
            if (oname != "集团总部") {
                alert("事业部不能下发数据!");
                return false;
            }
            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值
            // 1 改为 DepartCode
            var SerialNumberList = getRecordCellTextsByFiled("DepartCode"); 
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/DataDistribution/CommonHelperDataDistribution.aspx?name=OrgDataDistributionOperate&pra=" + SerialNumberList;
            dialog({ title: "数据下发", src: openWinUrl, width: 700, height: 400 });
        }
        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
