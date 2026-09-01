<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
   CodeBehind="ReportTemplateList.aspx.cs" Inherits="SKT.LeanMES.Web.Report.ReportTemplateList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
<%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                报表名称(中文)
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtTemplName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">报表类型</td>
            <td class="Field2">
                <SKTControl:ReportDDL runat="server" ID="ddlReport" ClientIDMode="Static"></SKTControl:ReportDDL>
            </td>
        </tr>
        <tr>
            <td class="Label2">报表类别</td>
            <td class="Field2">
                <asp:DropDownList ID="TemplateCategory" runat="server">
                    <asp:ListItem Text="全部" Value=""></asp:ListItem>
                    <asp:ListItem Text="简易报表" Value="1"></asp:ListItem>
                    <asp:ListItem Text="高级报表" Value="2"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <asp:BoundField DataField="ReportCNName" HeaderText="报表名称(中文)" HeaderStyle-Width="180px" SortExpression="ReportCNName"/>
            <asp:BoundField DataField="ReportENName" HeaderText="报表名称(英文)" HeaderStyle-Width="180px" SortExpression="ReportENName"/>
            <asp:BoundField DataField="RTModuleCNValue" HeaderText="报表类型" HeaderStyle-Width="180px" SortExpression="ReportTypeCNName"/>
            <asp:BoundField DataField="TemplateCategoryStr" HeaderText="报表类别" HeaderStyle-Width="180px" SortExpression="TemplateCategoryStr"/>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>                       
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Report.BLL.Report"
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
        var w = $(window).width() - 150;
        var h = $(window).height() - 70;
        //简易报表生成页面
        function DesignAdd() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Report/ReportDesign.aspx?name=ReportDesignAdd&ID=-1";
            dialog({ title: "简易报表新增模板", src: openWinUrl, width: w, height: h });
        }
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Report/ReportTemplateEdit.aspx?name=Template_TemplateAdd&ID=-1";
            dialog({ title: "高级报表新增模板", src: openWinUrl, width: w, height: h });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") { return false; }

            var wins = $(window.parent);
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Report/ReportTemplateEdit.aspx?name=Template_TemplateEdit&ID=" + idStr;
            dialog({ title: "编辑报表模板", src: openWinUrl, width: w, height: h });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") { return false; }

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Report/ReportTemplateView.aspx?name=Template_TemplateView&ID=" + idStr;
            dialog({ title: "查看报表模板", src: openWinUrl, width: w, height: h });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") { return false; }

            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(templName) {
            document.forms[0].submit();
        }
    </script>
</asp:Content>





