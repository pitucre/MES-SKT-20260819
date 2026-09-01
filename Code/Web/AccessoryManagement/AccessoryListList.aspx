<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="AccessoryListList.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryListList" Title="AccessoryList List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">辅料编码</td>
            <td class="Field2">
                <asp:TextBox ID="txtAccessoryListNO2" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2"><%=Resources.lang.WLTpye %></td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddllWLType">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="1">有铅</asp:ListItem>
                    <asp:ListItem Value="2">无铅</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="AccessoryCode" HeaderText="<%$ Resources:lang, AccessoryCode %>" />
            <asp:BoundField DataField="AccessoryName" HeaderText="<%$ Resources:lang, AccessoryName %>" />
            <asp:BoundField DataField="AccessoryTypeName" HeaderText="<%$ Resources:lang, AccessoryType %>" />
            <asp:BoundField DataField="ItemSpec" HeaderText="规格" />
            <asp:BoundField DataField="WLType" HeaderText="<%$ Resources:lang, WLTpye %>" />
            <asp:BoundField DataField="UnitName" HeaderText="<%$ Resources:lang, PartUnit %>" />
             <%--<asp:BoundField DataField="IsFreeze" HeaderText="<%$ Resources:lang, IsFreeze %>" />--%>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateTime" HeaderText="<%$ Resources:lang, CreateTime %>" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.AccessoryManagement.BLL.AccessoryList" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
        $("#ckbMultipleSelected").parent().hide();
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/AccessoryManagement/AccessoryListEdit.aspx?name=AccessoryListListAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.AccessoryListAdd %>", src: openWinUrl, width: 700, height: 450 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/AccessoryManagement/AccessoryListEdit.aspx?name=AccessoryListListEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.AccessoryListEdit %>", src: openWinUrl, width: 700, height: 450 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccessory.AccListDtl(idStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            
            //if (idStr == "") return false;
            //hdnOperate.val("delete");
            //hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

