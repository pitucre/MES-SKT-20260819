<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="SteelMeshInspectionProject.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelMeshInspectionProject" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">项目代码</td>
            <td class="Field3">
                <asp:TextBox ID="txtSMIPCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">项目名称</td>
            <td class="Field3">
                <asp:TextBox ID="txtSMIPName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">类型</td>
            <td class="Field3">
                <asp:DropDownList ID="SMIPType" runat="server" ClientIDMode="Static">
                    <asp:ListItem Selected="True" Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="0">通用</asp:ListItem>
                    <asp:ListItem Value="1">钢网</asp:ListItem>
                    <asp:ListItem Value="2">刮刀</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="SMIPCode" HeaderText="项目代码" />
            <asp:BoundField DataField="SMIPName" HeaderText="项目名称" />
            <asp:BoundField DataField="SMIPEntryMode" HeaderText="录入方式" />
            <asp:BoundField DataField="SMIPCriterion" HeaderText="判定标准" />
            <asp:BoundField DataField="SMIPTypeName" HeaderText="类型" />
            <asp:BoundField DataField="SMIPUnit" HeaderText="单位" />
<%--            <asp:BoundField DataField="SMIPStatus" HeaderText="状态" />--%>
            <asp:BoundField DataField="SMIPUserName" HeaderText="创建人" />
            <asp:BoundField DataField="SMIPDateTime" HeaderText="创建时间" />
            <asp:BoundField DataField="SMIPUpdateUserName" HeaderText="修改人" />
            <asp:BoundField DataField="SMIPUpdateDateTime" HeaderText="修改时间" />
            <asp:BoundField DataField="SMIPRem" HeaderText="备注" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.SteelMesh.BLL.SteelMeshInspectionProjecLogic" SelectMethod="GetAllSteelMeshInspectionProject" SelectCountMethod="GetSteelMeshInspectionProjectCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelMeshInspectionProjectEdit.aspx?name=SteelMeshInspectionProjectAdd&ID=-1";
            dialog({ title: mesLang("新增检验项目"), src: openWinUrl, width: 730, height: 500 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelMeshInspectionProjectEdit.aspx?name=SteelMeshInspectionProjectEdit&ID=" + idStr;
            dialog({ title: mesLang("修改检验项目"), src: openWinUrl, width: 730, height: 500 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.DeleteSteelMeshInspectionProject(idStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.DeleteSuccess%>')
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>


