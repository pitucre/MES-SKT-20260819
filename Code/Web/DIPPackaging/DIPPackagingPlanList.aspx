<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="DIPPackagingPlanList.aspx.cs" Inherits="SKT.LeanMES.Web.DIPPackaging.DIPPackagingPlanList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">料号</td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">线别</td>
            <td class="Field3">
                <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">工单号</td>
            <td class="Field3">
                <asp:TextBox ID="txtOrderNO" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="FName" HeaderText="楼层" />
            <asp:BoundField DataField="LineName" HeaderText="线别" />
            <asp:BoundField DataField="OrderNO" HeaderText="工单号" />
            <asp:BoundField DataField="ItemCode" HeaderText="料号" />
            <asp:BoundField DataField="ItemName" HeaderText="料名称" />
            <asp:BoundField DataField="ItemDes" HeaderText="产品描述" />
            <asp:BoundField DataField="PlanQty" HeaderText="计划生产数量" />
            <asp:BoundField DataField="PlanDatiTime" HeaderText="计划时间"  DataFormatString="{0:yyyy-MM-dd}"/>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Container.BLL.DIPPackagingPlan" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <div style="display:none"><asp:Button ID="Button1" runat="server"  /></div>
    <div style="display:none"><asp:Button ID="btnExport" runat="server" OnClick="btnExport_Click"  /></div>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function View() {
            Edit();
        }
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/DIPPackaging/DIPPackagingPlanEdit.aspx?name=DIPPackagingPlanAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.DIPPackagingPlanAdd %>", src: openWinUrl, width: 750, height: 550 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/DIPPackaging/DIPPackagingPlanEdit.aspx?name=DIPPackagingPlanEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.DIPPackagingPlanEdit %>", src: openWinUrl, width: 750, height: 550 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        function Import() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/DIPPackaging/DIPPackagingPlanIn.aspx?name=DIPPackagingPlanImport";
            dialog({ title: "<%=Resources.Pages.DIPPackagingPlanAdd %>", src: openWinUrl, width: 750, height: 550 });
        }
        function Export() {
            $("#<%=this.btnExport.ClientID%>").click();
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
