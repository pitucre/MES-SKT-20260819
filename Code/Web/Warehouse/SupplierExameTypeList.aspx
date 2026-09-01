<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master" CodeBehind="SupplierExameTypeList.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.SupplierExameTypeList" %>


<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.SupplierExameTypeName%>
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
            <asp:BoundField DataField="ExameType" HeaderText="类别"
                HeaderStyle-Width="120px" SortExpression="ExameType" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,CreateBy%>"
                SortExpression="ModifyBy"  HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,CreateDateTime%>"
                SortExpression="ModifyDateTime" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Warehouse.BLL.SupplierExameType"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/SupplierExameTypeEdit.aspx?name=Warehouse_SupplierExameTypeListAdd&ID=-1";
            dialog({ title: "<%= Resources.lang.WarehouseTypeAdd%>", src: openWinUrl, width: 450, height: 260 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/SupplierExameTypeEdit.aspx?name=Warehouse_SupplierExameTypeListEdit&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.WarehouseTypeEdit%>", src: openWinUrl, width: 450, height: 260 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/SupplierExameTypeView.aspx?name=Warehouse_SupplierExameTypeView&ID=" + idStr;
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
