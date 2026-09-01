<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="AccessoryTypeList.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryTypeList" Title="AccessoryType List Page" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1" colspan="2" style=" text-align:left;font-size:13px; ">
               <span>【备注】：解冻时长=锡膏搅拌扫描时间-锡膏解冻扫描时间; 搅拌时长=锡膏扫描上线时间-锡膏搅拌扫描时间;闲置时长=上线实时时间-解冻时长间;使用时间=上线实时时间-上线扫描时间;搅拌闲置时长=上线扫描时间-搅拌时长;</span></td>
        </tr>
        <tr>
            <td class="Label1">辅料类型名称</td>
            <td class="Field1">
                <asp:TextBox ID="txtAccessoryTypeNO2" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="AccessoryTypeName" HeaderText="<%$ Resources:lang, AccessoryTypeName %>" />
            <asp:BoundField DataField="ThawTime" HeaderText="<%$ Resources:lang, ThawTime %>" />
            <asp:BoundField DataField="LeaveUnusedTime" HeaderText="<%$ Resources:lang, LeaveUnusedTime %>" />
            <asp:BoundField DataField="UseTime" HeaderText="<%$ Resources:lang, UseTime %>" />
            <asp:BoundField DataField="StirTime" HeaderText="<%$ Resources:lang, StirTime %>" />
            <asp:BoundField DataField="StirIdleTime" HeaderText="<%$ Resources:lang, StirIdleTime %>" />
            <asp:BoundField DataField="StirQty" HeaderText="搅拌次数" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateTime" HeaderText="<%$ Resources:lang, CreateTime %>" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.AccessoryManagement.BLL.AccessoryType" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/AccessoryManagement/AccessoryTypeEdit.aspx?name=AccessoryTypeAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.AccessoryTypeAdd %>", src: openWinUrl, width: 680, height: 400});
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/AccessoryManagement/AccessoryTypeEdit.aspx?name=AccessoryTypeEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.AccessoryTypeEdit %>", src: openWinUrl, width: 680, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccessoryTypeDtl(idStr);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }
        alert('<%=Resources.Messages.DeleteSuccess%>')
            //hdnOperate.val("delete");
            //hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

