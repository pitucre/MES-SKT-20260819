<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="MsdBakeContionList.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MsdBakeContionList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                MSD等级
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtContainerCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>            
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound" >
        <Columns>
     
            <asp:BoundField DataField="Msl" HeaderText="MSD等级"  SortExpression="Msl" />
            <asp:BoundField DataField="HoursNum" HeaderText="封装厚度(mm)" SortExpression="HoursNum" />
             <asp:BoundField DataField="OverrunExposureTime" HeaderText="暴露时长(h)" SortExpression="OverrunExposureTime" />
            <asp:BoundField DataField="HoursNum2" HeaderText="烘烤时长(h)" SortExpression="HoursNum2" />
            <asp:BoundField DataField="TemperatureTwo" HeaderText="烘烤上限温度(℃)" SortExpression="TemperatureTwo" />
            <asp:BoundField DataField="Temperature" HeaderText="烘烤下限温度(℃)" SortExpression="Temperature" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" HeaderStyle-Width="60px" SortExpression="CreateBy" />
            <asp:BoundField DataField="AddTime" HeaderText="创建时间" HeaderStyle-Width="140px" SortExpression="AddTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" HeaderStyle-Width="60px" SortExpression="CreateBy" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" HeaderStyle-Width="140px" SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MSD.BLL.MsdBakeContion"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MSD/MsdBakeContionEdit.aspx?name=MSD_MsdBakeContionAdd&ID=-1";
            dialog({ title: mesLang("新增"), src: openWinUrl, width: 600, height: 400, resizeable: false });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MSD/MsdBakeContionEdit.aspx?name=MSD_MsdBakeContionEdit&ID=" + idStr;
            dialog({ title: mesLang("编辑"), src: openWinUrl, width: 600, height: 400, resizeable: false });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList() {
            document.forms[0].submit();
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
    </script>
</asp:Content>