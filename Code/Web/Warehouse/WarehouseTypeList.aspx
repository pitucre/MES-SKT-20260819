<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseTypeList.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseTypeList"
    Title="WarehouseType List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.WarehouseTypeName%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtKeyWords" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="WarehouseType" HeaderText="<%$ Resources:lang,WarehouseTypeName%>"
                HeaderStyle-Width="120px" SortExpression="WarehouseType" />
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang,Description%>" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy%>"
                SortExpression="CreateBy"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime%>"
                SortExpression="CreateDateTime" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy%>"
                SortExpression="ModifyBy"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime%>"
                SortExpression="ModifyDateTime" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Warehouse.BLL.WarehouseType"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseTypeEdit.aspx?name=Warehouse_WarehouseTypeAdd&ID=-1";
            dialog({ title: "<%= Resources.lang.WarehouseTypeAdd%>", src: openWinUrl, width: 450, height: 260 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseTypeEdit.aspx?name=Warehouse_WarehouseTypeEdit&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.WarehouseTypeEdit%>", src: openWinUrl, width: 450, height: 260 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/WarehouseTypeView.aspx?name=Warehouse_WarehouseTypeView&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.WarehouseTypeView%>", src: openWinUrl, width: 450, height: 260 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(obj) {
            $("#<%=this.txtKeyWords.ClientID %>").val(obj);
            document.forms[0].submit();
        }

        $(document).ready(function () {
            $("#<%= txtKeyWords.ClientID %>").blur(function () {                
                var re = "'|*|%|; |-|+|,|=|@";
                var charArr = re.split("|");
                for (i = 0; i < charArr.length; i++) {
                    if ($("#<%= txtKeyWords.ClientID %>").val().indexOf(charArr[i]) >= 0) {
                      
                        $("#<%= txtKeyWords.ClientID %>").val("");
                        $("#<%= txtKeyWords.ClientID %>").focus();
                    }
                }
            });
        });
    </script>
</asp:Content>
