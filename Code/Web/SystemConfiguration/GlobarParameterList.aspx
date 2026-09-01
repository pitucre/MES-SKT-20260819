<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
 CodeBehind="GlobarParameterList.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.GlobarParameterList" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
            <tr>
            <td class="Label1">
                <%=Resources.lang.ParaName %> 
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtParaName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="ParaType" HeaderText="编号" ItemStyle-Width="120px" SortExpression="ParaType"/>
            <asp:BoundField DataField="ParaName" HeaderText="<%$Resources:lang,ParaName %>" SortExpression="ParaName"/>
            <asp:BoundField DataField="ParaValue" HeaderText="<%$Resources:lang,ParaValue %>" SortExpression="ParaValue"/>
            <asp:BoundField DataField="Paraription" HeaderText="参数说明"   SortExpression="Paraription" />
            <asp:BoundField  DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy"/>
            <asp:BoundField  DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField  DataField="ModifyBy" HeaderText="修改人" SortExpression="ModifyBy"/>
            <asp:BoundField  DataField="ModifyTime" HeaderText="修改时间" SortExpression="ModifyTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.CommonDataSource.BLL.GlobarParameter"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
     
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function Add() {
            openWinUrl = "<%=WebHelper.WebRoot %>" + "/SystemConfiguration/GlobarParameterEdit.aspx?name=GlobarParameterAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.GlobarParameterAdd %>", src: openWinUrl, width: 650, height: 350 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr === "") return false;
            openWinUrl = "<%=WebHelper.WebRoot %>" + "/SystemConfiguration/GlobarParameterEdit.aspx?name=GlobarParameterEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.GlobarParameterEdit %>", src: openWinUrl, width: 650, height: 350 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr === "") return false;
            openWinUrl = "<%=WebHelper.WebRoot %>" + "/SystemConfiguration/GlobarParameterView.aspx?name=GlobarParameterView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.GlobarParameterEdit %>", src: openWinUrl, width: 650, height: 350 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr === "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
            return idStr;
        }

        function UpdateList(namestr) {
            document.forms[0].submit();
        }   
        
    </script>

</asp:Content>





