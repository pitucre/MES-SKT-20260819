<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master"
    AutoEventWireup="true" CodeBehind="ProductionSettingList.aspx.cs" Inherits="SKT.LeanMES.Web.ProductionDataConfiguration.ProductionSettingList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                查询类型
            </td>
            <td class="Field1">
                <asp:DropDownList runat="server" ID="ddlConfigType">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                   <asp:ListItem Value="1">是否JIT发料</asp:ListItem>                 
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" 
        onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="ConfigType" HeaderText="配置类型" />
            <asp:BoundField DataField="ConfigDesc" HeaderText="配置数据源" />
            <asp:BoundField DataField="IsGlobal" HeaderText="系统内置" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ProductionDataConfiguration.BLL.ProductionSetting"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ProductionDataConfiguration/ProductionSettingEdit.aspx?name=ProductionSettingAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.ProductionSettingAdd %>", src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ProductionDataConfiguration/ProductionSettingEdit.aspx?name=ProductionSettingEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.ProductionSettingEdit %>", src: openWinUrl, width: 600, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

         function Refresh() {
            document.forms[0].submit();
        }

        function UpdateList(typeId) {
            $("#<%=this.ddlConfigType.ClientID %>").val(typeId);
            document.forms[0].submit();
        }
    </script>
</asp:Content>