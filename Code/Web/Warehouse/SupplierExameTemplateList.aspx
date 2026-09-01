<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master" CodeBehind="SupplierExameTemplateList.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.SupplierExameTemplateList" %>


<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                模版名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSupplierExameTempletName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="SupplierExameTempletCode" HeaderText="模版编码"  SortExpression="SupplierExameTempletCode" />
             <asp:BoundField DataField="SupplierExameTempletName" HeaderText="模版名称" SortExpression="SupplierExameTempletName" />
            <asp:BoundField DataField="SupplierExameTempletType" HeaderText="考核类型" SortExpression="SupplierExameTempletType" />
            <asp:BoundField DataField="Description" HeaderText="备注" />
            <asp:BoundField DataField="IsEnable" HeaderText="是否启用" />
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
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Warehouse.BLL.SupplierExameTemplet"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/SupplierExameTemplateEdit.aspx?name=Warehouse_SupplierExameTemplateListAdd&ID=-1";
            dialog({ title: "<%= Resources.lang.SupplierExamTempletAdd%>", src: openWinUrl, width: 750, height: 550 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/SupplierExameTemplateEdit.aspx?name=Warehouse_SupplierExameTemplateListEdit&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.SupplierExamTempletEdit%>", src: openWinUrl, width: 750, height: 550 });
        }

       <%-- function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/SupplierExameTemplateView.aspx?name=Warehouse_SupplierExameTypeView&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.WarehouseTypeView%>", src: openWinUrl, width: 450, height: 260 });
        }--%>

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;

            //if (!window.confirm("确定要删除考核模板吗?")) {
            //    return false;
            //}

            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(obj) {
            $("#<%=this.txtSupplierExameTempletName.ClientID %>").val(obj);
            document.forms[0].submit();
        }

        $(document).ready(function () {
            $("#<%= txtSupplierExameTempletName.ClientID %>").blur(function () {                
                var re = "'|*|%|; |-|+|,|=|@";
                var charArr = re.split("|");
                for (i = 0; i < charArr.length; i++) {
                    if ($("#<%= txtSupplierExameTempletName.ClientID %>").val().indexOf(charArr[i]) >= 0) {
                        
                        $("#<%= txtSupplierExameTempletName.ClientID %>").val("");
                        $("#<%= txtSupplierExameTempletName.ClientID %>").focus();
                    }
                }
            });
        });
    </script>
</asp:Content>

